Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268308AbTBYUXL>; Tue, 25 Feb 2003 15:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268302AbTBYUWr>; Tue, 25 Feb 2003 15:22:47 -0500
Received: from [24.77.48.240] ([24.77.48.240]:41001 "EHLO aiinc.aiinc.ca")
	by vger.kernel.org with ESMTP id <S268281AbTBYUVE>;
	Tue, 25 Feb 2003 15:21:04 -0500
Date: Tue, 25 Feb 2003 12:31:18 -0800
From: Michael Hayes <mike@aiinc.ca>
Message-Id: <200302252031.h1PKVIa24912@aiinc.aiinc.ca>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Spelling fixes for 2.5.63 - doesn't
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes:
    doesnt -> doesn't (43 occurrences)

diff -ur a/arch/alpha/lib/ev6-memcpy.S b/arch/alpha/lib/ev6-memcpy.S
--- a/arch/alpha/lib/ev6-memcpy.S	Mon Feb 24 11:05:07 2003
+++ b/arch/alpha/lib/ev6-memcpy.S	Tue Feb 25 09:40:27 2003
@@ -180,7 +180,7 @@
 $misaligned:
 	mov	$0, $4			# E : dest temp
 	and	$0, 7, $1		# E : dest alignment mod8
-	beq	$1, $dest_0mod8		# U : life doesnt totally suck
+	beq	$1, $dest_0mod8		# U : life doesn't totally suck
 	nop
 
 $aligndest:
diff -ur a/arch/cris/kernel/head.S b/arch/cris/kernel/head.S
--- a/arch/cris/kernel/head.S	Mon Feb 24 11:05:44 2003
+++ b/arch/cris/kernel/head.S	Tue Feb 25 09:40:31 2003
@@ -541,12 +541,12 @@
 	moveq	0,$r0
 #if (!defined(CONFIG_ETRAX_KGDB) || !defined(CONFIG_ETRAX_DEBUG_PORT0)) \
 	&& !defined(CONFIG_DMA_MEMCPY)
-	; DMA channels 6 and 7 to ser0, kgdb doesnt want DMA
+	; DMA channels 6 and 7 to ser0, kgdb doesn't want DMA
 	or.d	  IO_STATE (R_GEN_CONFIG, dma7, serial0)	\
 		| IO_STATE (R_GEN_CONFIG, dma6, serial0),$r0
 #endif
 #if !defined(CONFIG_ETRAX_KGDB) || !defined(CONFIG_ETRAX_DEBUG_PORT1)
-	; DMA channels 8 and 9 to ser1, kgdb doesnt want DMA
+	; DMA channels 8 and 9 to ser1, kgdb doesn't want DMA
 	or.d	  IO_STATE (R_GEN_CONFIG, dma9, serial1)	\
 		| IO_STATE (R_GEN_CONFIG, dma8, serial1),$r0
 #endif	
@@ -559,7 +559,7 @@
 	; Enable serial port 2
 	or.w	IO_STATE (R_GEN_CONFIG, ser2, select),$r0
 #if !defined(CONFIG_ETRAX_KGDB) || !defined(CONFIG_ETRAX_DEBUG_PORT2)
-	; DMA channels 2 and 3 to ser2, kgdb doesnt want DMA
+	; DMA channels 2 and 3 to ser2, kgdb doesn't want DMA
 	or.d	  IO_STATE (R_GEN_CONFIG, dma3, serial2)	\
 		| IO_STATE (R_GEN_CONFIG, dma2, serial2),$r0
 #endif
@@ -568,7 +568,7 @@
 	; Enable serial port 3
 	or.w	IO_STATE (R_GEN_CONFIG, ser3, select),$r0
 #if !defined(CONFIG_ETRAX_KGDB) || !defined(CONFIG_ETRAX_DEBUG_PORT3)
-	; DMA channels 4 and 5 to ser3, kgdb doesnt want DMA
+	; DMA channels 4 and 5 to ser3, kgdb doesn't want DMA
 	or.d	  IO_STATE (R_GEN_CONFIG, dma5, serial3)	\
 		| IO_STATE (R_GEN_CONFIG, dma4, serial3),$r0
 #endif
