Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269016AbTCAUSB>; Sat, 1 Mar 2003 15:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269017AbTCAUSB>; Sat, 1 Mar 2003 15:18:01 -0500
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:19851 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP
	id <S269016AbTCAURq>; Sat, 1 Mar 2003 15:17:46 -0500
Date: Sat, 1 Mar 2003 20:28:07 +0000
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] More spelling fixes: loose->lose
Message-ID: <20030301202807.GA24998@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir eternal.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

   Loose, pronounced with a soft "s", as in the word "spelling", means
badly-fitting or vague.

   Lose, with a hard "s", as in the words "laser" and "is", means to
get rid of something or mislay something.

   49 occurrences of "loose" where "lose" was intended now fixed.
Patch against vanilla 2.5.63.


diff -ur linux-2.5.63-orig/arch/alpha/lib/checksum.c linux-2.5.63/arch/alpha/lib/checksum.c
--- linux-2.5.63-orig/arch/alpha/lib/checksum.c	2003-01-09 04:04:15.000000000 +0000
+++ linux-2.5.63/arch/alpha/lib/checksum.c	2003-03-01 19:56:18.000000000 +0000
@@ -63,7 +63,7 @@
 		  ((unsigned long) ntohs(len) << 16) +
 		  ((unsigned long) proto << 8));
 
-	/* Fold down to 32-bits so we don't loose in the typedef-less 
+	/* Fold down to 32-bits so we don't lose in the typedef-less 
 	   network stack.  */
 	/* 64 to 33 */
 	result = (result & 0xffffffff) + (result >> 32);
diff -ur linux-2.5.63-orig/arch/arm/kernel/ptrace.c linux-2.5.63/arch/arm/kernel/ptrace.c
--- linux-2.5.63-orig/arch/arm/kernel/ptrace.c	2003-03-01 16:20:32.000000000 +0000
+++ linux-2.5.63/arch/arm/kernel/ptrace.c	2003-03-01 19:54:16.000000000 +0000
@@ -435,7 +435,7 @@
 		 * be receiving a prefetch abort shortly.
 		 *
 		 * If we don't set this breakpoint here, then we can
-		 * loose control of the thread during single stepping.
+		 * lose control of the thread during single stepping.
 		 */
 		if (!alt || predicate(insn) != PREDICATE_ALWAYS)
 			add_breakpoint(child, dbg, pc + 4);
diff -ur linux-2.5.63-orig/arch/ia64/kernel/perfmon.c linux-2.5.63/arch/ia64/kernel/perfmon.c
--- linux-2.5.63-orig/arch/ia64/kernel/perfmon.c	2003-03-01 16:19:41.000000000 +0000
+++ linux-2.5.63/arch/ia64/kernel/perfmon.c	2003-03-01 19:55:03.000000000 +0000
@@ -2995,7 +2995,7 @@
 		 * interruptible). In this case, the PMU will be kept frozen and the process will 
 		 * run to completion without monitoring enabled.
 		 *
-		 * Of course, we cannot loose notify process when self-monitoring.
+		 * Of course, we cannot lose notify process when self-monitoring.
 		 */
 		t->pfm_ovfl_block_reset = 0; 
 
diff -ur linux-2.5.63-orig/arch/ia64/lib/checksum.c linux-2.5.63/arch/ia64/lib/checksum.c
--- linux-2.5.63-orig/arch/ia64/lib/checksum.c	2003-01-09 04:04:24.000000000 +0000
+++ linux-2.5.63/arch/ia64/lib/checksum.c	2003-03-01 19:54:37.000000000 +0000
@@ -50,7 +50,7 @@
 		  ((unsigned long) ntohs(len) << 16) +
 		  ((unsigned long) proto << 8));
 
-	/* Fold down to 32-bits so we don't loose in the typedef-less network stack.  */
+	/* Fold down to 32-bits so we don't lose in the typedef-less network stack.  */
 	/* 64 to 33 */
 	result = (result & 0xffffffff) + (result >> 32);
 	/* 33 to 32 */
diff -ur linux-2.5.63-orig/arch/m68k/q40/README linux-2.5.63/arch/m68k/q40/README
--- linux-2.5.63-orig/arch/m68k/q40/README	2003-01-09 04:03:49.000000000 +0000
+++ linux-2.5.63/arch/m68k/q40/README	2003-03-01 19:55:18.000000000 +0000
@@ -16,7 +16,7 @@
 particular device drivers.
 
 The floppy imposes a very high interrupt load on the CPU, approx 30K/s.
-When something blocks interrupts (HD) it will loose some of them, so far 
+When something blocks interrupts (HD) it will lose some of them, so far 
 this is not known to have caused any data loss. On highly loaded systems
 it can make the floppy very slow or practically stop. Other Q40 OS' simply 
 poll the floppy for this reason - something that can't be done in Linux.
