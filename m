Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268620AbTBZCwT>; Tue, 25 Feb 2003 21:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268626AbTBZCvW>; Tue, 25 Feb 2003 21:51:22 -0500
Received: from [24.77.48.240] ([24.77.48.240]:25145 "EHLO aiinc.aiinc.ca")
	by vger.kernel.org with ESMTP id <S268622AbTBZCut>;
	Tue, 25 Feb 2003 21:50:49 -0500
Date: Tue, 25 Feb 2003 19:01:09 -0800
From: Michael Hayes <mike@aiinc.ca>
Message-Id: <200302260301.h1Q319D07253@aiinc.aiinc.ca>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Spelling fixes for 2.5.63 - immediately
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes:
    immediatly -> immediately

Fixes 23 occurrences in all.

diff -ur a/arch/alpha/boot/tools/objstrip.c b/arch/alpha/boot/tools/objstrip.c
--- a/arch/alpha/boot/tools/objstrip.c	Mon Feb 24 11:06:03 2003
+++ b/arch/alpha/boot/tools/objstrip.c	Tue Feb 25 18:27:09 2003
@@ -7,7 +7,7 @@
  */
 /*
  * Converts an ECOFF or ELF object file into a bootable file.  The
- * object file must be a OMAGIC file (i.e., data and bss follow immediatly
+ * object file must be a OMAGIC file (i.e., data and bss follow immediately
  * behind the text).  See DEC "Assembly Language Programmer's Guide"
  * documentation for details.  The SRM boot process is documented in
  * the Alpha AXP Architecture Reference Manual, Second Edition by
diff -ur a/arch/cris/drivers/serial.c b/arch/cris/drivers/serial.c
--- a/arch/cris/drivers/serial.c	Mon Feb 24 11:05:36 2003
+++ b/arch/cris/drivers/serial.c	Tue Feb 25 18:27:11 2003
@@ -1766,7 +1766,7 @@
 
 B= Break character (0x00) with framing error.
 E= Error byte with parity error received after B characters.
-F= "Faked" valid byte received immediatly after B characters.
+F= "Faked" valid byte received immediately after B characters.
 V= Valid byte
 
 1.
diff -ur a/arch/m68k/math-emu/fp_util.S b/arch/m68k/math-emu/fp_util.S
--- a/arch/m68k/math-emu/fp_util.S	Mon Feb 24 11:06:01 2003
+++ b/arch/m68k/math-emu/fp_util.S	Tue Feb 25 18:27:13 2003
@@ -49,7 +49,7 @@
  * is currently at that time unused, be careful if you want change
  * something here. %d0 and %d1 is always usable, sometimes %d2 (or
  * only the lower half) most function have to return the %a0
- * unmodified, so that the caller can immediatly reuse it.
+ * unmodified, so that the caller can immediately reuse it.
  */
 
 	.globl	fp_ill, fp_end
diff -ur a/arch/ppc64/kernel/head.S b/arch/ppc64/kernel/head.S
--- a/arch/ppc64/kernel/head.S	Mon Feb 24 11:05:32 2003
+++ b/arch/ppc64/kernel/head.S	Tue Feb 25 18:27:16 2003
@@ -109,7 +109,7 @@
 	.llong  0x0
 
 	/* Secondary processors write this value with their cpu # */
-	/* after they enter the spin loop immediatly below.       */
+	/* after they enter the spin loop immediately below.       */
 	.globl  __secondary_hold_acknowledge
 __secondary_hold_acknowledge:
 	.llong  0x0
diff -ur a/drivers/acorn/block/fd1772.c b/drivers/acorn/block/fd1772.c
--- a/drivers/acorn/block/fd1772.c	Mon Feb 24 11:05:15 2003
+++ b/drivers/acorn/block/fd1772.c	Tue Feb 25 18:27:18 2003
@@ -1081,7 +1081,7 @@
 		MotorOn = 1;
 		START_TIMEOUT();
 		/* we must wait for the IRQ here, because the ST-DMA is
-		 * released immediatly afterwards and the interrupt may be
+		 * released immediately afterwards and the interrupt may be
 		 * delivered to the wrong driver.
 		 */
 	}
diff -ur a/drivers/acorn/block/mfmhd.c b/drivers/acorn/block/mfmhd.c
--- a/drivers/acorn/block/mfmhd.c	Mon Feb 24 11:05:12 2003
+++ b/drivers/acorn/block/mfmhd.c	Tue Feb 25 18:27:22 2003
@@ -406,7 +406,7 @@
 
 	outw(command, MFM_COMMAND);
 	status = inw(MFM_STATUS);
