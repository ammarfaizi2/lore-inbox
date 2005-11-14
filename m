Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbVKNVcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbVKNVcO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbVKNVcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:32:14 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:34190 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932148AbVKNVcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:32:10 -0500
Message-Id: <20051114212525.168514000@sergelap>
References: <20051114212341.724084000@sergelap>
Date: Mon, 14 Nov 2005 15:23:43 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: [RFC] [PATCH 02/13] Change pid accesses: most archs
Content-Disposition: inline; filename=B1-change-pid-tgid-references-arches
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace-Subject: Change pid accesses: most archs
From: Serge Hallyn <serue@us.ibm.com>

Change pid accesses for most architectures.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 arch/alpha/kernel/semaphore.c         |   16 ++++++++--------
 arch/alpha/kernel/signal.c            |    4 ++--
 arch/alpha/kernel/traps.c             |    6 +++---
 arch/alpha/mm/fault.c                 |    4 ++--
 arch/arm/kernel/process.c             |    2 +-
 arch/arm/kernel/ptrace.c              |    4 ++--
 arch/arm/kernel/traps.c               |   10 +++++-----
 arch/arm/mm/alignment.c               |    2 +-
 arch/arm/mm/fault.c                   |    2 +-
 arch/arm/nwfpe/fpmodule.c             |    2 +-
 arch/arm26/kernel/ptrace.c            |    2 +-
 arch/arm26/kernel/traps.c             |   12 ++++++------
 arch/arm26/mm/fault.c                 |    2 +-
 arch/arm26/nwfpe/fpmodule.c           |    2 +-
 arch/cris/arch-v10/kernel/traps.c     |    2 +-
 arch/cris/arch-v32/kernel/process.c   |    2 +-
 arch/cris/arch-v32/kernel/ptrace.c    |    4 ++--
 arch/cris/arch-v32/kernel/signal.c    |    2 +-
 arch/cris/arch-v32/kernel/traps.c     |    2 +-
 arch/cris/kernel/profile.c            |    2 +-
 arch/frv/kernel/gdb-stub.c            |    2 +-
 arch/frv/kernel/ptrace.c              |   10 +++++-----
 arch/frv/kernel/semaphore.c           |    2 +-
 arch/frv/kernel/signal.c              |    4 ++--
 arch/frv/kernel/traps.c               |    4 ++--
 arch/frv/mm/fault.c                   |    4 ++--
 arch/h8300/kernel/traps.c             |    2 +-
 arch/i386/kernel/crash.c              |    2 +-
 arch/i386/kernel/process.c            |    2 +-
 arch/i386/kernel/signal.c             |    4 ++--
 arch/i386/kernel/traps.c              |    2 +-
 arch/i386/lib/usercopy.c              |    2 +-
 arch/i386/mm/fault.c                  |    2 +-
 arch/m32r/kernel/process.c            |    8 ++++----
 arch/m32r/kernel/signal.c             |    2 +-
 arch/m32r/kernel/traps.c              |    2 +-
 arch/m32r/mm/fault.c                  |    2 +-
 arch/m68k/kernel/traps.c              |    6 +++---
 arch/m68k/mac/macints.c               |    2 +-
 arch/m68k/mm/fault.c                  |    2 +-
 arch/m68knommu/kernel/process.c       |    2 +-
 arch/m68knommu/kernel/time.c          |    2 +-
 arch/m68knommu/kernel/traps.c         |    4 ++--
 arch/m68knommu/platform/5307/timers.c |    2 +-
 arch/parisc/kernel/signal.c           |    4 ++--
 arch/parisc/kernel/smp.c              |    5 +++--
 arch/parisc/kernel/sys_parisc32.c     |    2 +-
 arch/parisc/kernel/traps.c            |   12 ++++++------
 arch/parisc/kernel/unaligned.c        |    2 +-
 arch/parisc/mm/fault.c                |    2 +-
 arch/powerpc/kernel/process.c         |    2 +-
 arch/powerpc/kernel/traps.c           |    4 ++--
 arch/powerpc/mm/fault.c               |    2 +-
 arch/powerpc/platforms/pseries/ras.c  |    4 ++--
 arch/powerpc/xmon/xmon.c              |    2 +-
 arch/ppc/kernel/process.c             |    6 +++---
 arch/ppc/kernel/softemu8xx.c          |    2 +-
 arch/ppc/kernel/traps.c               |    4 ++--
 arch/ppc/lib/locks.c                  |    6 +++---
 arch/ppc/mm/fault.c                   |    2 +-
 arch/ppc/xmon/xmon.c                  |    2 +-
 arch/s390/kernel/asm-offsets.c        |    2 +-
 arch/s390/kernel/process.c            |    2 +-
 arch/s390/math-emu/math.c             |    2 +-
 arch/s390/mm/fault.c                  |    2 +-
 arch/sh/kernel/process.c              |    2 +-
 arch/sh/kernel/signal.c               |    4 ++--
 arch/sh/kernel/traps.c                |    2 +-
 arch/sh/mm/fault.c                    |    2 +-
 arch/sh64/kernel/process.c            |    2 +-
 arch/sh64/kernel/signal.c             |    4 ++--
 arch/sh64/kernel/traps.c              |    4 ++--
 arch/sh64/lib/dbg.c                   |   12 ++++++------
 arch/sh64/mm/fault.c                  |   10 +++++-----
 arch/sparc/kernel/process.c           |    2 +-
 arch/sparc/kernel/ptrace.c            |    8 ++++----
 arch/sparc/kernel/setup.c             |    2 +-
 arch/sparc/kernel/sys_sparc.c         |    2 +-
 arch/sparc/kernel/sys_sunos.c         |    2 +-
 arch/sparc/kernel/traps.c             |    4 ++--
 arch/sparc/mm/fault.c                 |    6 +++---
 arch/sparc64/kernel/process.c         |    2 +-
 arch/sparc64/kernel/setup.c           |    2 +-
 arch/sparc64/kernel/sys_sunos32.c     |    2 +-
 arch/sparc64/kernel/traps.c           |    2 +-
 arch/sparc64/solaris/ioctl.c          |    4 ++--
 arch/um/kernel/process_kern.c         |    4 ++--
 arch/um/kernel/skas/process_kern.c    |    4 ++--
 arch/um/kernel/trap_kern.c            |    2 +-
 arch/um/sys-x86_64/sysrq.c            |    2 +-
 arch/v850/kernel/bug.c                |    4 ++--
 arch/v850/kernel/signal.c             |    4 ++--
 arch/x86_64/ia32/ia32_signal.c        |    4 ++--
 arch/x86_64/ia32/ptrace32.c           |    2 +-
 arch/x86_64/kernel/asm-offsets.c      |    2 +-
 arch/x86_64/kernel/mce.c              |    2 +-
 arch/x86_64/kernel/process.c          |    2 +-
 arch/x86_64/kernel/signal.c           |   10 +++++-----
 arch/x86_64/kernel/traps.c            |    6 +++---
 arch/x86_64/mm/fault.c                |    8 ++++----
 arch/xtensa/kernel/signal.c           |    4 ++--
 arch/xtensa/kernel/syscalls.c         |    4 ++--
 arch/xtensa/kernel/traps.c            |    6 +++---
 arch/xtensa/mm/fault.c                |    4 ++--
 drivers/s390/crypto/z90main.c         |    2 +-
 105 files changed, 194 insertions(+), 193 deletions(-)

Index: linux-2.6.15-rc1/arch/i386/kernel/crash.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/i386/kernel/crash.c
+++ linux-2.6.15-rc1/arch/i386/kernel/crash.c
@@ -73,7 +73,7 @@ static void crash_save_this_cpu(struct p
 	 */
 	buf = &crash_notes[cpu][0];
 	memset(&prstatus, 0, sizeof(prstatus));
-	prstatus.pr_pid = current->pid;
+	prstatus.pr_pid = task_pid(current);
 	elf_core_copy_regs(&prstatus.pr_reg, regs);
 	buf = append_elf_note(buf, "CORE", NT_PRSTATUS, &prstatus,
 				sizeof(prstatus));
Index: linux-2.6.15-rc1/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/i386/kernel/process.c
+++ linux-2.6.15-rc1/arch/i386/kernel/process.c
@@ -290,7 +290,7 @@ void show_regs(struct pt_regs * regs)
 	unsigned long cr0 = 0L, cr2 = 0L, cr3 = 0L, cr4 = 0L;
 
 	printk("\n");
-	printk("Pid: %d, comm: %20s\n", current->pid, current->comm);
+	printk("Pid: %d, comm: %20s\n", task_pid(current), current->comm);
 	printk("EIP: %04x:[<%08lx>] CPU: %d\n",0xffff & regs->xcs,regs->eip, smp_processor_id());
 	print_symbol("EIP is at %s\n", regs->eip);
 
Index: linux-2.6.15-rc1/arch/i386/kernel/signal.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/i386/kernel/signal.c
+++ linux-2.6.15-rc1/arch/i386/kernel/signal.c
@@ -430,7 +430,7 @@ static int setup_frame(int sig, struct k
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=%p pc=%p ra=%p\n",
-		current->comm, current->pid, frame, regs->eip, frame->pretcode);
+		current->comm, task_pid(current), frame, regs->eip, frame->pretcode);
 #endif
 
 	return 1;
@@ -524,7 +524,7 @@ static int setup_rt_frame(int sig, struc
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=%p pc=%p ra=%p\n",
-		current->comm, current->pid, frame, regs->eip, frame->pretcode);
+		current->comm, task_pid(current), frame, regs->eip, frame->pretcode);
 #endif
 
 	return 1;
Index: linux-2.6.15-rc1/arch/i386/kernel/traps.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/i386/kernel/traps.c
+++ linux-2.6.15-rc1/arch/i386/kernel/traps.c
@@ -228,7 +228,7 @@ void show_registers(struct pt_regs *regs
 	printk("ds: %04x   es: %04x   ss: %04x\n",
 		regs->xds & 0xffff, regs->xes & 0xffff, ss);
 	printk("Process %s (pid: %d, threadinfo=%p task=%p)",
-		current->comm, current->pid, current_thread_info(), current);
+		current->comm, task_pid(current), current_thread_info(), current);
 	/*
 	 * When in-kernel, we also print out the stack and code at the
 	 * time of the fault..
Index: linux-2.6.15-rc1/arch/i386/lib/usercopy.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/i386/lib/usercopy.c
+++ linux-2.6.15-rc1/arch/i386/lib/usercopy.c
@@ -543,7 +543,7 @@ survive:
 			retval = get_user_pages(current, current->mm,
 					(unsigned long )to, 1, 1, 0, &pg, NULL);
 
-			if (retval == -ENOMEM && current->pid == 1) {
+			if (retval == -ENOMEM && task_pid(current) == 1) {
 				up_read(&current->mm->mmap_sem);
 				blk_congestion_wait(WRITE, HZ/50);
 				goto survive;
Index: linux-2.6.15-rc1/arch/i386/mm/fault.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/i386/mm/fault.c
+++ linux-2.6.15-rc1/arch/i386/mm/fault.c
@@ -485,7 +485,7 @@ no_context:
  */
 out_of_memory:
 	up_read(&mm->mmap_sem);
-	if (tsk->pid == 1) {
+	if (task_pid(tsk) == 1) {
 		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
Index: linux-2.6.15-rc1/arch/alpha/kernel/semaphore.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/alpha/kernel/semaphore.c
+++ linux-2.6.15-rc1/arch/alpha/kernel/semaphore.c
@@ -69,7 +69,7 @@ __down_failed(struct semaphore *sem)
 
 #ifdef CONFIG_DEBUG_SEMAPHORE
 	printk("%s(%d): down failed(%p)\n",
-	       tsk->comm, tsk->pid, sem);
+	       tsk->comm, task_pid(tsk), sem);
 #endif
 
 	tsk->state = TASK_UNINTERRUPTIBLE;
@@ -98,7 +98,7 @@ __down_failed(struct semaphore *sem)
 
 #ifdef CONFIG_DEBUG_SEMAPHORE
 	printk("%s(%d): down acquired(%p)\n",
-	       tsk->comm, tsk->pid, sem);
+	       tsk->comm, task_pid(tsk), sem);
 #endif
 }
 
@@ -111,7 +111,7 @@ __down_failed_interruptible(struct semap
 
 #ifdef CONFIG_DEBUG_SEMAPHORE
 	printk("%s(%d): down failed(%p)\n",
-	       tsk->comm, tsk->pid, sem);
+	       tsk->comm, task_pid(tsk), sem);
 #endif
 
 	tsk->state = TASK_INTERRUPTIBLE;