diff -ur linux-2.5.63-orig/arch/mips/kernel/process.c linux-2.5.63/arch/mips/kernel/process.c
--- linux-2.5.63-orig/arch/mips/kernel/process.c	2003-01-09 04:04:12.000000000 +0000
+++ linux-2.5.63/arch/mips/kernel/process.c	2003-03-01 19:55:51.000000000 +0000
@@ -112,7 +112,7 @@
 	p->thread.reg31 = (unsigned long) ret_from_fork;
 
 	/*
-	 * New tasks loose permission to use the fpu. This accelerates context
+	 * New tasks lose permission to use the fpu. This accelerates context
 	 * switching for most programs since they don't use the fpu.
 	 */
 	p->thread.cp0_status = read_32bit_cp0_register(CP0_STATUS) &
diff -ur linux-2.5.63-orig/arch/mips/kernel/r2300_switch.S linux-2.5.63/arch/mips/kernel/r2300_switch.S
--- linux-2.5.63-orig/arch/mips/kernel/r2300_switch.S	2003-01-09 04:04:24.000000000 +0000
+++ linux-2.5.63/arch/mips/kernel/r2300_switch.S	2003-03-01 19:55:32.000000000 +0000
@@ -80,7 +80,7 @@
 	beqz	a0, 2f				# Save floating point state
 	 nor	t3, zero, t3
 	.set	reorder
-	lw	t1, ST_OFF(a0)			# last thread looses fpu
+	lw	t1, ST_OFF(a0)			# last thread loses fpu
 	and	t1, t3
 	sw	t1, ST_OFF(a0)
 	FPU_SAVE_SINGLE(a0, t1)			# clobbers t1
diff -ur linux-2.5.63-orig/arch/mips/kernel/r4k_switch.S linux-2.5.63/arch/mips/kernel/r4k_switch.S
--- linux-2.5.63-orig/arch/mips/kernel/r4k_switch.S	2003-01-09 04:04:25.000000000 +0000
+++ linux-2.5.63/arch/mips/kernel/r4k_switch.S	2003-03-01 19:56:02.000000000 +0000
@@ -85,7 +85,7 @@
 	beqz	a0, 2f				# Save floating point state
 	 nor	t3, zero, t3
 
-	lw	t1, ST_OFF(a0)			# last thread looses fpu
+	lw	t1, ST_OFF(a0)			# last thread loses fpu
 	and	t1, t3
 	sw	t1, ST_OFF(a0)
 
diff -ur linux-2.5.63-orig/arch/mips64/kernel/process.c linux-2.5.63/arch/mips64/kernel/process.c
--- linux-2.5.63-orig/arch/mips64/kernel/process.c	2003-01-09 04:03:58.000000000 +0000
+++ linux-2.5.63/arch/mips64/kernel/process.c	2003-03-01 19:57:29.000000000 +0000
@@ -105,7 +105,7 @@
 	p->thread.reg31 = (unsigned long) ret_from_fork;
 
 	/*
-	 * New tasks loose permission to use the fpu. This accelerates context
+	 * New tasks lose permission to use the fpu. This accelerates context
 	 * switching for most programs since they don't use the fpu.
 	 */
 	p->thread.cp0_status = read_32bit_cp0_register(CP0_STATUS) &
diff -ur linux-2.5.63-orig/arch/mips64/kernel/r4k_switch.S linux-2.5.63/arch/mips64/kernel/r4k_switch.S
--- linux-2.5.63-orig/arch/mips64/kernel/r4k_switch.S	2003-01-09 04:03:50.000000000 +0000
+++ linux-2.5.63/arch/mips64/kernel/r4k_switch.S	2003-03-01 19:57:46.000000000 +0000
@@ -79,7 +79,7 @@
 	beqz	a0, 2f				# Save floating point state
 	 nor	t3, zero, t3
 
-	ld	t1, ST_OFF(a0)			# last thread looses fpu
+	ld	t1, ST_OFF(a0)			# last thread loses fpu
 	and	t1, t3
 	sd	t1, ST_OFF(a0)
 	sll	t2, t1, 5
diff -ur linux-2.5.63-orig/arch/sparc/mm/iommu.c linux-2.5.63/arch/sparc/mm/iommu.c
--- linux-2.5.63-orig/arch/sparc/mm/iommu.c	2003-01-09 04:04:26.000000000 +0000
+++ linux-2.5.63/arch/sparc/mm/iommu.c	2003-03-01 19:57:15.000000000 +0000
@@ -320,7 +320,7 @@
 
 	iopte += ((busa - iommu->start) >> PAGE_SHIFT);
 	pa = pte_val(*iopte);
-	pa = (pa & 0xFFFFFFF0) << 4;		/* Loose higher bits of 36 */
+	pa = (pa & 0xFFFFFFF0) << 4;		/* Lose higher bits of 36 */
 	return pa + PAGE_OFFSET;
 }
 #endif
diff -ur linux-2.5.63-orig/Documentation/fb/sstfb.txt linux-2.5.63/Documentation/fb/sstfb.txt
--- linux-2.5.63-orig/Documentation/fb/sstfb.txt	2003-01-09 04:03:57.000000000 +0000
+++ linux-2.5.63/Documentation/fb/sstfb.txt	2003-03-01 19:58:03.000000000 +0000
@@ -138,7 +138,7 @@
 	- The driver is not your_favorite_toy-safe. this includes SMP...
           [Actually from inspection it seems to be safe - Alan]
 	- when using XFree86 FBdev (X over fbdev) you may see strange color