-	DBG("issue_command: status immediatly after command issue: %02X:\n ", status >> 8);
+	DBG("issue_command: status immediately after command issue: %02X:\n ", status >> 8);
 }
 
 static void wait_for_completion(void)
diff -ur a/drivers/char/scc.h b/drivers/char/scc.h
--- a/drivers/char/scc.h	Mon Feb 24 11:05:40 2003
+++ b/drivers/char/scc.h	Tue Feb 25 18:27:24 2003
@@ -428,7 +428,7 @@
  * for that purpose. They assume that a local variable 'port' is
  * declared and pointing to the port's scc_struct entry. The
  * variants with "_NB" appended should be used if no other SCC
- * accesses follow immediatly (within 0.5 usecs). They just skip the
+ * accesses follow immediately (within 0.5 usecs). They just skip the
  * final delay nops.
  * 
  * Please note that accesses to SCC registers should only take place
diff -ur a/drivers/isdn/tpam/tpam_commands.c b/drivers/isdn/tpam/tpam_commands.c
--- a/drivers/isdn/tpam/tpam_commands.c	Mon Feb 24 11:05:09 2003
+++ b/drivers/isdn/tpam/tpam_commands.c	Tue Feb 25 18:27:26 2003
@@ -880,7 +880,7 @@
 		memcpy(skb_put(result, len), data, len);
 	}
 
-	/* In loop mode, resend the data immediatly */
+	/* In loop mode, resend the data immediately */
 	if (card->loopmode) {
 		struct sk_buff *loopskb;
 
diff -ur a/drivers/media/video/zr36067.c b/drivers/media/video/zr36067.c
--- a/drivers/media/video/zr36067.c	Mon Feb 24 11:06:01 2003
+++ b/drivers/media/video/zr36067.c	Tue Feb 25 18:27:30 2003
@@ -3629,7 +3629,7 @@
 			       ("%s: ioctl VIDIOCCAPTURE: %d\n", zr->name,
 				v));
 
-			/* If there is nothing to do, return immediatly */
+			/* If there is nothing to do, return immediately */
 
 			if ((v && zr->v4l_overlay_active)
 			    || (!v && !zr->v4l_overlay_active))
@@ -4048,7 +4048,7 @@
 
 			zr->params = bp;
 
-			/* Make changes of input and norm go into effect immediatly */
+			/* Make changes of input and norm go into effect immediately */
 
 			/* We switch overlay off and on since a change in the norm
 			   needs different VFE settings */
diff -ur a/drivers/net/skfp/hwt.c b/drivers/net/skfp/hwt.c
--- a/drivers/net/skfp/hwt.c	Mon Feb 24 11:05:07 2003
+++ b/drivers/net/skfp/hwt.c	Tue Feb 25 18:27:32 2003
@@ -264,7 +264,7 @@
  * para	start		start time
  *	duration	time to wait
  *
- * NOTE: The fuction will return immediatly, if the timer is not 
+ * NOTE: The fuction will return immediately, if the timer is not 
  *	 started
  ************************/
 void hwt_wait_time(smc,start,duration)
diff -ur a/drivers/net/wan/lmc/lmc_main.c b/drivers/net/wan/lmc/lmc_main.c
--- a/drivers/net/wan/lmc/lmc_main.c	Mon Feb 24 11:05:15 2003
+++ b/drivers/net/wan/lmc/lmc_main.c	Tue Feb 25 18:27:34 2003
@@ -1024,7 +1024,7 @@
 }
 
 
-/* This is the entry point.  This is what is called immediatly. */
+/* This is the entry point.  This is what is called immediately. */
 /* This goes out and finds the card */
 
 int lmc_probe_fake(struct net_device *dev) /*fold00*/
diff -ur a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
--- a/drivers/s390/block/dasd_diag.c	Mon Feb 24 11:05:05 2003
+++ b/drivers/s390/block/dasd_diag.c	Tue Feb 25 18:27:40 2003
@@ -467,7 +467,7 @@
  * the diag_bio_t for each block has 16 bytes. 
  * That makes:
  * (8192 - 96 - 8) / 16 = 505.5 blocks at maximum.
- * We want to fit two into the available memory so that we can immediatly
+ * We want to fit two into the available memory so that we can immediately
  * start the next request if one finishes off. That makes 252.75 blocks
  * for one request. Give a little safety and the result is 240.
  */
diff -ur a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
--- a/drivers/s390/block/dasd_eckd.c	Mon Feb 24 11:05:04 2003
+++ b/drivers/s390/block/dasd_eckd.c	Tue Feb 25 18:27:44 2003
@@ -1427,7 +1427,7 @@
  * addition we have one define extent ccw + 16 bytes of data and one
  * locate record ccw + 16 bytes of data. That makes:
  * (8192 - 24 - 136 - 8 - 16 - 8 - 16) / 16 = 499 blocks at maximum.