@@ -139,7 +139,7 @@ __down_failed_interruptible(struct semap
 
 #ifdef CONFIG_DEBUG_SEMAPHORE
 	printk("%s(%d): down %s(%p)\n",
-	       current->comm, current->pid,
+	       current->comm, task_pid(current),
 	       (ret < 0 ? "interrupted" : "acquired"), sem);
 #endif
 	return ret;
@@ -168,7 +168,7 @@ down(struct semaphore *sem)
 #endif
 #ifdef CONFIG_DEBUG_SEMAPHORE
 	printk("%s(%d): down(%p) <count=%d> from %p\n",
-	       current->comm, current->pid, sem,
+	       current->comm, task_pid(current), sem,
 	       atomic_read(&sem->count), __builtin_return_address(0));
 #endif
 	__down(sem);
@@ -182,7 +182,7 @@ down_interruptible(struct semaphore *sem
 #endif
 #ifdef CONFIG_DEBUG_SEMAPHORE
 	printk("%s(%d): down(%p) <count=%d> from %p\n",
-	       current->comm, current->pid, sem,
+	       current->comm, task_pid(current), sem,
 	       atomic_read(&sem->count), __builtin_return_address(0));
 #endif
 	return __down_interruptible(sem);
@@ -201,7 +201,7 @@ down_trylock(struct semaphore *sem)
 
 #ifdef CONFIG_DEBUG_SEMAPHORE
 	printk("%s(%d): down_trylock %s from %p\n",
-	       current->comm, current->pid,
+	       current->comm, task_pid(current),
 	       ret ? "failed" : "acquired",
 	       __builtin_return_address(0));
 #endif
@@ -217,7 +217,7 @@ up(struct semaphore *sem)
 #endif
 #ifdef CONFIG_DEBUG_SEMAPHORE
 	printk("%s(%d): up(%p) <count=%d> from %p\n",
-	       current->comm, current->pid, sem,
+	       current->comm, task_pid(current), sem,
 	       atomic_read(&sem->count), __builtin_return_address(0));
 #endif
 	__up(sem);
Index: linux-2.6.15-rc1/arch/alpha/kernel/signal.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/alpha/kernel/signal.c
+++ linux-2.6.15-rc1/arch/alpha/kernel/signal.c
@@ -479,7 +479,7 @@ setup_frame(int sig, struct k_sigaction 
 	
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=%p pc=%p ra=%p\n",
-		current->comm, current->pid, frame, regs->pc, regs->r26);
+		current->comm, task_pid(current), frame, regs->pc, regs->r26);
 #endif
 
 	return;
@@ -541,7 +541,7 @@ setup_rt_frame(int sig, struct k_sigacti
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=%p pc=%p ra=%p\n",
-		current->comm, current->pid, frame, regs->pc, regs->r26);
+		current->comm, task_pid(current), frame, regs->pc, regs->r26);
 #endif
 
 	return;
Index: linux-2.6.15-rc1/arch/alpha/kernel/traps.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/alpha/kernel/traps.c
+++ linux-2.6.15-rc1/arch/alpha/kernel/traps.c
@@ -183,7 +183,7 @@ die_if_kernel(char * str, struct pt_regs
 #ifdef CONFIG_SMP
 	printk("CPU %d ", hard_smp_processor_id());
 #endif
-	printk("%s(%d): %s %ld\n", current->comm, current->pid, str, err);
+	printk("%s(%d): %s %ld\n", current->comm, task_pid(current), str, err);
 	dik_show_regs(regs, r9_15);
 	dik_show_trace((unsigned long *)(regs+1));
 	dik_show_code((unsigned int *)regs->pc);
@@ -646,7 +646,7 @@ got_exception:
 	lock_kernel();
 
 	printk("%s(%d): unhandled unaligned exception\n",
-	       current->comm, current->pid);
+	       current->comm, task_pid(current));
 
 	printk("pc = [<%016lx>]  ra = [<%016lx>]  ps = %04lx\n",
 	       pc, una_reg(26), regs->ps);
@@ -786,7 +786,7 @@ do_entUnaUser(void __user * va, unsigned
 		}
 		if (++cnt < 5) {
 			printk("%s(%d): unaligned trap at %016lx: %p %lx %ld\n",
-			       current->comm, current->pid,
+			       current->comm, task_pid(current),
 			       regs->pc - 4, va, opcode, reg);
 		}
 		last_time = jiffies;
