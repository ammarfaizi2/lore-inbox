Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbTEFDAw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 23:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbTEFC7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 22:59:42 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:34960 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262299AbTEFC5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 22:57:15 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][v850]  Whitespace and comment cleanups for v850 entry.S
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030506030925.625053779@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue,  6 May 2003 12:09:25 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes linux-2.5.69-uc0/arch/v850/kernel/entry.S linux-2.5.69-uc0-v850-20030506/arch/v850/kernel/entry.S
--- linux-2.5.69-uc0/arch/v850/kernel/entry.S	2003-04-21 10:52:40.000000000 +0900
+++ linux-2.5.69-uc0-v850-20030506/arch/v850/kernel/entry.S	2003-05-06 10:40:26.000000000 +0900
@@ -29,28 +29,28 @@
 #define CSYM	C_SYMBOL_NAME
 
 
-/* The offset of the struct pt_regs in a `state save frame' on the stack.  */
+/* The offset of the struct pt_regs in a state-save-frame on the stack.  */
 #define PTO	STATE_SAVE_PT_OFFSET
 
 
-/* Save argument registers to the struct pt_regs pointed to by EP.  */
+/* Save argument registers to the state-save-frame pointed to by EP.  */
 #define SAVE_ARG_REGS							      \
 	sst.w	r6, PTO+PT_GPR(6)[ep];					      \
 	sst.w	r7, PTO+PT_GPR(7)[ep];					      \
 	sst.w	r8, PTO+PT_GPR(8)[ep];					      \
 	sst.w	r9, PTO+PT_GPR(9)[ep]
-/* Restore argument registers from the struct pt_regs pointed to by EP.  */
+/* Restore argument registers from the state-save-frame pointed to by EP.  */
 #define RESTORE_ARG_REGS						      \
 	sld.w	PTO+PT_GPR(6)[ep], r6;					      \
 	sld.w	PTO+PT_GPR(7)[ep], r7;					      \
 	sld.w	PTO+PT_GPR(8)[ep], r8;					      \
 	sld.w	PTO+PT_GPR(9)[ep], r9
 
-/* Save value return registers to the struct pt_regs pointed to by EP.  */
+/* Save value return registers to the state-save-frame pointed to by EP.  */
 #define SAVE_RVAL_REGS							      \
 	sst.w	r10, PTO+PT_GPR(10)[ep];				      \
 	sst.w	r11, PTO+PT_GPR(11)[ep]
-/* Restore value return registers from the struct pt_regs pointed to by EP.  */
+/* Restore value return registers from the state-save-frame pointed to by EP.  */
 #define RESTORE_RVAL_REGS						      \
 	sld.w	PTO+PT_GPR(10)[ep], r10;				      \
 	sld.w	PTO+PT_GPR(11)[ep], r11
@@ -81,13 +81,13 @@
 	sld.w	PTO+PT_GPR(18)[ep], r18;				      \
 	sld.w	PTO+PT_GPR(19)[ep], r19
 
-/* Save `call clobbered' registers to the struct pt_regs pointed to by EP.  */
+/* Save `call clobbered' registers to the state-save-frame pointed to by EP.  */
 #define SAVE_CALL_CLOBBERED_REGS					      \
 	SAVE_CALL_CLOBBERED_REGS_BEFORE_ARGS;				      \
 	SAVE_ARG_REGS;							      \
 	SAVE_RVAL_REGS;							      \
 	SAVE_CALL_CLOBBERED_REGS_AFTER_RVAL
-/* Restore `call clobbered' registers from the struct pt_regs pointed to
+/* Restore `call clobbered' registers from the state-save-frame pointed to
    by EP.  */
 #define RESTORE_CALL_CLOBBERED_REGS					      \
 	RESTORE_CALL_CLOBBERED_REGS_BEFORE_ARGS;			      \