- * We want to fit two into the available memory so that we can immediatly
+ * We want to fit two into the available memory so that we can immediately
  * start the next request if one finishes off. That makes 249.5 blocks
  * for one request. Give a little safety and the result is 240.
  */
diff -ur a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
--- a/drivers/s390/block/dasd_fba.c	Mon Feb 24 11:05:36 2003
+++ b/drivers/s390/block/dasd_fba.c	Tue Feb 25 18:27:47 2003
@@ -389,7 +389,7 @@
  * locate record ccw for each block (stupid devices!) + 16 bytes of data.
  * That makes:
  * (8192 - 24 - 136 - 8 - 16) / 40 = 200.2 blocks at maximum.
- * We want to fit two into the available memory so that we can immediatly
+ * We want to fit two into the available memory so that we can immediately
  * start the next request if one finishes off. That makes 100.1 blocks
  * for one request. Give a little safety and the result is 96.
  */
diff -ur a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
--- a/drivers/s390/char/con3215.c	Mon Feb 24 11:05:37 2003
+++ b/drivers/s390/char/con3215.c	Tue Feb 25 18:27:52 2003
@@ -312,10 +312,10 @@
 }
 
 /*
- * Function to conditionally start an IO. A read is started immediatly,
- * a write is only started immediatly if the flush flag is on or the
+ * Function to conditionally start an IO. A read is started immediately,
+ * a write is only started immediately if the flush flag is on or the
  * amount of data is bigger than RAW3215_MIN_WRITE. If a write is not
- * done immediatly a timer is started with a delay of RAW3215_TIMEOUT.
+ * done immediately a timer is started with a delay of RAW3215_TIMEOUT.
  */
 static inline void
 raw3215_try_io(struct raw3215_info *raw)
diff -ur a/drivers/s390/char/sclp_rw.c b/drivers/s390/char/sclp_rw.c
--- a/drivers/s390/char/sclp_rw.c	Mon Feb 24 11:05:31 2003
+++ b/drivers/s390/char/sclp_rw.c	Tue Feb 25 18:27:54 2003
@@ -192,7 +192,7 @@
 	 * under VM (Why does VM interpret \n but the native machine doesn't ?)
 	 *
 	 * Depending on i/o-control setting the message is always written
-	 * immediatly or we wait for a final new line maybe coming with the
+	 * immediately or we wait for a final new line maybe coming with the
 	 * next message. Besides we avoid a buffer overrun by writing its
 	 * content.
 	 *
diff -ur a/drivers/s390/cio/device_fsm.c b/drivers/s390/cio/device_fsm.c
--- a/drivers/s390/cio/device_fsm.c	Mon Feb 24 11:05:32 2003
+++ b/drivers/s390/cio/device_fsm.c	Tue Feb 25 18:27:58 2003
@@ -288,7 +288,7 @@
 	}
 	/* Is Set Path Group supported? */
 	if (!cdev->private->flags.pgid_supp) {
-		/* No, set state online immediatly. */
+		/* No, set state online immediately. */
 		ccw_device_done(cdev, DEV_STATE_ONLINE);
 		return 0;
 	}
@@ -333,7 +333,7 @@
 		return -EBUSY;
 	/* Is Set Path Group supported? */
 	if (!cdev->private->flags.pgid_supp) {
-		/* No, set state offline immediatly. */
+		/* No, set state offline immediately. */
 		ccw_device_done(cdev, DEV_STATE_OFFLINE);
 		return 0;
 	}
diff -ur a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
--- a/drivers/s390/net/lcs.c	Mon Feb 24 11:05:09 2003
+++ b/drivers/s390/net/lcs.c	Tue Feb 25 18:28:02 2003
@@ -1206,7 +1206,7 @@
 	card->stats.tx_packets++;
 	dev_kfree_skb(skb);
 	if (card->tx_emitted <= 0)
-		/* If this is the first tx buffer emit it immediatly. */
+		/* If this is the first tx buffer emit it immediately. */
 		__lcs_emit_txbuffer(card);
 	return 0;
 }
diff -ur a/include/linux/n_r3964.h b/include/linux/n_r3964.h
--- a/include/linux/n_r3964.h	Mon Feb 24 11:05:39 2003
+++ b/include/linux/n_r3964.h	Tue Feb 25 18:28:05 2003
@@ -165,7 +165,7 @@
 {
 	unsigned int length;             /* length in chars without header */
 	unsigned char *data;             /* usually data is located 
-                                        immediatly behind this struct */
+                                        immediately behind this struct */
 	unsigned int locks;              /* only used in rx_buffer */
 	  
     struct r3964_block_header *next;
