Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265170AbUBKOrm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 09:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265289AbUBKOrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 09:47:42 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:14277 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S265170AbUBKOq7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 09:46:59 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: kgdb interdiff for i386.patch
Date: Wed, 11 Feb 2004 20:16:17 +0530
User-Agent: KMail/1.5
Cc: George Anzinger <george@mvista.com>, Tom Rini <trini@kernel.crashing.org>,
       Pavel Machek <pavel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402112016.22498.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is interdiff for file i386.patch

--- archive/2.1.0/linux-2.6.1-kgdb-2.1.0/i386.patch	2004-01-21 
22:05:40.000000000 +0530
+++ cvs/kgdb-2/i386.patch	2004-02-11 16:01:04.000000000 +0530
@@ -1,7 +1,7 @@
-diff -Naurp linux-2.6.1/arch/i386/Kconfig 
linux-2.6.1-kgdb-2.1.0-i386/arch/i386/Kconfig
---- linux-2.6.1/arch/i386/Kconfig	2004-01-10 11:01:35.000000000 +0530
-+++ linux-2.6.1-kgdb-2.1.0-i386/arch/i386/Kconfig	2004-01-12 
19:11:34.000000000 +0530
-@@ -1252,6 +1252,37 @@ config DEBUG_SPINLOCK_SLEEP
+diff -Naurp linux-2.6.2/arch/i386/Kconfig 
linux-2.6.2-kgdb-i386/arch/i386/Kconfig
+--- linux-2.6.2/arch/i386/Kconfig	2004-02-10 13:01:22.000000000 +0530
++++ linux-2.6.2-kgdb-i386/arch/i386/Kconfig	2004-02-10 13:11:38.000000000 
+0530
+@@ -1253,6 +1253,37 @@ config DEBUG_SPINLOCK_SLEEP
  	  If you say Y here, various routines which may sleep will become very
  	  noisy if they are called with a spinlock held.	
  
@@ -39,9 +39,9 @@
  config FRAME_POINTER
  	bool "Compile the kernel with frame pointers"
  	help
-diff -Naurp linux-2.6.1/arch/i386/kernel/entry.S 
linux-2.6.1-kgdb-2.1.0-i386/arch/i386/kernel/entry.S
---- linux-2.6.1/arch/i386/kernel/entry.S	2003-11-24 07:01:26.000000000 +0530
-+++ linux-2.6.1-kgdb-2.1.0-i386/arch/i386/kernel/entry.S	2004-01-20 
20:03:48.000000000 +0530
+diff -Naurp linux-2.6.2/arch/i386/kernel/entry.S 
linux-2.6.2-kgdb-i386/arch/i386/kernel/entry.S
+--- linux-2.6.2/arch/i386/kernel/entry.S	2003-11-24 07:01:26.000000000 +0530
++++ linux-2.6.2-kgdb-i386/arch/i386/kernel/entry.S	2004-02-10 
13:11:38.000000000 +0530
 @@ -226,7 +226,7 @@ need_resched:
  	jz restore_all
  	movl $PREEMPT_ACTIVE,TI_PRE_COUNT(%ebp)
@@ -110,10 +110,10 @@
  .data
  ENTRY(sys_call_table)
  	.long sys_restart_syscall	/* 0 - old "setup()" system call, used for 
restarting */
-diff -Naurp linux-2.6.1/arch/i386/kernel/i386-stub.c 
linux-2.6.1-kgdb-2.1.0-i386/arch/i386/kernel/i386-stub.c
---- linux-2.6.1/arch/i386/kernel/i386-stub.c	1970-01-01 05:30:00.000000000 
+0530
-+++ linux-2.6.1-kgdb-2.1.0-i386/arch/i386/kernel/i386-stub.c	2004-01-12 
19:11:34.000000000 +0530
-@@ -0,0 +1,457 @@
+diff -Naurp linux-2.6.2/arch/i386/kernel/i386-stub.c 
linux-2.6.2-kgdb-i386/arch/i386/kernel/i386-stub.c
+--- linux-2.6.2/arch/i386/kernel/i386-stub.c	1970-01-01 05:30:00.000000000 
+0530
++++ linux-2.6.2-kgdb-i386/arch/i386/kernel/i386-stub.c	2004-02-10 
18:35:49.000000000 +0530
+@@ -0,0 +1,373 @@
 +/*
 + *
 + * This program is free software; you can redistribute it and/or modify it
@@ -131,82 +131,13 @@
 +/*
 + * Copyright (C) 2000-2001 VERITAS Software Corporation.
 + */