@@ -96,19 +96,19 @@
 	RESTORE_CALL_CLOBBERED_REGS_AFTER_RVAL
 
 /* Save `call clobbered' registers except for the return-value registers
-   to the struct pt_regs pointed to by EP.  */
+   to the state-save-frame pointed to by EP.  */
 #define SAVE_CALL_CLOBBERED_REGS_NO_RVAL				      \
 	SAVE_CALL_CLOBBERED_REGS_BEFORE_ARGS;				      \
 	SAVE_ARG_REGS;							      \
 	SAVE_CALL_CLOBBERED_REGS_AFTER_RVAL
 /* Restore `call clobbered' registers except for the return-value registers
-   from the struct pt_regs pointed to by EP.  */
+   from the state-save-frame pointed to by EP.  */
 #define RESTORE_CALL_CLOBBERED_REGS_NO_RVAL				      \
 	RESTORE_CALL_CLOBBERED_REGS_BEFORE_ARGS;			      \
 	RESTORE_ARG_REGS;						      \
 	RESTORE_CALL_CLOBBERED_REGS_AFTER_RVAL
 
-/* Save `call saved' registers to the struct pt_regs pointed to by EP.  */
+/* Save `call saved' registers to the state-save-frame pointed to by EP.  */
 #define SAVE_CALL_SAVED_REGS						      \
 	sst.w	r2, PTO+PT_GPR(2)[ep];					      \
 	sst.w	r20, PTO+PT_GPR(20)[ep];				      \
@@ -121,7 +121,7 @@
 	sst.w	r27, PTO+PT_GPR(27)[ep];				      \
 	sst.w	r28, PTO+PT_GPR(28)[ep];				      \
 	sst.w	r29, PTO+PT_GPR(29)[ep]
-/* Restore `call saved' registers from the struct pt_regs pointed to by EP.  */
+/* Restore `call saved' registers from the state-save-frame pointed to by EP.  */
 #define RESTORE_CALL_SAVED_REGS						      \
 	sld.w	PTO+PT_GPR(2)[ep], r2;					      \
 	sld.w	PTO+PT_GPR(20)[ep], r20;				      \
@@ -136,12 +136,12 @@
 	sld.w	PTO+PT_GPR(29)[ep], r29
 
 
-/* Save the PC stored in the special register SAVEREG to the struct pt_regs
+/* Save the PC stored in the special register SAVEREG to the state-save-frame
    pointed to by EP.  r19 is clobbered.  */
 #define SAVE_PC(savereg)						      \
 	stsr	SR_ ## savereg, r19;					      \
 	sst.w	r19, PTO+PT_PC[ep]
-/* Restore the PC from the struct pt_regs pointed to by EP, to the special
+/* Restore the PC from the state-save-frame pointed to by EP, to the special
    register SAVEREG.  LP is clobbered (it is used as a scratch register
    because the POP_STATE macro restores it, and this macro is usually used
    inside POP_STATE).  */
@@ -149,11 +149,11 @@
 	sld.w	PTO+PT_PC[ep], lp;					      \
 	ldsr	lp, SR_ ## savereg
 /* Save the PSW register stored in the special register SAVREG to the
-   struct pt_regs pointed to by EP r19 is clobbered.  */
+   state-save-frame pointed to by EP.  r19 is clobbered.  */
 #define SAVE_PSW(savereg)						      \
 	stsr	SR_ ## savereg, r19;					      \
 	sst.w	r19, PTO+PT_PSW[ep]
-/* Restore the PSW register from the struct pt_regs pointed to by EP, to
+/* Restore the PSW register from the state-save-frame pointed to by EP, to
    the special register SAVEREG.  LP is clobbered (it is used as a scratch
    register because the POP_STATE macro restores it, and this macro is
    usually used inside POP_STATE).  */
@@ -161,7 +161,7 @@
 	sld.w	PTO+PT_PSW[ep], lp;					      \
 	ldsr	lp, SR_ ## savereg
 
-/* Save CTPC/CTPSW/CTBP registers to the struct pt_regs pointed to by REG.  
+/* Save CTPC/CTPSW/CTBP registers to the state-save-frame pointed to by REG.
    r19 is clobbered.  */
 #define SAVE_CT_REGS							      \
 	stsr	SR_CTPC, r19;						      \
