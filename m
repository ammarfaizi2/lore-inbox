Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268423AbTBYWk1>; Tue, 25 Feb 2003 17:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268387AbTBYWiW>; Tue, 25 Feb 2003 17:38:22 -0500
Received: from [24.77.48.240] ([24.77.48.240]:37168 "EHLO aiinc.aiinc.ca")
	by vger.kernel.org with ESMTP id <S268354AbTBYWhy>;
	Tue, 25 Feb 2003 17:37:54 -0500
Date: Tue, 25 Feb 2003 14:48:11 -0800
From: Michael Hayes <mike@aiinc.ca>
Message-Id: <200302252248.h1PMmBa29259@aiinc.aiinc.ca>
To: linux-kernel@vger.kernel.org
Subject: [REVISED][PATCH] Spelling fixes for 2.5.63 - won't
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removed changes to comments in .S files -- gcc does not like apostrophes
in assembler comments.

This fixes:
    wont -> won't (21 occurrences)

diff -ur a/arch/ia64/sn/kernel/setup.c b/arch/ia64/sn/kernel/setup.c
--- a/arch/ia64/sn/kernel/setup.c	Mon Feb 24 11:05:14 2003
+++ b/arch/ia64/sn/kernel/setup.c	Tue Feb 25 10:08:11 2003
@@ -172,7 +172,7 @@
 
 	/*
 	 * Parse enough of the SAL tables to locate the SAL entry point. Since, console
-	 * IO on SN2 is done via SAL calls, early_printk wont work without this.
+	 * IO on SN2 is done via SAL calls, early_printk won't work without this.
 	 *
 	 * This code duplicates some of the ACPI table parsing that is in efi.c & sal.c.
 	 * Any changes to those file may have to be made hereas well.
diff -ur a/arch/parisc/kernel/ptrace.c b/arch/parisc/kernel/ptrace.c
--- a/arch/parisc/kernel/ptrace.c	Mon Feb 24 11:05:09 2003
+++ b/arch/parisc/kernel/ptrace.c	Tue Feb 25 10:08:13 2003
@@ -242,7 +242,7 @@
 			 *
 			 * Allow writing to Nullify, Divide-step-correction,
 			 * and carry/borrow bits.
-			 * BEWARE, if you set N, and then single step, it wont
+			 * BEWARE, if you set N, and then single step, it won't
 			 * stop on the nullified instruction.
 			 */
 			DBG(("sys_ptrace(POKEUSR, %d, %lx, %lx)\n",
diff -ur a/drivers/char/n_hdlc.c b/drivers/char/n_hdlc.c
--- a/drivers/char/n_hdlc.c	Mon Feb 24 11:05:14 2003
+++ b/drivers/char/n_hdlc.c	Tue Feb 25 10:08:20 2003
@@ -833,7 +833,7 @@
 		poll_wait(filp, &tty->read_wait, wait);
 		poll_wait(filp, &tty->write_wait, wait);
 
-		/* set bits for operations that wont block */
+		/* set bits for operations that won't block */
 		if(n_hdlc->rx_buf_list.head)
 			mask |= POLLIN | POLLRDNORM;	/* readable */
 		if (test_bit(TTY_OTHER_CLOSED, &tty->flags))
diff -ur a/drivers/char/rio/rio_linux.c b/drivers/char/rio/rio_linux.c
--- a/drivers/char/rio/rio_linux.c	Mon Feb 24 11:05:34 2003
+++ b/drivers/char/rio/rio_linux.c	Tue Feb 25 10:08:22 2003
@@ -464,7 +464,7 @@
        recursive calls will hang the machine in the interrupt routine. 
 
      - hardware twiddling goes before "recursive". Otherwise when we
-       poll the card, and a recursive interrupt happens, we wont
+       poll the card, and a recursive interrupt happens, we won't
        ack the card, so it might keep on interrupting us. (especially
        level sensitive interrupt systems like PCI).
 
diff -ur a/drivers/char/sx.c b/drivers/char/sx.c
--- a/drivers/char/sx.c	Mon Feb 24 11:05:16 2003
+++ b/drivers/char/sx.c	Tue Feb 25 10:08:24 2003
@@ -1216,7 +1216,7 @@
 	     recursive calls will hang the machine in the interrupt routine. 
 
 	   - hardware twiddling goes before "recursive". Otherwise when we
-	     poll the card, and a recursive interrupt happens, we wont
+	     poll the card, and a recursive interrupt happens, we won't
 	     ack the card, so it might keep on interrupting us. (especially
 	     level sensitive interrupt systems like PCI).
 
diff -ur a/drivers/char/vt.c b/drivers/char/vt.c
--- a/drivers/char/vt.c	Mon Feb 24 11:05:41 2003
+++ b/drivers/char/vt.c	Tue Feb 25 10:08:28 2003
@@ -2872,7 +2872,7 @@
  *  this is done in order to maintain compatibility with the EGA/VGA fonts. It 
  *  is upto the actual low-level console-driver convert data into its favorite
  *  format (maybe we should add a `fontoffset' field to the `display'
- *  structure so we wont have to convert the fontdata all the time.
+ *  structure so we won't have to convert the fontdata all the time.
  *  /Jes
  */
 
diff -ur a/drivers/ieee1394/eth1394.c b/drivers/ieee1394/eth1394.c
--- a/drivers/ieee1394/eth1394.c	Mon Feb 24 11:05:35 2003
+++ b/drivers/ieee1394/eth1394.c	Tue Feb 25 10:08:31 2003
@@ -663,7 +663,7 @@
 	 * call to schedule our writes.  */
 
 	/* XXX: Right now we accept that we don't exactly follow RFC. When
-	 * we do, we will send ARP requests via GASP format, and so we wont
+	 * we do, we will send ARP requests via GASP format, and so we won't
 	 * need this hack.  */
 
 	spin_lock_irqsave (&priv->lock, flags);
diff -ur a/drivers/ieee1394/ohci1394.c b/drivers/ieee1394/ohci1394.c
--- a/drivers/ieee1394/ohci1394.c	Mon Feb 24 11:05:41 2003
+++ b/drivers/ieee1394/ohci1394.c	Tue Feb 25 10:08:33 2003
@@ -2266,7 +2266,7 @@
 	if (event & OHCI1394_cycleInconsistent) {
 		/* We subscribe to the cycleInconsistent event only to
 		 * clear the corresponding event bit... otherwise,
-		 * isochronous cycleMatch DMA wont work. */
+		 * isochronous cycleMatch DMA won't work. */
 		DBGMSG(ohci->id, "OHCI1394_cycleInconsistent");
 		event &= ~OHCI1394_cycleInconsistent;
 	}
diff -ur a/drivers/md/md.c b/drivers/md/md.c
--- a/drivers/md/md.c	Mon Feb 24 11:05:14 2003
+++ b/drivers/md/md.c	Tue Feb 25 10:08:35 2003
@@ -1731,7 +1731,7 @@
 			mddev_unlock(mddev);
 		}
 		/* on success, candidates will be empty, on error
-		 * it wont...
+		 * it won't...
 		 */
 		ITERATE_RDEV_GENERIC(candidates,rdev,tmp)
 			export_rdev(rdev);
diff -ur a/drivers/media/video/zr36120_i2c.c b/drivers/media/video/zr36120_i2c.c
--- a/drivers/media/video/zr36120_i2c.c	Mon Feb 24 11:06:03 2003
+++ b/drivers/media/video/zr36120_i2c.c	Tue Feb 25 10:08:39 2003
@@ -86,7 +86,7 @@
 		if (ztv->tuner_type >= 0)
 		{
 			if (i2c_control_device(&ztv->i2c,I2C_DRIVERID_TUNER,TUNER_SET_TYPE,&ztv->tuner_type)<0)
-			DEBUG(printk(CARD_INFO "attach_inform; tuner wont be set to type %d\n",CARD,ztv->tuner_type));
+			DEBUG(printk(CARD_INFO "attach_inform; tuner won't be set to type %d\n",CARD,ztv->tuner_type));
 		}
 		break;
 	 default:
diff -ur a/drivers/net/cs89x0.c b/drivers/net/cs89x0.c
--- a/drivers/net/cs89x0.c	Mon Feb 24 11:05:40 2003
+++ b/drivers/net/cs89x0.c	Tue Feb 25 10:08:40 2003
@@ -1112,7 +1112,7 @@
 	int i;
 	int ret;
 
-#ifndef CONFIG_SH_HICOSH4 /* uses irq#1, so this wont work */
+#ifndef CONFIG_SH_HICOSH4 /* uses irq#1, so this won't work */
 	if (dev->irq < 2) {
 		/* Allow interrupts to be generated by the chip */
 /* Cirrus' release had this: */
diff -ur a/drivers/net/eth16i.c b/drivers/net/eth16i.c
--- a/drivers/net/eth16i.c	Mon Feb 24 11:05:41 2003
+++ b/drivers/net/eth16i.c	Tue Feb 25 10:08:43 2003
@@ -1231,7 +1231,7 @@
 	/* Turn off all interrupts from adapter */
 	outw(ETH16I_INTR_OFF, ioaddr + TX_INTR_REG);
 
-	/* eth16i_tx wont be called */
+	/* eth16i_tx won't be called */
 	spin_lock(&lp->lock);
 
 	status = inw(ioaddr + TX_STATUS_REG);      /* Get the status */
diff -ur a/drivers/net/hp100.c b/drivers/net/hp100.c
--- a/drivers/net/hp100.c	Mon Feb 24 11:05:16 2003
+++ b/drivers/net/hp100.c	Tue Feb 25 10:08:45 2003
@@ -2811,7 +2811,7 @@
 			printk("hp100: %s: Problem logging into the HUB.\n", dev->name);
 			if (lp->chip == HP100_CHIPID_LASSEN) {
 				/* Check allowed Register to find out why there is a problem. */
-				val = hp100_inw(TRAIN_ALLOW);	/* wont work on non-ETR card */
+				val = hp100_inw(TRAIN_ALLOW);	/* won't work on non-ETR card */
 #ifdef HP100_DEBUG_TRAINING
 				printk("hp100: %s: MAC Configuration requested: 0x%04x, HUB allowed: 0x%04x\n", dev->name, hp100_inw(TRAIN_REQUEST), val);
 #endif
diff -ur a/drivers/net/wireless/arlan.c b/drivers/net/wireless/arlan.c
--- a/drivers/net/wireless/arlan.c	Mon Feb 24 11:05:35 2003
+++ b/drivers/net/wireless/arlan.c	Tue Feb 25 10:08:46 2003
@@ -567,7 +567,7 @@
 				break;
 			times++;
 		}
-		/* if long command, we wont repeat trying */ ;
+		/* if long command, we won't repeat trying */ ;
 		if (priv->card_polling_interval > 1)
 			break;
 		times++;
diff -ur a/fs/buffer.c b/fs/buffer.c
--- a/fs/buffer.c	Mon Feb 24 11:05:34 2003
+++ b/fs/buffer.c	Tue Feb 25 10:08:48 2003
@@ -2584,7 +2584,7 @@
  * BH_Lock state bit), any buffer that appears to be clean when doing a
  * write request, and any buffer that appears to be up-to-date when doing
  * read request.  Further it marks as clean buffers that are processed for
- * writing (the buffer cache wont assume that they are actually clean until
+ * writing (the buffer cache won't assume that they are actually clean until
  * the buffer gets unlocked).
  *
  * ll_rw_block sets b_end_io to simple completion handler that marks
diff -ur a/fs/nfsd/export.c b/fs/nfsd/export.c
--- a/fs/nfsd/export.c	Mon Feb 24 11:05:34 2003
+++ b/fs/nfsd/export.c	Tue Feb 25 10:08:50 2003
@@ -626,7 +626,7 @@
 
 	exp = exp_get_by_name(clp, nd.mnt, nd.dentry, NULL);
 
-	/* must make sure there wont be an ex_fsid clash */
+	/* must make sure there won't be an ex_fsid clash */
 	if ((nxp->ex_flags & NFSEXP_FSID) &&
 	    (fsid_key = exp_get_fsid_key(clp, nxp->ex_dev)) &&
 	    !IS_ERR(fsid_key) &&
diff -ur a/include/asm-ia64/mmzone.h b/include/asm-ia64/mmzone.h
--- a/include/asm-ia64/mmzone.h	Mon Feb 24 11:06:03 2003
+++ b/include/asm-ia64/mmzone.h	Tue Feb 25 10:08:52 2003
@@ -44,7 +44,7 @@
  * Note that IO addresses are NOT considered valid addresses.
  *
  * Note, many platforms can simply check if kaddr exceeds a specific size.  
- *	(However, this wont work on SGI platforms since IO space is embedded 
+ *	(However, this won't work on SGI platforms since IO space is embedded 
  * 	within the range of valid memory addresses & nodes have holes in the 
  *	address range between banks). 
  */
diff -ur a/include/asm-m68k/io.h b/include/asm-m68k/io.h
--- a/include/asm-m68k/io.h	Mon Feb 24 11:05:35 2003
+++ b/include/asm-m68k/io.h	Tue Feb 25 10:08:54 2003
@@ -250,7 +250,7 @@
 #define readl(addr)      in_le32(addr)
 #define writel(val,addr) out_le32((addr),(val))
 
-/* those can be defined for both ISA and PCI - it wont work though */
+/* those can be defined for both ISA and PCI - it won't work though */
 #define readb(addr)       in_8(addr)
 #define readw(addr)       in_le16(addr)
 #define writeb(val,addr)  out_8((addr),(val))
diff -ur a/include/linux/jiffies.h b/include/linux/jiffies.h
--- a/include/linux/jiffies.h	Mon Feb 24 11:05:05 2003
+++ b/include/linux/jiffies.h	Tue Feb 25 10:08:56 2003
@@ -28,7 +28,7 @@
  *	These inlines deal with timer wrapping correctly. You are 
  *	strongly encouraged to use them
  *	1. Because people otherwise forget
- *	2. Because if the timer wrap changes in future you wont have to
+ *	2. Because if the timer wrap changes in future you won't have to
  *	   alter your driver code.
  *
  * time_after(a,b) returns true if the time a is after time b.
diff -ur a/sound/oss/ad1816.c b/sound/oss/ad1816.c
--- a/sound/oss/ad1816.c	Mon Feb 24 11:05:43 2003
+++ b/sound/oss/ad1816.c	Tue Feb 25 10:08:59 2003
@@ -1227,7 +1227,7 @@
 			sound_free_dma(devc->dma_capture);
 		}
 
-		/* card wont get added if resources could not be allocated
+		/* card won't get added if resources could not be allocated
 		   thus we need not ckeck if allocation was successful */
 		sound_free_dma (devc->dma_playback);
 		free_irq(devc->irq, devc->osp);
diff -ur a/sound/oss/opl3sa2.c b/sound/oss/opl3sa2.c
--- a/sound/oss/opl3sa2.c	Mon Feb 24 11:05:04 2003
+++ b/sound/oss/opl3sa2.c	Tue Feb 25 10:09:05 2003
@@ -918,7 +918,7 @@
 		break;
 	}
 
-	/* its supposed to automute before suspending, so we wont bother */
+	/* its supposed to automute before suspending, so we won't bother */
 	opl3sa2_read(p->cfg_port, OPL3SA2_PM, &p->reg);
 	opl3sa2_write(p->cfg_port, OPL3SA2_PM, p->reg | pm_mode);
 