-+/****************************************************************************
-+ *  Header: remcom.c,v 1.34 91/03/09 12:29:49 glenne Exp $
-+ *
-+ *  Module name: remcom.c $
-+ *  Revision: 1.34 $
-+ *  Date: 91/03/09 12:29:49 $
++/*
 + *  Contributor:     Lake Stevens Instrument Division$
-+ *
-+ *  Description:     low level support for gdb debugger. $
-+ *
-+ *  Considerations:  only works on target hardware $
-+ *
 + *  Written by:      Glenn Engel $
 + *  Updated by:	     Amit Kale<akale@veritas.com>
-+ *  ModuleState:     Experimental $
-+ *
-+ *  NOTES:           See Below $
-+ *
 + *  Modified for 386 by Jim Kingdon, Cygnus Support.
 + *  Origianl kgdb, compatibility with 2.1.xx kernel by David Grothe 
<dave@gcom.com>
-+ *  Integrated into 2.2.5 kernel by Tigran Aivazian <tigran@sco.com>
-+ *      thread support,
-+ *      support for multiple processors,
-+ *  	support for ia-32(x86) hardware debugging,
-+ *  	Console support,
-+ *  	handling nmi watchdog
-+ *  	Amit S. Kale ( amitkale@emsyssoft.com )
-+ *
-+ *
-+ *  To enable debugger support, two things need to happen.  One, a
-+ *  call to set_debug_traps() is necessary in order to allow any breakpoints
-+ *  or error conditions to be properly intercepted and reported to gdb.
-+ *  Two, a breakpoint needs to be generated to begin communication.  This
-+ *  is most easily accomplished by a call to breakpoint().  Breakpoint()
-+ *  simulates a breakpoint by executing an int 3.
-+ *
-+ *************
-+ *
-+ *    The following gdb commands are supported:
-+ *
-+ * command          function                               Return value
-+ *
-+ *    g             return the value of the CPU registers  hex data or ENN
-+ *    G             set the value of the CPU registers     OK or ENN
-+ *
-+ *    mAA..AA,LLLL  Read LLLL bytes at address AA..AA      hex data or ENN
-+ *    MAA..AA,LLLL: Write LLLL bytes at address AA.AA      OK or ENN
-+ *
-+ *    c             Resume at current address              SNN   ( signal 
NN)
-+ *    cAA..AA       Continue at address AA..AA             SNN
-+ *
-+ *    s             Step one instruction                   SNN
-+ *    sAA..AA       Step one instruction from AA..AA       SNN
-+ *
-+ *    k             kill
-+ *
-+ *    ?             What was the last sigval ?             SNN   (signal NN)
-+ *
-+ * All commands and responses are sent with a packet which includes a
-+ * checksum.  A packet consists of
-+ *
-+ * $<packet info>#<checksum>.
-+ *
-+ * where
-+ * <packet info> :: <characters representing the command or response>
-+ * <checksum>    :: < two hex digits computed as modulo 256 sum of 
<packetinfo>>
-+ *
-+ * When a packet is received, it is first acknowledged with either '+' or 
'-'.
-+ * '+' indicates a successful transfer.  '-' indicates a failed transfer.
-+ *
-+ * Example:
-+ *
-+ * Host:                  Reply:
-+ * $m0,10#2a               +$00010203040506070809101112131415#42
-+ *
-+ 
****************************************************************************/
++ */
 +
 +#include <linux/string.h>
 +#include <linux/kernel.h>
@@ -234,7 +165,7 @@
 +#error change the definition of slavecpulocks
 +#endif
 +
-+static void i386_regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs 
*regs)
++void regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs)
 +{
 +    gdb_regs[_EAX] =  regs->eax;
 +    gdb_regs[_EBX] =  regs->ebx;
@@ -254,7 +185,7 @@
 +    gdb_regs[ _GS] =  0xFFFF;
 +}
 +
-+static void i386_sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct 
task_struct *p)
++void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct 
*p)
 +{
 +	gdb_regs[_EAX] = 0;
 +	gdb_regs[_EBX] = 0;
@@ -274,7 +205,7 @@
 +	gdb_regs[_GS]  = 0xFFFF;
 +}
 +
-+static void i386_gdb_regs_to_regs(unsigned long *gdb_regs, struct pt_regs 
*regs)
++void gdb_regs_to_regs(unsigned long *gdb_regs, struct pt_regs *regs)
 +{
 +    regs->eax	=     gdb_regs[_EAX] ;
 +    regs->ebx	=     gdb_regs[_EBX] ;
@@ -308,7 +239,7 @@
 +enabled:0}, {
 +enabled:0}};
 +
