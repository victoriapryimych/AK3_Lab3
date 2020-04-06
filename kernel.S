.syntax unified
.cpu cortex-m4
//.fpu softvfp
.thumb
#define a #5
#define b #2
#define c #3

// Global memory locations.
.global vtable_kernel
.global __kernel_reset__

.type vtable_kernel, %object
.type __kernel_reset__, %function

.section .interrupt_vector
vtable_kernel:
    .word __stack_start
    .word __kernel_reset__+1
    .size vtable_kernel, .-vtable_kernel

.section .rodata
    data: .asciz "kernel started!\n"
    final: .asciz "Value in register #4: "

.section .text
__kernel_reset__:
    ldr r0, =data
    bl dbgput_line

    //calculate
    mov r0, a
    mov r1, b
    mov r2, c
    mov r3, #3
    mov r4, #1
    sub r0, r1

pow:
    sub r2, #1
    lsl r4, #1
    cmp r2, #0
    bne pow

    mla r4, r0, r3, r4

    ldr r0, =final
    bl dbgput
    mov r0, r4
    bl dbgput_num

end:
    b end