@@ -170,7 +170,7 @@
 	sst.w	r19, PTO+PT_CTPSW[ep];					      \
 	stsr	SR_CTBP, r19;						      \
 	sst.w	r19, PTO+PT_CTBP[ep]
-/* Restore CTPC/CTPSW/CTBP registers from the struct pt_regs pointed to by EP.
+/* Restore CTPC/CTPSW/CTBP registers from the state-save-frame pointed to by EP.
    LP is clobbered (it is used as a scratch register because the POP_STATE
    macro restores it, and this macro is usually used inside POP_STATE).  */
 #define RESTORE_CT_REGS							      \
@@ -182,10 +182,11 @@
 	ldsr	lp, SR_CTBP
 
 
-/* Push register state, except for the stack pointer, on the stack in the form
-   of a struct pt_regs, in preparation for a system call.  This macro makes
-   sure that `special' registers, system registers; TYPE identifies the set of
-   extra registers to be saved as well.  EP is clobbered.  */
+/* Push register state, except for the stack pointer, on the stack in the
+   form of a state-save-frame (plus some extra padding), in preparation for
+   a system call.  This macro makes sure that the EP, GP, and LP
+   registers are saved, and TYPE identifies the set of extra registers to
+   be saved as well.  Also copies (the new value of) SP to EP.  */
 #define PUSH_STATE(type)						      \
 	addi	-STATE_SAVE_SIZE, sp, sp; /* Make room on the stack.  */      \
 	st.w	ep, PTO+PT_GPR(GPR_EP)[sp];				      \
@@ -193,8 +194,8 @@
 	sst.w	gp, PTO+PT_GPR(GPR_GP)[ep];				      \
 	sst.w	lp, PTO+PT_GPR(GPR_LP)[ep];				      \
 	type ## _STATE_SAVER
-/* Pop a register state, except for the stack pointer, from the struct pt_regs
-   on the stack.  */
+/* Pop a register state pushed by PUSH_STATE, except for the stack pointer,
+   from the the stack.  */
 #define POP_STATE(type)							      \
 	mov	sp, ep;							      \
 	type ## _STATE_RESTORER;					      \
@@ -205,7 +206,7 @@
 
 
 /* Switch to the kernel stack if necessary, and push register state on the
-   stack in the form of a struct pt_regs.  Also load the current task
+   stack in the form of a state-save-frame.  Also load the current task
    pointer if switching from user mode.  The stack-pointer (r3) should have
    already been saved to the memory location SP_SAVE_LOC (the reason for
    this is that the interrupt vectors may be beyond a 22-bit signed offset
@@ -311,8 +329,8 @@
 #define IRQ_EXTRA_STATE_RESTORER					      \
 	RESTORE_CALL_SAVED_REGS;					      \
 	RESTORE_CT_REGS
-#define IRQ_FUNCALL_EXTRA_STATE_SAVER       /* nothing */
-#define IRQ_FUNCALL_EXTRA_STATE_RESTORER    /* nothing */
+#define IRQ_SCHEDULE_EXTRA_STATE_SAVER	     /* nothing */
+#define IRQ_SCHEDULE_EXTRA_STATE_RESTORER    /* nothing */
 
 /* Register saving/restoring for non-maskable interrupts.  */
 #define NMI_RET reti
@@ -330,8 +348,8 @@
 #define NMI_EXTRA_STATE_RESTORER					      \
 	RESTORE_CALL_SAVED_REGS;					      \
 	RESTORE_CT_REGS
-#define NMI_FUNCALL_EXTRA_STATE_SAVER       /* nothing */
-#define NMI_FUNCALL_EXTRA_STATE_RESTORER    /* nothing */
+#define NMI_SCHEDULE_EXTRA_STATE_SAVER	     /* nothing */
+#define NMI_SCHEDULE_EXTRA_STATE_RESTORER    /* nothing */
 
 /* Register saving/restoring for debug traps.  */
 #define DBTRAP_RET .long 0x014607E0 /* `dbret', but gas doesn't support it. */
@@ -349,8 +367,8 @@
 #define DBTRAP_EXTRA_STATE_RESTORER					      \
 	RESTORE_CALL_SAVED_REGS;					      \
 	RESTORE_CT_REGS