diff -ur a/arch/i386/boot/setup.S b/arch/i386/boot/setup.S
--- a/arch/i386/boot/setup.S	Mon Feb 24 11:05:33 2003
+++ b/arch/i386/boot/setup.S	Tue Feb 25 09:40:34 2003
@@ -692,7 +692,7 @@
 	cmpb	$0x20, type_of_loader
 	je	end_move_self		# bootsect loader, we know of it
 
-# Boot loader doesnt support boot protocol version 2.02.
+# Boot loader doesn't support boot protocol version 2.02.
 # If we have our code not at 0x90000, we need to move it there now.
 # We also then need to move the params behind it (commandline)
 # Because we would overwrite the code on the current IP, we move
diff -ur a/arch/i386/kernel/cpu/cyrix.c b/arch/i386/kernel/cpu/cyrix.c
--- a/arch/i386/kernel/cpu/cyrix.c	Mon Feb 24 11:05:11 2003
+++ b/arch/i386/kernel/cpu/cyrix.c	Tue Feb 25 09:38:20 2003
@@ -49,7 +49,7 @@
  * Cx86_dir0_msb is a HACK needed by check_cx686_cpuid/slop in bugs.h in
  * order to identify the Cyrix CPU model after we're out of setup.c
  *
- * Actually since bugs.h doesnt even reference this perhaps someone should
+ * Actually since bugs.h doesn't even reference this perhaps someone should
  * fix the documentation ???
  */
 static unsigned char Cx86_dir0_msb __initdata = 0;
diff -ur a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
--- a/arch/i386/kernel/irq.c	Mon Feb 24 11:05:06 2003
+++ b/arch/i386/kernel/irq.c	Tue Feb 25 09:38:22 2003
@@ -87,7 +87,7 @@
 {
 /*
  * 'what should we do if we get a hw irq event on an illegal vector'.
- * each architecture has to answer this themselves, it doesnt deserve
+ * each architecture has to answer this themselves, it doesn't deserve
  * a generic callback i think.
  */
 #if CONFIG_X86
diff -ur a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Mon Feb 24 11:05:37 2003
+++ b/arch/i386/kernel/timers/timer_tsc.c	Tue Feb 25 09:38:24 2003
@@ -264,7 +264,7 @@
  	 *	the ident/bugs checks so we must run this hook as it
  	 *	may turn off the TSC flag.
  	 *
- 	 *	NOTE: this doesnt yet handle SMP 486 machines where only
+ 	 *	NOTE: this doesn't yet handle SMP 486 machines where only
  	 *	some CPU's have a TSC. Thats never worked and nobody has
  	 *	moaned if you have the only one in the world - you fix it!
  	 */
diff -ur a/arch/ia64/kernel/irq.c b/arch/ia64/kernel/irq.c
--- a/arch/ia64/kernel/irq.c	Mon Feb 24 11:05:42 2003
+++ b/arch/ia64/kernel/irq.c	Tue Feb 25 09:38:25 2003
@@ -104,7 +104,7 @@
 {
 /*
  * 'what should we do if we get a hw irq event on an illegal vector'.
- * each architecture has to answer this themselves, it doesnt deserve
+ * each architecture has to answer this themselves, it doesn't deserve
  * a generic callback i think.
  */
 #if CONFIG_X86
diff -ur a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
--- a/arch/ia64/mm/discontig.c	Mon Feb 24 11:05:42 2003
+++ b/arch/ia64/mm/discontig.c	Tue Feb 25 09:38:27 2003
@@ -241,7 +241,7 @@
  *	- build the nodedir for the node. This contains pointers to
  *	  the per-bank mem_map entries.
  *	- fix the page struct "virtual" pointers. These are bank specific
- *	  values that the paging system doesnt understand.
+ *	  values that the paging system doesn't understand.
  *	- replicate the nodedir structure to other nodes	
  */ 
 
diff -ur a/arch/ia64/sn/io/sn2/pcibr/pcibr_slot.c b/arch/ia64/sn/io/sn2/pcibr/pcibr_slot.c
--- a/arch/ia64/sn/io/sn2/pcibr/pcibr_slot.c	Mon Feb 24 11:05:31 2003
+++ b/arch/ia64/sn/io/sn2/pcibr/pcibr_slot.c	Tue Feb 25 09:38:29 2003
@@ -852,7 +852,7 @@
 	}
 
 	/* Get the PCI-X capability if running in PCI-X mode.  If the func
-	 * doesnt have a pcix capability, allocate a PCIIO_VENDOR_ID_NONE
+	 * doesn't have a pcix capability, allocate a PCIIO_VENDOR_ID_NONE
 	 * pcibr_info struct so the device driver for that function is not
 	 * called.
 	 */
diff -ur a/arch/ia64/sn/kernel/sn2/sn2_smp.c b/arch/ia64/sn/kernel/sn2/sn2_smp.c
--- a/arch/ia64/sn/kernel/sn2/sn2_smp.c	Mon Feb 24 11:05:44 2003
+++ b/arch/ia64/sn/kernel/sn2/sn2_smp.c	Tue Feb 25 09:38:31 2003
@@ -506,7 +506,7 @@
 	pio_phys_write_mmr(p, val);
 
 #ifndef CONFIG_SHUB_1_0_SPECIFIC
-	/* doesnt work on shub 1.0 */
+	/* doesn't work on shub 1.0 */
 	wait_piowc();
 #endif
 }