-+void i386_correct_hw_break(void)
++void kgdb_correct_hw_break(void)
 +{
 +	int breakno;
 +	int correctit;
@@ -367,7 +298,7 @@
 +	}
 +}
 +
-+int i386_remove_hw_break(unsigned long addr, int type)
++int kgdb_remove_hw_break(unsigned long addr, int type)
 +{
 +	int i, idx = -1;
 +	for (i = 0; i < 4; i ++) {
@@ -383,7 +314,7 @@
 +	return 0;
 +}
 +
-+int i386_set_hw_break(unsigned long addr, int type)
++int kgdb_set_hw_break(unsigned long addr, int type)
 +{
 +	int i, idx = -1;
 +	for (i = 0; i < 4; i ++) {
@@ -424,7 +355,7 @@
 +	return 0;
 +}
 +
-+static void i386_printexceptioninfo(int exceptionNo, int errorcode, char 
*buffer)
++void kgdb_printexceptioninfo(int exceptionNo, int errorcode, char *buffer)
 +{
 +	unsigned	dr6;
 +	int		i;
@@ -454,21 +385,22 @@
 +	return;
 +}
 +
-+static void i386_disable_hw_debug(struct pt_regs *regs) 
++void kgdb_disable_hw_debug(struct pt_regs *regs) 
 +{
 +	/* Disable hardware debugging while we are in kgdb */
 +	asm volatile("movl %0,%%db7": /* no output */ : "r"(0));
 +}
 +
-+static void i386_post_master_code(struct pt_regs *regs, int eVector, int 
err_code)
++void kgdb_post_master_code(struct pt_regs *regs, int eVector, int err_code)
 +{
 +	/* Master processor is completely in the debugger */
 +	gdb_i386vector = eVector;
 +	gdb_i386errcode = err_code;
 +}
-+static int i386_handle_exception(int exceptionVector, int signo, int 
err_code,
-+                                 char *remcomInBuffer, char 
*remcomOutBuffer,
-+                                 struct pt_regs *linux_regs)
++
++int kgdb_arch_handle_exception(int exceptionVector, int signo,
++		int err_code, char *remcomInBuffer, char *remcomOutBuffer,
++		struct pt_regs *linux_regs)
 +{
 +	long addr, length;
 +	long breakno, breaktype;
@@ -514,7 +446,7 @@
 +				}
 +			}
 +		}
-+		i386_correct_hw_break();
++		kgdb_correct_hw_break();
 +		asm volatile ("movl %0, %%db6\n"::"r" (0));
 +
 +		return (0);
@@ -551,29 +483,13 @@
 +	return -1; /* this means that we do not want to exit from the handler */
 +}
 +
-+int i386_kgdb_init(void)
-+{
-+	return 0;
-+}
-+
 +struct kgdb_arch arch_kgdb_ops =  {
 +	.gdb_bpt_instr = {0xcc},
 +	.flags = KGDB_HW_BREAKPOINT,
-+	.kgdb_init = i386_kgdb_init,
-+	.regs_to_gdb_regs = i386_regs_to_gdb_regs,
-+	.sleeping_thread_to_gdb_regs = i386_sleeping_thread_to_gdb_regs,
-+	.gdb_regs_to_regs = i386_gdb_regs_to_regs,
-+	.printexceptioninfo = i386_printexceptioninfo,
-+	.disable_hw_debug = i386_disable_hw_debug,
-+	.post_master_code = i386_post_master_code,
-+	.handle_exception = i386_handle_exception,
-+	.set_break = i386_set_hw_break,
-+	.remove_break = i386_remove_hw_break,
-+	.correct_hw_break = i386_correct_hw_break,
 +};
-diff -Naurp linux-2.6.1/arch/i386/kernel/irq.c 
linux-2.6.1-kgdb-2.1.0-i386/arch/i386/kernel/irq.c
---- linux-2.6.1/arch/i386/kernel/irq.c	2004-01-10 11:01:35.000000000 +0530
-+++ linux-2.6.1-kgdb-2.1.0-i386/arch/i386/kernel/irq.c	2004-01-20 
20:04:48.000000000 +0530
+diff -Naurp linux-2.6.2/arch/i386/kernel/irq.c 
linux-2.6.2-kgdb-i386/arch/i386/kernel/irq.c
+--- linux-2.6.2/arch/i386/kernel/irq.c	2004-01-10 11:01:35.000000000 +0530
++++ linux-2.6.2-kgdb-i386/arch/i386/kernel/irq.c	2004-02-10 
13:11:39.000000000 +0530
 @@ -410,7 +410,7 @@ void enable_irq(unsigned int irq)
   * SMP cross-CPU interrupts have their own specific
   * handlers).
