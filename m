Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268324AbTBYUZn>; Tue, 25 Feb 2003 15:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268322AbTBYUZR>; Tue, 25 Feb 2003 15:25:17 -0500
Received: from [24.77.48.240] ([24.77.48.240]:41513 "EHLO aiinc.aiinc.ca")
	by vger.kernel.org with ESMTP id <S268285AbTBYUVE>;
	Tue, 25 Feb 2003 15:21:04 -0500
Date: Tue, 25 Feb 2003 12:31:18 -0800
From: Michael Hayes <mike@aiinc.ca>
Message-Id: <200302252031.h1PKVIX24915@aiinc.aiinc.ca>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Spelling fixes for 2.5.63 - don't
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes:
    dont -> don't (157 occurrences)

diff -ur a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
--- a/arch/alpha/kernel/entry.S	Mon Feb 24 11:05:04 2003
+++ b/arch/alpha/kernel/entry.S	Tue Feb 25 10:39:37 2003
@@ -516,7 +516,7 @@
 	stt	$f29, 296($sp)
 	stt	$f30, 304($sp)
 	stt	$f0, 312($sp)	# save fpcr in slot of $f31
-	ldt	$f0, 64($sp)	# dont let "do_switch_stack" change fp state.
+	ldt	$f0, 64($sp)	# don't let "do_switch_stack" change fp state.
 	ret	$31, ($1), 1
 .end do_switch_stack
 
diff -ur a/arch/alpha/kernel/head.S b/arch/alpha/kernel/head.S
--- a/arch/alpha/kernel/head.S	Mon Feb 24 11:05:04 2003
+++ b/arch/alpha/kernel/head.S	Tue Feb 25 10:39:41 2003
@@ -85,7 +85,7 @@
 
 	#
 	# It is handy, on occasion, to make halt actually just loop. 
-	# Putting it here means we dont have to recompile the whole
+	# Putting it here means we don't have to recompile the whole
 	# kernel.
 	#
 
diff -ur a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
--- a/arch/arm/kernel/head.S	Mon Feb 24 11:05:05 2003
+++ b/arch/arm/kernel/head.S	Tue Feb 25 10:39:45 2003
@@ -56,7 +56,7 @@
  * ---------------------------
  *
  * This is normally called from the decompressor code.  The requirements
- * are: MMU = off, D-cache = off, I-cache = dont care, r0 = 0,
+ * are: MMU = off, D-cache = off, I-cache = don't care, r0 = 0,
  * r1 = machine nr.
  *
  * This code is mostly position independent, so if you link the kernel at
diff -ur a/arch/arm/mm/tlb-v3.S b/arch/arm/mm/tlb-v3.S
--- a/arch/arm/mm/tlb-v3.S	Mon Feb 24 11:05:05 2003
+++ b/arch/arm/mm/tlb-v3.S	Tue Feb 25 10:39:48 2003
@@ -32,7 +32,7 @@
 	vma_vm_mm r2, r2
 	act_mm	r3				@ get current->active_mm
 	teq	r2, r3				@ == mm ?
-	movne	pc, lr				@ no, we dont do anything
+	movne	pc, lr				@ no, we don't do anything
 ENTRY(v3_flush_kern_tlb_range)
 	bic	r0, r0, #0x0ff
 	bic	r0, r0, #0xf00
diff -ur a/arch/arm/mm/tlb-v4.S b/arch/arm/mm/tlb-v4.S
--- a/arch/arm/mm/tlb-v4.S	Mon Feb 24 11:05:15 2003
+++ b/arch/arm/mm/tlb-v4.S	Tue Feb 25 10:39:50 2003
@@ -33,7 +33,7 @@
 	vma_vm_mm ip, r2
 	act_mm	r3				@ get current->active_mm
 	eors	r3, ip, r3				@ == mm ?
-	movne	pc, lr				@ no, we dont do anything
+	movne	pc, lr				@ no, we don't do anything
 	vma_vm_flags ip, r2
 .v4_flush_kern_tlb_range:
 	bic	r0, r0, #0x0ff
diff -ur a/arch/arm/mm/tlb-v4wb.S b/arch/arm/mm/tlb-v4wb.S
--- a/arch/arm/mm/tlb-v4wb.S	Mon Feb 24 11:05:15 2003
+++ b/arch/arm/mm/tlb-v4wb.S	Tue Feb 25 10:39:54 2003
@@ -33,7 +33,7 @@
 	vma_vm_mm ip, r2
 	act_mm	r3				@ get current->active_mm
 	eors	r3, ip, r3				@ == mm ?
-	movne	pc, lr				@ no, we dont do anything
+	movne	pc, lr				@ no, we don't do anything
 	vma_vm_flags r2, r2
 	mcr	p15, 0, r3, c7, c10, 4		@ drain WB
 	tst	r2, #VM_EXEC
diff -ur a/arch/arm/mm/tlb-v4wbi.S b/arch/arm/mm/tlb-v4wbi.S
--- a/arch/arm/mm/tlb-v4wbi.S	Mon Feb 24 11:05:12 2003
+++ b/arch/arm/mm/tlb-v4wbi.S	Tue Feb 25 10:39:52 2003
@@ -32,7 +32,7 @@
 	vma_vm_mm ip, r2
 	act_mm	r3				@ get current->active_mm
 	eors	r3, ip, r3			@ == mm ?
-	movne	pc, lr				@ no, we dont do anything
+	movne	pc, lr				@ no, we don't do anything
 	mov	r3, #0
 	mcr	p15, 0, r3, c7, c10, 4		@ drain WB
 	vma_vm_flags r2, r2
diff -ur a/arch/cris/boot/rescue/head.S b/arch/cris/boot/rescue/head.S
--- a/arch/cris/boot/rescue/head.S	Mon Feb 24 11:05:39 2003
+++ b/arch/cris/boot/rescue/head.S	Tue Feb 25 10:39:58 2003
@@ -10,7 +10,7 @@
  * If any of the checksums fail, we assume the flash is so
  * corrupt that we cant use it to boot into the ftp flash
  * loader, and instead we initialize the serial port to
- * receive a flash-loader and new flash image. we dont include
+ * receive a flash-loader and new flash image. we don't include
  * any flash code here, but just accept a certain amount of
  * bytes from the serial port and jump into it. the downloaded
  * code is put in the cache.
@@ -120,7 +120,7 @@
 	;; This is the entry point of the rescue code
 	;; 0x80000000 if loaded in flash (as it should be)
 	;; since etrax actually starts at address 2 when booting from flash, we
-	;; put a nop (2 bytes) here first so we dont accidentally skip the di
+	;; put a nop (2 bytes) here first so we don't accidentally skip the di
 	
 	nop	
 	di
diff -ur a/arch/cris/boot/rescue/kimagerescue.S b/arch/cris/boot/rescue/kimagerescue.S
--- a/arch/cris/boot/rescue/kimagerescue.S	Mon Feb 24 11:05:44 2003
+++ b/arch/cris/boot/rescue/kimagerescue.S	Tue Feb 25 10:40:01 2003
@@ -48,7 +48,7 @@
 	;; This is the entry point of the rescue code
 	;; 0x80000000 if loaded in flash (as it should be)
 	;; since etrax actually starts at address 2 when booting from flash, we
-	;; put a nop (2 bytes) here first so we dont accidentally skip the di
+	;; put a nop (2 bytes) here first so we don't accidentally skip the di
 	
 	nop	
 	di
diff -ur a/arch/cris/drivers/lpslave/e100lpslave.S b/arch/cris/drivers/lpslave/e100lpslave.S
--- a/arch/cris/drivers/lpslave/e100lpslave.S	Mon Feb 24 11:05:15 2003
+++ b/arch/cris/drivers/lpslave/e100lpslave.S	Tue Feb 25 10:40:04 2003
@@ -384,7 +384,7 @@
 	.word	0x0001		; sw_len, 1 byte (ecp command) 
 	.word	0x0019		; ctrl, d_ecp | d_eol | d_int
 	.dword	0		; next
-	.dword	TP2desc2	; buffer, dont care
+	.dword	TP2desc2	; buffer, don't care
 	.word	0		; hw_len
 	.word	0		; status
 
diff -ur a/arch/cris/kernel/entry.S b/arch/cris/kernel/entry.S
--- a/arch/cris/kernel/entry.S	Mon Feb 24 11:05:29 2003
+++ b/arch/cris/kernel/entry.S	Tue Feb 25 10:40:11 2003
@@ -259,7 +259,7 @@
 	
 	;; The system_call is called by a BREAK instruction, which works like
 	;; an interrupt call but it stores the return PC in BRP instead of IRP.
-	;; Since we dont really want to have two epilogues (one for system calls
+	;; Since we don't really want to have two epilogues (one for system calls
 	;; and one for interrupts) we push the contents of BRP instead of IRP in the
 	;; system call prologue, to make it look like an ordinary interrupt on the
 	;; stackframe.
@@ -575,7 +575,7 @@
 Watchdog_bite:
 
 #ifdef CONFIG_ETRAX_WATCHDOG_NICE_DOGGY
-       ;; We just restart the watchdog here to be sure we dont get
+       ;; We just restart the watchdog here to be sure we don't get
        ;; hit while printing the watchdogmsg below
        ;; This restart is compatible with the rest of the C-code, so
        ;; the C-code can keep restarting the watchdog after this point.
diff -ur a/arch/cris/kernel/head.S b/arch/cris/kernel/head.S
--- a/arch/cris/kernel/head.S	Mon Feb 24 11:05:44 2003
+++ b/arch/cris/kernel/head.S	Tue Feb 25 10:40:14 2003
@@ -182,7 +182,7 @@
 	;; This is the entry point of the kernel. We are in supervisor mode.
 	;; 0x00000000 if Flash, 0x40004000 if DRAM
 	;; since etrax actually starts at address 2 when booting from flash, we
-	;; put a nop (2 bytes) here first so we dont accidentally skip the di
+	;; put a nop (2 bytes) here first so we don't accidentally skip the di
 	;;
 	;; NOTICE! The registers r8 and r9 are used as parameters carrying
 	;; information from the decompressor (if the kernel was compressed). 
@@ -196,7 +196,7 @@
 	;; we cannot do very much! See arch/cris/README.mm
 	;;
 	;; Notice that since we're potentially running at 0x00 or 0x40 right now,
-	;; we will get a fault as soon as we enable the MMU if we dont
+	;; we will get a fault as soon as we enable the MMU if we don't
 	;; temporarily map those segments linearily.
 	;;
 	;; Due to a bug in Etrax-100 LX version 1 we need to map the memory
diff -ur a/arch/cris/kernel/process.c b/arch/cris/kernel/process.c
--- a/arch/cris/kernel/process.c	Mon Feb 24 11:05:35 2003
+++ b/arch/cris/kernel/process.c	Tue Feb 25 10:40:18 2003
@@ -154,7 +154,7 @@
 #if defined(CONFIG_ETRAX_WATCHDOG) && !defined(CONFIG_SVINTO_SIM)
 	cause_of_death = 0xbedead;
 #else
-	/* Since we dont plan to keep on reseting the watchdog,
+	/* Since we don't plan to keep on reseting the watchdog,
 	   the key can be arbitrary hence three */
 	*R_WATCHDOG = IO_FIELD(R_WATCHDOG, key, 3) |
 		IO_STATE(R_WATCHDOG, enable, start);
@@ -226,7 +226,7 @@
 
 	swstack = ((struct switch_stack *)childregs) - 1;
 
-	swstack->r9 = 0; /* parameter to ret_from_sys_call, 0 == dont restart the syscall */
+	swstack->r9 = 0; /* parameter to ret_from_sys_call, 0 == don't restart the syscall */
 
 	/* we want to return into ret_from_sys_call after the _resume */
 
diff -ur a/arch/cris/kernel/setup.c b/arch/cris/kernel/setup.c
--- a/arch/cris/kernel/setup.c	Mon Feb 24 11:05:43 2003
+++ b/arch/cris/kernel/setup.c	Tue Feb 25 10:40:20 2003
@@ -164,7 +164,7 @@
 
 	paging_init();
 
-	/* We dont use a command line yet, so just re-initialize it without
+	/* We don't use a command line yet, so just re-initialize it without
 	   saving anything that might be there.  */
 
 	*cmdline_p = command_line;