-	patterns at the border of your windows (the pixels loose the lowest
+	patterns at the border of your windows (the pixels lose the lowest
 	byte -> basicaly the blue component nd some of the green) . I'm unable
 	to reproduce this with XFree86-3.3, but one of the testers has this
 	problem with XFree86-4. apparently recent Xfree86-4.x solve this
diff -ur linux-2.5.63-orig/Documentation/filesystems/vfs.txt linux-2.5.63/Documentation/filesystems/vfs.txt
--- linux-2.5.63-orig/Documentation/filesystems/vfs.txt	2003-01-09 04:04:18.000000000 +0000
+++ linux-2.5.63/Documentation/filesystems/vfs.txt	2003-03-01 19:59:44.000000000 +0000
@@ -439,7 +439,7 @@
 
   d_release: called when a dentry is really deallocated
 
-  d_iput: called when a dentry looses its inode (just prior to its
+  d_iput: called when a dentry loses its inode (just prior to its
 	being deallocated). The default when this is NULL is that the
 	VFS calls iput(). If you define this method, you must call
 	iput() yourself
diff -ur linux-2.5.63-orig/Documentation/input/joystick-api.txt linux-2.5.63/Documentation/input/joystick-api.txt
--- linux-2.5.63-orig/Documentation/input/joystick-api.txt	2003-01-09 04:04:14.000000000 +0000
+++ linux-2.5.63/Documentation/input/joystick-api.txt	2003-03-01 19:59:33.000000000 +0000
@@ -168,7 +168,7 @@
 and too many events to store in the queue get generated. Note that
 high system load may contribute to space those reads even more.
 
-If time between reads is enough to fill the queue and loose an event,
+If time between reads is enough to fill the queue and lose an event,
 the driver will switch to startup mode and next time you read it,
 synthetic events (JS_EVENT_INIT) will be generated to inform you of
 the actual state of the joystick.
diff -ur linux-2.5.63-orig/Documentation/scsi/ibmmca.txt linux-2.5.63/Documentation/scsi/ibmmca.txt
--- linux-2.5.63-orig/Documentation/scsi/ibmmca.txt	2003-03-01 16:19:38.000000000 +0000
+++ linux-2.5.63/Documentation/scsi/ibmmca.txt	2003-03-01 19:58:49.000000000 +0000
@@ -254,7 +254,7 @@
    device to be existant, but it has no ldn assigned, it gets a ldn out of 7 
    to 14. The numbers are assigned in cyclic order. Therefore it takes 8 
    dynamical reassignments on the SCSI-devices, until a certain device 
-   looses its ldn again. This assures, that dynamical remapping is avoided 
+   loses its ldn again. This assures, that dynamical remapping is avoided 
    during intense I/O between up to 15 SCSI-devices (means pun,lun 
    combinations). A further advantage of this method is, that people who
    build their kernel without probing on all luns will get what they expect,
diff -ur linux-2.5.63-orig/Documentation/sx.txt linux-2.5.63/Documentation/sx.txt
--- linux-2.5.63-orig/Documentation/sx.txt	2003-01-09 04:04:12.000000000 +0000
+++ linux-2.5.63/Documentation/sx.txt	2003-03-01 20:00:13.000000000 +0000
@@ -265,7 +265,7 @@
 	  -- Done (Ugly: not the way I want it. Copied from serial.c).
 
         - write buffer isn't flushed at close.
-	  -- Done. I still seem to loose a few chars at close. 
+	  -- Done. I still seem to lose a few chars at close. 
 	     Sorry. I think that this is a firmware issue. (-> Specialix)
 
 	- drain hardware before  changing termios
diff -ur linux-2.5.63-orig/Documentation/vm/locking linux-2.5.63/Documentation/vm/locking
--- linux-2.5.63-orig/Documentation/vm/locking	2003-03-01 16:19:05.000000000 +0000
+++ linux-2.5.63/Documentation/vm/locking	2003-03-01 19:58:21.000000000 +0000
@@ -80,7 +80,7 @@
 mm start up ... this is a loose form of stability on mm_users. For
 example, it is used in copy_mm to protect against a racing tlb_gather_mmu
 single address space optimization, so that the zap_page_range (from
-vmtruncate) does not loose sending ipi's to cloned threads that might 
+vmtruncate) does not lose sending ipi's to cloned threads that might 
 be spawned underneath it and go to user mode to drag in pte's into tlbs.
 
 swap_list_lock/swap_device_lock
diff -ur linux-2.5.63-orig/drivers/acorn/net/ether3.c linux-2.5.63/drivers/acorn/net/ether3.c
--- linux-2.5.63-orig/drivers/acorn/net/ether3.c	2003-01-09 04:04:26.000000000 +0000
+++ linux-2.5.63/drivers/acorn/net/ether3.c	2003-03-01 20:06:35.000000000 +0000
@@ -304,7 +304,7 @@
 	/*
 	 * There is a problem with the NQ8005 in that it occasionally loses the
 	 * last two bytes.  To get round this problem, we receive the CRC as
-	 * well.  That way, if we do loose the last two, then it doesn't matter.
+	 * well.  That way, if we do lose the last two, then it doesn't matter.
 	 */
 	ether3_outw(priv->regs.config1 | CFG1_TRANSEND, REG_CONFIG1);
 	ether3_outw((TX_END>>8) - 1, REG_BUFWIN);
diff -ur linux-2.5.63-orig/drivers/acpi/power.c linux-2.5.63/drivers/acpi/power.c
--- linux-2.5.63-orig/drivers/acpi/power.c	2003-03-01 16:20:16.000000000 +0000
+++ linux-2.5.63/drivers/acpi/power.c	2003-03-01 20:02:24.000000000 +0000
@@ -351,7 +351,7 @@
 
 	/*
 	 * First we reference all power resources required in the target list
-	 * (e.g. so the device doesn't loose power while transitioning).
+	 * (e.g. so the device doesn't lose power while transitioning).
 	 */
 	for (i=0; i<tl->count; i++) {
 		result = acpi_power_on(tl->handles[i]);
diff -ur linux-2.5.63-orig/drivers/block/elevator.c linux-2.5.63/drivers/block/elevator.c
--- linux-2.5.63-orig/drivers/block/elevator.c	2003-03-01 16:20:33.000000000 +0000
+++ linux-2.5.63/drivers/block/elevator.c	2003-03-01 20:07:04.000000000 +0000
@@ -20,7 +20,7 @@
  *
  * Jens:
  * - Rework again to work with bio instead of buffer_heads
- * - loose bi_dev comparisons, partition handling is right now
+ * - lose bi_dev comparisons, partition handling is right now
  * - completely modularize elevator setup and teardown
  *
  */
diff -ur linux-2.5.63-orig/drivers/cdrom/cdrom.c linux-2.5.63/drivers/cdrom/cdrom.c
--- linux-2.5.63-orig/drivers/cdrom/cdrom.c	2003-03-01 16:20:33.000000000 +0000
+++ linux-2.5.63/drivers/cdrom/cdrom.c	2003-03-01 20:07:55.000000000 +0000
@@ -172,7 +172,7 @@
   -- Defined CD_DVD and CD_CHANGER log levels.
   -- Fixed the CDROMREADxxx ioctls.
   -- CDROMPLAYTRKIND uses the GPCMD_PLAY_AUDIO_MSF command - too few
-  drives supported it. We loose the index part, however.
+  drives supported it. We lose the index part, however.
   -- Small modifications to accomodate opens of /dev/hdc1, required
   for ide-cd to handle multisession discs.
   -- Export cdrom_mode_sense and cdrom_mode_select.
diff -ur linux-2.5.63-orig/drivers/cdrom/sbpcd.c linux-2.5.63/drivers/cdrom/sbpcd.c
--- linux-2.5.63-orig/drivers/cdrom/sbpcd.c	2003-01-09 04:03:55.000000000 +0000
+++ linux-2.5.63/drivers/cdrom/sbpcd.c	2003-03-01 20:07:43.000000000 +0000
@@ -341,7 +341,7 @@
  * Trying to merge requests breaks this driver horribly (as in it goes
  * boom and apparently has done so since 2.3.41).  As it is a legacy
  * driver for a horribly slow double speed CD on a hideous interface
- * designed for polled operation, I won't loose any sleep in simply
+ * designed for polled operation, I won't lose any sleep in simply
  * disallowing merging.				Paul G.  02/2001
  *
  * Thu May 30 14:14:47 CEST 2002:
diff -ur linux-2.5.63-orig/drivers/char/serial167.c linux-2.5.63/drivers/char/serial167.c
--- linux-2.5.63-orig/drivers/char/serial167.c	2003-01-09 04:04:13.000000000 +0000
+++ linux-2.5.63/drivers/char/serial167.c	2003-03-01 20:02:51.000000000 +0000
@@ -460,7 +460,7 @@
 		    *tty->flip.char_buf_ptr++ = 0;
 		    /*
 		       If the flip buffer itself is
-		       overflowing, we still loose
+		       overflowing, we still lose
 		       the next incoming character.
 		     */
 		    if(tty->flip.count < TTY_FLIPBUF_SIZE){
diff -ur linux-2.5.63-orig/drivers/net/sk_mca.c linux-2.5.63/drivers/net/sk_mca.c
--- linux-2.5.63-orig/drivers/net/sk_mca.c	2003-03-01 16:19:28.000000000 +0000
+++ linux-2.5.63/drivers/net/sk_mca.c	2003-03-01 20:01:41.000000000 +0000
@@ -581,7 +581,7 @@
 	return GetLANCE(dev, LANCE_CSR0);
 }
 
-/* did we loose blocks due to a FIFO overrun ? */
+/* did we lose blocks due to a FIFO overrun ? */
 
 static u16 irqmiss_handler(struct SKMCA_NETDEV *dev, u16 oldcsr0)
 {
diff -ur linux-2.5.63-orig/drivers/net/wan/dscc4.c linux-2.5.63/drivers/net/wan/dscc4.c
--- linux-2.5.63-orig/drivers/net/wan/dscc4.c	2003-03-01 16:19:51.000000000 +0000
+++ linux-2.5.63/drivers/net/wan/dscc4.c	2003-03-01 20:01:27.000000000 +0000
@@ -47,7 +47,7 @@
  * Tx direction
  * When the tx ring is full, the xmit routine issues a call to netdev_stop.
  * The device is supposed to be enabled again during an ALLS irq (we could
- * use HI but as it's easy to loose events, it's fscked).
+ * use HI but as it's easy to lose events, it's fscked).
  *
  * Rx direction
  * The received frames aren't supposed to span over multiple receiving areas.
diff -ur linux-2.5.63-orig/drivers/net/wan/lmc/lmc_main.c linux-2.5.63/drivers/net/wan/lmc/lmc_main.c
--- linux-2.5.63-orig/drivers/net/wan/lmc/lmc_main.c	2003-03-01 16:19:51.000000000 +0000
+++ linux-2.5.63/drivers/net/wan/lmc/lmc_main.c	2003-03-01 20:01:00.000000000 +0000
@@ -2149,7 +2149,7 @@
         /* owned by 21140 */
         sc->lmc_rxring[i].status = 0x80000000;
 
-        /* used to be PKT_BUF_SZ now uses skb since we loose some to head room */
+        /* used to be PKT_BUF_SZ now uses skb since we lose some to head room */
         sc->lmc_rxring[i].length = skb->end - skb->data;
 
         /* use to be tail which is dumb since you're thinking why write
diff -ur linux-2.5.63-orig/drivers/net/wireless/orinoco.c linux-2.5.63/drivers/net/wireless/orinoco.c
--- linux-2.5.63-orig/drivers/net/wireless/orinoco.c	2003-03-01 16:20:57.000000000 +0000
+++ linux-2.5.63/drivers/net/wireless/orinoco.c	2003-03-01 20:01:56.000000000 +0000
@@ -117,7 +117,7 @@
  *	o Init of priv->tx_rate_ctrl in firmware specific section.
  *	o Prism2/Symbol rate, upto should be 0xF and not 0x15. Doh !
  *	o Spectrum card always need cor_reset (for every reset)
- *	o Fix cor_reset to not loose bit 7 in the register
+ *	o Fix cor_reset to not lose bit 7 in the register
  *	o flush_stale_links to remove zombie Pcmcia instances
  *	o Ack previous hermes event before reset
  *		Me (with my little hands)
diff -ur linux-2.5.63-orig/drivers/scsi/aic7xxx_old.c linux-2.5.63/drivers/scsi/aic7xxx_old.c
--- linux-2.5.63-orig/drivers/scsi/aic7xxx_old.c	2003-03-01 16:21:00.000000000 +0000
+++ linux-2.5.63/drivers/scsi/aic7xxx_old.c	2003-03-01 20:04:27.000000000 +0000
@@ -4609,8 +4609,8 @@
          * handler do the rest.  We don't want to unpause the sequencer yet
          * though so we'll return early.  We also have to make sure that
          * we clear the SEQINT *BEFORE* we set the REQINIT handler active
-         * or else it's possible on VLB cards to loose the first REQINIT
-         * interrupt.  Edge triggered EISA cards could also loose this
+         * or else it's possible on VLB cards to lose the first REQINIT
+         * interrupt.  Edge triggered EISA cards could also lose this
          * interrupt, although PCI and level triggered cards should not
          * have this problem since they continually interrupt the kernel
          * until we take care of the situation.
diff -ur linux-2.5.63-orig/drivers/scsi/atari_NCR5380.c linux-2.5.63/drivers/scsi/atari_NCR5380.c
--- linux-2.5.63-orig/drivers/scsi/atari_NCR5380.c	2003-01-09 04:04:16.000000000 +0000
+++ linux-2.5.63/drivers/scsi/atari_NCR5380.c	2003-03-01 20:05:24.000000000 +0000
@@ -2953,7 +2953,7 @@
      * on any queue, so they won't be retried ...
      *
      * Conclusion: either scsi.c disables timeout for all resetted commands
-     * immediately, or we loose!  As of linux-2.0.20 it doesn't.
+     * immediately, or we lose!  As of linux-2.0.20 it doesn't.
      */
 
     /* After the reset, there are no more connected or disconnected commands
diff -ur linux-2.5.63-orig/drivers/scsi/dpt_i2o.c linux-2.5.63/drivers/scsi/dpt_i2o.c
--- linux-2.5.63-orig/drivers/scsi/dpt_i2o.c	2003-03-01 16:20:24.000000000 +0000
+++ linux-2.5.63/drivers/scsi/dpt_i2o.c	2003-03-01 20:03:44.000000000 +0000
@@ -1252,7 +1252,7 @@
 		}
 	}
 	spin_unlock(&adpt_post_wait_lock);
-        // If this happens we loose commands that probably really completed
+        // If this happens we lose commands that probably really completed
 	printk(KERN_DEBUG"dpti: Could Not find task %d in wait queue\n",context);
 	printk(KERN_DEBUG"      Tasks in wait queue:\n");
 	for(p1 = adpt_post_wait_queue; p1; p1 = p1->next) {
diff -ur linux-2.5.63-orig/drivers/scsi/mac_NCR5380.c linux-2.5.63/drivers/scsi/mac_NCR5380.c
--- linux-2.5.63-orig/drivers/scsi/mac_NCR5380.c	2003-01-09 04:04:22.000000000 +0000
+++ linux-2.5.63/drivers/scsi/mac_NCR5380.c	2003-03-01 20:03:32.000000000 +0000
@@ -3082,7 +3082,7 @@
      * on any queue, so they won't be retried ...
      *
      * Conclusion: either scsi.c disables timeout for all resetted commands
-     * immediately, or we loose!  As of linux-2.0.20 it doesn't.
+     * immediately, or we lose!  As of linux-2.0.20 it doesn't.
      */
 
     /* After the reset, there are no more connected or disconnected commands
diff -ur linux-2.5.63-orig/drivers/scsi/ncr53c8xx.c linux-2.5.63/drivers/scsi/ncr53c8xx.c
--- linux-2.5.63-orig/drivers/scsi/ncr53c8xx.c	2003-03-01 16:19:57.000000000 +0000
+++ linux-2.5.63/drivers/scsi/ncr53c8xx.c	2003-03-01 20:05:03.000000000 +0000
@@ -1536,7 +1536,7 @@
 	/*
 	**	Now there are 4 possibilities:
 	**
-	**	(1) The ncr looses arbitration.
+	**	(1) The ncr loses arbitration.
 	**	This is ok, because it will try again,
 	**	when the bus becomes idle.
 	**	(But beware of the timeout function!)
diff -ur linux-2.5.63-orig/drivers/scsi/seagate.c linux-2.5.63/drivers/scsi/seagate.c
--- linux-2.5.63-orig/drivers/scsi/seagate.c	2003-03-01 16:20:25.000000000 +0000
+++ linux-2.5.63/drivers/scsi/seagate.c	2003-03-01 20:04:50.000000000 +0000
@@ -493,7 +493,7 @@
 
 	/*
 	 *	At all times, we will use IRQ 5.  Should also check for IRQ3
-	 *	if we loose our first interrupt.
+	 *	if we lose our first interrupt.
 	 */
 	instance = scsi_register (tpnt, 0);
 	if (instance == NULL)
diff -ur linux-2.5.63-orig/drivers/scsi/sr.c linux-2.5.63/drivers/scsi/sr.c
--- linux-2.5.63-orig/drivers/scsi/sr.c	2003-01-09 04:03:58.000000000 +0000
+++ linux-2.5.63/drivers/scsi/sr.c	2003-03-01 20:03:04.000000000 +0000
@@ -26,7 +26,7 @@
  *	Modified by Richard Gooch <rgooch@atnf.csiro.au> to support devfs
  *
  *	Modified by Jens Axboe <axboe@suse.de> - support DVD-RAM
- *	transparently and loose the GHOST hack
+ *	transparently and lose the GHOST hack
  *
  *	Modified by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
  *	check resource allocation in sr_init and some cleanups
diff -ur linux-2.5.63-orig/drivers/scsi/sun3_NCR5380.c linux-2.5.63/drivers/scsi/sun3_NCR5380.c
--- linux-2.5.63-orig/drivers/scsi/sun3_NCR5380.c	2003-01-09 04:03:53.000000000 +0000
+++ linux-2.5.63/drivers/scsi/sun3_NCR5380.c	2003-03-01 20:04:41.000000000 +0000
@@ -2970,7 +2970,7 @@
      * on any queue, so they won't be retried ...
      *
      * Conclusion: either scsi.c disables timeout for all resetted commands
-     * immediately, or we loose!  As of linux-2.0.20 it doesn't.
+     * immediately, or we lose!  As of linux-2.0.20 it doesn't.
      */
 
     /* After the reset, there are no more connected or disconnected commands
diff -ur linux-2.5.63-orig/drivers/scsi/sym53c8xx_2/sym_fw1.h linux-2.5.63/drivers/scsi/sym53c8xx_2/sym_fw1.h
--- linux-2.5.63-orig/drivers/scsi/sym53c8xx_2/sym_fw1.h	2003-01-09 04:04:22.000000000 +0000
+++ linux-2.5.63/drivers/scsi/sym53c8xx_2/sym_fw1.h	2003-03-01 20:05:57.000000000 +0000
@@ -340,7 +340,7 @@
 	/*
 	 *  Now there are 4 possibilities:
 	 *
-	 *  (1) The chip looses arbitration.
+	 *  (1) The chip loses arbitration.
 	 *  This is ok, because it will try again,
 	 *  when the bus becomes idle.
 	 *  (But beware of the timeout function!)
diff -ur linux-2.5.63-orig/drivers/scsi/sym53c8xx_2/sym_fw2.h linux-2.5.63/drivers/scsi/sym53c8xx_2/sym_fw2.h
--- linux-2.5.63-orig/drivers/scsi/sym53c8xx_2/sym_fw2.h	2003-01-09 04:04:24.000000000 +0000
+++ linux-2.5.63/drivers/scsi/sym53c8xx_2/sym_fw2.h	2003-03-01 20:06:05.000000000 +0000
@@ -320,7 +320,7 @@
 	/*
 	 *  Now there are 4 possibilities:
 	 *
-	 *  (1) The chip looses arbitration.
+	 *  (1) The chip loses arbitration.
 	 *  This is ok, because it will try again,
 	 *  when the bus becomes idle.
 	 *  (But beware of the timeout function!)
diff -ur linux-2.5.63-orig/drivers/scsi/sym53c8xx.c linux-2.5.63/drivers/scsi/sym53c8xx.c
--- linux-2.5.63-orig/drivers/scsi/sym53c8xx.c	2003-03-01 16:21:01.000000000 +0000
+++ linux-2.5.63/drivers/scsi/sym53c8xx.c	2003-03-01 20:05:39.000000000 +0000
@@ -2677,7 +2677,7 @@
 	/*
 	**	Now there are 4 possibilities:
 	**
-	**	(1) The ncr looses arbitration.
+	**	(1) The ncr loses arbitration.
 	**	This is ok, because it will try again,
 	**	when the bus becomes idle.
 	**	(But beware of the timeout function!)
diff -ur linux-2.5.63-orig/drivers/serial/68328serial.h linux-2.5.63/drivers/serial/68328serial.h
--- linux-2.5.63-orig/drivers/serial/68328serial.h	2003-01-09 04:04:25.000000000 +0000
+++ linux-2.5.63/drivers/serial/68328serial.h	2003-03-01 20:09:19.000000000 +0000
@@ -93,7 +93,7 @@
  * board I would assume that RXRE is the safest setting.
  *
  * For EZ328 I use RXHE (Half empty) interrupt to reduce the number of
- * interrupts. RXFE (receive queue full) causes the system to loose data
+ * interrupts. RXFE (receive queue full) causes the system to lose data
  * at least at 115200 baud
  *
  * If your board is busy doing other stuff, you might consider to use
diff -ur linux-2.5.63-orig/drivers/video/amifb.c linux-2.5.63/drivers/video/amifb.c
--- linux-2.5.63-orig/drivers/video/amifb.c	2003-01-09 04:04:24.000000000 +0000
+++ linux-2.5.63/drivers/video/amifb.c	2003-03-01 20:08:59.000000000 +0000
@@ -274,9 +274,9 @@
    display of sprites, I use the following policy on horizontal panning and
    the hardware cursor:
 
-      - if you want to start display DMA too early, you loose the ability to
+      - if you want to start display DMA too early, you lose the ability to
         do smooth horizontal panning (xpanstep 1 -> 64).
-      - if you want to go even further, you loose the hardware cursor too.
+      - if you want to go even further, you lose the hardware cursor too.
 
    IMHO a hardware cursor is more important for X than horizontal scrolling,
    so that's my motivation.
diff -ur linux-2.5.63-orig/drivers/video/cyber2000fb.c linux-2.5.63/drivers/video/cyber2000fb.c
--- linux-2.5.63-orig/drivers/video/cyber2000fb.c	2003-01-09 04:03:57.000000000 +0000
+++ linux-2.5.63/drivers/video/cyber2000fb.c	2003-03-01 20:08:47.000000000 +0000
@@ -1697,7 +1697,7 @@
 	unsigned char val;
 
 #if defined(__sparc_v9__)
-#error "You loose, consult DaveM."
+#error "You lose, consult DaveM."
 #elif defined(__sparc__)
 	/*
 	 * SPARC does not have an "outb" instruction, so we generate
diff -ur linux-2.5.63-orig/fs/bio.c linux-2.5.63/fs/bio.c
--- linux-2.5.63-orig/fs/bio.c	2003-03-01 16:21:04.000000000 +0000
+++ linux-2.5.63/fs/bio.c	2003-03-01 20:09:45.000000000 +0000
@@ -383,7 +383,7 @@
 		return 0;
 
 	/*
-	 * we might loose a segment or two here, but rather that than
+	 * we might lose a segment or two here, but rather that than
 	 * make this too complex.
 	 */
 retry_segments:
diff -ur linux-2.5.63-orig/include/asm-mips/processor.h linux-2.5.63/include/asm-mips/processor.h
--- linux-2.5.63-orig/include/asm-mips/processor.h	2003-01-09 04:03:50.000000000 +0000
+++ linux-2.5.63/include/asm-mips/processor.h	2003-03-01 20:11:23.000000000 +0000
@@ -228,7 +228,7 @@
  * Do necessary setup to start up a newly executed thread.
  */
 #define start_thread(regs, new_pc, new_sp) do {				\
-	/* New thread looses kernel privileges. */			\
+	/* New thread loses kernel privileges. */			\
 	regs->cp0_status = (regs->cp0_status & ~(ST0_CU0|ST0_KSU)) | KU_USER;\
 	regs->cp0_epc = new_pc;						\
 	regs->regs[29] = new_sp;					\
diff -ur linux-2.5.63-orig/include/asm-mips64/processor.h linux-2.5.63/include/asm-mips64/processor.h
--- linux-2.5.63-orig/include/asm-mips64/processor.h	2003-01-09 04:04:14.000000000 +0000
+++ linux-2.5.63/include/asm-mips64/processor.h	2003-03-01 20:10:46.000000000 +0000
@@ -256,7 +256,7 @@
 do {									\
 	unsigned long __status;						\
 									\
-	/* New thread looses kernel privileges. */			\
+	/* New thread loses kernel privileges. */			\
 	__status = regs->cp0_status & ~(ST0_CU0|ST0_FR|ST0_KSU);	\
 	__status |= KSU_USER;						\
 	__status |= (current->thread.mflags & MF_32BIT) ? 0 : ST0_FR;	\
diff -ur linux-2.5.63-orig/include/asm-parisc/assembly.h linux-2.5.63/include/asm-parisc/assembly.h
--- linux-2.5.63-orig/include/asm-parisc/assembly.h	2003-03-01 16:19:19.000000000 +0000
+++ linux-2.5.63/include/asm-parisc/assembly.h	2003-03-01 20:11:01.000000000 +0000
@@ -381,7 +381,7 @@
 	/* cr11 (sar) is a funny one.  5 bits on PA1.1 and 6 bit on PA2.0
 	 * For PA2.0 mtsar or mtctl always write 6 bits, but mfctl only
 	 * reads 5 bits.  Use mfctl,w to read all six bits.  Otherwise
-	 * we loose the 6th bit on a save/restore over interrupt.
+	 * we lose the 6th bit on a save/restore over interrupt.
 	 */
 	mfctl,w  %cr11, %r1
 	STREG    %r1, PT_SAR (\regs)
diff -ur linux-2.5.63-orig/include/linux/securebits.h linux-2.5.63/include/linux/securebits.h
--- linux-2.5.63-orig/include/linux/securebits.h	2003-01-09 04:03:56.000000000 +0000
+++ linux-2.5.63/include/linux/securebits.h	2003-03-01 20:10:11.000000000 +0000
@@ -14,7 +14,7 @@
 #define SECURE_NOROOT            0
 
 /* When set, setuid to/from uid 0 does not trigger capability-"fixes"
-   to be compatible with old programs relying on set*uid to loose
+   to be compatible with old programs relying on set*uid to lose
    privileges. When unset, setuid doesn't change privileges. */
 #define SECURE_NO_SETUID_FIXUP   2
 
diff -ur linux-2.5.63-orig/net/ipv4/netfilter/ip_conntrack_core.c linux-2.5.63/net/ipv4/netfilter/ip_conntrack_core.c
--- linux-2.5.63-orig/net/ipv4/netfilter/ip_conntrack_core.c	2003-03-01 16:21:12.000000000 +0000
+++ linux-2.5.63/net/ipv4/netfilter/ip_conntrack_core.c	2003-03-01 20:12:40.000000000 +0000
@@ -702,7 +702,7 @@
 	if (!expected)
 		conntrack->helper = ip_ct_find_helper(&repl_tuple);
 
-	/* If the expectation is dying, then this is a looser. */
+	/* If the expectation is dying, then this is a loser. */
 	if (expected
 	    && expected->expectant->helper->timeout
 	    && ! del_timer(&expected->timeout))
diff -ur linux-2.5.63-orig/net/irda/irlmp_event.c linux-2.5.63/net/irda/irlmp_event.c
--- linux-2.5.63-orig/net/irda/irlmp_event.c	2003-01-09 04:03:58.000000000 +0000
+++ linux-2.5.63/net/irda/irlmp_event.c	2003-03-01 20:13:06.000000000 +0000
@@ -423,7 +423,7 @@
 			/* We don't want to change state just yet, because
 			 * we want to reflect accurately the real state of
 			 * the LAP, not the state we wish it was in,
-			 * so that we don't loose LM_LAP_CONNECT_REQUEST.
+			 * so that we don't lose LM_LAP_CONNECT_REQUEST.
 			 * In some cases, IrLAP won't close the LAP
 			 * immediately. For example, it might still be
 			 * retrying packets or waiting for the pf bit.
diff -ur linux-2.5.63-orig/net/irda/irttp.c linux-2.5.63/net/irda/irttp.c
--- linux-2.5.63-orig/net/irda/irttp.c	2003-01-09 04:04:16.000000000 +0000
+++ linux-2.5.63/net/irda/irttp.c	2003-03-01 20:13:17.000000000 +0000
@@ -710,7 +710,7 @@
 		 * The current skb has a reference to the socket that sent
 		 * it (skb->sk). When we pass it to IrLMP, the skb will be
 		 * stored in in IrLAP (self->wx_list). When we are within
-		 * IrLAP, we loose the notion of socket, so we should not
+		 * IrLAP, we lose the notion of socket, so we should not
 		 * have a reference to a socket. So, we drop it here.
 		 *
 		 * Why does it matter ?


-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
           --- I must be musical:  I've got *loads* of CDs ---           

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+YRfXssJ7whwzWGARArO0AJ0Z/xsK1I/9VwVDkaGSm/huQdi8rQCeNSPY
VqdMiOI93KdbTd8UD/knuYs=
=WGs0
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