@@ -601,9 +517,9 @@
  		spin_lock(&desc->lock);
  		if (!noirqdebug)
  			note_interrupt(irq, desc, action_ret);
-diff -Naurp linux-2.6.1/arch/i386/kernel/Makefile 
linux-2.6.1-kgdb-2.1.0-i386/arch/i386/kernel/Makefile
---- linux-2.6.1/arch/i386/kernel/Makefile	2004-01-10 11:01:35.000000000 +0530
-+++ linux-2.6.1-kgdb-2.1.0-i386/arch/i386/kernel/Makefile	2004-01-12 
19:11:34.000000000 +0530
+diff -Naurp linux-2.6.2/arch/i386/kernel/Makefile 
linux-2.6.2-kgdb-i386/arch/i386/kernel/Makefile
+--- linux-2.6.2/arch/i386/kernel/Makefile	2004-01-10 11:01:35.000000000 +0530
++++ linux-2.6.2-kgdb-i386/arch/i386/kernel/Makefile	2004-02-10 
13:11:39.000000000 +0530
 @@ -31,6 +31,7 @@ obj-y				+= sysenter.o vsyscall.o
  obj-$(CONFIG_ACPI_SRAT) 	+= srat.o
  obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
@@ -612,9 +528,9 @@
  
  EXTRA_AFLAGS   := -traditional
  
-diff -Naurp linux-2.6.1/arch/i386/kernel/nmi.c 
linux-2.6.1-kgdb-2.1.0-i386/arch/i386/kernel/nmi.c
---- linux-2.6.1/arch/i386/kernel/nmi.c	2003-11-24 07:02:02.000000000 +0530
-+++ linux-2.6.1-kgdb-2.1.0-i386/arch/i386/kernel/nmi.c	2004-01-12 
19:11:34.000000000 +0530
+diff -Naurp linux-2.6.2/arch/i386/kernel/nmi.c 
linux-2.6.2-kgdb-i386/arch/i386/kernel/nmi.c
+--- linux-2.6.2/arch/i386/kernel/nmi.c	2003-11-24 07:02:02.000000000 +0530
++++ linux-2.6.2-kgdb-i386/arch/i386/kernel/nmi.c	2004-02-10 
13:11:39.000000000 +0530
 @@ -25,6 +25,7 @@
  #include <linux/module.h>
  #include <linux/nmi.h>
@@ -650,9 +566,9 @@
  			spin_lock(&nmi_print_lock);
  			/*
  			 * We are in trouble anyway, lets at least try
-diff -Naurp linux-2.6.1/arch/i386/kernel/signal.c 
linux-2.6.1-kgdb-2.1.0-i386/arch/i386/kernel/signal.c
---- linux-2.6.1/arch/i386/kernel/signal.c	2003-11-24 07:01:52.000000000 +0530
-+++ linux-2.6.1-kgdb-2.1.0-i386/arch/i386/kernel/signal.c	2004-01-12 
19:11:34.000000000 +0530
+diff -Naurp linux-2.6.2/arch/i386/kernel/signal.c 
linux-2.6.2-kgdb-i386/arch/i386/kernel/signal.c
+--- linux-2.6.2/arch/i386/kernel/signal.c	2003-11-24 07:01:52.000000000 +0530
++++ linux-2.6.2-kgdb-i386/arch/i386/kernel/signal.c	2004-02-10 
13:11:39.000000000 +0530
 @@ -580,7 +580,8 @@ int do_signal(struct pt_regs *regs, sigs
  		 * have been cleared if the watchpoint triggered
  		 * inside the kernel.
@@ -663,9 +579,9 @@
  
  		/* Whee!  Actually deliver the signal.  */
  		handle_signal(signr, &info, oldset, regs);
-diff -Naurp linux-2.6.1/arch/i386/kernel/traps.c 
linux-2.6.1-kgdb-2.1.0-i386/arch/i386/kernel/traps.c
---- linux-2.6.1/arch/i386/kernel/traps.c	2003-11-24 07:01:14.000000000 +0530
-+++ linux-2.6.1-kgdb-2.1.0-i386/arch/i386/kernel/traps.c	2004-01-12 
19:11:34.000000000 +0530
+diff -Naurp linux-2.6.2/arch/i386/kernel/traps.c 
linux-2.6.2-kgdb-i386/arch/i386/kernel/traps.c
+--- linux-2.6.2/arch/i386/kernel/traps.c	2003-11-24 07:01:14.000000000 +0530
++++ linux-2.6.2-kgdb-i386/arch/i386/kernel/traps.c	2004-02-10 
13:11:39.000000000 +0530
 @@ -51,6 +51,7 @@
  
  #include <linux/irq.h>