Index: linux-2.6.15-rc1/arch/alpha/mm/fault.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/alpha/mm/fault.c
+++ linux-2.6.15-rc1/arch/alpha/mm/fault.c
@@ -194,13 +194,13 @@ do_page_fault(unsigned long address, uns
 	/* We ran out of memory, or some other thing happened to us that
 	   made us unable to handle the page fault gracefully.  */
  out_of_memory:
-	if (current->pid == 1) {
+	if (task_pid(current) == 1) {
 		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
 	}
 	printk(KERN_ALERT "VM: killing process %s(%d)\n",
-	       current->comm, current->pid);
+	       current->comm, task_pid(current));
 	if (!user_mode(regs))
 		goto no_context;
 	do_exit(SIGKILL);
Index: linux-2.6.15-rc1/arch/arm/kernel/process.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/arm/kernel/process.c
+++ linux-2.6.15-rc1/arch/arm/kernel/process.c
@@ -227,7 +227,7 @@ void __show_regs(struct pt_regs *regs)
 void show_regs(struct pt_regs * regs)
 {
 	printk("\n");
-	printk("Pid: %d, comm: %20s\n", current->pid, current->comm);
+	printk("Pid: %d, comm: %20s\n", task_pid(current), current->comm);
 	__show_regs(regs);
 	__backtrace();
 }
Index: linux-2.6.15-rc1/arch/arm/kernel/ptrace.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/arm/kernel/ptrace.c
+++ linux-2.6.15-rc1/arch/arm/kernel/ptrace.c
@@ -392,7 +392,7 @@ static void clear_breakpoint(struct task
 
 		if (ret != 2 || old_insn.thumb != BREAKINST_THUMB)
 			printk(KERN_ERR "%s:%d: corrupted Thumb breakpoint at "
-				"0x%08lx (0x%04x)\n", task->comm, task->pid,
+				"0x%08lx (0x%04x)\n", task->comm, task_pid(task),
 				addr, old_insn.thumb);
 	} else {
 		ret = swap_insn(task, addr & ~3, &old_insn.arm,
@@ -400,7 +400,7 @@ static void clear_breakpoint(struct task
 
 		if (ret != 4 || old_insn.arm != BREAKINST_ARM)
 			printk(KERN_ERR "%s:%d: corrupted ARM breakpoint at "
-				"0x%08lx (0x%08x)\n", task->comm, task->pid,
+				"0x%08lx (0x%08x)\n", task->comm, task_pid(task),
 				addr, old_insn.arm);
 	}
 }
Index: linux-2.6.15-rc1/arch/arm/kernel/traps.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/arm/kernel/traps.c
+++ linux-2.6.15-rc1/arch/arm/kernel/traps.c
@@ -207,7 +207,7 @@ static void __die(const char *str, int e
 	print_modules();
 	__show_regs(regs);
 	printk("Process %s (pid: %d, stack limit = 0x%p)\n",
-		tsk->comm, tsk->pid, thread + 1);
+		tsk->comm, task_pid(tsk), thread + 1);
 
 	if (!user_mode(regs) || in_interrupt()) {
 		dump_mem("Stack: ", regs->ARM_sp,
@@ -306,7 +306,7 @@ asmlinkage void do_undefinstr(struct pt_
 #ifdef CONFIG_DEBUG_USER
 	if (user_debug & UDBG_UNDEFINED) {
 		printk(KERN_INFO "%s (%d): undefined instruction: pc=%p\n",
-			current->comm, current->pid, pc);
+			current->comm, task_pid(current), pc);
 		dump_instr(regs);
 	}
 #endif
@@ -360,7 +360,7 @@ static int bad_syscall(int n, struct pt_
 #ifdef CONFIG_DEBUG_USER
 	if (user_debug & UDBG_SYSCALL) {
 		printk(KERN_ERR "[%d] %s: obsolete system call %08x.\n",
-			current->pid, current->comm, n);
+			task_pid(current), current->comm, n);
 		dump_instr(regs);
 	}
 #endif
@@ -537,7 +537,7 @@ asmlinkage int arm_syscall(int no, struc
 	 */
 	if (user_debug & UDBG_SYSCALL) {
 		printk("[%d] %s: arm syscall %d\n",
-		       current->pid, current->comm, no);
+		       task_pid(current), current->comm, no);
 		dump_instr(regs);
 		if (user_mode(regs)) {
 			__show_regs(regs);
@@ -614,7 +614,7 @@ baddataabort(int code, unsigned long ins
 #ifdef CONFIG_DEBUG_USER
 	if (user_debug & UDBG_BADABORT) {
 		printk(KERN_ERR "[%d] %s: bad data abort: code %d instr 0x%08lx\n",
-			current->pid, current->comm, code, instr);
+			task_pid(current), current->comm, code, instr);
 		dump_instr(regs);
 		show_pte(current->mm, addr);
 	}
Index: linux-2.6.15-rc1/arch/arm/mm/alignment.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/arm/mm/alignment.c
+++ linux-2.6.15-rc1/arch/arm/mm/alignment.c
@@ -759,7 +759,7 @@ do_alignment(unsigned long addr, unsigne
 	if (ai_usermode & 1)
 		printk("Alignment trap: %s (%d) PC=0x%08lx Instr=0x%0*lx "
 		       "Address=0x%08lx FSR 0x%03x\n", current->comm,
-			current->pid, instrptr,
+			task_pid(current), instrptr,
 		        thumb_mode(regs) ? 4 : 8,
 		        thumb_mode(regs) ? tinstr : instr,
 		        addr, fsr);
Index: linux-2.6.15-rc1/arch/arm/mm/fault.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/arm/mm/fault.c
+++ linux-2.6.15-rc1/arch/arm/mm/fault.c
@@ -198,7 +198,7 @@ survive:
 		return fault;
 	}
 
-	if (tsk->pid != 1)
+	if (task_pid(tsk) != 1)
 		goto out;
 
 	/*
Index: linux-2.6.15-rc1/arch/arm/nwfpe/fpmodule.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/arm/nwfpe/fpmodule.c
+++ linux-2.6.15-rc1/arch/arm/nwfpe/fpmodule.c
@@ -131,7 +131,7 @@ void float_raise(signed char flags)
  	if (flags & ~BIT_IXC)
  		printk(KERN_DEBUG
 		       "NWFPE: %s[%d] takes exception %08x at %p from %08lx\n",
-		       current->comm, current->pid, flags,
+		       current->comm, task_pid(current), flags,
 		       __builtin_return_address(0), GET_USERREG()->ARM_pc);
 #endif
 
Index: linux-2.6.15-rc1/arch/arm26/kernel/ptrace.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/arm26/kernel/ptrace.c
+++ linux-2.6.15-rc1/arch/arm26/kernel/ptrace.c
@@ -366,7 +366,7 @@ static void clear_breakpoint(struct task
 
 	if (ret != 4 || old_insn != BREAKINST_ARM)
 		printk(KERN_ERR "%s:%d: corrupted ARM breakpoint at "
-			"0x%08lx (0x%08x)\n", task->comm, task->pid,
+			"0x%08lx (0x%08x)\n", task->comm, task_pid(task),
 			addr, old_insn);
 }
 
Index: linux-2.6.15-rc1/arch/arm26/kernel/traps.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/arm26/kernel/traps.c
+++ linux-2.6.15-rc1/arch/arm26/kernel/traps.c
@@ -187,7 +187,7 @@ NORET_TYPE void die(const char *str, str
 	printk("CPU: %d\n", smp_processor_id());
 	show_regs(regs);
 	printk("Process %s (pid: %d, stack limit = 0x%p)\n",
-		current->comm, current->pid, tsk->thread_info + 1);
+		current->comm, task_pid(current), tsk->thread_info + 1);
 
 	if (!user_mode(regs) || in_interrupt()) {
 		__dump_stack(tsk, (unsigned long)(regs + 1));
@@ -276,7 +276,7 @@ asmlinkage void do_undefinstr(struct pt_
 
 #ifdef CONFIG_DEBUG_USER
 	printk(KERN_INFO "%s (%d): undefined instruction: pc=%p\n",
-		current->comm, current->pid, pc);
+		current->comm, task_pid(current), pc);
 	dump_instr(regs);
 #endif
 
@@ -299,7 +299,7 @@ asmlinkage void do_excpt(unsigned long a
 
 #ifdef CONFIG_DEBUG_USER
 	printk(KERN_INFO "%s (%d): address exception: pc=%08lx\n",
-		current->comm, current->pid, instruction_pointer(regs));
+		current->comm, task_pid(current), instruction_pointer(regs));
 	dump_instr(regs);
 #endif
 
@@ -363,7 +363,7 @@ static int bad_syscall(int n, struct pt_
 
 #ifdef CONFIG_DEBUG_USER
 	printk(KERN_ERR "[%d] %s: obsolete system call %08x.\n",
-		current->pid, current->comm, n);
+		task_pid(current), current->comm, n);
 	dump_instr(regs);
 #endif
 
@@ -442,7 +442,7 @@ asmlinkage int arm_syscall(int no, struc
 	 * experience shows that these seem to indicate that
 	 * something catastrophic has happened
 	 */
-	printk("[%d] %s: arm syscall %d\n", current->pid, current->comm, no);
+	printk("[%d] %s: arm syscall %d\n", task_pid(current), current->comm, no);
 	dump_instr(regs);
 	if (user_mode(regs)) {
 		show_regs(regs);
@@ -478,7 +478,7 @@ baddataabort(int code, unsigned long ins
 
 #ifdef CONFIG_DEBUG_USER
 	printk(KERN_ERR "[%d] %s: bad data abort: code %d instr 0x%08lx\n",
-		current->pid, current->comm, code, instr);
+		task_pid(current), current->comm, code, instr);
 	dump_instr(regs);
 	show_pte(current->mm, addr);
 #endif
Index: linux-2.6.15-rc1/arch/arm26/mm/fault.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/arm26/mm/fault.c
+++ linux-2.6.15-rc1/arch/arm26/mm/fault.c
@@ -186,7 +186,7 @@ survive:
 	}
 
 	fault = -3; /* out of memory */
-	if (tsk->pid != 1)
+	if (task_pid(tsk) != 1)
 		goto out;
 
 	/*
Index: linux-2.6.15-rc1/arch/arm26/nwfpe/fpmodule.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/arm26/nwfpe/fpmodule.c
+++ linux-2.6.15-rc1/arch/arm26/nwfpe/fpmodule.c
@@ -145,7 +145,7 @@ void float_raise(signed char flags)
   
 #ifdef CONFIG_DEBUG_USER
   printk(KERN_DEBUG "NWFPE: %s[%d] takes exception %08x at %p from %08x\n",
-	 current->comm, current->pid, flags,
+	 current->comm, task_pid(current), flags,
 	 __builtin_return_address(0), GET_USERREG()[15]);
 #endif
 
Index: linux-2.6.15-rc1/arch/cris/arch-v10/kernel/traps.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/cris/arch-v10/kernel/traps.c
+++ linux-2.6.15-rc1/arch/cris/arch-v10/kernel/traps.c
@@ -40,7 +40,7 @@ show_registers(struct pt_regs * regs)
 	       regs->r12, regs->r13, regs->orig_r10, regs);
 	raw_printk("R_MMU_CAUSE: %08lx\n", (unsigned long)*R_MMU_CAUSE);
 	raw_printk("Process %s (pid: %d, stackpage=%08lx)\n",
-	       current->comm, current->pid, (unsigned long)current);
+	       current->comm, task_pid(current), (unsigned long)current);
 
 	/*
          * When in-kernel, we also print out the stack and code at the
Index: linux-2.6.15-rc1/arch/cris/arch-v32/kernel/process.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/cris/arch-v32/kernel/process.c
+++ linux-2.6.15-rc1/arch/cris/arch-v32/kernel/process.c
@@ -45,7 +45,7 @@ void default_idle(void)
 extern void deconfigure_bp(long pid);
 void exit_thread(void)
 {
-	deconfigure_bp(current->pid);
+	deconfigure_bp(task_pid(current));
 }
 
 /*
Index: linux-2.6.15-rc1/arch/cris/arch-v32/kernel/ptrace.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/cris/arch-v32/kernel/ptrace.c
+++ linux-2.6.15-rc1/arch/cris/arch-v32/kernel/ptrace.c
@@ -52,7 +52,7 @@ long get_reg(struct task_struct *task, u
 	else if (regno == PT_PPC)
 		ret = get_pseudo_pc(task);
 	else if (regno <= PT_MAX)
-		ret = get_debugreg(task->pid, regno);
+		ret = get_debugreg(task_pid(task), regno);
 	else
 		ret = 0;
 
@@ -73,7 +73,7 @@ int put_reg(struct task_struct *task, un
 		if (data != get_pseudo_pc(task))
 			((unsigned long *)user_regs(task->thread_info))[PT_ERP] = data;
 	} else if (regno <= PT_MAX)
-		return put_debugreg(task->pid, regno, data);
+		return put_debugreg(task_pid(task), regno, data);
 	else
 		return -1;
 	return 0;
Index: linux-2.6.15-rc1/arch/cris/arch-v32/kernel/signal.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/cris/arch-v32/kernel/signal.c
+++ linux-2.6.15-rc1/arch/cris/arch-v32/kernel/signal.c
@@ -648,7 +648,7 @@ ugdb_trap_user(struct thread_info *ti, i
 		if (!(user_regs(ti)->erp & 0x1))
 			user_regs(ti)->erp -= 2;
 	}
-	sys_kill(ti->task->pid, sig);
+	sys_kill(ti->task_pid(task), sig);
 }
 
 void
Index: linux-2.6.15-rc1/arch/cris/arch-v32/kernel/traps.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/cris/arch-v32/kernel/traps.c
+++ linux-2.6.15-rc1/arch/cris/arch-v32/kernel/traps.c
@@ -57,7 +57,7 @@ show_registers(struct pt_regs *regs)
 	raw_printk("Instruction MMU Cause: %08lx\n", i_mmu_cause);
 
 	raw_printk("Process %s (pid: %d, stackpage: %08lx)\n",
-		current->comm, current->pid, (unsigned long) current);
+		current->comm, task_pid(current), (unsigned long) current);
 
 	/* Show additional info if in kernel-mode. */
 	if (!user_mode(regs)) {
Index: linux-2.6.15-rc1/arch/cris/kernel/profile.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/cris/kernel/profile.c
+++ linux-2.6.15-rc1/arch/cris/kernel/profile.c
@@ -18,7 +18,7 @@ cris_profile_sample(struct pt_regs* regs
   if (!prof_running)
     return;
   if (user_mode(regs))
-    *(unsigned int*)sample_buffer_pos = current->pid;
+    *(unsigned int*)sample_buffer_pos = task_pid(current);
   else
     *(unsigned int*)sample_buffer_pos = 0;
   *(unsigned int*)(sample_buffer_pos + 4) = instruction_pointer(regs);
Index: linux-2.6.15-rc1/arch/frv/kernel/gdb-stub.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/frv/kernel/gdb-stub.c
+++ linux-2.6.15-rc1/arch/frv/kernel/gdb-stub.c
@@ -1182,7 +1182,7 @@ static void __attribute__((unused)) gdbs
 			printk(" | ");
 	}
 
-	gdbstub_printk("Process %s (pid: %d)\n", current->comm, current->pid);
+	gdbstub_printk("Process %s (pid: %d)\n", current->comm, task_pid(current));
 } /* end gdbstub_show_regs() */
 
 /*****************************************************************************/
Index: linux-2.6.15-rc1/arch/frv/kernel/ptrace.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/frv/kernel/ptrace.c
+++ linux-2.6.15-rc1/arch/frv/kernel/ptrace.c
@@ -639,7 +639,7 @@ asmlinkage void do_syscall_trace(int lea
 	if (!leaving) {
 		if (!argmask) {
 			printk(KERN_CRIT "[%d] %s(%lx,%lx,%lx,%lx,%lx,%lx)\n",
-			       current->pid,
+			       task_pid(current),
 			       name,
 			       __frame->gr8,
 			       __frame->gr9,
@@ -650,12 +650,12 @@ asmlinkage void do_syscall_trace(int lea
 		}
 		else if (argmask == 0xffffff) {
 			printk(KERN_CRIT "[%d] %s()\n",
-			       current->pid,
+			       task_pid(current),
 			       name);
 		}
 		else {
 			printk(KERN_CRIT "[%d] %s(",
-			       current->pid,
+			       task_pid(current),
 			       name);
 
 			argp = &__frame->gr8;
@@ -691,9 +691,9 @@ asmlinkage void do_syscall_trace(int lea
 	}
 	else {
 		if ((int)__frame->gr8 > -4096 && (int)__frame->gr8 < 4096)
-			printk(KERN_CRIT "[%d] %s() = %ld\n", current->pid, name, __frame->gr8);
+			printk(KERN_CRIT "[%d] %s() = %ld\n", task_pid(current), name, __frame->gr8);
 		else
-			printk(KERN_CRIT "[%d] %s() = %lx\n", current->pid, name, __frame->gr8);
+			printk(KERN_CRIT "[%d] %s() = %lx\n", task_pid(current), name, __frame->gr8);
 	}
 	return;
 #endif
Index: linux-2.6.15-rc1/arch/frv/kernel/semaphore.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/frv/kernel/semaphore.c
+++ linux-2.6.15-rc1/arch/frv/kernel/semaphore.c
@@ -25,7 +25,7 @@ void semtrace(struct semaphore *sem, con
 {
 	if (sem->debug)
 		printk("[%d] %s({%d,%d})\n",
-		       current->pid,
+		       task_pid(current),
 		       str,
 		       sem->counter,
 		       list_empty(&sem->wait_list) ? 0 : 1);
Index: linux-2.6.15-rc1/arch/frv/kernel/signal.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/frv/kernel/signal.c
+++ linux-2.6.15-rc1/arch/frv/kernel/signal.c
@@ -364,7 +364,7 @@ static void setup_frame(int sig, struct 
 
 #if DEBUG_SIG
 	printk("SIG deliver %d (%s:%d): sp=%p pc=%lx ra=%p\n",
-		sig, current->comm, current->pid, frame, regs->pc, frame->pretcode);
+		sig, current->comm, task_pid(current), frame, regs->pc, frame->pretcode);
 #endif
 
 	return;
@@ -459,7 +459,7 @@ static void setup_rt_frame(int sig, stru
 
 #if DEBUG_SIG
 	printk("SIG deliver %d (%s:%d): sp=%p pc=%lx ra=%p\n",
-		sig, current->comm, current->pid, frame, regs->pc, frame->pretcode);
+		sig, current->comm, task_pid(current), frame, regs->pc, frame->pretcode);
 #endif
 
 	return;
Index: linux-2.6.15-rc1/arch/frv/kernel/traps.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/frv/kernel/traps.c
+++ linux-2.6.15-rc1/arch/frv/kernel/traps.c
@@ -296,7 +296,7 @@ void show_regs(struct pt_regs *regs)
 			printk(" | ");
 	}
 
-	printk("Process %s (pid: %d)\n", current->comm, current->pid);
+	printk("Process %s (pid: %d)\n", current->comm, task_pid(current));
 }
 
 void die_if_kernel(const char *str, ...)
@@ -365,7 +365,7 @@ void show_backtrace(struct pt_regs *fram
 		stop = (unsigned long) frame;
 	}
 
-	printk("\nProcess %s (pid: %d)\n\n", current->comm, current->pid);
+	printk("\nProcess %s (pid: %d)\n\n", current->comm, task_pid(current));
 
 	for (;;) {
 		/* dump stack segment between frames */
Index: linux-2.6.15-rc1/arch/frv/mm/fault.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/frv/mm/fault.c
+++ linux-2.6.15-rc1/arch/frv/mm/fault.c
@@ -101,10 +101,10 @@ asmlinkage void do_page_fault(int datamm
 		if ((ear0 & PAGE_MASK) + 2 * PAGE_SIZE < __frame->sp) {
 #if 0
 			printk("[%d] ### Access below stack @%lx (sp=%lx)\n",
-			       current->pid, ear0, __frame->sp);
+			       task_pid(current), ear0, __frame->sp);
 			show_registers(__frame);
 			printk("[%d] ### Code: [%08lx] %02x %02x %02x %02x %02x %02x %02x %02x\n",
-			       current->pid,
+			       task_pid(current),
 			       __frame->pc,
 			       ((u8*)__frame->pc)[0],
 			       ((u8*)__frame->pc)[1],
Index: linux-2.6.15-rc1/arch/h8300/kernel/traps.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/h8300/kernel/traps.c
+++ linux-2.6.15-rc1/arch/h8300/kernel/traps.c
@@ -56,7 +56,7 @@ static void dump(struct pt_regs *fp)
 	int		i;
 
 	printk("\nCURRENT PROCESS:\n\n");
-	printk("COMM=%s PID=%d\n", current->comm, current->pid);
+	printk("COMM=%s PID=%d\n", current->comm, task_pid(current));
 	if (current->mm) {
 		printk("TEXT=%08x-%08x DATA=%08x-%08x BSS=%08x-%08x\n",
 			(int) current->mm->start_code,
Index: linux-2.6.15-rc1/arch/m32r/kernel/process.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/m32r/kernel/process.c
+++ linux-2.6.15-rc1/arch/m32r/kernel/process.c
@@ -214,19 +214,19 @@ int kernel_thread(int (*fn)(void *), voi
 void exit_thread(void)
 {
 	/* Nothing to do. */
-	DPRINTK("pid = %d\n", current->pid);
+	DPRINTK("pid = %d\n", task_pid(current));
 }
 
 void flush_thread(void)
 {
-	DPRINTK("pid = %d\n", current->pid);
+	DPRINTK("pid = %d\n", task_pid(current));
 	memset(&current->thread.debug_trap, 0, sizeof(struct debug_trap));
 }
 
 void release_thread(struct task_struct *dead_task)
 {
 	/* do nothing */
-	DPRINTK("pid = %d\n", dead_task->pid);
+	DPRINTK("pid = %d\n", dead_task_pid(task));
 }
 
 /* Fill in the fpu structure for a core dump.. */
@@ -249,7 +249,7 @@ int copy_thread(int nr, unsigned long cl
 
 	childregs->spu = spu;
 	childregs->r0 = 0;	/* Child gets zero as return value */
-	regs->r0 = tsk->pid;
+	regs->r0 = task_pid(tsk);
 	tsk->thread.sp = (unsigned long)childregs;
 	tsk->thread.lr = (unsigned long)ret_from_fork;
 
Index: linux-2.6.15-rc1/arch/m32r/kernel/signal.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/m32r/kernel/signal.c
+++ linux-2.6.15-rc1/arch/m32r/kernel/signal.c
@@ -294,7 +294,7 @@ static void setup_rt_frame(int sig, stru
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=%p pc=%p\n",
-		current->comm, current->pid, frame, regs->pc);
+		current->comm, task_pid(current), frame, regs->pc);
 #endif
 
 	return;
Index: linux-2.6.15-rc1/arch/m32r/kernel/traps.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/m32r/kernel/traps.c
+++ linux-2.6.15-rc1/arch/m32r/kernel/traps.c
@@ -197,7 +197,7 @@ static void show_registers(struct pt_reg
 		printk("SPI: %08lx\n", sp);
 	}
 	printk("Process %s (pid: %d, process nr: %d, stackpage=%08lx)",
-		current->comm, current->pid, 0xffff & i, 4096+(unsigned long)current);
+		current->comm, task_pid(current), 0xffff & i, 4096+(unsigned long)current);
 
 	/*
 	 * When in-kernel, we also print out the stack and code at the
Index: linux-2.6.15-rc1/arch/m32r/mm/fault.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/m32r/mm/fault.c
+++ linux-2.6.15-rc1/arch/m32r/mm/fault.c
@@ -300,7 +300,7 @@ no_context:
  */
 out_of_memory:
 	up_read(&mm->mmap_sem);
-	if (tsk->pid == 1) {
+	if (task_pid(tsk) == 1) {
 		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
Index: linux-2.6.15-rc1/arch/m68k/kernel/traps.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/m68k/kernel/traps.c
+++ linux-2.6.15-rc1/arch/m68k/kernel/traps.c
@@ -673,7 +673,7 @@ static inline void bus_error030 (struct 
 #ifdef DEBUG
 	unsigned long desc;
 
-	printk ("pid = %x  ", current->pid);
+	printk ("pid = %x  ", task_pid(current));
 	printk ("SSW=%#06x  ", ssw);
 
 	if (ssw & (FC | FB))
@@ -1057,7 +1057,7 @@ void bad_super_trap (struct frame *fp)
 				fp->un.fmtb.daddr, space_names[ssw & DFC],
 				fp->ptregs.pc);
 	}
-	printk ("Current process id is %d\n", current->pid);
+	printk ("Current process id is %d\n", task_pid(current));
 	die_if_kernel("BAD KERNEL TRAP", &fp->ptregs, 0);
 }
 
@@ -1199,7 +1199,7 @@ void die_if_kernel (char *str, struct pt
 	       fp->d4, fp->d5, fp->a0, fp->a1);
 
 	printk("Process %s (pid: %d, stackpage=%08lx)\n",
-		current->comm, current->pid, PAGE_SIZE+(unsigned long)current);
+		current->comm, task_pid(current), PAGE_SIZE+(unsigned long)current);
 	show_stack(NULL, (unsigned long *)fp);
 	do_exit(SIGSEGV);
 }
Index: linux-2.6.15-rc1/arch/m68k/mac/macints.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/m68k/mac/macints.c
+++ linux-2.6.15-rc1/arch/m68k/mac/macints.c
@@ -696,7 +696,7 @@ irqreturn_t mac_nmi_handler(int irq, voi
 		if (STACK_MAGIC != *(unsigned long *)current->kernel_stack_page)
 			printk("Corrupted stack page\n");
 		printk("Process %s (pid: %d, stackpage=%08lx)\n",
-			current->comm, current->pid, current->kernel_stack_page);
+			current->comm, task_pid(current), current->kernel_stack_page);
 		if (intr_count == 1)
 			dump_stack((struct frame *)fp);
 #else
Index: linux-2.6.15-rc1/arch/m68k/mm/fault.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/m68k/mm/fault.c
+++ linux-2.6.15-rc1/arch/m68k/mm/fault.c
@@ -181,7 +181,7 @@ good_area:
  */
 out_of_memory:
 	up_read(&mm->mmap_sem);
-	if (current->pid == 1) {
+	if (task_pid(current) == 1) {
 		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
Index: linux-2.6.15-rc1/arch/m68knommu/kernel/process.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/m68knommu/kernel/process.c
+++ linux-2.6.15-rc1/arch/m68knommu/kernel/process.c
@@ -331,7 +331,7 @@ void dump(struct pt_regs *fp)
 	int		i;
 
 	printk(KERN_EMERG "\nCURRENT PROCESS:\n\n");
-	printk(KERN_EMERG "COMM=%s PID=%d\n", current->comm, current->pid);
+	printk(KERN_EMERG "COMM=%s PID=%d\n", current->comm, task_pid(current));
 
 	if (current->mm) {
 		printk(KERN_EMERG "TEXT=%08x-%08x DATA=%08x-%08x BSS=%08x-%08x\n",
Index: linux-2.6.15-rc1/arch/m68knommu/kernel/time.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/m68knommu/kernel/time.c
+++ linux-2.6.15-rc1/arch/m68knommu/kernel/time.c
@@ -56,7 +56,7 @@ static irqreturn_t timer_interrupt(int i
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
-	if (current->pid)
+	if (task_pid(current))
 		profile_tick(CPU_PROFILING, regs);
 
 	/*
Index: linux-2.6.15-rc1/arch/m68knommu/kernel/traps.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/m68knommu/kernel/traps.c
+++ linux-2.6.15-rc1/arch/m68knommu/kernel/traps.c
@@ -82,7 +82,7 @@ void die_if_kernel(char *str, struct pt_
 	       fp->d4, fp->d5, fp->a0, fp->a1);
 
 	printk(KERN_EMERG "Process %s (pid: %d, stackpage=%08lx)\n",
-		current->comm, current->pid, PAGE_SIZE+(unsigned long)current);
+		current->comm, task_pid(current), PAGE_SIZE+(unsigned long)current);
 	show_stack(NULL, (unsigned long *)fp);
 	do_exit(SIGSEGV);
 }
@@ -166,7 +166,7 @@ void bad_super_trap(struct frame *fp)
 		printk (KERN_WARNING "*** Exception %d ***   FORMAT=%X\n",
 			(fp->ptregs.vector) >> 2, 
 			fp->ptregs.format);
-	printk (KERN_WARNING "Current process id is %d\n", current->pid);
+	printk (KERN_WARNING "Current process id is %d\n", task_pid(current));
 	die_if_kernel("BAD KERNEL TRAP", &fp->ptregs, 0);
 }
 
Index: linux-2.6.15-rc1/arch/m68knommu/platform/5307/timers.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/m68knommu/platform/5307/timers.c
+++ linux-2.6.15-rc1/arch/m68knommu/platform/5307/timers.c
@@ -110,7 +110,7 @@ void coldfire_profile_tick(int irq, void
 {
 	/* Reset ColdFire timer2 */
 	mcf_proftp->ter = MCFTIMER_TER_CAP | MCFTIMER_TER_REF;
-	if (current->pid)
+	if (task_pid(current))
 		profile_tick(CPU_PROFILING, regs);
 }
 
Index: linux-2.6.15-rc1/arch/parisc/kernel/signal.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/parisc/kernel/signal.c
+++ linux-2.6.15-rc1/arch/parisc/kernel/signal.c
@@ -228,7 +228,7 @@ give_sigsegv:
 	si.si_signo = SIGSEGV;
 	si.si_errno = 0;
 	si.si_code = SI_KERNEL;
-	si.si_pid = current->pid;
+	si.si_pid = task_pid(current);
 	si.si_uid = current->uid;
 	si.si_addr = &frame->uc;
 	force_sig_info(SIGSEGV, &si, current);
@@ -483,7 +483,7 @@ setup_rt_frame(int sig, struct k_sigacti
 
 
 	DBG(1,"setup_rt_frame: sig deliver (%s,%d) frame=0x%p sp=%#lx iaoq=%#lx/%#lx rp=%#lx\n",
-	       current->comm, current->pid, frame, regs->gr[30],
+	       current->comm, task_pid(current), frame, regs->gr[30],
 	       regs->iaoq[0], regs->iaoq[1], rp);
 
 	return 1;
Index: linux-2.6.15-rc1/arch/parisc/kernel/smp.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/parisc/kernel/smp.c
+++ linux-2.6.15-rc1/arch/parisc/kernel/smp.c
@@ -680,7 +680,8 @@ int sys_cpus(int argc, char **argv)
 		}
 #else
 		printk("\n%s  %4d      0     0 --------",
-			(current->pid)?"RUNNING ": "IDLING  ",current->pid); 
+			(task_pid(current))?"RUNNING ": "IDLING  ",
+						task_pid(current));
 #endif
 	} else if ((argc==2) && !(strcmp(argv[1],"-s"))) { 
 #ifdef DUMP_MORE_STATE
@@ -705,7 +706,7 @@ int sys_cpus(int argc, char **argv)
 			}	
 		}
 #else
-		printk("\n%s    CPU0",(current->pid==0)?"RUNNING ":"IDLING  "); 
+		printk("\n%s    CPU0",(task_pid(current)==0)?"RUNNING ":"IDLING  ");
 #endif
 	} else {
 		printk("sys_cpus:Unknown request\n");
Index: linux-2.6.15-rc1/arch/parisc/kernel/sys_parisc32.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/parisc/kernel/sys_parisc32.c
+++ linux-2.6.15-rc1/arch/parisc/kernel/sys_parisc32.c
@@ -95,7 +95,7 @@ asmlinkage long sys32_unimplemented(int 
 	int r22, int r21, int r20)
 {
     printk(KERN_ERR "%s(%d): Unimplemented 32 on 64 syscall #%d!\n", 
-    	current->comm, current->pid, r20);
+    	current->comm, task_pid(current), r20);
     return -ENOSYS;
 }
 
Index: linux-2.6.15-rc1/arch/parisc/kernel/traps.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/parisc/kernel/traps.c
+++ linux-2.6.15-rc1/arch/parisc/kernel/traps.c
@@ -216,7 +216,7 @@ void die_if_kernel(char *str, struct pt_
 			return; /* STFU */
 
 		printk(KERN_CRIT "%s (pid %d): %s (code %ld) at " RFMT "\n",
-			current->comm, current->pid, str, err, regs->iaoq[0]);
+			current->comm, task_pid(current), str, err, regs->iaoq[0]);
 #ifdef PRINT_USER_FAULTS
 		/* XXX for debugging only */
 		show_regs(regs);
@@ -248,7 +248,7 @@ void die_if_kernel(char *str, struct pt_
 		pdc_console_restart();
 	
 	printk(KERN_CRIT "%s (pid %d): %s (code %ld)\n",
-		current->comm, current->pid, str, err);
+		current->comm, task_pid(current), str, err);
 	show_regs(regs);
 
 	/* Wot's wrong wif bein' racy? */
@@ -288,7 +288,7 @@ void handle_break(unsigned iir, struct p
 	case 0x00:
 #ifdef PRINT_USER_FAULTS
 		printk(KERN_DEBUG "break 0,0: pid=%d command='%s'\n",
-		       current->pid, current->comm);
+		       task_pid(current), current->comm);
 #endif
 		die_if_kernel("Breakpoint", regs, 0);
 #ifdef PRINT_USER_FAULTS
@@ -308,7 +308,7 @@ void handle_break(unsigned iir, struct p
 	default:
 #ifdef PRINT_USER_FAULTS
 		printk(KERN_DEBUG "break %#08x: pid=%d command='%s'\n",
-		       iir, current->pid, current->comm);
+		       iir, task_pid(current), current->comm);
 		show_regs(regs);
 #endif
 		si.si_signo = SIGTRAP;
@@ -746,7 +746,7 @@ void handle_interruption(int code, struc
 		if (user_mode(regs)) {
 #ifdef PRINT_USER_FAULTS
 			printk(KERN_DEBUG "\nhandle_interruption() pid=%d command='%s'\n",
-			    current->pid, current->comm);
+			    task_pid(current), current->comm);
 			show_regs(regs);
 #endif
 			/* SIGBUS, for lack of a better one. */
@@ -771,7 +771,7 @@ void handle_interruption(int code, struc
 		else
 			printk(KERN_DEBUG "User Fault (long pointer) (fault %d) ",
 			       code);
-		printk("pid=%d command='%s'\n", current->pid, current->comm);
+		printk("pid=%d command='%s'\n", task_pid(current), current->comm);
 		show_regs(regs);
 #endif
 		si.si_signo = SIGSEGV;
Index: linux-2.6.15-rc1/arch/parisc/kernel/unaligned.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/parisc/kernel/unaligned.c
+++ linux-2.6.15-rc1/arch/parisc/kernel/unaligned.c
@@ -527,7 +527,7 @@ void handle_unaligned(struct pt_regs *re
 		    && ++unaligned_count < 5) {
 			char buf[256];
 			sprintf(buf, "%s(%d): unaligned access to 0x" RFMT " at ip=0x" RFMT "\n",
-				current->comm, current->pid, regs->ior, regs->iaoq[0]);
+				current->comm, task_pid(current), regs->ior, regs->iaoq[0]);
 			printk(KERN_WARNING "%s", buf);
 #ifdef DEBUG_UNALIGNED
 			show_regs(regs);
Index: linux-2.6.15-rc1/arch/parisc/mm/fault.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/parisc/mm/fault.c
+++ linux-2.6.15-rc1/arch/parisc/mm/fault.c
@@ -214,7 +214,7 @@ bad_area:
 #ifdef PRINT_USER_FAULTS
 		printk(KERN_DEBUG "\n");
 		printk(KERN_DEBUG "do_page_fault() pid=%d command='%s' type=%lu address=0x%08lx\n",
-		    tsk->pid, tsk->comm, code, address);
+		    task_pid(tsk), tsk->comm, code, address);
 		if (vma) {
 			printk(KERN_DEBUG "vm_start = 0x%08lx, vm_end = 0x%08lx\n",
 					vma->vm_start, vma->vm_end);
Index: linux-2.6.15-rc1/arch/ppc/kernel/process.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/ppc/kernel/process.c
+++ linux-2.6.15-rc1/arch/ppc/kernel/process.c
@@ -112,7 +112,7 @@ int check_stack(struct task_struct *tsk)
 	{
 		printk("stack out of bounds: %s/%d\n"
 		       " tsk_top %08lx ksp %08lx stack_top %08lx\n",
-		       tsk->comm,tsk->pid,
+		       tsk->comm,task_pid(tsk),
 		       tsk_top, tsk->thread.ksp, stack_top);
 		ret |= 2;
 	}
@@ -122,7 +122,7 @@ int check_stack(struct task_struct *tsk)
 	{
 		printk("current stack ptr out of bounds: %s/%d\n"
 		       " tsk_top %08lx sp %08lx stack_top %08lx\n",
-		       current->comm,current->pid,
+		       current->comm,task_pid(current),
 		       tsk_top, _get_SP(), stack_top);
 		ret |= 4;
 	}
@@ -384,7 +384,7 @@ void show_regs(struct pt_regs * regs)
 	if (trap == 0x300 || trap == 0x600)
 		printk("DAR: %08lX, DSISR: %08lX\n", regs->dar, regs->dsisr);
 	printk("TASK = %p[%d] '%s' THREAD: %p\n",
-	       current, current->pid, current->comm, current->thread_info);
+	       current, task_pid(current), current->comm, current->thread_info);
 	printk("Last syscall: %ld ", current->thread.last_syscall);
 
 #ifdef CONFIG_SMP
Index: linux-2.6.15-rc1/arch/ppc/kernel/softemu8xx.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/ppc/kernel/softemu8xx.c
+++ linux-2.6.15-rc1/arch/ppc/kernel/softemu8xx.c
@@ -120,7 +120,7 @@ Soft_emulate_8xx(struct pt_regs *regs)
 		printk("Bad emulation %s/%d\n"
 		       " NIP: %08lx instruction: %08x opcode: %x "
 		       "A: %x B: %x C: %x code: %x rc: %x\n",
-		       current->comm,current->pid,
+		       current->comm,task_pid(current),
 		       regs->nip,
 		       instword,inst,
 		       (instword>>16)&0x1f,
Index: linux-2.6.15-rc1/arch/ppc/kernel/traps.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/ppc/kernel/traps.c
+++ linux-2.6.15-rc1/arch/ppc/kernel/traps.c
@@ -131,7 +131,7 @@ void _exception(int signr, struct pt_reg
 	 * generate the same exception over and over again and we get
 	 * nowhere.  Better to kill it and let the kernel panic.
 	 */
-	if (current->pid == 1) {
+	if (task_pid(current) == 1) {
 		__sighandler_t handler;
 
 		spin_lock_irq(&current->sighand->siglock);
@@ -759,7 +759,7 @@ void nonrecoverable_exception(struct pt_
 void trace_syscall(struct pt_regs *regs)
 {
 	printk("Task: %p(%d), PC: %08lX/%08lX, Syscall: %3ld, Result: %s%ld    %s\n",
-	       current, current->pid, regs->nip, regs->link, regs->gpr[0],
+	       current, task_pid(current), regs->nip, regs->link, regs->gpr[0],
 	       regs->ccr&0x10000000?"Error=":"", regs->gpr[3], print_tainted());
 }
 
Index: linux-2.6.15-rc1/arch/ppc/lib/locks.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/ppc/lib/locks.c
+++ linux-2.6.15-rc1/arch/ppc/lib/locks.c
@@ -80,7 +80,7 @@ void _raw_spin_unlock(spinlock_t *lp)
   	if ( !lp->lock )
 		printk("_spin_unlock(%p): no lock cpu %d curr PC %p %s/%d\n",
 		       lp, smp_processor_id(), __builtin_return_address(0),
-		       current->comm, current->pid);
+		       current->comm, task_pid(current));
 	if ( lp->owner_cpu != smp_processor_id() )
 		printk("_spin_unlock(%p): cpu %d trying clear of cpu %d pc %lx val %lx\n",
 		      lp, smp_processor_id(), (int)lp->owner_cpu,
@@ -142,7 +142,7 @@ void _raw_read_unlock(rwlock_t *rw)
 {
 	if ( rw->lock == 0 )
 		printk("_read_unlock(): %s/%d (nip %08lX) lock %d\n",
-		       current->comm,current->pid,current->thread.regs->nip,
+		       current->comm,task_pid(current),current->thread.regs->nip,
 		      rw->lock);
 	wmb();
 	atomic_dec((atomic_t *) &(rw)->lock);
@@ -180,7 +180,7 @@ void _raw_write_unlock(rwlock_t *rw)
 {
 	if (rw->lock >= 0)
 		printk("_write_lock(): %s/%d (nip %08lX) lock %d\n",
-		      current->comm,current->pid,current->thread.regs->nip,
+		      current->comm,task_pid(current),current->thread.regs->nip,
 		      rw->lock);
 	wmb();
 	rw->lock = 0;
Index: linux-2.6.15-rc1/arch/ppc/mm/fault.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/ppc/mm/fault.c
+++ linux-2.6.15-rc1/arch/ppc/mm/fault.c
@@ -290,7 +290,7 @@ bad_area:
  */
 out_of_memory:
 	up_read(&mm->mmap_sem);
-	if (current->pid == 1) {
+	if (task_pid(current) == 1) {
 		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
Index: linux-2.6.15-rc1/arch/ppc/xmon/xmon.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/ppc/xmon/xmon.c
+++ linux-2.6.15-rc1/arch/ppc/xmon/xmon.c
@@ -895,7 +895,7 @@ excprint(struct pt_regs *fp)
 		printf("dar = %x, dsisr = %x\n", fp->dar, fp->dsisr);
 	if (current)
 		printf("current = %x, pid = %d, comm = %s\n",
-		       current, current->pid, current->comm);
+		       current, task_pid(current), current->comm);
 }
 
 void
Index: linux-2.6.15-rc1/arch/s390/kernel/process.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/s390/kernel/process.c
+++ linux-2.6.15-rc1/arch/s390/kernel/process.c
@@ -155,7 +155,7 @@ void show_regs(struct pt_regs *regs)
 
         printk("CPU:    %d    %s\n", tsk->thread_info->cpu, print_tainted());
         printk("Process %s (pid: %d, task: %p, ksp: %p)\n",
-	       current->comm, current->pid, (void *) tsk,
+	       current->comm, task_pid(current), (void *) tsk,
 	       (void *) tsk->thread.ksp);
 
 	show_registers(regs);
Index: linux-2.6.15-rc1/arch/s390/math-emu/math.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/s390/math-emu/math.c
+++ linux-2.6.15-rc1/arch/s390/math-emu/math.c
@@ -108,7 +108,7 @@ static void display_emulation_not_implem
                 location = (__u16 *)(regs->psw.addr-S390_lowcore.pgm_ilc);
                 printk("%s ieee fpu instruction not emulated "
                        "process name: %s pid: %d \n",
-                       instr, current->comm, current->pid);
+                       instr, current->comm, task_pid(current));
                 printk("%s's PSW:    %08lx %08lx\n", instr,
                        (unsigned long) regs->psw.mask,
                        (unsigned long) location);
Index: linux-2.6.15-rc1/arch/s390/mm/fault.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/s390/mm/fault.c
+++ linux-2.6.15-rc1/arch/s390/mm/fault.c
@@ -316,7 +316,7 @@ no_context:
 */
 out_of_memory:
 	up_read(&mm->mmap_sem);
-	if (tsk->pid == 1) {
+	if (task_pid(tsk) == 1) {
 		yield();
 		goto survive;
 	}
Index: linux-2.6.15-rc1/arch/sh/kernel/process.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/sh/kernel/process.c
+++ linux-2.6.15-rc1/arch/sh/kernel/process.c
@@ -105,7 +105,7 @@ void machine_power_off(void)
 void show_regs(struct pt_regs * regs)
 {
 	printk("\n");
-	printk("Pid : %d, Comm: %20s\n", current->pid, current->comm);
+	printk("Pid : %d, Comm: %20s\n", task_pid(current), current->comm);
 	print_symbol("PC is at %s\n", regs->pc);
 	printk("PC  : %08lx SP  : %08lx SR  : %08lx ",
 	       regs->pc, regs->regs[15], regs->sr);
Index: linux-2.6.15-rc1/arch/sh/kernel/signal.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/sh/kernel/signal.c
+++ linux-2.6.15-rc1/arch/sh/kernel/signal.c
@@ -404,7 +404,7 @@ static void setup_frame(int sig, struct 
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=%p pc=%08lx pr=%08lx\n",
-		current->comm, current->pid, frame, regs->pc, regs->pr);
+		current->comm, task_pid(current), frame, regs->pc, regs->pr);
 #endif
 
 	flush_cache_sigtramp(regs->pr);
@@ -479,7 +479,7 @@ static void setup_rt_frame(int sig, stru
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=%p pc=%08lx pr=%08lx\n",
-		current->comm, current->pid, frame, regs->pc, regs->pr);
+		current->comm, task_pid(current), frame, regs->pc, regs->pr);
 #endif
 
 	flush_cache_sigtramp(regs->pr);
Index: linux-2.6.15-rc1/arch/sh/kernel/traps.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/sh/kernel/traps.c
+++ linux-2.6.15-rc1/arch/sh/kernel/traps.c
@@ -362,7 +362,7 @@ static int handle_unaligned_access(u16 i
 		handle_unaligned_notify_count--;
 
 		printk("Fixing up unaligned userspace access in \"%s\" pid=%d pc=0x%p ins=0x%04hx\n",
-		       current->comm,current->pid,(u16*)regs->pc,instruction);
+		       current->comm,task_pid(current),(u16*)regs->pc,instruction);
 	}
 
 	ret = -EFAULT;
Index: linux-2.6.15-rc1/arch/sh/mm/fault.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/sh/mm/fault.c
+++ linux-2.6.15-rc1/arch/sh/mm/fault.c
@@ -160,7 +160,7 @@ no_context:
  */
 out_of_memory:
 	up_read(&mm->mmap_sem);
-	if (current->pid == 1) {
+	if (task_pid(current) == 1) {
 		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
Index: linux-2.6.15-rc1/arch/sh64/kernel/process.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/sh64/kernel/process.c
+++ linux-2.6.15-rc1/arch/sh64/kernel/process.c
@@ -927,7 +927,7 @@ asids_proc_info(char *buf, char **start,
 	struct task_struct *p;
 	read_lock(&tasklist_lock);
 	for_each_process(p) {
-		int pid = p->pid;
+		int pid = task_pid(p);
 		struct mm_struct *mm;
 		if (!pid) continue;
 		mm = p->mm;
Index: linux-2.6.15-rc1/arch/sh64/kernel/signal.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/sh64/kernel/signal.c
+++ linux-2.6.15-rc1/arch/sh64/kernel/signal.c
@@ -512,7 +512,7 @@ static void setup_frame(int sig, struct 
 	/* Broken %016Lx */
 	printk("SIG deliver (#%d,%s:%d): sp=%p pc=%08Lx%08Lx link=%08Lx%08Lx\n",
 		signal,
-		current->comm, current->pid, frame,
+		current->comm, task_pid(current), frame,
 		regs->pc >> 32, regs->pc & 0xffffffff,
 		DEREF_REG_PR >> 32, DEREF_REG_PR & 0xffffffff);
 #endif
@@ -618,7 +618,7 @@ static void setup_rt_frame(int sig, stru
 	/* Broken %016Lx */
 	printk("SIG deliver (#%d,%s:%d): sp=%p pc=%08Lx%08Lx link=%08Lx%08Lx\n",
 		signal,
-		current->comm, current->pid, frame,
+		current->comm, task_pid(current), frame,
 		regs->pc >> 32, regs->pc & 0xffffffff,
 		DEREF_REG_PR >> 32, DEREF_REG_PR & 0xffffffff);
 #endif
Index: linux-2.6.15-rc1/arch/sh64/kernel/traps.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/sh64/kernel/traps.c
+++ linux-2.6.15-rc1/arch/sh64/kernel/traps.c
@@ -765,7 +765,7 @@ static int misaligned_fixup(struct pt_re
 		--user_mode_unaligned_fixup_count;
 		/* Only do 'count' worth of these reports, to remove a potential DoS against syslog */
 		printk("Fixing up unaligned userspace access in \"%s\" pid=%d pc=0x%08x ins=0x%08lx\n",
-		       current->comm, current->pid, (__u32)regs->pc, opcode);
+		       current->comm, task_pid(current), (__u32)regs->pc, opcode);
 	} else
 #endif
 	if (!user_mode(regs) && (kernel_mode_unaligned_fixup_count > 0)) {
@@ -775,7 +775,7 @@ static int misaligned_fixup(struct pt_re
 			       (__u32)regs->pc, opcode);
 		} else {
 			printk("Fixing up unaligned kernelspace access in \"%s\" pid=%d pc=0x%08x ins=0x%08lx\n",
-			       current->comm, current->pid, (__u32)regs->pc, opcode);
+			       current->comm, task_pid(current), (__u32)regs->pc, opcode);
 		}
 	}
 
Index: linux-2.6.15-rc1/arch/sh64/lib/dbg.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/sh64/lib/dbg.c
+++ linux-2.6.15-rc1/arch/sh64/lib/dbg.c
@@ -173,7 +173,7 @@ void evt_debug(int evt, int ret_addr, in
 	int pid;
 	struct ring_node *rr;
 
-	pid = current->pid;
+	pid = task_pid(current);
 	stack_bottom = (unsigned long) current->thread_info;
 	asm volatile("ori r15, 0, %0" : "=r" (sp));
 	rr = event_ring + event_ptr;
@@ -209,7 +209,7 @@ void evt_debug(int evt, int ret_addr, in
 			 *
 			 * Just overwrite old entries on ring overflow - this
 			 * is only for last-hope debugging. */
-			stored_syscalls[syscall_next].pid = current->pid;
+			stored_syscalls[syscall_next].pid = task_pid(current);
 			stored_syscalls[syscall_next].syscall_number = syscallno;
 			syscall_next++;
 			syscall_next &= (N_STORED_SYSCALLS - 1);
@@ -230,7 +230,7 @@ static void drain_syscalls(void) {
 void evt_debug2(unsigned int ret)
 {
 	drain_syscalls();
-	printk("Task %d: syscall returns %08x\n", current->pid, ret);
+	printk("Task %d: syscall returns %08x\n", task_pid(current), ret);
 }
 
 void evt_debug_ret_from_irq(struct pt_regs *regs)
@@ -238,7 +238,7 @@ void evt_debug_ret_from_irq(struct pt_re
 	int pid;
 	struct ring_node *rr;
 
-	pid = current->pid;
+	pid = task_pid(current);
 	rr = event_ring + event_ptr;
 	rr->evt = 0xffff;
 	rr->ret_addr = 0;
@@ -254,7 +254,7 @@ void evt_debug_ret_from_exc(struct pt_re
 	int pid;
 	struct ring_node *rr;
 
-	pid = current->pid;
+	pid = task_pid(current);
 	rr = event_ring + event_ptr;
 	rr->evt = 0xfffe;
 	rr->ret_addr = 0;
@@ -276,7 +276,7 @@ void show_excp_regs(char *from, int trap
 
 	printk("\n");
 	printk("EXCEPTION - %s: task %d; Linux trap # %d; signal = %d\n",
-	       ((from) ? from : "???"), current->pid, trapnr, signr);
+	       ((from) ? from : "???"), task_pid(current), trapnr, signr);
 
 	asm volatile ("getcon   " __EXPEVT ", %0":"=r"(ah));
 	asm volatile ("getcon   " __EXPEVT ", %0":"=r"(al));
Index: linux-2.6.15-rc1/arch/sh64/mm/fault.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/sh64/mm/fault.c
+++ linux-2.6.15-rc1/arch/sh64/mm/fault.c
@@ -82,7 +82,7 @@ static inline void print_vma(struct vm_a
 
 static inline void print_task(struct task_struct *tsk)
 {
-	printk("Task pid %d\n", tsk->pid);
+	printk("Task pid %d\n", task_pid(tsk));
 }
 
 static pte_t *lookup_pte(struct mm_struct *mm, unsigned long address)
@@ -271,13 +271,13 @@ bad_area:
 			 * usermode, so only need a few */
 			count++;
 			printk("user mode bad_area address=%08lx pid=%d (%s) pc=%08lx\n",
-				address, current->pid, current->comm,
+				address, task_pid(current), current->comm,
 				(unsigned long) regs->pc);
 #if 0
 			show_regs(regs);
 #endif
 		}
-		if (tsk->pid == 1) {
+		if (task_pid(tsk) == 1) {
 			panic("INIT had user mode bad_area\n");
 		}
 		tsk->thread.address = address;
@@ -319,14 +319,14 @@ no_context:
  * us unable to handle the page fault gracefully.
  */
 out_of_memory:
-	if (current->pid == 1) {
+	if (task_pid(current) == 1) {
 		panic("INIT out of memory\n");
 		yield();
 		goto survive;
 	}
 	printk("fault:Out of memory\n");
 	up_read(&mm->mmap_sem);
-	if (current->pid == 1) {
+	if (task_pid(current) == 1) {
 		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
Index: linux-2.6.15-rc1/arch/sparc/kernel/process.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/sparc/kernel/process.c
+++ linux-2.6.15-rc1/arch/sparc/kernel/process.c
@@ -554,7 +554,7 @@ int copy_thread(int nr, unsigned long cl
 #endif
 
 	/* Set the return value for the child. */
-	childregs->u_regs[UREG_I0] = current->pid;
+	childregs->u_regs[UREG_I0] = task_pid(current);
 	childregs->u_regs[UREG_I1] = 1;
 
 	/* Set the return value for the parent. */
Index: linux-2.6.15-rc1/arch/sparc/kernel/ptrace.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/sparc/kernel/ptrace.c
+++ linux-2.6.15-rc1/arch/sparc/kernel/ptrace.c
@@ -155,7 +155,7 @@ static inline void read_sunos_user(struc
 		/* Rest of them are completely unsupported. */
 	default:
 		printk("%s [%d]: Wants to read user offset %ld\n",
-		       current->comm, current->pid, offset);
+		       current->comm, task_pid(current), offset);
 		pt_error_return(regs, EIO);
 		return;
 	}
@@ -222,7 +222,7 @@ static inline void write_sunos_user(stru
 		/* Rest of them are completely unsupported or "no-touch". */
 	default:
 		printk("%s [%d]: Wants to write user offset %ld\n",
-		       current->comm, current->pid, offset);
+		       current->comm, task_pid(current), offset);
 		goto failure;
 	}
 success:
@@ -596,7 +596,7 @@ out:
 asmlinkage void syscall_trace(void)
 {
 #ifdef DEBUG_PTRACE
-	printk("%s [%d]: syscall_trace\n", current->comm, current->pid);
+	printk("%s [%d]: syscall_trace\n", current->comm, task_pid(current));
 #endif
 	if (!test_thread_flag(TIF_SYSCALL_TRACE))
 		return;
@@ -612,7 +612,7 @@ asmlinkage void syscall_trace(void)
 	 */
 #ifdef DEBUG_PTRACE
 	printk("%s [%d]: syscall_trace exit= %x\n", current->comm,
-		current->pid, current->exit_code);
+		task_pid(current), current->exit_code);
 #endif
 	if (current->exit_code) {
 		send_sig (current->exit_code, current, 1);
Index: linux-2.6.15-rc1/arch/sparc/kernel/setup.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/sparc/kernel/setup.c
+++ linux-2.6.15-rc1/arch/sparc/kernel/setup.c
@@ -85,7 +85,7 @@ void prom_sync_me(void)
 		prom_palette(1);
 	prom_printf("PROM SYNC COMMAND...\n");
 	show_free_areas();
-	if(current->pid != 0) {
+	if(task_pid(current) != 0) {
 		local_irq_enable();
 		sys_sync();
 		local_irq_disable();
Index: linux-2.6.15-rc1/arch/sparc/kernel/sys_sparc.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/sparc/kernel/sys_sparc.c
+++ linux-2.6.15-rc1/arch/sparc/kernel/sys_sparc.c
@@ -353,7 +353,7 @@ c_sys_nis_syscall (struct pt_regs *regs)
 	if (count++ > 5)
 		return -ENOSYS;
 	printk ("%s[%d]: Unimplemented SPARC system call %d\n",
-		current->comm, current->pid, (int)regs->u_regs[1]);
+		current->comm, task_pid(current), (int)regs->u_regs[1]);
 #ifdef DEBUG_UNIMP_SYSCALL	
 	show_regs (regs);
 #endif
Index: linux-2.6.15-rc1/arch/sparc/kernel/sys_sunos.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/sparc/kernel/sys_sunos.c
+++ linux-2.6.15-rc1/arch/sparc/kernel/sys_sunos.c
@@ -825,7 +825,7 @@ asmlinkage int sunos_setpgrp(pid_t pid, 
 	int ret;
 
 	/* So stupid... */
-	if ((!pid || pid == current->pid) &&
+	if ((!pid || pid == task_pid(current)) &&
 	    !pgid) {
 		sys_setsid();
 		ret = 0;
Index: linux-2.6.15-rc1/arch/sparc/kernel/traps.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/sparc/kernel/traps.c
+++ linux-2.6.15-rc1/arch/sparc/kernel/traps.c
@@ -39,7 +39,7 @@ struct trap_trace_entry trapbuf[1024];
 
 void syscall_trace_entry(struct pt_regs *regs)
 {
-	printk("%s[%d]: ", current->comm, current->pid);
+	printk("%s[%d]: ", current->comm, task_pid(current));
 	printk("scall<%d> (could be %d)\n", (int) regs->u_regs[UREG_G1],
 	       (int) regs->u_regs[UREG_I0]);
 }
@@ -100,7 +100,7 @@ void die_if_kernel(char *str, struct pt_
 "              /_| \\__/ |_\\\n"
 "                 \\__U_/\n");
 
-	printk("%s(%d): %s [#%d]\n", current->comm, current->pid, str, ++die_counter);
+	printk("%s(%d): %s [#%d]\n", current->comm, task_pid(current), str, ++die_counter);
 	show_regs(regs);
 
 	__SAVE; __SAVE; __SAVE; __SAVE;
Index: linux-2.6.15-rc1/arch/sparc/mm/fault.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/sparc/mm/fault.c
+++ linux-2.6.15-rc1/arch/sparc/mm/fault.c
@@ -318,7 +318,7 @@ bad_area_nosemaphore:
 	if(from_user) {
 #if 0
 		printk("Fault whee %s [%d]: segfaults at %08lx pc=%08lx\n",
-		       tsk->comm, tsk->pid, address, regs->pc);
+		       tsk->comm, task_pid(tsk), address, regs->pc);
 #endif
 		info.si_signo = SIGSEGV;
 		info.si_errno = 0;
@@ -512,7 +512,7 @@ inline void force_user_fault(unsigned lo
 
 #if 0
 	printk("wf<pid=%d,wr=%d,addr=%08lx>\n",
-	       tsk->pid, write, address);
+	       task_pid(tsk), write, address);
 #endif
 	down_read(&mm->mmap_sem);
 	vma = find_vma(mm, address);
@@ -544,7 +544,7 @@ bad_area:
 	up_read(&mm->mmap_sem);
 #if 0
 	printk("Window whee %s [%d]: segfaults at %08lx\n",
-	       tsk->comm, tsk->pid, address);
+	       tsk->comm, task_pid(tsk), address);
 #endif
 	info.si_signo = SIGSEGV;
 	info.si_errno = 0;
Index: linux-2.6.15-rc1/arch/sparc64/kernel/process.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/sparc64/kernel/process.c
+++ linux-2.6.15-rc1/arch/sparc64/kernel/process.c
@@ -669,7 +669,7 @@ int copy_thread(int nr, unsigned long cl
 	}
 
 	/* Set the return value for the child. */
-	t->kregs->u_regs[UREG_I0] = current->pid;
+	t->kregs->u_regs[UREG_I0] = task_pid(current);
 	t->kregs->u_regs[UREG_I1] = 1;
 
 	/* Set the second return value for the parent. */
Index: linux-2.6.15-rc1/arch/sparc64/kernel/setup.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/sparc64/kernel/setup.c
+++ linux-2.6.15-rc1/arch/sparc64/kernel/setup.c
@@ -129,7 +129,7 @@ int prom_callback(long *args)
 	if (!strcmp(cmd, "sync")) {
 		prom_printf("PROM `%s' command...\n", cmd);
 		show_free_areas();
-		if (current->pid != 0) {
+		if (task_pid(current) != 0) {
 			local_irq_enable();
 			sys_sync();
 			local_irq_disable();
Index: linux-2.6.15-rc1/arch/sparc64/kernel/sys_sunos32.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/sparc64/kernel/sys_sunos32.c
+++ linux-2.6.15-rc1/arch/sparc64/kernel/sys_sunos32.c
@@ -791,7 +791,7 @@ asmlinkage int sunos_setpgrp(pid_t pid, 
 	int ret;
 
 	/* So stupid... */
-	if ((!pid || pid == current->pid) &&
+	if ((!pid || pid == task_pid(current)) &&
 	    !pgid) {
 		sys_setsid();
 		ret = 0;
Index: linux-2.6.15-rc1/arch/sparc64/kernel/traps.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/sparc64/kernel/traps.c
+++ linux-2.6.15-rc1/arch/sparc64/kernel/traps.c
@@ -1896,7 +1896,7 @@ void die_if_kernel(char *str, struct pt_
 "              /_| \\__/ |_\\\n"
 "                 \\__U_/\n");
 
-	printk("%s(%d): %s [#%d]\n", current->comm, current->pid, str, ++die_counter);
+	printk("%s(%d): %s [#%d]\n", current->comm, task_pid(current), str, ++die_counter);
 	notify_die(DIE_OOPS, str, regs, 0, 255, SIGSEGV);
 	__asm__ __volatile__("flushw");
 	__show_regs(regs);
Index: linux-2.6.15-rc1/arch/sparc64/solaris/ioctl.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/sparc64/solaris/ioctl.c
+++ linux-2.6.15-rc1/arch/sparc64/solaris/ioctl.c
@@ -548,13 +548,13 @@ static inline int solaris_S(struct file 
 			return solaris_ioctl(fd, si.cmd, si.data);
 		}
 	case 9: /* I_SETSIG */
-		return sys_ioctl(fd, FIOSETOWN, current->pid);
+		return sys_ioctl(fd, FIOSETOWN, task_pid(current));
 	case 10: /* I_GETSIG */
 		old_fs = get_fs();
 		set_fs(KERNEL_DS);
 		sys_ioctl(fd, FIOGETOWN, (unsigned long)&ret);
 		set_fs(old_fs);
-		if (ret == current->pid) return 0x3ff;
+		if (ret == task_pid(current)) return 0x3ff;
 		else return -EINVAL;
 	case 11: /* I_FIND */
         {
Index: linux-2.6.15-rc1/arch/um/kernel/process_kern.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/um/kernel/process_kern.c
+++ linux-2.6.15-rc1/arch/um/kernel/process_kern.c
@@ -180,7 +180,7 @@ unsigned long stack_sp(unsigned long pag
 
 int current_pid(void)
 {
-	return(current->pid);
+	return(task_pid(current));
 }
 
 void default_idle(void)
@@ -261,7 +261,7 @@ char *current_cmd(void)
 void force_sigbus(void)
 {
 	printk(KERN_ERR "Killing pid %d because of a lack of memory\n", 
-	       current->pid);
+	       task_pid(current));
 	lock_kernel();
 	sigaddset(&current->pending.signal, SIGBUS);
 	recalc_sigpending();
Index: linux-2.6.15-rc1/arch/um/kernel/skas/process_kern.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/um/kernel/skas/process_kern.c
+++ linux-2.6.15-rc1/arch/um/kernel/skas/process_kern.c
@@ -32,13 +32,13 @@ void switch_to_skas(void *prev, void *ne
 	to = next;
 
 	/* XXX need to check runqueues[cpu].idle */
-	if(current->pid == 0)
+	if(task_pid(current) == 0)
 		switch_timers(0);
 
 	switch_threads(&from->thread.mode.skas.switch_buf, 
 		       to->thread.mode.skas.switch_buf);
 
-	if(current->pid == 0)
+	if(task_pid(current) == 0)
 		switch_timers(1);
 }
 
Index: linux-2.6.15-rc1/arch/um/kernel/trap_kern.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/um/kernel/trap_kern.c
+++ linux-2.6.15-rc1/arch/um/kernel/trap_kern.c
@@ -107,7 +107,7 @@ out_nosemaphore:
  * us unable to handle the page fault gracefully.
  */
 out_of_memory:
-	if (current->pid == 1) {
+	if (task_pid(current) == 1) {
 		up_read(&mm->mmap_sem);
 		yield();
 		down_read(&mm->mmap_sem);
Index: linux-2.6.15-rc1/arch/um/sys-x86_64/sysrq.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/um/sys-x86_64/sysrq.c
+++ linux-2.6.15-rc1/arch/um/sys-x86_64/sysrq.c
@@ -16,7 +16,7 @@ void __show_regs(struct pt_regs * regs)
 	printk("\n");
 	print_modules();
 	printk("Pid: %d, comm: %.20s %s %s\n",
-	       current->pid, current->comm, print_tainted(), system_utsname.release);
+	       task_pid(current), current->comm, print_tainted(), system_utsname.release);
 	printk("RIP: %04lx:[<%016lx>] ", PT_REGS_CS(regs) & 0xffff,
 	       PT_REGS_RIP(regs));
 	printk("\nRSP: %016lx  EFLAGS: %08lx\n", PT_REGS_RSP(regs),
Index: linux-2.6.15-rc1/arch/v850/kernel/bug.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/v850/kernel/bug.c
+++ linux-2.6.15-rc1/arch/v850/kernel/bug.c
@@ -38,7 +38,7 @@ int bad_trap (int trap_num, struct pt_re
 {
 	printk (KERN_CRIT
 		"unimplemented trap %d called at 0x%08lx, pid %d!\n",
-		trap_num, regs->pc, current->pid);
+		trap_num, regs->pc, task_pid(current));
 	return -ENOSYS;
 }
 
@@ -50,7 +50,7 @@ void unexpected_reset (unsigned long ret
 		"unexpected reset in %s mode, pid %d"
 		" (ret_addr = 0x%lx, sp = 0x%lx)\n",
 		kmode ? "kernel" : "user",
-		task ? task->pid : -1,
+		task ? task_pid(task) : -1,
 		ret_addr, sp);
 
 	machine_halt ();
Index: linux-2.6.15-rc1/arch/v850/kernel/signal.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/v850/kernel/signal.c
+++ linux-2.6.15-rc1/arch/v850/kernel/signal.c
@@ -338,7 +338,7 @@ static void setup_frame(int sig, struct 
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=%p pc=%08lx ra=%08lx\n",
-		current->comm, current->pid, frame, regs->pc, );
+		current->comm, task_pid(current), frame, regs->pc, );
 #endif
 
 	return;
@@ -413,7 +413,7 @@ static void setup_rt_frame(int sig, stru
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=%p pc=%08lx pr=%08lx\n",
-		current->comm, current->pid, frame, regs->pc, regs->pr);
+		current->comm, task_pid(current), frame, regs->pc, regs->pr);
 #endif
 
 	return;
Index: linux-2.6.15-rc1/arch/x86_64/ia32/ia32_signal.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/x86_64/ia32/ia32_signal.c
+++ linux-2.6.15-rc1/arch/x86_64/ia32/ia32_signal.c
@@ -515,7 +515,7 @@ int ia32_setup_frame(int sig, struct k_s
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=%p pc=%p ra=%p\n",
-		current->comm, current->pid, frame, regs->rip, frame->pretcode);
+		current->comm, task_pid(current), frame, regs->rip, frame->pretcode);
 #endif
 
 	return 1;
@@ -615,7 +615,7 @@ int ia32_setup_rt_frame(int sig, struct 
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=%p pc=%p ra=%p\n",
-		current->comm, current->pid, frame, regs->rip, frame->pretcode);
+		current->comm, task_pid(current), frame, regs->rip, frame->pretcode);
 #endif
 
 	return 1;
Index: linux-2.6.15-rc1/arch/x86_64/kernel/mce.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/x86_64/kernel/mce.c
+++ linux-2.6.15-rc1/arch/x86_64/kernel/mce.c
@@ -248,7 +248,7 @@ void do_machine_check(struct pt_regs * r
 		   but most likely they occur at boot anyways, where
 		   it is best to just halt the machine. */
 		if ((!user_space && (panic_on_oops || tolerant < 2)) ||
-		    (unsigned)current->pid <= 1)
+		    (unsigned)task_pid(current) <= 1)
 			mce_panic("Uncorrected machine check", &panicm, mcestart);
 
 		/* do_exit takes an awful lot of locks and has as
Index: linux-2.6.15-rc1/arch/x86_64/kernel/process.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/x86_64/kernel/process.c
+++ linux-2.6.15-rc1/arch/x86_64/kernel/process.c
@@ -269,7 +269,7 @@ void __show_regs(struct pt_regs * regs)
 	printk("\n");
 	print_modules();
 	printk("Pid: %d, comm: %.20s %s %s %.*s\n",
-		current->pid, current->comm, print_tainted(),
+		task_pid(current), current->comm, print_tainted(),
 		system_utsname.release,
 		(int)strcspn(system_utsname.version, " "),
 		system_utsname.version);
Index: linux-2.6.15-rc1/arch/x86_64/kernel/signal.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/x86_64/kernel/signal.c
+++ linux-2.6.15-rc1/arch/x86_64/kernel/signal.c
@@ -165,7 +165,7 @@ asmlinkage long sys_rt_sigreturn(struct 
 		goto badframe;
 
 #ifdef DEBUG_SIG
-	printk("%d sigreturn rip:%lx rsp:%lx frame:%p rax:%lx\n",current->pid,regs.rip,regs.rsp,frame,eax);
+	printk("%d sigreturn rip:%lx rsp:%lx frame:%p rax:%lx\n",task_pid(current),regs.rip,regs.rsp,frame,eax);
 #endif
 
 	if (do_sigaltstack(&frame->uc.uc_stack, NULL, regs->rsp) == -EFAULT)
@@ -297,7 +297,7 @@ static int setup_rt_frame(int sig, struc
 		goto give_sigsegv;
 
 #ifdef DEBUG_SIG
-	printk("%d old rip %lx old rsp %lx old rax %lx\n", current->pid,regs->rip,regs->rsp,regs->rax);
+	printk("%d old rip %lx old rsp %lx old rax %lx\n", task_pid(current),regs->rip,regs->rsp,regs->rax);
 #endif
 
 	/* Set up registers for signal handler */
@@ -324,7 +324,7 @@ static int setup_rt_frame(int sig, struc
 		ptrace_notify(SIGTRAP);
 #ifdef DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=%p pc=%p ra=%p\n",
-		current->comm, current->pid, frame, regs->rip, frame->pretcode);
+		current->comm, task_pid(current), frame, regs->rip, frame->pretcode);
 #endif
 
 	return 1;
@@ -346,7 +346,7 @@ handle_signal(unsigned long sig, siginfo
 
 #ifdef DEBUG_SIG
 	printk("handle_signal pid:%d sig:%lu rip:%lx rsp:%lx regs=%p\n",
-		current->pid, sig,
+		task_pid(current), sig,
 		regs->rip, regs->rsp, regs);
 #endif
 
@@ -490,7 +490,7 @@ void signal_fault(struct pt_regs *regs, 
 	struct task_struct *me = current; 
 	if (exception_trace)
 		printk("%s[%d] bad frame in %s frame:%p rip:%lx rsp:%lx orax:%lx\n",
-	       me->comm,me->pid,where,frame,regs->rip,regs->rsp,regs->orig_rax); 
+	       me->comm,task_pid(me),where,frame,regs->rip,regs->rsp,regs->orig_rax);
 
 	force_sig(SIGSEGV, me); 
 } 
Index: linux-2.6.15-rc1/arch/x86_64/kernel/traps.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/x86_64/kernel/traps.c
+++ linux-2.6.15-rc1/arch/x86_64/kernel/traps.c
@@ -282,7 +282,7 @@ void show_registers(struct pt_regs *regs
 	printk("CPU %d ", cpu);
 	__show_regs(regs);
 	printk("Process %s (pid: %d, threadinfo %p, task %p)\n",
-		cur->comm, cur->pid, cur->thread_info, cur);
+		cur->comm, task_pid(cur), cur->thread_info, cur);
 
 	/*
 	 * When in-kernel, we also print out the stack and code at the
@@ -447,7 +447,7 @@ static void __kprobes do_trap(int trapnr
 		if (exception_trace && unhandled_signal(tsk, signr))
 			printk(KERN_INFO
 			       "%s[%d] trap %s rip:%lx rsp:%lx error:%lx\n",
-			       tsk->comm, tsk->pid, str,
+			       tsk->comm, task_pid(tsk), str,
 			       regs->rip,regs->rsp,error_code); 
 
 		tsk->thread.error_code = error_code;
@@ -533,7 +533,7 @@ asmlinkage void __kprobes do_general_pro
 		if (exception_trace && unhandled_signal(tsk, SIGSEGV))
 			printk(KERN_INFO
 		       "%s[%d] general protection rip:%lx rsp:%lx error:%lx\n",
-			       tsk->comm, tsk->pid,
+			       tsk->comm, task_pid(tsk),
 			       regs->rip,regs->rsp,error_code); 
 
 		tsk->thread.error_code = error_code;
Index: linux-2.6.15-rc1/arch/x86_64/mm/fault.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/x86_64/mm/fault.c
+++ linux-2.6.15-rc1/arch/x86_64/mm/fault.c
@@ -210,7 +210,7 @@ static int is_errata93(struct pt_regs *r
 
 int unhandled_signal(struct task_struct *tsk, int sig)
 {
-	if (tsk->pid == 1)
+	if (task_pid(tsk) == 1)
 		return 1;
 	if (tsk->ptrace & PT_PTRACED)
 		return 0;
@@ -482,8 +482,8 @@ bad_area_nosemaphore:
 		if (exception_trace && unhandled_signal(tsk, SIGSEGV)) {
 			printk(
 		       "%s%s[%d]: segfault at %016lx rip %016lx rsp %016lx error %lx\n",
-					tsk->pid > 1 ? KERN_INFO : KERN_EMERG,
-					tsk->comm, tsk->pid, address, regs->rip,
+					task_pid(tsk) > 1 ? KERN_INFO : KERN_EMERG,
+					tsk->comm, task_pid(tsk), address, regs->rip,
 					regs->rsp, error_code);
 		}
        
@@ -545,7 +545,7 @@ no_context:
  */
 out_of_memory:
 	up_read(&mm->mmap_sem);
-	if (current->pid == 1) { 
+	if (task_pid(current) == 1) {
 		yield();
 		goto again;
 	}
Index: linux-2.6.15-rc1/arch/xtensa/kernel/signal.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/xtensa/kernel/signal.c
+++ linux-2.6.15-rc1/arch/xtensa/kernel/signal.c
@@ -570,7 +570,7 @@ static void setup_frame(int sig, struct 
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): signal=%d sp=%p pc=%08x\n",
-		current->comm, current->pid, signal, frame, regs->pc);
+		current->comm, task_pid(current), signal, frame, regs->pc);
 #endif
 
 	return;
@@ -634,7 +634,7 @@ static void setup_rt_frame(int sig, stru
 
 #if DEBUG_SIG
 	printk("SIG rt deliver (%s:%d): signal=%d sp=%p pc=%08x\n",
-		current->comm, current->pid, signal, frame, regs->pc);
+		current->comm, task_pid(current), signal, frame, regs->pc);
 #endif
 
 	return;
Index: linux-2.6.15-rc1/arch/xtensa/kernel/syscalls.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/xtensa/kernel/syscalls.c
+++ linux-2.6.15-rc1/arch/xtensa/kernel/syscalls.c
@@ -245,7 +245,7 @@ void system_call (struct pt_regs *regs)
 	if (strncmp(sysname, "sys_", 4) == 0)
 		sysname = sysname + 4;
 
-	printk("\017SYSCALL:I:%x:%d:%s  %s(", regs->pc, current->pid,
+	printk("\017SYSCALL:I:%x:%d:%s  %s(", regs->pc, task_pid(current),
 	       current->comm, sysname);
 	for (i = 0; i < nargs; i++)
 		printk((i>0) ? ", %#lx" : "%#lx", parms[i]);
@@ -255,7 +255,7 @@ void system_call (struct pt_regs *regs)
 	res = syscall((void *)parm0, parm1, parm2, parm3, parm4, parm5);
 
 #if DEBUG
-	printk("\017SYSCALL:O:%d:%s  %s(",current->pid, current->comm, sysname);
+	printk("\017SYSCALL:O:%d:%s  %s(",task_pid(current), current->comm, sysname);
 	for (i = 0; i < nargs; i++)
 		printk((i>0) ? ", %#lx" : "%#lx", parms[i]);
 	if (res < 4096)
Index: linux-2.6.15-rc1/arch/xtensa/kernel/traps.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/xtensa/kernel/traps.c
+++ linux-2.6.15-rc1/arch/xtensa/kernel/traps.c
@@ -176,7 +176,7 @@ void do_unhandled(struct pt_regs *regs, 
 	printk("Caught unhandled exception in '%s' "
 	       "(pid = %d, pc = %#010lx) - should not happen\n"
 	       "\tEXCCAUSE is %ld\n",
-	       current->comm, current->pid, regs->pc, exccause);
+	       current->comm, task_pid(current), regs->pc, exccause);
 	force_sig(SIGILL, current);
 }
 
@@ -228,7 +228,7 @@ do_illegal_instruction(struct pt_regs *r
 	/* If in user mode, send SIGILL signal to current process. */
 
 	printk("Illegal Instruction in '%s' (pid = %d, pc = %#010lx)\n",
-	    current->comm, current->pid, regs->pc);
+	    current->comm, task_pid(current), regs->pc);
 	force_sig(SIGILL, current);
 }
 
@@ -254,7 +254,7 @@ do_unaligned_user (struct pt_regs *regs)
 	current->thread.error_code = -3;
 	printk("Unaligned memory access to %08lx in '%s' "
 	       "(pid = %d, pc = %#010lx)\n",
-	       regs->excvaddr, current->comm, current->pid, regs->pc);
+	       regs->excvaddr, current->comm, task_pid(current), regs->pc);
 	info.si_signo = SIGBUS;
 	info.si_errno = 0;
 	info.si_code = BUS_ADRALN;
Index: linux-2.6.15-rc1/arch/xtensa/mm/fault.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/xtensa/mm/fault.c
+++ linux-2.6.15-rc1/arch/xtensa/mm/fault.c
@@ -64,7 +64,7 @@ void do_page_fault(struct pt_regs *regs)
 		    exccause == XCHAL_EXCCAUSE_FETCH_CACHE_ATTRIBUTE) ? 1 : 0;
 
 #if 0
-	printk("[%s:%d:%08x:%d:%08x:%s%s]\n", current->comm, current->pid,
+	printk("[%s:%d:%08x:%d:%08x:%s%s]\n", current->comm, task_pid(current),
 	       address, exccause, regs->pc, is_write? "w":"", is_exec? "x":"");
 #endif
 
@@ -144,7 +144,7 @@ bad_area:
 	 */
 out_of_memory:
 	up_read(&mm->mmap_sem);
-	if (current->pid == 1) {
+	if (task_pid(current) == 1) {
 		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
Index: linux-2.6.15-rc1/arch/s390/kernel/asm-offsets.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/s390/kernel/asm-offsets.c
+++ linux-2.6.15-rc1/arch/s390/kernel/asm-offsets.c
@@ -22,7 +22,7 @@ int main(void)
 	DEFINE(__THREAD_mm_segment,
 	       offsetof(struct task_struct, thread.mm_segment),);
 	BLANK();
-	DEFINE(__TASK_pid, offsetof(struct task_struct, pid),);
+	DEFINE(__TASK_pid, offsetof(struct task_struct, __pid),);
 	BLANK();
 	DEFINE(__PER_atmid, offsetof(per_struct, lowcore.words.perc_atmid),);
 	DEFINE(__PER_address, offsetof(per_struct, lowcore.words.address),);
Index: linux-2.6.15-rc1/drivers/s390/crypto/z90main.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/s390/crypto/z90main.c
+++ linux-2.6.15-rc1/drivers/s390/crypto/z90main.c
@@ -942,7 +942,7 @@ init_work_element(struct work_element *w
 	step = atomic_inc_return(&z90crypt_step);
 	memcpy(we_p->caller_id+0, (void *) &pid, sizeof(pid));
 	memcpy(we_p->caller_id+4, (void *) &step, sizeof(step));
-	we_task_pid(p) = pid;
+	we_p->pid = pid;
 	we_p->priv_data = priv_data;
 	we_p->status[0] = STAT_DEFAULT;
 	we_p->audit[0] = 0x00;
Index: linux-2.6.15-rc1/arch/x86_64/ia32/ptrace32.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/x86_64/ia32/ptrace32.c
+++ linux-2.6.15-rc1/arch/x86_64/ia32/ptrace32.c
@@ -212,7 +212,7 @@ static struct task_struct *find_target(i
 	read_unlock(&tasklist_lock);
 	if (child) { 
 		*err = -EPERM;
-		if (child->pid == 1) 
+		if (task_pid(child) == 1)
 			goto out;
 		*err = ptrace_check_attach(child, request == PTRACE_KILL); 
 		if (*err < 0) 
Index: linux-2.6.15-rc1/arch/x86_64/kernel/asm-offsets.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/x86_64/kernel/asm-offsets.c
+++ linux-2.6.15-rc1/arch/x86_64/kernel/asm-offsets.c
@@ -26,7 +26,7 @@ int main(void)
 	ENTRY(state);
 	ENTRY(flags); 
 	ENTRY(thread); 
-	ENTRY(pid);
+	ENTRY(__pid);
 	BLANK();
 #undef ENTRY
 #define ENTRY(entry) DEFINE(threadinfo_ ## entry, offsetof(struct thread_info, entry))
Index: linux-2.6.15-rc1/arch/powerpc/mm/fault.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/powerpc/mm/fault.c
+++ linux-2.6.15-rc1/arch/powerpc/mm/fault.c
@@ -350,7 +350,7 @@ bad_area_nosemaphore:
  */
 out_of_memory:
 	up_read(&mm->mmap_sem);
-	if (current->pid == 1) {
+	if (task_pid(current) == 1) {
 		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
Index: linux-2.6.15-rc1/arch/powerpc/xmon/xmon.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/powerpc/xmon/xmon.c
+++ linux-2.6.15-rc1/arch/powerpc/xmon/xmon.c
@@ -1368,7 +1368,7 @@ void excprint(struct pt_regs *fp)
 #endif
 	if (current) {
 		printf("    pid   = %ld, comm = %s\n",
-		       current->pid, current->comm);
+		       task_pid(current), current->comm);
 	}
 
 	if (trap == 0x700)
Index: linux-2.6.15-rc1/arch/powerpc/kernel/traps.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/powerpc/kernel/traps.c
+++ linux-2.6.15-rc1/arch/powerpc/kernel/traps.c
@@ -195,7 +195,7 @@ void _exception(int signr, struct pt_reg
 	 * generate the same exception over and over again and we get
 	 * nowhere.  Better to kill it and let the kernel panic.
 	 */
-	if (current->pid == 1) {
+	if (task_pid(current) == 1) {
 		__sighandler_t handler;
 
 		spin_lock_irq(&current->sighand->siglock);
@@ -860,7 +860,7 @@ void nonrecoverable_exception(struct pt_
 void trace_syscall(struct pt_regs *regs)
 {
 	printk("Task: %p(%d), PC: %08lX/%08lX, Syscall: %3ld, Result: %s%ld    %s\n",
-	       current, current->pid, regs->nip, regs->link, regs->gpr[0],
+	       current, task_pid(current), regs->nip, regs->link, regs->gpr[0],
 	       regs->ccr&0x10000000?"Error=":"", regs->gpr[3], print_tainted());
 }
 
Index: linux-2.6.15-rc1/arch/powerpc/platforms/pseries/ras.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/powerpc/platforms/pseries/ras.c
+++ linux-2.6.15-rc1/arch/powerpc/platforms/pseries/ras.c
@@ -313,10 +313,10 @@ static int recover_mce(struct pt_regs *r
 		   err->disposition == RTAS_DISP_NOT_RECOVERED &&
 		   err->target == RTAS_TARGET_MEMORY &&
 		   err->type == RTAS_TYPE_ECC_UNCORR &&
-		   !(current->pid == 0 || current->pid == 1)) {
+		   !(task_pid(current) == 0 || task_pid(current) == 1)) {
 		/* Kill off a user process with an ECC error */
 		printk(KERN_ERR "MCE: uncorrectable ecc error for pid %d\n",
-		       current->pid);
+		       task_pid(current));
 		/* XXX something better for ECC error? */
 		_exception(SIGBUS, regs, BUS_ADRERR, regs->nip);
 		nonfatal = 1;
Index: linux-2.6.15-rc1/arch/powerpc/kernel/process.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/powerpc/kernel/process.c
+++ linux-2.6.15-rc1/arch/powerpc/kernel/process.c
@@ -402,7 +402,7 @@ void show_regs(struct pt_regs * regs)
 	if (trap == 0x300 || trap == 0x600)
 		printk("DAR: "REG", DSISR: "REG"\n", regs->dar, regs->dsisr);
 	printk("TASK = %p[%d] '%s' THREAD: %p",
-	       current, current->pid, current->comm, current->thread_info);
+	       current, task_pid(current), current->comm, current->thread_info);
 
 #ifdef CONFIG_SMP
 	printk(" CPU: %d", smp_processor_id());

--