diff -ur a/arch/mips/baget/wbflush.c b/arch/mips/baget/wbflush.c
--- a/arch/mips/baget/wbflush.c	Mon Feb 24 11:05:37 2003
+++ b/arch/mips/baget/wbflush.c	Tue Feb 25 09:38:33 2003
@@ -17,7 +17,7 @@
 }
 
 /*
- * Baget/MIPS doesnt need to write back the WB.
+ * Baget/MIPS doesn't need to write back the WB.
  */
 static void wbflush_baget(void)
 {
diff -ur a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
--- a/arch/mips/kernel/irq.c	Mon Feb 24 11:05:10 2003
+++ b/arch/mips/kernel/irq.c	Tue Feb 25 09:38:35 2003
@@ -44,7 +44,7 @@
 {
 	/*
 	 * 'what should we do if we get a hw irq event on an illegal vector'.
-	 * each architecture has to answer this themselves, it doesnt deserve
+	 * each architecture has to answer this themselves, it doesn't deserve
 	 * a generic callback i think.
 	 */
 	printk("unexpected interrupt %d\n", irq);
diff -ur a/arch/mips/math-emu/ieee754.c b/arch/mips/math-emu/ieee754.c
--- a/arch/mips/math-emu/ieee754.c	Mon Feb 24 11:05:05 2003
+++ b/arch/mips/math-emu/ieee754.c	Tue Feb 25 09:38:38 2003
@@ -3,7 +3,7 @@
  *
  * BUGS
  * not much dp done
- * doesnt generate IEEE754_INEXACT
+ * doesn't generate IEEE754_INEXACT
  *
  */
 /*
diff -ur a/arch/ppc64/boot/addRamDisk.c b/arch/ppc64/boot/addRamDisk.c
--- a/arch/ppc64/boot/addRamDisk.c	Mon Feb 24 11:05:34 2003
+++ b/arch/ppc64/boot/addRamDisk.c	Tue Feb 25 09:38:40 2003
@@ -154,7 +154,7 @@
   
 	/* Process the Sysmap file to determine where _end is */
 	sysmapPages = sysmapLen / 4096;
-	/* read the whole file line by line, expect that it doesnt fail */
+	/* read the whole file line by line, expect that it doesn't fail */
 	while ( fgets(inbuf, 4096, sysmap) )  ;
 	/* search for _end in the last page of the system map */
 	ptr_end = strstr(inbuf, " _end");
diff -ur a/arch/ppc64/boot/addSystemMap.c b/arch/ppc64/boot/addSystemMap.c
--- a/arch/ppc64/boot/addSystemMap.c	Mon Feb 24 11:05:31 2003
+++ b/arch/ppc64/boot/addSystemMap.c	Tue Feb 25 09:38:43 2003
@@ -146,7 +146,7 @@
   /* Process the Sysmap file to determine the true end of the kernel */
 	sysmapPages = sysmapLen / 4096;
 	printf("System map pages to copy = %ld\n", sysmapPages);
-	/* read the whole file line by line, expect that it doesnt fail */
+	/* read the whole file line by line, expect that it doesn't fail */
 	while ( fgets(inbuf, 4096, sysmap) )  ;
 	/* search for _end in the last page of the system map */
 	ptr_end = strstr(inbuf, " _end");
diff -ur a/arch/ppc64/kernel/lmb.c b/arch/ppc64/kernel/lmb.c
--- a/arch/ppc64/kernel/lmb.c	Mon Feb 24 11:05:33 2003
+++ b/arch/ppc64/kernel/lmb.c	Tue Feb 25 09:38:45 2003
@@ -73,7 +73,7 @@
 	_lmb->reserved.cnt = 1;
 }
 
-/* This is only used here, it doesnt deserve to be in bitops.h */
+/* This is only used here, it doesn't deserve to be in bitops.h */
 static __inline__ long cnt_trailing_zeros(unsigned long mask)
 {
         long cnt;
diff -ur a/arch/ppc64/kernel/smp.c b/arch/ppc64/kernel/smp.c
--- a/arch/ppc64/kernel/smp.c	Mon Feb 24 11:05:39 2003
+++ b/arch/ppc64/kernel/smp.c	Tue Feb 25 09:38:46 2003
@@ -51,7 +51,7 @@
 int smp_threads_ready = 0;
 unsigned long cache_decay_ticks;
 
-/* initialised so it doesnt end up in bss */
+/* initialised so it doesn't end up in bss */
 unsigned long cpu_online_map = 0;
 
 static struct smp_ops_t *smp_ops;
diff -ur a/arch/sh/kernel/irq.c b/arch/sh/kernel/irq.c
--- a/arch/sh/kernel/irq.c	Mon Feb 24 11:05:15 2003
+++ b/arch/sh/kernel/irq.c	Tue Feb 25 09:38:48 2003
@@ -61,7 +61,7 @@
 {
 /*
  * 'what should we do if we get a hw irq event on an illegal vector'.
- * each architecture has to answer this themselves, it doesnt deserve
+ * each architecture has to answer this themselves, it doesn't deserve
  * a generic callback i think.
  */
 	printk("unexpected IRQ trap at vector %02x\n", irq);
diff -ur a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
--- a/arch/um/kernel/irq.c	Mon Feb 24 11:05:40 2003
+++ b/arch/um/kernel/irq.c	Tue Feb 25 09:38:50 2003
@@ -45,7 +45,7 @@
 {
 /*
  * 'what should we do if we get a hw irq event on an illegal vector'.
- * each architecture has to answer this themselves, it doesnt deserve
+ * each architecture has to answer this themselves, it doesn't deserve
  * a generic callback i think.
  */
 #if CONFIG_X86
diff -ur a/arch/v850/kernel/entry.S b/arch/v850/kernel/entry.S
--- a/arch/v850/kernel/entry.S	Mon Feb 24 11:05:44 2003
+++ b/arch/v850/kernel/entry.S	Tue Feb 25 09:40:41 2003
@@ -543,7 +543,7 @@
 END(syscall_long)	
 
 /* Entry point used to return from a long syscall.  Only needed to restore
-   r13/r14 if the general trap mechanism doesnt' do so.  */
+   r13/r14 if the general trap mechanism doesn't do so.  */
 L_ENTRY(ret_from_long_syscall):
 	ld.w	PTO+PT_GPR(13)[sp], r13 // Restore the extra registers
 	ld.w	PTO+PT_GPR(13)[sp], r14
diff -ur a/arch/v850/kernel/irq.c b/arch/v850/kernel/irq.c
--- a/arch/v850/kernel/irq.c	Mon Feb 24 11:05:39 2003
+++ b/arch/v850/kernel/irq.c	Tue Feb 25 09:38:52 2003
@@ -48,7 +48,7 @@
 {
 	/*
 	 * 'what should we do if we get a hw irq event on an illegal vector'.
-	 * each architecture has to answer this themselves, it doesnt deserve
+	 * each architecture has to answer this themselves, it doesn't deserve
 	 * a generic callback i think.
 	 */
 	printk("received IRQ %d with unknown interrupt type\n", irq);
diff -ur a/arch/x86_64/boot/setup.S b/arch/x86_64/boot/setup.S
--- a/arch/x86_64/boot/setup.S	Mon Feb 24 11:05:47 2003
+++ b/arch/x86_64/boot/setup.S	Tue Feb 25 09:40:47 2003
@@ -510,7 +510,7 @@
 	cmpb	$0x20, type_of_loader
 	je	end_move_self		# bootsect loader, we know of it
 
-# Boot loader doesnt support boot protocol version 2.02.
+# Boot loader doesn't support boot protocol version 2.02.
 # If we have our code not at 0x90000, we need to move it there now.
 # We also then need to move the params behind it (commandline)
 # Because we would overwrite the code on the current IP, we move
diff -ur a/arch/x86_64/kernel/apic.c b/arch/x86_64/kernel/apic.c
--- a/arch/x86_64/kernel/apic.c	Mon Feb 24 11:05:10 2003
+++ b/arch/x86_64/kernel/apic.c	Tue Feb 25 09:38:54 2003
@@ -948,7 +948,7 @@
 /*
  * Local APIC timer interrupt. This is the most natural way for doing
  * local interrupts, but local timer interrupts can be emulated by
- * broadcast interrupts too. [in case the hw doesnt support APIC timers]
+ * broadcast interrupts too. [in case the hw doesn't support APIC timers]
  *
  * [ if a single-CPU system runs an SMP kernel then we call the local
  *   interrupt as well. Thus we cannot inline the local irq ... ]
diff -ur a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
--- a/arch/x86_64/kernel/io_apic.c	Mon Feb 24 11:05:32 2003
+++ b/arch/x86_64/kernel/io_apic.c	Tue Feb 25 09:38:59 2003
@@ -685,7 +685,7 @@
 	entry.vector = vector;
 
 	/*
-	 * The timer IRQ doesnt have to know that behind the
+	 * The timer IRQ doesn't have to know that behind the
 	 * scene we have a 8259A-master in AEOI mode ...
 	 */
 	irq_desc[0].handler = &ioapic_edge_irq_type;
@@ -1539,7 +1539,7 @@
 	printk(" failed.\n");
 
 	if (nmi_watchdog) {
-		printk(KERN_WARNING "timer doesnt work through the IO-APIC - disabling NMI Watchdog!\n");
+		printk(KERN_WARNING "timer doesn't work through the IO-APIC - disabling NMI Watchdog!\n");
 		nmi_watchdog = 0;
 	}
 
diff -ur a/arch/x86_64/kernel/irq.c b/arch/x86_64/kernel/irq.c
--- a/arch/x86_64/kernel/irq.c	Mon Feb 24 11:05:29 2003
+++ b/arch/x86_64/kernel/irq.c	Tue Feb 25 09:39:01 2003
@@ -87,7 +87,7 @@
 {
 /*
  * 'what should we do if we get a hw irq event on an illegal vector'.
- * each architecture has to answer this themselves, it doesnt deserve
+ * each architecture has to answer this themselves, it doesn't deserve
  * a generic callback i think.
  */
 #if CONFIG_X86
diff -ur a/drivers/isdn/i4l/isdn_ppp_ccp.c b/drivers/isdn/i4l/isdn_ppp_ccp.c
--- a/drivers/isdn/i4l/isdn_ppp_ccp.c	Mon Feb 24 11:05:15 2003
+++ b/drivers/isdn/i4l/isdn_ppp_ccp.c	Tue Feb 25 09:39:03 2003
@@ -197,7 +197,7 @@
 		   and increase ids only when an Ack is received for a
 		   given id */
 		id = ccp->reset->lastid++;
-		/* We always expect an Ack if the decompressor doesnt
+		/* We always expect an Ack if the decompressor doesn't
 		   know	better */
 		rp->expra = 1;
 		rp->dtval = 0;
diff -ur a/fs/cifs/cifspdu.h b/fs/cifs/cifspdu.h
--- a/fs/cifs/cifspdu.h	Mon Feb 24 11:05:41 2003
+++ b/fs/cifs/cifspdu.h	Tue Feb 25 09:39:05 2003
@@ -1245,7 +1245,7 @@
 	__u8 Reserved3;
 	__u16 SubCommand;	/* one setup word */
 	__u16 ByteCount;
-	__u8 Pad[3];		/* Win2K has sent 0x0F01 (max resp length perhaps?) followed by one byte pad - doesnt seem to matter though */
+	__u8 Pad[3];		/* Win2K has sent 0x0F01 (max resp length perhaps?) followed by one byte pad - doesn't seem to matter though */
 	__u16 MaxReferralLevel;
 	char RequestFileName[1];
 } TRANSACTION2_GET_DFS_REFER_REQ;
diff -ur a/fs/xfs/xfs_trans_dquot.c b/fs/xfs/xfs_trans_dquot.c
--- a/fs/xfs/xfs_trans_dquot.c	Mon Feb 24 11:05:11 2003
+++ b/fs/xfs/xfs_trans_dquot.c	Tue Feb 25 09:39:06 2003
@@ -755,7 +755,7 @@
 
 /*
  * Lock the dquot and change the reservation if we can.
- * This doesnt change the actual usage, just the reservation.
+ * This doesn't change the actual usage, just the reservation.
  * The inode sent in is locked.
  *
  * Returns 0 on success, EDQUOT or other errors otherwise
diff -ur a/include/asm-i386/mach-default/do_timer.h b/include/asm-i386/mach-default/do_timer.h
--- a/include/asm-i386/mach-default/do_timer.h	Mon Feb 24 11:05:43 2003
+++ b/include/asm-i386/mach-default/do_timer.h	Tue Feb 25 09:39:08 2003
@@ -67,7 +67,7 @@
 #ifdef BUGGY_NEPTUN_TIMER
 		/*
 		 * for the Neptun bug we know that the 'latch'
-		 * command doesnt latch the high and low value
+		 * command doesn't latch the high and low value
 		 * of the counter atomically. Thus we have to 
 		 * substract 256 from the counter 
 		 * ... funny, isnt it? :)
diff -ur a/include/asm-i386/pgtable-2level.h b/include/asm-i386/pgtable-2level.h
--- a/include/asm-i386/pgtable-2level.h	Mon Feb 24 11:05:33 2003
+++ b/include/asm-i386/pgtable-2level.h	Tue Feb 25 09:39:10 2003
@@ -42,7 +42,7 @@
 #define set_pte(pteptr, pteval) (*(pteptr) = pteval)
 #define set_pte_atomic(pteptr, pteval) set_pte(pteptr,pteval)
 /*
- * (pmds are folded into pgds so this doesnt get actually called,
+ * (pmds are folded into pgds so this doesn't get actually called,
  * but the define is needed for a generic inline function.)
  */
 #define set_pmd(pmdptr, pmdval) (*(pmdptr) = pmdval)
diff -ur a/include/asm-i386/semaphore.h b/include/asm-i386/semaphore.h
--- a/include/asm-i386/semaphore.h	Mon Feb 24 11:05:14 2003
+++ b/include/asm-i386/semaphore.h	Tue Feb 25 09:39:11 2003
@@ -76,7 +76,7 @@
  *	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
  *
  * i'd rather use the more flexible initialization above, but sadly
- * GCC 2.7.2.3 emits a bogus warning. EGCS doesnt. Oh well.
+ * GCC 2.7.2.3 emits a bogus warning. EGCS doesn't. Oh well.
  */
 	atomic_set(&sem->count, val);
 	sem->sleepers = 0;
diff -ur a/include/asm-mips/pgtable.h b/include/asm-mips/pgtable.h
--- a/include/asm-mips/pgtable.h	Mon Feb 24 11:05:14 2003
+++ b/include/asm-mips/pgtable.h	Tue Feb 25 09:39:14 2003
@@ -291,7 +291,7 @@
 }
 
 /*
- * (pmds are folded into pgds so this doesnt get actually called,
+ * (pmds are folded into pgds so this doesn't get actually called,
  * but the define is needed for a generic inline function.)
  */
 #define set_pmd(pmdptr, pmdval) (*(pmdptr) = pmdval)
diff -ur a/include/asm-mips64/pgtable.h b/include/asm-mips64/pgtable.h
--- a/include/asm-mips64/pgtable.h	Mon Feb 24 11:06:01 2003
+++ b/include/asm-mips64/pgtable.h	Tue Feb 25 09:39:13 2003
@@ -318,7 +318,7 @@
 }
 
 /*
- * (pmds are folded into pgds so this doesnt get actually called,
+ * (pmds are folded into pgds so this doesn't get actually called,
  * but the define is needed for a generic inline function.)
  */
 #define set_pmd(pmdptr, pmdval) (*(pmdptr) = pmdval)
diff -ur a/include/asm-sh/semaphore.h b/include/asm-sh/semaphore.h
--- a/include/asm-sh/semaphore.h	Mon Feb 24 11:06:01 2003
+++ b/include/asm-sh/semaphore.h	Tue Feb 25 09:39:16 2003
@@ -54,7 +54,7 @@
  *	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
  *
  * i'd rather use the more flexible initialization above, but sadly
- * GCC 2.7.2.3 emits a bogus warning. EGCS doesnt. Oh well.
+ * GCC 2.7.2.3 emits a bogus warning. EGCS doesn't. Oh well.
  */
 	atomic_set(&sem->count, val);
 	sem->sleepers = 0;
diff -ur a/include/asm-um/pgtable.h b/include/asm-um/pgtable.h
--- a/include/asm-um/pgtable.h	Mon Feb 24 11:06:03 2003
+++ b/include/asm-um/pgtable.h	Tue Feb 25 09:39:17 2003
@@ -226,7 +226,7 @@
 }
 
 /*
- * (pmds are folded into pgds so this doesnt get actually called,
+ * (pmds are folded into pgds so this doesn't get actually called,
  * but the define is needed for a generic inline function.)
  */
 #define set_pmd(pmdptr, pmdval) (*(pmdptr) = pmdval)
diff -ur a/include/asm-x86_64/semaphore.h b/include/asm-x86_64/semaphore.h
--- a/include/asm-x86_64/semaphore.h	Mon Feb 24 11:05:04 2003
+++ b/include/asm-x86_64/semaphore.h	Tue Feb 25 09:39:19 2003
@@ -78,7 +78,7 @@
  *	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
  *
  * i'd rather use the more flexible initialization above, but sadly
- * GCC 2.7.2.3 emits a bogus warning. EGCS doesnt. Oh well.
+ * GCC 2.7.2.3 emits a bogus warning. EGCS doesn't. Oh well.
  */
 	atomic_set(&sem->count, val);
 	sem->sleepers = 0;
diff -ur a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Mon Feb 24 11:05:07 2003
+++ b/kernel/fork.c	Tue Feb 25 09:39:20 2003
@@ -901,7 +901,7 @@
 
 	/*
 	 * Share the timeslice between parent and child, thus the
-	 * total amount of pending timeslices in the system doesnt change,
+	 * total amount of pending timeslices in the system doesn't change,
 	 * resulting in more scheduling fairness.
 	 */
 	local_irq_disable();
diff -ur a/sound/oss/cs4232.c b/sound/oss/cs4232.c
--- a/sound/oss/cs4232.c	Mon Feb 24 11:05:34 2003
+++ b/sound/oss/cs4232.c	Tue Feb 25 09:39:21 2003
@@ -127,7 +127,7 @@
 	 * method conflicts with possible PnP support in the OS. For this reason 
 	 * driver is just a temporary kludge.
 	 *
-	 * Also the Cirrus/Crystal method doesnt always work. Try ISA PnP first ;)
+	 * Also the Cirrus/Crystal method doesn't always work. Try ISA PnP first ;)
 	 */
 
 	/*
diff -ur a/sound/oss/trident.c b/sound/oss/trident.c
--- a/sound/oss/trident.c	Mon Feb 24 11:05:39 2003
+++ b/sound/oss/trident.c	Tue Feb 25 09:39:29 2003
@@ -81,7 +81,7 @@
  *  v0.14.9a
  *	Aug 6 2001 Alan Cox
  *	0.14.9 crashed on rmmod due to a timer/bh left running. Simplified
- *	the existing logic (the BH doesnt help as ac97 is lock_irqsave)
+ *	the existing logic (the BH doesn't help as ac97 is lock_irqsave)
  *	and used del_timer_sync to clean up
  *	Fixed a problem where the ALi change broke my generic card
  *  v0.14.9