@@ -737,9 +653,9 @@
  	return;
  
  debug_vm86:
-diff -Naurp linux-2.6.1/arch/i386/mm/fault.c 
linux-2.6.1-kgdb-2.1.0-i386/arch/i386/mm/fault.c
---- linux-2.6.1/arch/i386/mm/fault.c	2003-12-26 18:33:55.000000000 +0530
-+++ linux-2.6.1-kgdb-2.1.0-i386/arch/i386/mm/fault.c	2004-01-12 
19:11:35.000000000 +0530
+diff -Naurp linux-2.6.2/arch/i386/mm/fault.c 
linux-2.6.2-kgdb-i386/arch/i386/mm/fault.c
+--- linux-2.6.2/arch/i386/mm/fault.c	2003-12-26 18:33:55.000000000 +0530
++++ linux-2.6.2-kgdb-i386/arch/i386/mm/fault.c	2004-02-10 16:04:35.000000000 
+0530
 @@ -2,6 +2,11 @@
   *  linux/arch/i386/mm/fault.c
   *
@@ -760,20 +676,7 @@
  
  #include <asm/system.h>
  #include <asm/uaccess.h>
-@@ -262,6 +268,12 @@ asmlinkage void do_page_fault(struct pt_
- 	if (in_atomic() || !mm)
- 		goto bad_area_nosemaphore;
- 
-+	if (debugger_memerr_expected) {
-+		/* This fault was caused by memory access through a debugger.
-+		 * Don't handle it like user accesses */
-+		goto no_context;
-+	}
-+
- 	down_read(&mm->mmap_sem);
- 
- 	vma = find_vma(mm, address);
-@@ -399,6 +411,8 @@ no_context:
+@@ -399,6 +405,8 @@ no_context:
   	if (is_prefetch(regs, address))
   		return;
  
@@ -782,7 +685,7 @@
  /*
   * Oops. The kernel tried to access some bad page. We'll have to
   * terminate things with extreme prejudice.
-@@ -406,6 +420,7 @@ no_context:
+@@ -406,6 +414,7 @@ no_context:
  
  	bust_spinlocks(1);
  
@@ -790,9 +693,9 @@
  	if (address < PAGE_SIZE)
  		printk(KERN_ALERT "Unable to handle kernel NULL pointer dereference");
  	else
-diff -Naurp linux-2.6.1/include/asm-i386/kgdb.h 
linux-2.6.1-kgdb-2.1.0-i386/include/asm-i386/kgdb.h
---- linux-2.6.1/include/asm-i386/kgdb.h	1970-01-01 05:30:00.000000000 +0530
-+++ linux-2.6.1-kgdb-2.1.0-i386/include/asm-i386/kgdb.h	2004-01-12 
19:11:35.000000000 +0530
+diff -Naurp linux-2.6.2/include/asm-i386/kgdb.h 
linux-2.6.2-kgdb-i386/include/asm-i386/kgdb.h
+--- linux-2.6.2/include/asm-i386/kgdb.h	1970-01-01 05:30:00.000000000 +0530
++++ linux-2.6.2-kgdb-i386/include/asm-i386/kgdb.h	2004-02-11 
13:36:58.000000000 +0530
 @@ -0,0 +1,49 @@
 +#ifndef _ASM_KGDB_H_
 +#define _ASM_KGDB_H_
@@ -843,9 +746,9 @@
 +#define BREAK_INSTR_SIZE       1
 +
 +#endif /* _ASM_KGDB_H_ */
-diff -Naurp linux-2.6.1/include/asm-i386/processor.h 
linux-2.6.1-kgdb-2.1.0-i386/include/asm-i386/processor.h
---- linux-2.6.1/include/asm-i386/processor.h	2004-01-10 11:01:47.000000000 
+0530
-+++ linux-2.6.1-kgdb-2.1.0-i386/include/asm-i386/processor.h	2004-01-12 
19:11:35.000000000 +0530
+diff -Naurp linux-2.6.2/include/asm-i386/processor.h 
linux-2.6.2-kgdb-i386/include/asm-i386/processor.h
+--- linux-2.6.2/include/asm-i386/processor.h	2004-01-10 11:01:47.000000000 
+0530
++++ linux-2.6.2-kgdb-i386/include/asm-i386/processor.h	2004-02-10 
13:11:39.000000000 +0530
 @@ -393,6 +393,7 @@ struct tss_struct {
  	 * be within the limit.
  	 */


