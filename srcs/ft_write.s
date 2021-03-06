;			ft_write (RDI = fd, RSI = *str, RDX = nbytes)

global _ft_write
extern ___error

section .text

_ft_write:
			mov		rax, 0x2000004			; write vector number
			syscall							; call system function write
			jc 		.error					; syscall set CF = 1 if any errors occur and copy code number in RAX
			ret								; return number of written letters (RAX)
.error:
											; here we have error number at RAX. Store RDX to re-use it leter
			push 	rdx						; place Error number at RDX
			mov 	rdx, rax				; save error code to RDX
			call 	___error				; get pointer to ERRNO using C function
			mov 	[rax], rdx				; write this error code at errno adress
			pop		rdx						; restore RDX before exit
			mov 	rax, -1					; set returned value to -1
			ret								; return -1 error