-#define DBTRAP_FUNCALL_EXTRA_STATE_SAVER       /* nothing */
-#define DBTRAP_FUNCALL_EXTRA_STATE_RESTORER    /* nothing */
+#define DBTRAP_SCHEDULE_EXTRA_STATE_SAVER	/* nothing */
+#define DBTRAP_SCHEDULE_EXTRA_STATE_RESTORER	/* nothing */
 
 /* Register saving/restoring for a context switch.  We don't need to save
    too many registers, because context-switching looks like a function call
@@ -372,14 +390,14 @@
 	RESTORE_CT_REGS
 
 
-/* Restore register state from the struct pt_regs on the stack, switch back
+/* Restore register state from the state-save-frame on the stack, switch back
    to the user stack if necessary, and return from the trap/interrupt.
    EXTRA_STATE_RESTORER is a sequence of assembly language statements to
    restore anything not restored by this macro.  Only registers not saved by
    the C compiler are restored (that is, R3(sp), R4(gp), R31(lp), and
    anything restored by EXTRA_STATE_RESTORER).  */
 #define RETURN(type)							      \
-        ld.b	PTO+PT_KERNEL_MODE[sp], r19;				      \
+	ld.b	PTO+PT_KERNEL_MODE[sp], r19;				      \
 	di;				/* Disable interrupts */	      \
 	cmp	r19, r0;		/* See if returning to kernel mode, */\
 	bne	2f;			/* ... if so, skip resched &c.  */    \
@@ -471,7 +487,7 @@
  *   Return value in r10
  */
 G_ENTRY(trap):
-	SAVE_STATE (TRAP, r12, ENTRY_SP) // Save registers. 
+	SAVE_STATE (TRAP, r12, ENTRY_SP) // Save registers.
 	stsr	SR_ECR, r19		// Find out which trap it was.
 	ei				// Enable interrupts.
 	mov	hilo(ret_from_trap), lp	// where the trap should return
@@ -481,12 +497,12 @@
 	// numbers into the (0-31) << 2 range we want, (3) set the flags.
 	shl	27, r19			// chop off all high bits
 	shr	25, r19			// scale back down and then << 2
-	bnz	2f			// See if not trap 0. 
+	bnz	2f			// See if not trap 0.
 
-	// Trap 0 is a `short' system call, skip general trap table. 
-	MAKE_SYS_CALL			// Jump to the syscall function. 
+	// Trap 0 is a `short' system call, skip general trap table.
+	MAKE_SYS_CALL			// Jump to the syscall function.
 
-2:	// For other traps, use a table lookup. 
+2:	// For other traps, use a table lookup.
 	mov	hilo(CSYM(trap_table)), r18
 	add	r19, r18
 	ld.w	0[r18], r18
@@ -505,6 +521,7 @@
 	RETURN(TRAP)
 END(ret_from_trap)
 
+
 /* This the initial entry point for a new child thread, with an appropriate
    stack in place that makes it look the the child is in the middle of an
    syscall.  This function is actually `returned to' from switch_thread
@@ -538,7 +555,7 @@
 	mov	hilo(ret_from_long_syscall), lp
 
 	MAKE_SYS_CALL			// Jump to the syscall function.
-END(syscall_long)	
+END(syscall_long)
 
 /* Entry point used to return from a long syscall.  Only needed to restore
    r13/r14 if the general trap mechanism doesnt' do so.  */
@@ -576,8 +593,8 @@
 
 L_ENTRY(sys_clone_wrapper):
 	ld.w	PTO+PT_GPR(GPR_SP)[sp], r19 // parent's stack pointer
-        cmp	r7, r0			// See if child SP arg (arg 1) is 0.
-	cmov	z, r19, r7, r7		// ... and use the parent's if so. 
+	cmp	r7, r0			// See if child SP arg (arg 1) is 0.
+	cmov	z, r19, r7, r7		// ... and use the parent's if so.
 	movea	PTO, sp, r8		// Arg 2: parent context
 	mov	hilo(CSYM(fork_common)), r18// Where the real work gets done
 	br	save_extra_state_tramp	// Save state and go there