diff -ur a/arch/cris/kernel/signal.c b/arch/cris/kernel/signal.c
--- a/arch/cris/kernel/signal.c	Mon Feb 24 11:05:06 2003
+++ b/arch/cris/kernel/signal.c	Tue Feb 25 10:40:23 2003
@@ -494,7 +494,7 @@
 			case -ERESTARTNOHAND:
 				/* ERESTARTNOHAND means that the syscall should only be
 				   restarted if there was no handler for the signal, and since
-				   we only get here if there is a handler, we dont restart */
+				   we only get here if there is a handler, we don't restart */
 				regs->r10 = -EINTR;
 				break;
 
diff -ur a/arch/cris/mm/fault.c b/arch/cris/mm/fault.c
--- a/arch/cris/mm/fault.c	Mon Feb 24 11:05:43 2003
+++ b/arch/cris/mm/fault.c	Tue Feb 25 10:40:25 2003
@@ -170,7 +170,7 @@
 
 	if (miss) {
 		/* see if the pte exists at all
-		 * refer through current_pgd, dont use mm->pgd
+		 * refer through current_pgd, don't use mm->pgd
 		 */
 
 		pmd = (pmd_t *)(current_pgd + pgd_index(address));
diff -ur a/arch/cris/mm/tlb.c b/arch/cris/mm/tlb.c
--- a/arch/cris/mm/tlb.c	Mon Feb 24 11:05:09 2003
+++ b/arch/cris/mm/tlb.c	Tue Feb 25 10:40:27 2003
@@ -58,7 +58,7 @@
 	int i;
 	unsigned long flags;
 
-	/* the vpn of i & 0xf is so we dont write similar TLB entries
+	/* the vpn of i & 0xf is so we don't write similar TLB entries
 	 * in the same 4-way entry group. details.. 
 	 */
 
diff -ur a/arch/i386/boot/setup.S b/arch/i386/boot/setup.S
--- a/arch/i386/boot/setup.S	Mon Feb 24 11:05:33 2003
+++ b/arch/i386/boot/setup.S	Tue Feb 25 10:40:31 2003
@@ -33,7 +33,7 @@
  * Transcribed from Intel (as86) -> AT&T (gas) by Chris Noe, May 1999.
  * <stiker@northlink.com>
  *
- * Fix to work around buggy BIOSes which dont use carry bit correctly
+ * Fix to work around buggy BIOSes which don't use carry bit correctly
  * and/or report extended memory in CX/DX for e801h memory size detection 
  * call.  As a result the kernel got wrong figures.  The int15/e801h docs
  * from Ralf Brown interrupt list seem to indicate AX/BX should be used
@@ -360,7 +360,7 @@
 
 meme801:
 	stc					# fix to work around buggy
-	xorw	%cx,%cx				# BIOSes which dont clear/set
+	xorw	%cx,%cx				# BIOSes which don't clear/set
 	xorw	%dx,%dx				# carry on pass/error of
 						# e801h memory size call
 						# or merely pass cx,dx though
diff -ur a/arch/i386/kernel/apm.c b/arch/i386/kernel/apm.c
--- a/arch/i386/kernel/apm.c	Mon Feb 24 11:05:06 2003
+++ b/arch/i386/kernel/apm.c	Tue Feb 25 10:40:41 2003
@@ -1096,7 +1096,7 @@
  *	@blank: on/off
  *
  *	Attempt to blank the console, firstly by blanking just video device
- *	zero, and if that fails (some BIOSes dont support it) then it blanks
+ *	zero, and if that fails (some BIOSes don't support it) then it blanks
  *	all video devices. Typically the BIOS will do laptop backlight and
  *	monitor powerdown for us.
  */
diff -ur a/arch/i386/kernel/cpu/cyrix.c b/arch/i386/kernel/cpu/cyrix.c
--- a/arch/i386/kernel/cpu/cyrix.c	Mon Feb 24 11:05:11 2003
+++ b/arch/i386/kernel/cpu/cyrix.c	Tue Feb 25 10:40:54 2003
@@ -77,7 +77,7 @@
  * BIOSes for compatibility with DOS games.  This makes the udelay loop
  * work correctly, and improves performance.
  *
- * FIXME: our newer udelay uses the tsc. We dont need to frob with SLOP
+ * FIXME: our newer udelay uses the tsc. We don't need to frob with SLOP
  */
 
 extern void calibrate_delay(void) __init;
diff -ur a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
--- a/arch/i386/kernel/io_apic.c	Mon Feb 24 11:05:15 2003
+++ b/arch/i386/kernel/io_apic.c	Tue Feb 25 10:41:05 2003
@@ -46,7 +46,7 @@
 
 /*
  *	Is the SiS APIC rmw bug present ?
- *	-1 = dont know, 0 = no, 1 = yes
+ *	-1 = don't know, 0 = no, 1 = yes
  */
 int sis_apic_bug = -1;
 
diff -ur a/arch/i386/kernel/nmi.c b/arch/i386/kernel/nmi.c
--- a/arch/i386/kernel/nmi.c	Mon Feb 24 11:05:33 2003
+++ b/arch/i386/kernel/nmi.c	Tue Feb 25 10:41:08 2003
@@ -325,7 +325,7 @@
  * as these watchdog NMI IRQs are generated on every CPU, we only
  * have to check the current processor.
  *
- * since NMIs dont listen to _any_ locks, we have to be extremely
+ * since NMIs don't listen to _any_ locks, we have to be extremely
  * careful not to rely on unsafe variables. The printk might lock
  * up though, so we have to break up any console locks first ...
  * [when there will be more tty-related locks, break them up
diff -ur a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	Mon Feb 24 11:05:31 2003
+++ b/arch/i386/kernel/setup.c	Tue Feb 25 10:41:15 2003
@@ -818,7 +818,7 @@
 		request_resource(&iomem_resource, res);
 		if (e820.map[i].type == E820_RAM) {
 			/*
-			 *  We dont't know which RAM region contains kernel data,
+			 *  We don't know which RAM region contains kernel data,
 			 *  so we try it repeatedly and let the resource manager
 			 *  test it.
 			 */
diff -ur a/arch/i386/lib/mmx.c b/arch/i386/lib/mmx.c
--- a/arch/i386/lib/mmx.c	Mon Feb 24 11:05:32 2003
+++ b/arch/i386/lib/mmx.c	Tue Feb 25 10:41:19 2003
@@ -15,7 +15,7 @@
  *		(reported so on K6-III)
  *	We should use a better code neutral filler for the short jump
  *		leal ebx. [ebx] is apparently best for K6-2, but Cyrix ??
- *	We also want to clobber the filler register so we dont get any
+ *	We also want to clobber the filler register so we don't get any
  *		register forwarding stalls on the filler. 
  *
  *	Add *user handling. Checksums are not a win with MMX on any CPU
diff -ur a/arch/ia64/ia32/ia32_signal.c b/arch/ia64/ia32/ia32_signal.c
--- a/arch/ia64/ia32/ia32_signal.c	Mon Feb 24 11:05:05 2003
+++ b/arch/ia64/ia32/ia32_signal.c	Tue Feb 25 10:41:21 2003
@@ -338,7 +338,7 @@
 	/*
 	 * Updating fsr, fcr, fir, fdr.
 	 * Just a bit more complicated than save.
-	 * - Need to make sure that we dont write any value other than the
+	 * - Need to make sure that we don't write any value other than the
 	 *   specific fpstate info
 	 * - Need to make sure that the untouched part of frs, fdr, fir, fcr
 	 *   should remain same while writing.
diff -ur a/arch/ia64/kernel/minstate.h b/arch/ia64/kernel/minstate.h
--- a/arch/ia64/kernel/minstate.h	Mon Feb 24 11:05:41 2003
+++ b/arch/ia64/kernel/minstate.h	Tue Feb 25 10:41:31 2003
@@ -26,7 +26,7 @@
  */
 
 /*
- * For ivt.s we want to access the stack virtually so we dont have to disable translation
+ * For ivt.s we want to access the stack virtually so we don't have to disable translation
  * on interrupts.
  */
 #define MINSTATE_START_SAVE_MIN_VIRT								\
@@ -52,7 +52,7 @@
 
 /*
  * For mca_asm.S we want to access the stack physically since the state is saved before we
- * go virtual and dont want to destroy the iip or ipsr.
+ * go virtual and don't want to destroy the iip or ipsr.
  */
 #define MINSTATE_START_SAVE_MIN_PHYS								\
 (pKStk) movl sp=ia64_init_stack+IA64_STK_OFFSET-IA64_PT_REGS_SIZE;				\
diff -ur a/arch/ia64/sn/fakeprom/fpmem.c b/arch/ia64/sn/fakeprom/fpmem.c
--- a/arch/ia64/sn/fakeprom/fpmem.c	Mon Feb 24 11:05:16 2003
+++ b/arch/ia64/sn/fakeprom/fpmem.c	Tue Feb 25 10:41:34 2003
@@ -226,7 +226,7 @@
                                         numbytes -= NODE0_HOLE_SIZE;
                                 /*
                                  * UGLY hack - we must skip overr the kernel and
-                                 * PROM runtime services but we dont exactly where it is.
+                                 * PROM runtime services but we don't exactly where it is.
                                  * So lets just reserve:
 				 *	node 0
 				 *		0-1MB for PAL
diff -ur a/arch/ia64/sn/fakeprom/fw-emu.c b/arch/ia64/sn/fakeprom/fw-emu.c
--- a/arch/ia64/sn/fakeprom/fw-emu.c	Mon Feb 24 11:05:39 2003
+++ b/arch/ia64/sn/fakeprom/fw-emu.c	Tue Feb 25 10:41:38 2003
@@ -757,7 +757,7 @@
 	sal_systab->checksum = -checksum;
 
 	/* If the checksum is correct, the kernel tries to use the
-	 * table. We dont build enough table & the kernel aborts.
+	 * table. We don't build enough table & the kernel aborts.
 	 * Note that the PROM hasd thhhe same problem!!
 	 */
 
diff -ur a/arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c b/arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c
--- a/arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c	Mon Feb 24 11:06:03 2003
+++ b/arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c	Tue Feb 25 10:41:41 2003
@@ -1527,7 +1527,7 @@
 	/* enable parity checking on PICs internal RAM */
 	pic_ctrl_reg |= PIC_CTRL_PAR_EN_RESP;
 	pic_ctrl_reg |= PIC_CTRL_PAR_EN_ATE;
-	/* PIC BRINGUP WAR (PV# 862253): dont enable write request
+	/* PIC BRINGUP WAR (PV# 862253): don't enable write request
 	 * parity checking.
 	 */
 	if (!PCIBR_WAR_ENABLED(PV862253, pcibr_soft)) {
diff -ur a/arch/ia64/sn/io/sn2/pcibr/pcibr_slot.c b/arch/ia64/sn/io/sn2/pcibr/pcibr_slot.c
--- a/arch/ia64/sn/io/sn2/pcibr/pcibr_slot.c	Mon Feb 24 11:05:31 2003
+++ b/arch/ia64/sn/io/sn2/pcibr/pcibr_slot.c	Tue Feb 25 10:41:44 2003
@@ -803,7 +803,7 @@
 	 * 'min_gnt' and attempt to calculate a latency time. 
 	 *
 	 * NOTE: For now if the device is on the 'real time' arbitration
-	 * ring we dont set the latency timer.  
+	 * ring we don't set the latency timer.  
 	 *
 	 * WAR: SGI's IOC3 and RAD devices target abort if you write a 
 	 * single byte into their config space.  So don't set the Latency
diff -ur a/arch/ia64/sn/kernel/llsc4.c b/arch/ia64/sn/kernel/llsc4.c
--- a/arch/ia64/sn/kernel/llsc4.c	Mon Feb 24 11:05:39 2003
+++ b/arch/ia64/sn/kernel/llsc4.c	Tue Feb 25 10:41:47 2003
@@ -301,7 +301,7 @@
 		 */
 		linei = randn(linecount, &seed);
 		sharei = randn(2, &seed);
-		slinei = (linei + (linecount/2))%linecount;		/* I dont like this - fix later */
+		slinei = (linei + (linecount/2))%linecount;		/* I don't like this - fix later */
 
 		linep = (dataline_t *)blocks[linei];
 		slinep = (dataline_t *)blocks[slinei];
diff -ur a/arch/ia64/sn/kernel/sn1/sn1_smp.c b/arch/ia64/sn/kernel/sn1/sn1_smp.c
--- a/arch/ia64/sn/kernel/sn1/sn1_smp.c	Mon Feb 24 11:05:16 2003
+++ b/arch/ia64/sn/kernel/sn1/sn1_smp.c	Tue Feb 25 10:41:50 2003
@@ -100,7 +100,7 @@
 
 /*
  * The following table/struct is for remembering PTC coherency domains. It
- * is also used to translate sapicid into cpuids. We dont want to start 
+ * is also used to translate sapicid into cpuids. We don't want to start 
  * cpus unless we know their cache domain.
  */
 #ifdef PTC_NOTYET
diff -ur a/arch/ia64/sn/kernel/sn2/sn2_smp.c b/arch/ia64/sn/kernel/sn2/sn2_smp.c
--- a/arch/ia64/sn/kernel/sn2/sn2_smp.c	Mon Feb 24 11:05:44 2003
+++ b/arch/ia64/sn/kernel/sn2/sn2_smp.c	Tue Feb 25 10:41:52 2003
@@ -395,7 +395,7 @@
 	mycnode = local_nodeid;
 
 	/* 
-	 * For now, we dont want to spin uninterruptibly waiting
+	 * For now, we don't want to spin uninterruptibly waiting
 	 * for the lock. Makes hangs hard to debug.
 	 */
 	local_irq_save(flags);
diff -ur a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
--- a/arch/mips/kernel/setup.c	Mon Feb 24 11:05:11 2003
+++ b/arch/mips/kernel/setup.c	Tue Feb 25 10:42:13 2003
@@ -775,7 +775,7 @@
 		request_resource(&iomem_resource, res);
 
 		/*
-		 *  We dont't know which RAM region contains kernel data,
+		 *  We don't know which RAM region contains kernel data,
 		 *  so we try it repeatedly and let the resource manager
 		 *  test it.
 		 */
diff -ur a/arch/mips/math-emu/ieee754dp.c b/arch/mips/math-emu/ieee754dp.c
--- a/arch/mips/math-emu/ieee754dp.c	Mon Feb 24 11:05:37 2003
+++ b/arch/mips/math-emu/ieee754dp.c	Tue Feb 25 10:42:18 2003
@@ -106,7 +106,7 @@
  */
 ieee754dp ieee754dp_format(int sn, int xe, unsigned long long xm)
 {
-	assert(xm);		/* we dont gen exact zeros (probably should) */
+	assert(xm);		/* we don't gen exact zeros (probably should) */
 
 	assert((xm >> (DP_MBITS + 1 + 3)) == 0);	/* no execess */
 	assert(xm & (DP_HIDDEN_BIT << 3));
diff -ur a/arch/mips/math-emu/ieee754sp.c b/arch/mips/math-emu/ieee754sp.c
--- a/arch/mips/math-emu/ieee754sp.c	Mon Feb 24 11:05:15 2003
+++ b/arch/mips/math-emu/ieee754sp.c	Tue Feb 25 10:42:20 2003
@@ -107,7 +107,7 @@
  */
 ieee754sp ieee754sp_format(int sn, int xe, unsigned xm)
 {
-	assert(xm);		/* we dont gen exact zeros (probably should) */
+	assert(xm);		/* we don't gen exact zeros (probably should) */
 
 	assert((xm >> (SP_MBITS + 1 + 3)) == 0);	/* no execess */
 	assert(xm & (SP_HIDDEN_BIT << 3));
diff -ur a/arch/mips64/math-emu/ieee754dp.c b/arch/mips64/math-emu/ieee754dp.c
--- a/arch/mips64/math-emu/ieee754dp.c	Mon Feb 24 11:05:41 2003
+++ b/arch/mips64/math-emu/ieee754dp.c	Tue Feb 25 10:42:00 2003
@@ -106,7 +106,7 @@
  */
 ieee754dp ieee754dp_format(int sn, int xe, unsigned long long xm)
 {
-	assert(xm);		/* we dont gen exact zeros (probably should) */
+	assert(xm);		/* we don't gen exact zeros (probably should) */
 
 	assert((xm >> (DP_MBITS + 1 + 3)) == 0);	/* no execess */
 	assert(xm & (DP_HIDDEN_BIT << 3));
diff -ur a/arch/mips64/math-emu/ieee754sp.c b/arch/mips64/math-emu/ieee754sp.c
--- a/arch/mips64/math-emu/ieee754sp.c	Mon Feb 24 11:05:34 2003
+++ b/arch/mips64/math-emu/ieee754sp.c	Tue Feb 25 10:42:03 2003
@@ -107,7 +107,7 @@
  */
 ieee754sp ieee754sp_format(int sn, int xe, unsigned xm)
 {
-	assert(xm);		/* we dont gen exact zeros (probably should) */
+	assert(xm);		/* we don't gen exact zeros (probably should) */
 
 	assert((xm >> (SP_MBITS + 1 + 3)) == 0);	/* no execess */
 	assert(xm & (SP_HIDDEN_BIT << 3));
diff -ur a/arch/mips64/sgi-ip27/ip27-nmi.c b/arch/mips64/sgi-ip27/ip27-nmi.c
--- a/arch/mips64/sgi-ip27/ip27-nmi.c	Mon Feb 24 11:05:05 2003
+++ b/arch/mips64/sgi-ip27/ip27-nmi.c	Tue Feb 25 10:42:09 2003
@@ -127,7 +127,7 @@
 	 * This is for 2 reasons:
 	 *	- sometimes a MMSC fail to NMI all cpus.
 	 *	- on 512p SN0 system, the MMSC will only send NMIs to
-	 *	  half the cpus. Unfortunately, we dont know which cpus may be
+	 *	  half the cpus. Unfortunately, we don't know which cpus may be
 	 *	  NMIed - it depends on how the site chooses to configure.
 	 * 
 	 * Note: it has been measure that it takes the MMSC up to 2.3 secs to
diff -ur a/arch/ppc64/kernel/pSeries_lpar.c b/arch/ppc64/kernel/pSeries_lpar.c
--- a/arch/ppc64/kernel/pSeries_lpar.c	Mon Feb 24 11:06:02 2003
+++ b/arch/ppc64/kernel/pSeries_lpar.c	Tue Feb 25 10:42:30 2003
@@ -461,7 +461,7 @@
 		return -1;
 
 	/*
-	 * Since we try and ioremap PHBs we dont own, the pte insert
+	 * Since we try and ioremap PHBs we don't own, the pte insert
 	 * will fail. However we must catch the failure in hash_page
 	 * or we will loop forever, so return -2 in this case.
 	 */
@@ -485,7 +485,7 @@
 
 	for (i = 0; i < HPTES_PER_GROUP; i++) {
 
-		/* dont remove a bolted entry */
+		/* don't remove a bolted entry */
 		lpar_rc = plpar_pte_remove(H_ANDCOND, hpte_group + slot_offset,
 					   (0x1UL << 4), &dummy1, &dummy2);
 
diff -ur a/arch/ppc64/xmon/xmon.c b/arch/ppc64/xmon/xmon.c
--- a/arch/ppc64/xmon/xmon.c	Mon Feb 24 11:05:41 2003
+++ b/arch/ppc64/xmon/xmon.c	Tue Feb 25 10:42:32 2003
@@ -2072,7 +2072,7 @@
 	int instr;
 	int num_parms;
 
-	/* dont look for traceback table in userspace */
+	/* don't look for traceback table in userspace */
 	if (codeaddr < PAGE_OFFSET)
 		return 0;
 
diff -ur a/arch/s390/boot/ipleckd.S b/arch/s390/boot/ipleckd.S
--- a/arch/s390/boot/ipleckd.S	Mon Feb 24 11:05:15 2003
+++ b/arch/s390/boot/ipleckd.S	Tue Feb 25 10:42:43 2003
@@ -14,7 +14,7 @@
 # change 09/20/00       removed obsolete store of ipldevice to textesegment
 
 # Usage of registers
-# r1:	ipl subchannel ( general use, dont overload without save/restore !)
+# r1:	ipl subchannel ( general use, don't overload without save/restore !)
 # r10:
 # r13:	base register 	index to 0x0000
 # r14:	callers address
diff -ur a/arch/s390x/boot/ipleckd.S b/arch/s390x/boot/ipleckd.S
--- a/arch/s390x/boot/ipleckd.S	Mon Feb 24 11:05:14 2003
+++ b/arch/s390x/boot/ipleckd.S	Tue Feb 25 10:42:48 2003
@@ -14,7 +14,7 @@
 # change 09/20/00       removed obsolete store of ipldevice to textesegment
 
 # Usage of registers
-# r1:	ipl subchannel ( general use, dont overload without save/restore !)
+# r1:	ipl subchannel ( general use, don't overload without save/restore !)
 # r10:
 # r13:	base register 	index to 0x0000
 # r14:	callers address
diff -ur a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
--- a/arch/sparc/mm/srmmu.c	Mon Feb 24 11:05:34 2003
+++ b/arch/sparc/mm/srmmu.c	Tue Feb 25 10:42:51 2003
@@ -2120,7 +2120,7 @@
 	srmmu_is_bad();
 }
 
-/* dont laugh, static pagetables */
+/* don't laugh, static pagetables */
 static void srmmu_check_pgt_cache(int low, int high)
 {
 }
diff -ur a/arch/x86_64/boot/setup.S b/arch/x86_64/boot/setup.S
--- a/arch/x86_64/boot/setup.S	Mon Feb 24 11:05:47 2003
+++ b/arch/x86_64/boot/setup.S	Tue Feb 25 10:43:00 2003
@@ -33,7 +33,7 @@
  * Transcribed from Intel (as86) -> AT&T (gas) by Chris Noe, May 1999.
  * <stiker@northlink.com>
  *
- * Fix to work around buggy BIOSes which dont use carry bit correctly
+ * Fix to work around buggy BIOSes which don't use carry bit correctly
  * and/or report extended memory in CX/DX for e801h memory size detection 
  * call.  As a result the kernel got wrong figures.  The int15/e801h docs
  * from Ralf Brown interrupt list seem to indicate AX/BX should be used
@@ -349,7 +349,7 @@
 
 meme801:
 	stc					# fix to work around buggy
-	xorw	%cx,%cx				# BIOSes which dont clear/set
+	xorw	%cx,%cx				# BIOSes which don't clear/set
 	xorw	%dx,%dx				# carry on pass/error of
 						# e801h memory size call
 						# or merely pass cx,dx though
diff -ur a/arch/x86_64/kernel/e820.c b/arch/x86_64/kernel/e820.c
--- a/arch/x86_64/kernel/e820.c	Mon Feb 24 11:05:14 2003
+++ b/arch/x86_64/kernel/e820.c	Tue Feb 25 10:43:06 2003
@@ -204,7 +204,7 @@
 		request_resource(&iomem_resource, res);
 		if (e820.map[i].type == E820_RAM) {
 			/*
-			 *  We dont't know which RAM region contains kernel data,
+			 *  We don't know which RAM region contains kernel data,
 			 *  so we try it repeatedly and let the resource manager
 			 *  test it.
 			 */
diff -ur a/arch/x86_64/kernel/nmi.c b/arch/x86_64/kernel/nmi.c
--- a/arch/x86_64/kernel/nmi.c	Mon Feb 24 11:05:31 2003
+++ b/arch/x86_64/kernel/nmi.c	Tue Feb 25 10:43:11 2003
@@ -228,7 +228,7 @@
  * as these watchdog NMI IRQs are generated on every CPU, we only
  * have to check the current processor.
  *
- * since NMIs dont listen to _any_ locks, we have to be extremely
+ * since NMIs don't listen to _any_ locks, we have to be extremely
  * careful not to rely on unsafe variables. The printk might lock
  * up though, so we have to break up any console locks first ...
  * [when there will be more tty-related locks, break them up
diff -ur a/drivers/char/mwave/tp3780i.h b/drivers/char/mwave/tp3780i.h
--- a/drivers/char/mwave/tp3780i.h	Mon Feb 24 11:05:10 2003
+++ b/drivers/char/mwave/tp3780i.h	Tue Feb 25 10:43:24 2003
@@ -72,7 +72,7 @@
 #define TP_CFG_DisableLBusTimeout 0	/* Enable LBus timeout */
 #define TP_CFG_N_Divisor       32	/* Clock = 39.1608 Mhz */
 #define TP_CFG_M_Multiplier    37	/* " */
-#define TP_CFG_PllBypass        0	/* dont bypass */
+#define TP_CFG_PllBypass        0	/* don't bypass */
 #define TP_CFG_ChipletEnable 0xFFFF	/* Enable all chiplets */
 
 typedef struct {
diff -ur a/drivers/char/watchdog/i810-tco.c b/drivers/char/watchdog/i810-tco.c
--- a/drivers/char/watchdog/i810-tco.c	Mon Feb 24 11:05:05 2003
+++ b/drivers/char/watchdog/i810-tco.c	Tue Feb 25 10:43:45 2003
@@ -161,7 +161,7 @@
 }
 
 /*
- * Reload (trigger) the timer. Lock is needed so we dont reload it during
+ * Reload (trigger) the timer. Lock is needed so we don't reload it during
  * a reprogramming event
  */
  
diff -ur a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
--- a/drivers/ide/ide-dma.c	Mon Feb 24 11:05:32 2003
+++ b/drivers/ide/ide-dma.c	Tue Feb 25 10:43:50 2003
@@ -454,7 +454,7 @@
  *	An IDE DMA transfer timed out. In the event of an error we ask
  *	the driver to resolve the problem, if a DMA transfer is still
  *	in progress we continue to wait (arguably we need to add a 
- *	secondary 'I dont care what the drive thinks' timeout here)
+ *	secondary 'I don't care what the drive thinks' timeout here)
  *	Finally if we have an interrupt but for some reason got the
  *	timeout first we complete the I/O. This can occur if an 
  *	interrupt is lost or due to bugs.
diff -ur a/drivers/ide/ppc/mpc8xx.c b/drivers/ide/ppc/mpc8xx.c
--- a/drivers/ide/ppc/mpc8xx.c	Mon Feb 24 11:05:47 2003
+++ b/drivers/ide/ppc/mpc8xx.c	Tue Feb 25 10:43:53 2003
@@ -331,7 +331,7 @@
 					(0x80000000 >> ioport_dsc[data_port].irq);
 
 #ifdef CONFIG_IDE_8xx_PCCARD
-	/* Make sure we dont get garbage irq */
+	/* Make sure we don't get garbage irq */
 	((immap_t *) IMAP_ADDR)->im_pcmcia.pcmc_pscr = 0xFFFF;
 
 	/* Enable falling edge irq */
diff -ur a/drivers/ieee1394/amdtp.c b/drivers/ieee1394/amdtp.c
--- a/drivers/ieee1394/amdtp.c	Mon Feb 24 11:05:34 2003
+++ b/drivers/ieee1394/amdtp.c	Tue Feb 25 10:43:56 2003
@@ -228,7 +228,7 @@
 	/* The cycle_count and cycle_offset fields are used for the
 	 * synchronization timestamps (syt) in the cip header.  They
 	 * are incremented by at least a cycle every time we put a
-	 * time stamp in a packet.  As we dont time stamp all
+	 * time stamp in a packet.  As we don't time stamp all
 	 * packages, cycle_count isn't updated in every cycle, and
 	 * sometimes it's incremented by 2.  Thus, we have
 	 * cycle_count2, which is simply incremented by one with each
@@ -748,7 +748,7 @@
 
 		/* This next addition should be modulo 8000 (0x1f40),
 		 * but we only use the lower 4 bits of cycle_count, so
-		 * we dont need the modulo. */
+		 * we don't need the modulo. */
 		atomic_add(s->cycle_offset.integer / 3072, &s->cycle_count);
 		s->cycle_offset.integer %= 3072;
 	}
diff -ur a/drivers/isdn/eicon/eicon_idi.c b/drivers/isdn/eicon/eicon_idi.c
--- a/drivers/isdn/eicon/eicon_idi.c	Mon Feb 24 11:05:04 2003
+++ b/drivers/isdn/eicon/eicon_idi.c	Tue Feb 25 10:43:59 2003
@@ -2717,7 +2717,7 @@
 	int twaitpq = 0;
 
 	if (ack->RcId != ((chan->e.ReqCh) ? chan->e.B2Id : chan->e.D3Id)) {
-		/* I dont know why this happens, should not ! */
+		/* I don't know why this happens, should not ! */
 		/* just ignoring this RC */
 		eicon_log(ccard, 16, "idi_ack: Ch%d: RcId %d not equal to last %d\n", chan->No, 
 			ack->RcId, (chan->e.ReqCh) ? chan->e.B2Id : chan->e.D3Id);
diff -ur a/drivers/isdn/hardware/eicon/i4l_idi.c b/drivers/isdn/hardware/eicon/i4l_idi.c
--- a/drivers/isdn/hardware/eicon/i4l_idi.c	Mon Feb 24 11:05:32 2003
+++ b/drivers/isdn/hardware/eicon/i4l_idi.c	Tue Feb 25 10:44:01 2003
@@ -2717,7 +2717,7 @@
   int twaitpq = 0;
 
 	if (ack->RcId != ((chan->e.ReqCh) ? chan->e.B2Id : chan->e.D3Id)) {
-		/* I dont know why this happens, should not ! */
+		/* I don't know why this happens, should not ! */
 		/* just ignoring this RC */
 		eicon_log(ccard, 16, "idi_ack: Ch%d: RcId %d not equal to last %d\n", chan->No, 
 			ack->RcId, (chan->e.ReqCh) ? chan->e.B2Id : chan->e.D3Id);
diff -ur a/drivers/isdn/hysdn/hysdn_boot.c b/drivers/isdn/hysdn/hysdn_boot.c
--- a/drivers/isdn/hysdn/hysdn_boot.c	Mon Feb 24 11:05:29 2003
+++ b/drivers/isdn/hysdn/hysdn_boot.c	Tue Feb 25 10:44:03 2003
@@ -357,7 +357,7 @@
 		hysdn_addlog(card, "SysReady Token Data invalid CRC");
 		return (1);
 	}
-	len--;			/* dont check CRC byte */
+	len--;			/* don't check CRC byte */
 	while (len > 0) {
 
 		if (*cp == SYSR_TOK_END)
diff -ur a/drivers/md/md.c b/drivers/md/md.c
--- a/drivers/md/md.c	Mon Feb 24 11:05:14 2003
+++ b/drivers/md/md.c	Tue Feb 25 10:44:05 2003
@@ -1427,7 +1427,7 @@
 			/*
 			 * 'default chunksize' in the old md code used to
 			 * be PAGE_SIZE, baaad.
-			 * we abort here to be on the safe side. We dont
+			 * we abort here to be on the safe side. We don't
 			 * want to continue the bad practice.
 			 */
 			printk(BAD_CHUNKSIZE);
diff -ur a/drivers/media/radio/miropcm20-rds-core.c b/drivers/media/radio/miropcm20-rds-core.c
--- a/drivers/media/radio/miropcm20-rds-core.c	Mon Feb 24 11:05:43 2003
+++ b/drivers/media/radio/miropcm20-rds-core.c	Tue Feb 25 10:44:08 2003
@@ -91,7 +91,7 @@
 	}
 }
 
-/* dont use any ..._nowait() function if you are not sure what you do... */
+/* don't use any ..._nowait() function if you are not sure what you do... */
 
 static inline void rds_rawwrite_nowait(unsigned char byte)
 {
diff -ur a/drivers/message/fusion/mptscsih.c b/drivers/message/fusion/mptscsih.c
--- a/drivers/message/fusion/mptscsih.c	Mon Feb 24 11:05:16 2003
+++ b/drivers/message/fusion/mptscsih.c	Tue Feb 25 10:44:12 2003
@@ -4207,7 +4207,7 @@
 	/*
 	 * Need to check ASC here; if it is "special," then
 	 * the ASCQ is variable, and indicates failed component number.
-	 * We must treat the ASCQ as a "dont care" while searching the
+	 * We must treat the ASCQ as a "don't care" while searching the
 	 * mptscsih_ASCQ_Table[] by masking it off, and then restoring it later
 	 * on when we actually need to identify the failed component.
 	 */
diff -ur a/drivers/message/i2o/i2o_block.c b/drivers/message/i2o/i2o_block.c
--- a/drivers/message/i2o/i2o_block.c	Mon Feb 24 11:05:38 2003
+++ b/drivers/message/i2o/i2o_block.c	Tue Feb 25 10:44:14 2003
@@ -1729,7 +1729,7 @@
 	 *	We may get further callbacks for ourself. The i2o_core
 	 *	code handles this case reasonably sanely. The problem here
 	 *	is we shouldn't get them .. but a couple of cards feel 
-	 *	obliged to tell us stuff we dont care about.
+	 *	obliged to tell us stuff we don't care about.
 	 *
 	 *	This isnt ideal at all but will do for now.
 	 */
diff -ur a/drivers/mtd/devices/blkmtd.c b/drivers/mtd/devices/blkmtd.c
--- a/drivers/mtd/devices/blkmtd.c	Mon Feb 24 11:05:05 2003
+++ b/drivers/mtd/devices/blkmtd.c	Tue Feb 25 10:44:19 2003
@@ -16,7 +16,7 @@
  *       thread writes pages out to the device in the background. This
  *       ensures that writes are order even if a page is updated twice.
  *       Also, since pages in the page cache are never marked as dirty,
- *       we dont have to worry about writepage() being called on some 
+ *       we don't have to worry about writepage() being called on some 
  *       random page which may not be in the write order.
  * 
  *       Erases are handled like writes, so the callback is called after
@@ -33,7 +33,7 @@
  *       Page cache usage may still be a bit wrong. Check we are doing
  *       everything properly.
  * 
- *       Somehow allow writes to dirty the page cache so we dont use too
+ *       Somehow allow writes to dirty the page cache so we don't use too
  *       much memory making copies of outgoing pages. Need to handle case
  *       where page x is written to, then page y, then page x again before
  *       any of them have been committed to disk.
@@ -350,7 +350,7 @@
       int max_sectors = KIO_MAX_SECTORS >> (item->rawdevice->sector_bits - 9);
 
       /* If we are writing to the last page on the device and it doesn't end
-       * on a page boundary, subtract the number of sectors that dont exist.
+       * on a page boundary, subtract the number of sectors that don't exist.
        */
       if(item->rawdevice->partial_last_page && 
 	 (item->pagenr + item->pagecnt -1) == item->rawdevice->partial_last_page) {
diff -ur a/drivers/net/8390.c b/drivers/net/8390.c
--- a/drivers/net/8390.c	Mon Feb 24 11:05:08 2003
+++ b/drivers/net/8390.c	Tue Feb 25 10:44:22 2003
@@ -277,7 +277,7 @@
 	/* Mask interrupts from the ethercard. 
 	   SMP: We have to grab the lock here otherwise the IRQ handler
 	   on another CPU can flip window and race the IRQ mask set. We end
-	   up trashing the mcast filter not disabling irqs if we dont lock */
+	   up trashing the mcast filter not disabling irqs if we don't lock */
 	   
 	spin_lock_irqsave(&ei_local->page_lock, flags);
 	outb_p(0x00, e8390_base + EN0_IMR);
diff -ur a/drivers/net/e100/e100_main.c b/drivers/net/e100/e100_main.c
--- a/drivers/net/e100/e100_main.c	Mon Feb 24 11:05:31 2003
+++ b/drivers/net/e100/e100_main.c	Tue Feb 25 10:44:25 2003
@@ -2236,7 +2236,7 @@
 	spin_lock_irqsave(&(bdp->bd_lock), lock_flag);
 	switch (bdp->next_cu_cmd) {
 	case RESUME_NO_WAIT:
-		/*last cu command was a CU_RESMUE if this is a 558 or newer we dont need to
+		/*last cu command was a CU_RESMUE if this is a 558 or newer we don't need to
 		 * wait for command word to clear, we reach here only if we are bachlor
 		 */
 		e100_exec_cmd(bdp, SCB_CUC_RESUME);
diff -ur a/drivers/net/fc/iph5526.c b/drivers/net/fc/iph5526.c
--- a/drivers/net/fc/iph5526.c	Mon Feb 24 11:05:12 2003
+++ b/drivers/net/fc/iph5526.c	Tue Feb 25 10:44:47 2003
@@ -748,7 +748,7 @@
 	else
 		if (current_IMQ_index < fi->q.imq_cons_indx)
 			no_of_entries = IMQ_LENGTH - (fi->q.imq_cons_indx - current_IMQ_index);
-	/* We dont want to look at the same IMQ entry again. 
+	/* We don't want to look at the same IMQ entry again. 
 	 */
 	temp_imq_cons_indx = fi->q.imq_cons_indx + 1;
 	if (no_of_entries != 0)
@@ -2263,7 +2263,7 @@
 u_int type  = TYPE_ELS | SEQUENCE_INITIATIVE | FIRST_SEQUENCE;
 u_int my_mtu = fi->g.my_mtu;
 	ENTER("tx_logi");
-	/* We dont want interrupted for our own logi. 
+	/* We don't want interrupted for our own logi. 
 	 * It screws up the port discovery process. 
 	 */
 	if (d_id == fi->g.my_id)
@@ -2567,7 +2567,7 @@
 	}
 	/* Perform Port Discovery after timer expires.
 	 * We are giving time for the ADISCed nodes to respond
-	 * so that we dont have to perform PLOGI to those whose
+	 * so that we don't have to perform PLOGI to those whose
 	 * login are _still_ valid.
 	 */
 	fi->explore_timer.function = port_discovery_timer;
@@ -3527,7 +3527,7 @@
 						/* There might be some new nodes to be 
 						 * discovered. But, some of the earlier 
 						 * requests as a result of the RSCN might be 
-						 * in progress. We dont want to duplicate that 
+						 * in progress. We don't want to duplicate that 
 						 * effort. So letz call SCR after a lag.
 						 */
 						fi->explore_timer.function = scr_timer;
diff -ur a/drivers/net/fc/tach_structs.h b/drivers/net/fc/tach_structs.h
--- a/drivers/net/fc/tach_structs.h	Mon Feb 24 11:05:38 2003
+++ b/drivers/net/fc/tach_structs.h	Tue Feb 25 10:44:51 2003
@@ -248,7 +248,7 @@
 	volatile u_char n_port_try;
 	volatile u_char nport_timer_set;
 	volatile u_char lport_timer_set;
-	/* Hmmm... We dont want to Initialize while closing */
+	/* Hmmm... We don't want to Initialize while closing */
 	u_char dont_init; 
 	u_int my_node_name_high;
 	u_int my_node_name_low;
diff -ur a/drivers/net/irda/irtty-sir.c b/drivers/net/irda/irtty-sir.c
--- a/drivers/net/irda/irtty-sir.c	Mon Feb 24 11:05:04 2003
+++ b/drivers/net/irda/irtty-sir.c	Tue Feb 25 10:44:57 2003
@@ -532,7 +532,7 @@
 		tty->driver.flush_buffer(tty);
 	
 /* from old irtty - but what is it good for?
- * we _are_ the ldisc and we _dont_ implement flush_buffer!
+ * we _are_ the ldisc and we _don't_ implement flush_buffer!
  *
  *	if (tty->ldisc.flush_buffer)
  *		tty->ldisc.flush_buffer(tty);
diff -ur a/drivers/net/irda/sir_dev.c b/drivers/net/irda/sir_dev.c
--- a/drivers/net/irda/sir_dev.c	Mon Feb 24 11:05:35 2003
+++ b/drivers/net/irda/sir_dev.c	Tue Feb 25 10:45:00 2003
@@ -569,7 +569,7 @@
 
 	/* instead of adding tests to protect against drv->do_write==NULL
 	 * at several places we refuse to create a sir_dev instance for
-	 * drivers which dont implement do_write.
+	 * drivers which don't implement do_write.
 	 */
 	if (!drv ||  !drv->do_write)
 		return NULL;
diff -ur a/drivers/net/pcmcia/axnet_cs.c b/drivers/net/pcmcia/axnet_cs.c
--- a/drivers/net/pcmcia/axnet_cs.c	Mon Feb 24 11:05:33 2003
+++ b/drivers/net/pcmcia/axnet_cs.c	Tue Feb 25 10:45:03 2003
@@ -1226,7 +1226,7 @@
 	/* Mask interrupts from the ethercard. 
 	   SMP: We have to grab the lock here otherwise the IRQ handler
 	   on another CPU can flip window and race the IRQ mask set. We end
-	   up trashing the mcast filter not disabling irqs if we dont lock */
+	   up trashing the mcast filter not disabling irqs if we don't lock */
 	   
 	spin_lock_irqsave(&ei_local->page_lock, flags);
 	outb_p(0x00, e8390_base + EN0_IMR);
diff -ur a/drivers/net/sis900.c b/drivers/net/sis900.c
--- a/drivers/net/sis900.c	Mon Feb 24 11:05:29 2003
+++ b/drivers/net/sis900.c	Tue Feb 25 10:45:05 2003
@@ -1971,7 +1971,7 @@
 			status = mdio_read(dev, mii_phy->phy_addr, MII_CONTROL);
                 
 			/* enable auto negotiation and reset the negotioation
-			   (I dont really know what the auto negatiotiation reset
+			   (I don't really know what the auto negatiotiation reset
 			   really means, but it sounds for me right to do one here)*/
 			mdio_write(dev, mii_phy->phy_addr,
 				   MII_CONTROL, status | MII_CNTL_AUTO | MII_CNTL_RST_AUTO);
diff -ur a/drivers/net/tg3.c b/drivers/net/tg3.c
--- a/drivers/net/tg3.c	Mon Feb 24 11:05:33 2003
+++ b/drivers/net/tg3.c	Tue Feb 25 10:45:10 2003
@@ -3303,7 +3303,7 @@
 	0x00000000
 };
 
-#if 0 /* All zeros, dont eat up space with it. */
+#if 0 /* All zeros, don't eat up space with it. */
 u32 tg3FwData[(TG3_FW_DATA_LEN / sizeof(u32)) + 1] = {
 	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000
@@ -3736,7 +3736,7 @@
 	0x00000000
 };
 
-#if 0 /* All zeros, dont eat up space with it. */
+#if 0 /* All zeros, don't eat up space with it. */
 u32 tg3TsoFwData[] = {
 	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000
diff -ur a/drivers/net/tokenring/madgemc.c b/drivers/net/tokenring/madgemc.c
--- a/drivers/net/tokenring/madgemc.c	Mon Feb 24 11:05:45 2003
+++ b/drivers/net/tokenring/madgemc.c	Tue Feb 25 10:45:12 2003
@@ -80,7 +80,7 @@
 static void madgemc_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 
 /*
- * These work around paging, however they dont guarentee you're on the
+ * These work around paging, however they don't guarentee you're on the
  * right page.
  */
 #define SIFREADB(reg) (inb(dev->base_addr + ((reg<0x8)?reg:reg-0x8)))
diff -ur a/drivers/net/wan/comx-hw-munich.c b/drivers/net/wan/comx-hw-munich.c
--- a/drivers/net/wan/comx-hw-munich.c	Mon Feb 24 11:05:12 2003
+++ b/drivers/net/wan/comx-hw-munich.c	Tue Feb 25 10:45:14 2003
@@ -1304,7 +1304,7 @@
 		ch = (struct comx_channel *)dev->priv;
 		hw = (struct slicecom_privdata *)ch->HW_privdata;
 
-		/* We dont trust the "Tx available" info from the TIQ, but check        */
+		/* We don't trust the "Tx available" info from the TIQ, but check        */
 		/* every ring if there is some free room                                        */
 
 		if (ch->init_status && netif_running(dev))
diff -ur a/drivers/net/wan/hostess_sv11.c b/drivers/net/wan/hostess_sv11.c
--- a/drivers/net/wan/hostess_sv11.c	Mon Feb 24 11:05:38 2003
+++ b/drivers/net/wan/hostess_sv11.c	Tue Feb 25 10:45:21 2003
@@ -61,7 +61,7 @@
 	skb->mac.raw=skb->data;
 	skb->dev=c->netdevice;
 	/*
-	 *	Send it to the PPP layer. We dont have time to process
+	 *	Send it to the PPP layer. We don't have time to process
 	 *	it right now.
 	 */
 	netif_rx(skb);
diff -ur a/drivers/net/wan/sdla_chdlc.c b/drivers/net/wan/sdla_chdlc.c
--- a/drivers/net/wan/sdla_chdlc.c	Mon Feb 24 11:05:32 2003
+++ b/drivers/net/wan/sdla_chdlc.c	Tue Feb 25 10:45:24 2003
@@ -3529,7 +3529,7 @@
 					card->devname);
 		}else{ 
 			/* IP addresses are the same and the link is up, 
-                         * we dont have to do anything here. Therefore, exit */
+                         * we don't have to do anything here. Therefore, exit */
 			return 0;
 		}
 	}
diff -ur a/drivers/net/wan/sdla_ppp.c b/drivers/net/wan/sdla_ppp.c
--- a/drivers/net/wan/sdla_ppp.c	Mon Feb 24 11:05:11 2003
+++ b/drivers/net/wan/sdla_ppp.c	Tue Feb 25 10:45:26 2003
@@ -3418,7 +3418,7 @@
 					card->devname);
 		}else{ 
 			/* IP addresses are the same and the link is up, 
-                         * we dont have to do anything here. Therefore, exit */
+                         * we don't have to do anything here. Therefore, exit */
 			return 0;
 		}
 	}
diff -ur a/drivers/net/wan/sealevel.c b/drivers/net/wan/sealevel.c
--- a/drivers/net/wan/sealevel.c	Mon Feb 24 11:05:35 2003
+++ b/drivers/net/wan/sealevel.c	Tue Feb 25 10:45:29 2003
@@ -62,7 +62,7 @@
 	skb->mac.raw=skb->data;
 	skb->dev=c->netdevice;
 	/*
-	 *	Send it to the PPP layer. We dont have time to process
+	 *	Send it to the PPP layer. We don't have time to process
 	 *	it right now.
 	 */
 	netif_rx(skb);
diff -ur a/drivers/net/wan/z85230.c b/drivers/net/wan/z85230.c
--- a/drivers/net/wan/z85230.c	Mon Feb 24 11:05:05 2003
+++ b/drivers/net/wan/z85230.c	Tue Feb 25 10:45:32 2003
@@ -1634,7 +1634,7 @@
 			write_zsreg(c, R0, RES_Rx_CRC);
 		}
 		else
-			/* Can't occur as we dont reenable the DMA irq until
+			/* Can't occur as we don't reenable the DMA irq until
 			   after the flip is done */
 			printk(KERN_WARNING "%s: DMA flip overrun!\n", c->netdevice->name);
 			
diff -ur a/drivers/net/wireless/airo.c b/drivers/net/wireless/airo.c
--- a/drivers/net/wireless/airo.c	Mon Feb 24 11:05:08 2003
+++ b/drivers/net/wireless/airo.c	Tue Feb 25 10:45:37 2003
@@ -2213,7 +2213,7 @@
 	/* Enable the interrupts */
 	OUT4500( ai, EVINTEN, STATUS_INTS );
 	/* Note there is a race condition between the last two lines that
-	   I dont know how to get rid of right now... */
+	   I don't know how to get rid of right now... */
 }
 
 static void disable_interrupts( struct airo_info *ai ) {
diff -ur a/drivers/s390/cio/qdio.h b/drivers/s390/cio/qdio.h
--- a/drivers/s390/cio/qdio.h	Mon Feb 24 11:05:11 2003
+++ b/drivers/s390/cio/qdio.h	Tue Feb 25 10:45:56 2003
@@ -27,7 +27,7 @@
 #define IQDIO_DELAY_TARGET 0
 #define QDIO_BUSY_BIT_PATIENCE 2000 /* in microsecs */
 #define IQDIO_GLOBAL_LAPS 2 /* GLOBAL_LAPS are not used as we */
-#define IQDIO_GLOBAL_LAPS_INT 1 /* dont global summary */
+#define IQDIO_GLOBAL_LAPS_INT 1 /* don't global summary */
 #define IQDIO_LOCAL_LAPS 4
 #define IQDIO_LOCAL_LAPS_INT 1
 #define IQDIO_GLOBAL_SUMMARY_CC_MASK 2
diff -ur a/drivers/sbus/char/envctrl.c b/drivers/sbus/char/envctrl.c
--- a/drivers/sbus/char/envctrl.c	Mon Feb 24 11:05:10 2003
+++ b/drivers/sbus/char/envctrl.c	Tue Feb 25 10:46:00 2003
@@ -810,7 +810,7 @@
 		pchild->fan_mask |= chnls_mask[(pchild->chnl_array[i]).chnl_no];
 
 	/* We only need to know if this child has fan status monitored.
-	 * We dont care which channels since we have the mask already.
+	 * We don't care which channels since we have the mask already.
 	 */
 	pchild->mon_type[0] = ENVCTRL_FANSTAT_MON;
 }
@@ -842,7 +842,7 @@
 	}
 
 	/* We only need to know if this child has global addressing 
-	 * line monitored.  We dont care which channels since we know 
+	 * line monitored.  We don't care which channels since we know 
 	 * the mask already (ENVCTRL_GLOBALADDR_ADDR_MASK).
 	 */
 	pchild->mon_type[0] = ENVCTRL_GLOBALADDR_MON;
@@ -858,7 +858,7 @@
 		pchild->voltage_mask |= chnls_mask[(pchild->chnl_array[i]).chnl_no];
 
 	/* We only need to know if this child has voltage status monitored.
-	 * We dont care which channels since we have the mask already.
+	 * We don't care which channels since we have the mask already.
 	 */
 	pchild->mon_type[0] = ENVCTRL_VOLTAGESTAT_MON;
 }
diff -ur a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
--- a/drivers/scsi/megaraid.c	Mon Feb 24 11:05:04 2003
+++ b/drivers/scsi/megaraid.c	Tue Feb 25 10:46:16 2003
@@ -1714,7 +1714,7 @@
 	unsigned char *data = (unsigned char *) SCpnt->request_buffer;
 	mega_driver_info driver_info;
 
-	/* If this is not our command dont do anything */
+	/* If this is not our command don't do anything */
 	if (SCpnt->cmnd[0] != M_RD_DRIVER_IOCTL_INTERFACE)
 		return 0;
 
@@ -2879,7 +2879,7 @@
 #endif
 		}
 
-		/* Hmmm...Should we not make this more modularized so that in future we dont add
+		/* Hmmm...Should we not make this more modularized so that in future we don't add
 		   for each firmware */
 
 		if (flag & BOARD_QUARTZ) {
@@ -2906,7 +2906,7 @@
 			 * pci_vendor_id not subsysvid - AM
 			 */
 
-			/* If we dont detect this valid subsystem vendor id's 
+			/* If we don't detect this valid subsystem vendor id's 
 			   we refuse to load the driver 
 			   PART of PC200X compliance
 			 */
diff -ur a/drivers/scsi/ncr53c8xx.c b/drivers/scsi/ncr53c8xx.c
--- a/drivers/scsi/ncr53c8xx.c	Mon Feb 24 11:05:14 2003
+++ b/drivers/scsi/ncr53c8xx.c	Tue Feb 25 10:46:22 2003
@@ -3090,7 +3090,7 @@
 		case 0x8:
 			/*
 			**	JUMP / CALL
-			**	dont't relocate if relative :-)
+			**	don't relocate if relative :-)
 			*/
 			if (opcode & 0x00800000)
 				relocs = 0;
@@ -5852,7 +5852,7 @@
 	/*
 	**	Why not to try the immediate lower divisor and to choose 
 	**	the one that allows the fastest output speed ?
-	**	We dont want input speed too much greater than output speed.
+	**	We don't want input speed too much greater than output speed.
 	*/
 	if (div >= 1 && fak < 8) {
 		u_long fak2, per2;
diff -ur a/drivers/scsi/qlogicfc.c b/drivers/scsi/qlogicfc.c
--- a/drivers/scsi/qlogicfc.c	Mon Feb 24 11:05:38 2003
+++ b/drivers/scsi/qlogicfc.c	Tue Feb 25 10:46:27 2003
@@ -1563,7 +1563,7 @@
 				/* 
 				 * if any of the following are true we do not
 				 * call scsi_done.  if the status is CS_ABORTED
-				 * we dont have to call done because the upper
+				 * we don't have to call done because the upper
 				 * level should already know its aborted.
 				 */
 				if (hostdata->handle_serials[le_hand] != Cmnd->serial_number 
diff -ur a/drivers/scsi/sym53c8xx.c b/drivers/scsi/sym53c8xx.c
--- a/drivers/scsi/sym53c8xx.c	Mon Feb 24 11:05:36 2003
+++ b/drivers/scsi/sym53c8xx.c	Tue Feb 25 10:46:36 2003
@@ -4631,7 +4631,7 @@
 		case 0x8:
 			/*
 			**	JUMP / CALL
-			**	dont't relocate if relative :-)
+			**	don't relocate if relative :-)
 			*/
 			if (opcode & 0x00800000)
 				relocs = 0;
@@ -7953,7 +7953,7 @@
 	/*
 	**	Why not to try the immediate lower divisor and to choose 
 	**	the one that allows the fastest output speed ?
-	**	We dont want input speed too much greater than output speed.
+	**	We don't want input speed too much greater than output speed.
 	*/
 	if (div >= 1 && fak < 8) {
 		u_long fak2, per2;
diff -ur a/drivers/scsi/sym53c8xx_2/sym_fw.c b/drivers/scsi/sym53c8xx_2/sym_fw.c
--- a/drivers/scsi/sym53c8xx_2/sym_fw.c	Mon Feb 24 11:06:01 2003
+++ b/drivers/scsi/sym53c8xx_2/sym_fw.c	Tue Feb 25 10:46:30 2003
@@ -539,7 +539,7 @@
 		case 0x8:
 			/*
 			 *  JUMP / CALL
-			 *  dont't relocate if relative :-)
+			 *  don't relocate if relative :-)
 			 */
 			if (opcode & 0x00800000)
 				relocs = 0;
diff -ur a/drivers/usb/class/bluetty.c b/drivers/usb/class/bluetty.c
--- a/drivers/usb/class/bluetty.c	Mon Feb 24 11:05:39 2003
+++ b/drivers/usb/class/bluetty.c	Tue Feb 25 10:46:39 2003
@@ -267,7 +267,7 @@
 {
 	if (!bluetooth || 
 	    bluetooth_paranoia_check (bluetooth, function)) { 
-		/* then say that we dont have a valid usb_bluetooth thing, which will
+		/* then say that we don't have a valid usb_bluetooth thing, which will
 		 * end up generating -ENODEV return values */
 		return NULL;
 	}
diff -ur a/drivers/usb/media/konicawc.c b/drivers/usb/media/konicawc.c
--- a/drivers/usb/media/konicawc.c	Mon Feb 24 11:05:04 2003
+++ b/drivers/usb/media/konicawc.c	Tue Feb 25 10:46:42 2003
@@ -266,7 +266,7 @@
 			sts &= ~0x40;
 		}
 		
-		/* work out the button status, but dont do
+		/* work out the button status, but don't do
 		   anything with it for now */
 
 		if(button != cam->buttonsts) {
diff -ur a/drivers/usb/serial/keyspan_pda.S b/drivers/usb/serial/keyspan_pda.S
--- a/drivers/usb/serial/keyspan_pda.S	Mon Feb 24 11:05:31 2003
+++ b/drivers/usb/serial/keyspan_pda.S	Tue Feb 25 10:46:44 2003
@@ -1104,7 +1104,7 @@
 	;; [tx_ring_out] has been sent
 	;; if tx_ring_in == tx_ring_out, theres no work to do
 	;; there are (tx_ring_in - tx_ring_out) chars to be written
-	;; dont let _in lap _out
+	;; don't let _in lap _out
 	;;   cannot inc if tx_ring_in+1 == tx_ring_out
 	;;  write [tx_ring_in+1] then tx_ring_in++
 	;;   if (tx_ring_in+1 == tx_ring_out), overflow
diff -ur a/drivers/usb/serial/usb-serial.h b/drivers/usb/serial/usb-serial.h
--- a/drivers/usb/serial/usb-serial.h	Mon Feb 24 11:06:03 2003
+++ b/drivers/usb/serial/usb-serial.h	Tue Feb 25 10:46:47 2003
@@ -342,7 +342,7 @@
 	if (!port || 
 		port_paranoia_check (port, function) ||
 		serial_paranoia_check (port->serial, function)) {
-		/* then say that we dont have a valid usb_serial thing, which will
+		/* then say that we don't have a valid usb_serial thing, which will
 		 * end up genrating -ENODEV return values */ 
 		return NULL;
 	}
diff -ur a/drivers/usb/serial/xircom_pgs.S b/drivers/usb/serial/xircom_pgs.S
--- a/drivers/usb/serial/xircom_pgs.S	Mon Feb 24 11:05:35 2003
+++ b/drivers/usb/serial/xircom_pgs.S	Tue Feb 25 10:46:50 2003
@@ -1172,7 +1172,7 @@
 	;; [tx_ring_out] has been sent
 	;; if tx_ring_in == tx_ring_out, theres no work to do
 	;; there are (tx_ring_in - tx_ring_out) chars to be written
-	;; dont let _in lap _out
+	;; don't let _in lap _out
 	;;   cannot inc if tx_ring_in+1 == tx_ring_out
 	;;  write [tx_ring_in+1] then tx_ring_in++
 	;;   if (tx_ring_in+1 == tx_ring_out), overflow
diff -ur a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
--- a/drivers/video/sa1100fb.c	Mon Feb 24 11:05:13 2003
+++ b/drivers/video/sa1100fb.c	Tue Feb 25 10:46:52 2003
@@ -1370,7 +1370,7 @@
 #ifdef CONFIG_SA1100_HUW_WEBPANEL
 #error Move me into __sa1100fb_lcd_power and/or __sa1100fb_backlight_power
 	if (machine_is_huw_webpanel()) {
-		// dont forget to set the control lines to zero (?)
+		// don't forget to set the control lines to zero (?)
 		DPRINTK("ShutDown HuW LCD controller\n");
 		BCR_clear(BCR_TFT_ENA + BCR_CCFL_POW + BCR_PWM_BACKLIGHT);
 	}
diff -ur a/drivers/video/sstfb.c b/drivers/video/sstfb.c
--- a/drivers/video/sstfb.c	Mon Feb 24 11:05:35 2003
+++ b/drivers/video/sstfb.c	Tue Feb 25 10:46:56 2003
@@ -35,7 +35,7 @@
       wich one should i use ? is there any preferred one ? It seems ARGB is
       the one ...
 -TODO: in  set_var check the validity of timings (hsync vsync)...
--TODO: check and recheck the use of sst_wait_idle : we dont flush the fifo via
+-TODO: check and recheck the use of sst_wait_idle : we don't flush the fifo via
        a nop command. so it's ok as long as the commands we pass don't go
        through the fifo. warning: issuing a nop command seems to need pci_fifo
 -FIXME: in case of failure in the init sequence, be sure we return to a safe
diff -ur a/fs/xfs/xfs_attr_leaf.c b/fs/xfs/xfs_attr_leaf.c
--- a/fs/xfs/xfs_attr_leaf.c	Mon Feb 24 11:05:31 2003
+++ b/fs/xfs/xfs_attr_leaf.c	Tue Feb 25 10:47:45 2003
@@ -1374,7 +1374,7 @@
 		count * sizeof(xfs_attr_leaf_entry_t) +
 		INT_GET(leaf->hdr.usedbytes, ARCH_CONVERT);
 	if (bytes > (state->blocksize >> 1)) {
-		*action = 0;	/* blk over 50%, dont try to join */
+		*action = 0;	/* blk over 50%, don't try to join */
 		return(0);
 	}
 
diff -ur a/fs/xfs/xfs_da_btree.c b/fs/xfs/xfs_da_btree.c
--- a/fs/xfs/xfs_da_btree.c	Mon Feb 24 11:05:39 2003
+++ b/fs/xfs/xfs_da_btree.c	Tue Feb 25 10:47:48 2003
@@ -830,8 +830,8 @@
 	node = (xfs_da_intnode_t *)info;
 	count = INT_GET(node->hdr.count, ARCH_CONVERT);
 	if (count > (state->node_ents >> 1)) {
-		*action = 0;	/* blk over 50%, dont try to join */
-		return(0);	/* blk over 50%, dont try to join */
+		*action = 0;	/* blk over 50%, don't try to join */
+		return(0);	/* blk over 50%, don't try to join */
 	}
 
 	/*
diff -ur a/fs/xfs/xfs_dir_leaf.c b/fs/xfs/xfs_dir_leaf.c
--- a/fs/xfs/xfs_dir_leaf.c	Mon Feb 24 11:05:43 2003
+++ b/fs/xfs/xfs_dir_leaf.c	Tue Feb 25 10:47:50 2003
@@ -1341,7 +1341,7 @@
 		count * ((uint)sizeof(xfs_dir_leaf_name_t)-1) +
 		INT_GET(leaf->hdr.namebytes, ARCH_CONVERT);
 	if (bytes > (state->blocksize >> 1)) {
-		*action = 0;	/* blk over 50%, dont try to join */
+		*action = 0;	/* blk over 50%, don't try to join */
 		return(0);
 	}
 
diff -ur a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
--- a/fs/xfs/xfs_dquot.c	Mon Feb 24 11:05:31 2003
+++ b/fs/xfs/xfs_dquot.c	Tue Feb 25 10:47:52 2003
@@ -840,7 +840,7 @@
  * Given the file system, inode OR id, and type (UDQUOT/GDQUOT), return a
  * a locked dquot, doing an allocation (if requested) as needed.
  * When both an inode and an id are given, the inode's id takes precedence.
- * That is, if the id changes while we dont hold the ilock inside this
+ * That is, if the id changes while we don't hold the ilock inside this
  * function, the new dquot is returned, not necessarily the one requested
  * in the id argument.
  */
diff -ur a/include/asm-alpha/mman.h b/include/asm-alpha/mman.h
--- a/include/asm-alpha/mman.h	Mon Feb 24 11:05:05 2003
+++ b/include/asm-alpha/mman.h	Tue Feb 25 10:47:55 2003
@@ -39,7 +39,7 @@
 #define MADV_SEQUENTIAL	2		/* expect sequential page references */
 #define MADV_WILLNEED	3		/* will need these pages */
 #define	MADV_SPACEAVAIL	5		/* ensure resources are available */
-#define MADV_DONTNEED	6		/* dont need these pages */
+#define MADV_DONTNEED	6		/* don't need these pages */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff -ur a/include/asm-alpha/rwsem.h b/include/asm-alpha/rwsem.h
--- a/include/asm-alpha/rwsem.h	Mon Feb 24 11:05:42 2003
+++ b/include/asm-alpha/rwsem.h	Tue Feb 25 10:47:57 2003
@@ -7,7 +7,7 @@
  */
 
 #ifndef _LINUX_RWSEM_H
-#error please dont include asm/rwsem.h directly, use linux/rwsem.h instead
+#error "please don't include asm/rwsem.h directly, use linux/rwsem.h instead"
 #endif
 
 #ifdef __KERNEL__
diff -ur a/include/asm-cris/namei.h b/include/asm-cris/namei.h
--- a/include/asm-cris/namei.h	Mon Feb 24 11:05:33 2003
+++ b/include/asm-cris/namei.h	Tue Feb 25 10:47:59 2003
@@ -9,7 +9,7 @@
 
 /* used to find file-system prefixes for doing emulations
  * see for example asm-sparc/namei.h
- * we dont use it...
+ * we don't use it...
  */
 
 #define __emul_prefix() NULL
diff -ur a/include/asm-i386/rwsem.h b/include/asm-i386/rwsem.h
--- a/include/asm-i386/rwsem.h	Mon Feb 24 11:05:29 2003
+++ b/include/asm-i386/rwsem.h	Tue Feb 25 10:48:01 2003
@@ -33,7 +33,7 @@
 #define _I386_RWSEM_H
 
 #ifndef _LINUX_RWSEM_H
-#error please dont include asm/rwsem.h directly, use linux/rwsem.h instead
+#error "please don't include asm/rwsem.h directly, use linux/rwsem.h instead"
 #endif
 
 #ifdef __KERNEL__
diff -ur a/include/asm-ia64/sn/pci/bridge.h b/include/asm-ia64/sn/pci/bridge.h
--- a/include/asm-ia64/sn/pci/bridge.h	Mon Feb 24 11:05:11 2003
+++ b/include/asm-ia64/sn/pci/bridge.h	Tue Feb 25 10:48:03 2003
@@ -1684,7 +1684,7 @@
 /* RRB clear register */
 #define	BRIDGE_RRB_CLEAR(r)	(0x00000001<<(r))
 
-/* Defines for the virtual channels so we dont hardcode 0-3 within code */
+/* Defines for the virtual channels so we don't hardcode 0-3 within code */
 #define VCHAN0	0	/* virtual channel 0 (ie. the "normal" channel) */
 #define VCHAN1	1	/* virtual channel 1 */
 #define VCHAN2	2	/* virtual channel 2 - PIC only */
diff -ur a/include/asm-ia64/sn/pda.h b/include/asm-ia64/sn/pda.h
--- a/include/asm-ia64/sn/pda.h	Mon Feb 24 11:05:44 2003
+++ b/include/asm-ia64/sn/pda.h	Tue Feb 25 10:48:06 2003
@@ -84,10 +84,10 @@
  * the IA64 cpu_data area. A full page is allocated for the cp_data area for each
  * cpu but only a small amout of the page is actually used. We put the SNIA PDA
  * in the same page as the cpu_data area. Note that there is a check in the setup
- * code to verify that we dont overflow the page.
+ * code to verify that we don't overflow the page.
  *
  * Seems like we should should cache-line align the pda so that any changes in the
- * size of the cpu_data area dont change cache layout. Should we align to 32, 64, 128
+ * size of the cpu_data area don't change cache layout. Should we align to 32, 64, 128
  * or 512 boundary. Each has merits. For now, pick 128 but should be revisited later.
  */
 DECLARE_PER_CPU(struct pda_s, pda_percpu);
diff -ur a/include/asm-ia64/sn/sn1/mmzone_sn1.h b/include/asm-ia64/sn/sn1/mmzone_sn1.h
--- a/include/asm-ia64/sn/sn1/mmzone_sn1.h	Mon Feb 24 11:05:47 2003
+++ b/include/asm-ia64/sn/sn1/mmzone_sn1.h	Tue Feb 25 10:48:08 2003
@@ -130,7 +130,7 @@
 
 /*
  * Calculate a "goal" value to be passed to __alloc_bootmem_node for allocating structures on
- * nodes so that they dont alias to the same line in the cache as the previous allocated structure.
+ * nodes so that they don't alias to the same line in the cache as the previous allocated structure.
  * This macro takes an address of the end of previous allocation, rounds it to a page boundary & 
  * changes the node number.
  */
diff -ur a/include/asm-ia64/sn/sn2/mmzone_sn2.h b/include/asm-ia64/sn/sn2/mmzone_sn2.h
--- a/include/asm-ia64/sn/sn2/mmzone_sn2.h	Mon Feb 24 11:05:45 2003
+++ b/include/asm-ia64/sn/sn2/mmzone_sn2.h	Tue Feb 25 10:48:10 2003
@@ -137,7 +137,7 @@
 
 /*
  * Calculate a "goal" value to be passed to __alloc_bootmem_node for allocating structures on
- * nodes so that they dont alias to the same line in the cache as the previous allocated structure.
+ * nodes so that they don't alias to the same line in the cache as the previous allocated structure.
  * This macro takes an address of the end of previous allocation, rounds it to a page boundary & 
  * changes the node number.
  */
diff -ur a/include/asm-ia64/sn/sn_cpuid.h b/include/asm-ia64/sn/sn_cpuid.h
--- a/include/asm-ia64/sn/sn_cpuid.h	Mon Feb 24 11:05:10 2003
+++ b/include/asm-ia64/sn/sn_cpuid.h	Tue Feb 25 10:48:12 2003
@@ -47,7 +47,7 @@
  *			hard_smp_processor_id()- cpu_physical_id of current processor
  *			cpu_physical_id(cpuid) - convert a <cpuid> to a <physical_cpuid>
  *			cpu_logical_id(phy_id) - convert a <physical_cpuid> to a <cpuid> 
- *				* not real efficient - dont use in perf critical code
+ *				* not real efficient - don't use in perf critical code
  *
  *         LID - processor defined register (see PRM V2).
  *
diff -ur a/include/asm-parisc/eisa_eeprom.h b/include/asm-parisc/eisa_eeprom.h
--- a/include/asm-parisc/eisa_eeprom.h	Mon Feb 24 11:05:34 2003
+++ b/include/asm-parisc/eisa_eeprom.h	Tue Feb 25 10:48:22 2003
@@ -25,7 +25,7 @@
 	u_int8_t  ver_maj;
 	u_int8_t  ver_min;
 	u_int8_t  num_slots;        /* number of EISA slots in system */
-	u_int16_t csum;             /* checksum, I dont know how to calulate this */
+	u_int16_t csum;             /* checksum, I don't know how to calulate this */
 	u_int8_t  pad[10];
 } __attribute__ ((packed));
 
diff -ur a/include/asm-parisc/mman.h b/include/asm-parisc/mman.h
--- a/include/asm-parisc/mman.h	Mon Feb 24 11:05:34 2003
+++ b/include/asm-parisc/mman.h	Tue Feb 25 10:48:25 2003
@@ -32,7 +32,7 @@
 #define MADV_RANDOM     1               /* expect random page references */
 #define MADV_SEQUENTIAL 2               /* expect sequential page references */
 #define MADV_WILLNEED   3               /* will need these pages */
-#define MADV_DONTNEED   4               /* dont need these pages */
+#define MADV_DONTNEED   4               /* don't need these pages */
 #define MADV_SPACEAVAIL 5               /* insure that resources are reserved */
 #define MADV_VPS_PURGE  6               /* Purge pages from VM page cache */
 #define MADV_VPS_INHERIT 7              /* Inherit parents page size */
diff -ur a/include/asm-ppc64/pgtable.h b/include/asm-ppc64/pgtable.h
--- a/include/asm-ppc64/pgtable.h	Mon Feb 24 11:05:46 2003
+++ b/include/asm-ppc64/pgtable.h	Tue Feb 25 10:48:28 2003
@@ -198,7 +198,7 @@
  * Find an entry in a page-table-directory.  We combine the address region 
  * (the high order N bits) and the pgd portion of the address.
  */
-/* to avoid overflow in free_pgtables we dont use PTRS_PER_PGD here */
+/* to avoid overflow in free_pgtables we don't use PTRS_PER_PGD here */
 #define pgd_index(address) (((address) >> (PGDIR_SHIFT)) & 0x7ff)
 
 #define pgd_offset(mm, address)	 ((mm)->pgd + pgd_index(address))
diff -ur a/include/asm-s390/ccwdev.h b/include/asm-s390/ccwdev.h
--- a/include/asm-s390/ccwdev.h	Mon Feb 24 11:05:42 2003
+++ b/include/asm-s390/ccwdev.h	Tue Feb 25 10:48:30 2003
@@ -120,7 +120,7 @@
 					/* device is no longer available     */
 	int (*set_online) (struct ccw_device *);
 	int (*set_offline) (struct ccw_device *);
-	struct device_driver driver;	/* higher level structure, dont init
+	struct device_driver driver;	/* higher level structure, don't init
 					   this from your driver	     */
 	char *name;
 };
diff -ur a/include/asm-s390/rwsem.h b/include/asm-s390/rwsem.h
--- a/include/asm-s390/rwsem.h	Mon Feb 24 11:05:31 2003
+++ b/include/asm-s390/rwsem.h	Tue Feb 25 10:49:11 2003
@@ -38,7 +38,7 @@
  */
 
 #ifndef _LINUX_RWSEM_H
-#error please dont include asm/rwsem.h directly, use linux/rwsem.h instead
+#error "please don't include asm/rwsem.h directly, use linux/rwsem.h instead"
 #endif
 
 #ifdef __KERNEL__
diff -ur a/include/asm-s390x/ccwdev.h b/include/asm-s390x/ccwdev.h
--- a/include/asm-s390x/ccwdev.h	Mon Feb 24 11:05:41 2003
+++ b/include/asm-s390x/ccwdev.h	Tue Feb 25 10:49:15 2003
@@ -120,7 +120,7 @@
 					/* device is no longer available     */
 	int (*set_online) (struct ccw_device *);
 	int (*set_offline) (struct ccw_device *);
-	struct device_driver driver;	/* higher level structure, dont init
+	struct device_driver driver;	/* higher level structure, don't init
 					   this from your driver	     */
 	char *name;
 };
diff -ur a/include/asm-s390x/rwsem.h b/include/asm-s390x/rwsem.h
--- a/include/asm-s390x/rwsem.h	Mon Feb 24 11:05:14 2003
+++ b/include/asm-s390x/rwsem.h	Tue Feb 25 10:49:16 2003
@@ -38,7 +38,7 @@
  */
 
 #ifndef _LINUX_RWSEM_H
-#error please dont include asm/rwsem.h directly, use linux/rwsem.h instead
+#error "please don't include asm/rwsem.h directly, use linux/rwsem.h instead"
 #endif
 
 #ifdef __KERNEL__
diff -ur a/include/asm-sparc64/rwsem.h b/include/asm-sparc64/rwsem.h
--- a/include/asm-sparc64/rwsem.h	Mon Feb 24 11:05:38 2003
+++ b/include/asm-sparc64/rwsem.h	Tue Feb 25 10:49:18 2003
@@ -8,7 +8,7 @@
 #define _SPARC64_RWSEM_H
 
 #ifndef _LINUX_RWSEM_H
-#error please dont include asm/rwsem.h directly, use linux/rwsem.h instead
+#error "please don't include asm/rwsem.h directly, use linux/rwsem.h instead"
 #endif
 
 #ifdef __KERNEL__
diff -ur a/include/asm-x86_64/rwsem.h b/include/asm-x86_64/rwsem.h
--- a/include/asm-x86_64/rwsem.h	Mon Feb 24 11:05:39 2003
+++ b/include/asm-x86_64/rwsem.h	Tue Feb 25 10:49:20 2003
@@ -34,7 +34,7 @@
 #define _X8664_RWSEM_H
 
 #ifndef _LINUX_RWSEM_H
-#error please dont include asm/rwsem.h directly, use linux/rwsem.h instead
+#error "please don't include asm/rwsem.h directly, use linux/rwsem.h instead"
 #endif
 
 #ifdef __KERNEL__
diff -ur a/include/linux/rwsem-spinlock.h b/include/linux/rwsem-spinlock.h
--- a/include/linux/rwsem-spinlock.h	Mon Feb 24 11:05:33 2003
+++ b/include/linux/rwsem-spinlock.h	Tue Feb 25 10:49:31 2003
@@ -9,7 +9,7 @@
 #define _LINUX_RWSEM_SPINLOCK_H
 
 #ifndef _LINUX_RWSEM_H
-#error please dont include linux/rwsem-spinlock.h directly, use linux/rwsem.h instead
+#error "please don't include linux/rwsem-spinlock.h directly, use linux/rwsem.h instead"
 #endif
 
 #include <linux/spinlock.h>
diff -ur a/include/net/irda/vlsi_ir.h b/include/net/irda/vlsi_ir.h
--- a/include/net/irda/vlsi_ir.h	Mon Feb 24 11:05:34 2003
+++ b/include/net/irda/vlsi_ir.h	Tue Feb 25 10:49:44 2003
@@ -382,7 +382,7 @@
  *		PLSWID = (pulsetime * freq / (BAUD+1)) - 1
  *			where pulsetime is the requested IrPHY pulse width
  *			and freq is 8(16)MHz for 40(48)MHz primary input clock
- *		PREAMB: dont care for SIR
+ *		PREAMB: don't care for SIR
  *
  *		The nominal SIR pulse width is 3/16 bit time so we have PLSWID=12
  *		fixed for all SIR speeds at 40MHz input clock (PLSWID=24 at 48MHz).
@@ -401,7 +401,7 @@
  *		PREAMB = 1
  *
  * FIR-mode:	BAUD = 0
- *		PLSWID: dont care
+ *		PLSWID: don't care
  *		PREAMB = 15
  */
 
diff -ur a/include/sound/cs46xx_dsp_spos.h b/include/sound/cs46xx_dsp_spos.h
--- a/include/sound/cs46xx_dsp_spos.h	Mon Feb 24 11:05:34 2003
+++ b/include/sound/cs46xx_dsp_spos.h	Tue Feb 25 10:49:50 2003
@@ -36,12 +36,12 @@
 #define SEGTYPE_SP_COEFFICIENT          0x00000004
 
 #define DSP_SPOS_UU      0x0deadul     /* unused */
-#define DSP_SPOS_DC      0x0badul      /* dont care */
-#define DSP_SPOS_DC_DC   0x0bad0badul  /* dont care */
+#define DSP_SPOS_DC      0x0badul      /* don't care */
+#define DSP_SPOS_DC_DC   0x0bad0badul  /* don't care */
 #define DSP_SPOS_UUUU    0xdeadc0edul  /* unused */
 #define DSP_SPOS_UUHI    0xdeadul
 #define DSP_SPOS_UULO    0xc0edul
-#define DSP_SPOS_DCDC    0x0badf1d0ul  /* dont care */
+#define DSP_SPOS_DCDC    0x0badf1d0ul  /* don't care */
 #define DSP_SPOS_DCDCHI  0x0badul
 #define DSP_SPOS_DCDCLO  0xf1d0ul
 
diff -ur a/kernel/exit.c b/kernel/exit.c
--- a/kernel/exit.c	Mon Feb 24 11:05:42 2003
+++ b/kernel/exit.c	Tue Feb 25 10:49:57 2003
@@ -482,7 +482,7 @@
 
 static inline void reparent_thread(task_t *p, task_t *father, int traced)
 {
-	/* We dont want people slaying init.  */
+	/* We don't want people slaying init.  */
 	if (p->exit_signal != -1)
 		p->exit_signal = SIGCHLD;
 	p->self_exec_id++;
diff -ur a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Mon Feb 24 11:05:07 2003
+++ b/kernel/fork.c	Tue Feb 25 10:50:01 2003
@@ -446,7 +446,7 @@
 		tsk->clear_child_tid = NULL;
 
 		/*
-		 * We dont check the error code - if userspace has
+		 * We don't check the error code - if userspace has
 		 * not set up a proper pointer then tough luck.
 		 */
 		put_user(0, tidptr);
diff -ur a/kernel/futex.c b/kernel/futex.c
--- a/kernel/futex.c	Mon Feb 24 11:05:13 2003
+++ b/kernel/futex.c	Tue Feb 25 10:50:03 2003
@@ -297,7 +297,7 @@
 		time = schedule_timeout(time);
 	set_current_state(TASK_RUNNING);
 	/*
-	 * NOTE: we dont remove ourselves from the waitqueue because
+	 * NOTE: we don't remove ourselves from the waitqueue because
 	 * we are the only user of it.
 	 */
 	if (time == 0) {
diff -ur a/net/core/dev.c b/net/core/dev.c
--- a/net/core/dev.c	Mon Feb 24 11:05:32 2003
+++ b/net/core/dev.c	Tue Feb 25 10:50:27 2003
@@ -1215,7 +1215,7 @@
 #ifdef OFFLINE_SAMPLE
 static void sample_queue(unsigned long dummy)
 {
-/* 10 ms 0r 1ms -- i dont care -- JHS */
+/* 10 ms 0r 1ms -- i don't care -- JHS */
 	int next_tick = 1;
 	int cpu = smp_processor_id();
 
diff -ur a/sound/drivers/mtpav.c b/sound/drivers/mtpav.c
--- a/sound/drivers/mtpav.c	Mon Feb 24 11:05:40 2003
+++ b/sound/drivers/mtpav.c	Tue Feb 25 10:51:06 2003
@@ -102,7 +102,7 @@
 /*
  *      defines
  */
-//#define USE_FAKE_MTP //       dont actually read/write to MTP device (for debugging without an actual unit) (does not work yet)
+//#define USE_FAKE_MTP //       don't actually read/write to MTP device (for debugging without an actual unit) (does not work yet)
 
 // parallel port usage masks
 #define SIGS_BYTE 0x08
@@ -763,7 +763,7 @@
 	if (err < 0)
 		goto __error;
 
-	err = snd_card_register(mtp_card->card);	// dont snd_card_register until AFTER all cards reources done!
+	err = snd_card_register(mtp_card->card);	// don't snd_card_register until AFTER all cards reources done!
 
 	//printk("snd_card_register returned %d\n", err);
 	if (err < 0)
diff -ur a/sound/i2c/l3/uda1341.c b/sound/i2c/l3/uda1341.c
--- a/sound/i2c/l3/uda1341.c	Mon Feb 24 11:05:32 2003
+++ b/sound/i2c/l3/uda1341.c	Tue Feb 25 10:51:09 2003
@@ -494,7 +494,7 @@
 	
 	DEBUG_NAME(KERN_DEBUG "info_enum where: %d\n", where);
 
-	// this register we dont handle this way
+	// this register we don't handle this way
 	if (!uda1341_enum_items[where])
 		return -EINVAL;
 
diff -ur a/sound/oss/dmasound/dmasound_awacs.c b/sound/oss/dmasound/dmasound_awacs.c
--- a/sound/oss/dmasound/dmasound_awacs.c	Mon Feb 24 11:05:15 2003
+++ b/sound/oss/dmasound/dmasound_awacs.c	Tue Feb 25 10:51:20 2003
@@ -1354,7 +1354,7 @@
 			case AWACS_DACA:
 				wait_ms(10); /* Check this !!! */
 				daca_leave_sleep();
-				break ;		/* dont know how yet */
+				break ;		/* don't know how yet */
 			case AWACS_BURGUNDY:
 				break ;
 			case AWACS_SCREAMER:
@@ -2960,7 +2960,7 @@
 			request_module("i2c-keywest");
 #endif /* CONFIG_KMOD */
 			daca_init();
-			break ;		/* dont know how yet */
+			break ;		/* don't know how yet */
 		case AWACS_BURGUNDY:
 			awacs_burgundy_init();
 			break ;
diff -ur a/sound/oss/maestro.c b/sound/oss/maestro.c
--- a/sound/oss/maestro.c	Mon Feb 24 11:05:42 2003
+++ b/sound/oss/maestro.c	Tue Feb 25 10:51:25 2003
@@ -3507,7 +3507,7 @@
 	 * 		or
 	 *		- we're not a 2e, lesser chipps seem to have problems.
 	 *		- we're not on our _very_ small whitelist.  some implemenetations
-	 *			really dont' like the pm code, others require it.
+	 *			really don't like the pm code, others require it.
 	 *			feel free to expand this as required.
 	 */
 #define SUBSYSTEM_VENDOR(x) (x&0xffff)
diff -ur a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
--- a/sound/pci/cs46xx/cs46xx_lib.c	Mon Feb 24 11:05:06 2003
+++ b/sound/pci/cs46xx/cs46xx_lib.c	Tue Feb 25 10:51:52 2003
@@ -24,7 +24,7 @@
  *
  *  FINALLY: A credit to the developers Tom and Jordan 
  *           at Cirrus for have helping me out with the DSP, however we
- *           still dont have sufficient documentation and technical
+ *           still don't have sufficient documentation and technical
  *           references to be able to implement all fancy feutures
  *           supported by the cs46xx DSP's. 
  *           Benny <benny@hostmobility.com>
@@ -2401,7 +2401,7 @@
 		schedule_timeout(HZ/100);
 	} while (time_after_eq(end_time, jiffies));
 
-	snd_printk("CS46xx secondary codec dont respond!\n");  
+	snd_printk("CS46xx secondary codec don't respond!\n");  
 }
 #endif
 
diff -ur a/sound/pci/cs46xx/dsp_spos_scb_lib.c b/sound/pci/cs46xx/dsp_spos_scb_lib.c
--- a/sound/pci/cs46xx/dsp_spos_scb_lib.c	Mon Feb 24 11:05:44 2003
+++ b/sound/pci/cs46xx/dsp_spos_scb_lib.c	Tue Feb 25 10:51:59 2003
@@ -1540,7 +1540,7 @@
 		cs46xx_dsp_enable_spdif_hw (chip);
 	}
 
-	/* dont touch anything if SPDIF is open */
+	/* don't touch anything if SPDIF is open */
 	if ( ins->spdif_status_out & DSP_SPDIF_STATUS_PLAYBACK_OPEN) {
 		/* when cs46xx_iec958_post_close(...) is called it
 		   will call this function if necessary depending on
@@ -1584,7 +1584,7 @@
 {
 	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
 
-	/* dont touch anything if SPDIF is open */
+	/* don't touch anything if SPDIF is open */
 	if ( ins->spdif_status_out & DSP_SPDIF_STATUS_PLAYBACK_OPEN) {
 		ins->spdif_status_out &= ~DSP_SPDIF_STATUS_OUTPUT_ENABLED;
 		return -EBUSY;
diff -ur a/sound/sound_core.c b/sound/sound_core.c
--- a/sound/sound_core.c	Mon Feb 24 11:05:47 2003
+++ b/sound/sound_core.c	Tue Feb 25 10:52:02 2003
@@ -14,7 +14,7 @@
  *                         --------------------
  * 
  *	Top level handler for the sound subsystem. Various devices can
- *	plug into this. The fact they dont all go via OSS doesn't mean 
+ *	plug into this. The fact they don't all go via OSS doesn't mean 
  *	they don't have to implement the OSS API. There is a lot of logic
  *	to keeping much of the OSS weight out of the code in a compatibility
  *	module, but it's up to the driver to rember to load it...