@@ -598,8 +615,8 @@
 END(sys_sigsuspend_wrapper)
 L_ENTRY(sys_rt_sigsuspend_wrapper):
 	movea	PTO, sp, r8		// add user context as 3rd arg
-	mov	hilo(CSYM(sys_rt_sigsuspend)), r18	// syscall function
-	jarl	save_extra_state_tramp, lp	// Save state and do it
+	mov	hilo(CSYM(sys_rt_sigsuspend)), r18 // syscall function
+	jarl	save_extra_state_tramp, lp	   // Save state and do it
 	br	restore_extra_regs_and_ret_from_trap
 END(sys_rt_sigsuspend_wrapper)
 
@@ -637,7 +653,7 @@
  * indirect jump).
  */
 G_ENTRY(irq):
-	SAVE_STATE (IRQ, r0, ENTRY_SP)	// Save registers. 
+	SAVE_STATE (IRQ, r0, ENTRY_SP)	// Save registers.
 
 	stsr	SR_ECR, r6		// Find out which interrupt it was.
 	movea	PTO, sp, r7		// User regs are arg2
@@ -657,7 +673,7 @@
 	RETURN(IRQ)
 END(irq)
 
-	
+
 /*
  * Debug trap / illegal-instruction exception
  *
@@ -754,8 +882,8 @@
 
 	.align 4
 C_DATA(trap_table):
-	.long bad_trap_wrapper		// trap 0, doesn't use trap table. 
-	.long syscall_long		// trap 1, `long' syscall. 
+	.long bad_trap_wrapper		// trap 0, doesn't use trap table.
+	.long syscall_long		// trap 1, `long' syscall.
 	.long bad_trap_wrapper
 	.long bad_trap_wrapper
 	.long bad_trap_wrapper
@@ -774,7 +902,7 @@
 
 
 	.section .rodata
-	
+
 	.align 4
 C_DATA(sys_call_table):
 	.long CSYM(sys_restart_syscall)	// 0
@@ -835,7 +963,7 @@
 	.long CSYM(sys_fcntl)		// 55
 	.long CSYM(sys_ni_syscall)	// was: mpx
 	.long CSYM(sys_setpgid)
-	.long CSYM(sys_ni_syscall) 	// was: ulimit
+	.long CSYM(sys_ni_syscall)	// was: ulimit
 	.long CSYM(sys_ni_syscall)
 	.long CSYM(sys_umask)		// 60
 	.long CSYM(sys_chroot)
@@ -875,7 +1003,7 @@
 	.long CSYM(sys_fchown)		// 95
 	.long CSYM(sys_getpriority)
 	.long CSYM(sys_setpriority)
-	.long CSYM(sys_ni_syscall) 	// was: profil
+	.long CSYM(sys_ni_syscall)	// was: profil
 	.long CSYM(sys_statfs)
 	.long CSYM(sys_fstatfs)		// 100
 	.long CSYM(sys_ni_syscall)	// i386: ioperm
@@ -900,7 +1028,7 @@
 	.long sys_clone_wrapper		// 120
 	.long CSYM(sys_setdomainname)
 	.long CSYM(sys_newuname)
-	.long CSYM(sys_ni_syscall)	// i386: modify_ldt, m68k: cacheflush 
+	.long CSYM(sys_ni_syscall)	// i386: modify_ldt, m68k: cacheflush
 	.long CSYM(sys_adjtimex)
 	.long CSYM(sys_ni_syscall)	// 125 - sys_mprotect
 	.long CSYM(sys_sigprocmask)
@@ -937,7 +1065,7 @@
 	.long CSYM(sys_sched_getscheduler)
 	.long CSYM(sys_sched_yield)
 	.long CSYM(sys_sched_get_priority_max)
-	.long CSYM(sys_sched_get_priority_min)  // 160
+	.long CSYM(sys_sched_get_priority_min)	// 160
 	.long CSYM(sys_sched_rr_get_interval)
 	.long CSYM(sys_nanosleep)
 	.long CSYM(sys_ni_syscall)	// sys_mremap
