Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268372AbTBYWiI>; Tue, 25 Feb 2003 17:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268383AbTBYWiH>; Tue, 25 Feb 2003 17:38:07 -0500
Received: from [24.77.48.240] ([24.77.48.240]:37936 "EHLO aiinc.aiinc.ca")
	by vger.kernel.org with ESMTP id <S268372AbTBYWhy>;
	Tue, 25 Feb 2003 17:37:54 -0500
Date: Tue, 25 Feb 2003 14:48:11 -0800
From: Michael Hayes <mike@aiinc.ca>
Message-Id: <200302252248.h1PMmBl29251@aiinc.aiinc.ca>
To: linux-kernel@vger.kernel.org
Subject: [REVISED][PATCH] Spelling fixes for 2.5.63 - can't
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removed changes to comments in .S files -- gcc does not like apostrophes
in assembler comments.

This fixes:
    cant -> can't (28 occurrences)

diff -ur a/arch/cris/drivers/serial.c b/arch/cris/drivers/serial.c
--- a/arch/cris/drivers/serial.c	Mon Feb 24 11:05:36 2003
+++ b/arch/cris/drivers/serial.c	Tue Feb 25 10:11:07 2003
@@ -132,7 +132,7 @@
  *   Items worth noticing:
  *
  *      No Etrax100 port 1 workarounds (does only compile on 2.4 anyway now)
- *      RS485 is not ported (why cant it be done in userspace as on x86 ?)
+ *      RS485 is not ported (why can't it be done in userspace as on x86 ?)
  *      Statistics done through async_icount - if any more stats are needed,
  *      that's the place to put them or in an arch-dep version of it.
  *      timeout_interrupt and the other fast timeout stuff not ported yet
diff -ur a/arch/ia64/sn/fakeprom/fpmem.c b/arch/ia64/sn/fakeprom/fpmem.c
--- a/arch/ia64/sn/fakeprom/fpmem.c	Mon Feb 24 11:05:16 2003
+++ b/arch/ia64/sn/fakeprom/fpmem.c	Tue Feb 25 10:11:37 2003
@@ -218,7 +218,7 @@
 				}
 
                                 /*
-                                 * Check for the node 0 hole. Since banks cant
+                                 * Check for the node 0 hole. Since banks can't
                                  * span the hole, we only need to check if the end of
                                  * the range is the end of the hole.
                                  */
diff -ur a/arch/mips/math-emu/sp_fdp.c b/arch/mips/math-emu/sp_fdp.c
--- a/arch/mips/math-emu/sp_fdp.c	Mon Feb 24 11:05:32 2003
+++ b/arch/mips/math-emu/sp_fdp.c	Tue Feb 25 10:14:09 2003
@@ -49,7 +49,7 @@
 	case IEEE754_CLASS_ZERO:
 		return ieee754sp_zero(xs);
 	case IEEE754_CLASS_DNORM:
-		/* cant possibly be sp representable */
+		/* can't possibly be sp representable */
 		SETCX(IEEE754_UNDERFLOW);
 		return ieee754sp_xcpt(ieee754sp_zero(xs), "fdp", x);
 	case IEEE754_CLASS_NORM:
diff -ur a/arch/mips64/math-emu/sp_fdp.c b/arch/mips64/math-emu/sp_fdp.c
--- a/arch/mips64/math-emu/sp_fdp.c	Mon Feb 24 11:05:45 2003
+++ b/arch/mips64/math-emu/sp_fdp.c	Tue Feb 25 10:13:58 2003
@@ -49,7 +49,7 @@
 	case IEEE754_CLASS_ZERO:
 		return ieee754sp_zero(xs);
 	case IEEE754_CLASS_DNORM:
-		/* cant possibly be sp representable */
+		/* can't possibly be sp representable */
 		SETCX(IEEE754_UNDERFLOW);
 		return ieee754sp_xcpt(ieee754sp_zero(xs), "fdp", x);
 	case IEEE754_CLASS_NORM:
diff -ur a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
--- a/drivers/char/pcmcia/synclink_cs.c	Mon Feb 24 11:05:15 2003
+++ b/drivers/char/pcmcia/synclink_cs.c	Tue Feb 25 10:17:46 2003
@@ -4505,7 +4505,7 @@
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("mgslpc_sppp_rx_done(%s)\n",info->netname);	
 	if (skb == NULL) {
-		printk(KERN_NOTICE "%s: cant alloc skb, dropping packet\n",
+		printk(KERN_NOTICE "%s: can't alloc skb, dropping packet\n",
 			info->netname);
 		info->netstats.rx_dropped++;
 		return;
diff -ur a/drivers/char/rio/riotty.c b/drivers/char/rio/riotty.c
--- a/drivers/char/rio/riotty.c	Mon Feb 24 11:05:16 2003
+++ b/drivers/char/rio/riotty.c	Tue Feb 25 10:17:56 2003
@@ -737,10 +737,10 @@
 RIOCookMode(struct ttystatics *tp)
 {
 	/*
-	** We cant handle tm.c_mstate != 0 on SCO
-	** We cant handle mapping
-	** We cant handle non-ttwrite line disc.
-	** We cant handle lflag XCASE
+	** We can't handle tm.c_mstate != 0 on SCO
+	** We can't handle mapping
+	** We can't handle non-ttwrite line disc.
+	** We can't handle lflag XCASE
 	** We can handle oflag OPOST & (OCRNL, ONLCR, TAB3)
 	*/
 
diff -ur a/drivers/char/synclink.c b/drivers/char/synclink.c
--- a/drivers/char/synclink.c	Mon Feb 24 11:05:15 2003
+++ b/drivers/char/synclink.c	Tue Feb 25 10:18:12 2003
@@ -8103,7 +8103,7 @@
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("mgsl_sppp_rx_done(%s)\n",info->netname);	
 	if (skb == NULL) {
-		printk(KERN_NOTICE "%s: cant alloc skb, dropping packet\n",
+		printk(KERN_NOTICE "%s: can't alloc skb, dropping packet\n",
 			info->netname);
 		info->netstats.rx_dropped++;
 		return;
diff -ur a/drivers/char/synclinkmp.c b/drivers/char/synclinkmp.c
--- a/drivers/char/synclinkmp.c	Mon Feb 24 11:05:11 2003
+++ b/drivers/char/synclinkmp.c	Tue Feb 25 10:18:16 2003
@@ -1829,7 +1829,7 @@
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("sppp_rx_done(%s)\n",info->netname);
 	if (skb == NULL) {
-		printk(KERN_NOTICE "%s: cant alloc skb, dropping packet\n",
+		printk(KERN_NOTICE "%s: can't alloc skb, dropping packet\n",
 			info->netname);
 		info->netstats.rx_dropped++;
 		return;
diff -ur a/drivers/media/radio/miropcm20-radio.c b/drivers/media/radio/miropcm20-radio.c
--- a/drivers/media/radio/miropcm20-radio.c	Mon Feb 24 11:05:13 2003
+++ b/drivers/media/radio/miropcm20-radio.c	Tue Feb 25 10:18:30 2003
@@ -15,7 +15,7 @@
  */
 
 /* What ever you think about the ACI, version 0x07 is not very well!
- * I cant get frequency, 'tuner status', 'tuner flags' or mute/mono
+ * I can't get frequency, 'tuner status', 'tuner flags' or mute/mono
  * conditions...                Robert 
  */
 
@@ -93,7 +93,7 @@
 	} else {
 		/* stereo */
 		*flags=VIDEO_TUNER_STEREO_ON;
-		/* I cant see stereo, when forced to mono */
+		/* I can't see stereo, when forced to mono */
 		dev->stereo=1;
 	}
 
diff -ur a/drivers/mtd/devices/blkmtd.c b/drivers/mtd/devices/blkmtd.c
--- a/drivers/mtd/devices/blkmtd.c	Mon Feb 24 11:05:05 2003
+++ b/drivers/mtd/devices/blkmtd.c	Tue Feb 25 10:21:50 2003
@@ -217,7 +217,7 @@
   DEBUG(3, "blkmtd: readpage: getting kiovec\n");
   err = alloc_kiovec(1, &iobuf);
   if (err) {
-    printk("blkmtd: cant allocate kiobuf\n");
+    printk("blkmtd: can't allocate kiobuf\n");
     SetPageError(page);
     return err;
   }
@@ -226,7 +226,7 @@
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,4)
   blocks = kmalloc(KIO_MAX_SECTORS * sizeof(*blocks));
   if(blocks == NULL) {
-    printk("blkmtd: cant allocate iobuf blocks\n");
+    printk("blkmtd: can't allocate iobuf blocks\n");
     free_kiovec(1, &iobuf);
     SetPageError(page);
     return -ENOMEM;
@@ -306,7 +306,7 @@
   daemonize("blkmtdd");
 
   if(alloc_kiovec(1, &iobuf)) {
-    printk("blkmtd: write_queue_task cant allocate kiobuf\n");
+    printk("blkmtd: write_queue_task can't allocate kiobuf\n");
     return 0;
   }
 
@@ -314,7 +314,7 @@
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,4)
   blocks = kmalloc(KIO_MAX_SECTORS * sizeof(unsigned long));
   if(blocks == NULL) {
-    printk("blkmtd: write_queue_task cant allocate iobuf blocks\n");
+    printk("blkmtd: write_queue_task can't allocate iobuf blocks\n");
     free_kiovec(1, &iobuf);
     return 0;
   }
@@ -794,7 +794,7 @@
       page = grab_cache_page(&rawdevice->as, pagenr);
       DEBUG(3, "blkmtd: write: got page %d from page cache\n", pagenr);
       if(!page) {
-	printk("blkmtd: write: cant grab cache page %d\n", pagenr);
+	printk("blkmtd: write: can't grab cache page %d\n", pagenr);
 	err = -EIO;
 	goto write_err;
       }
@@ -1090,7 +1090,7 @@
 
   file = filp_open(device, mode, 0);
   if(IS_ERR(file)) {
-    printk("blkmtd: error, cant open device %s\n", device);
+    printk("blkmtd: error, can't open device %s\n", device);
     DEBUG(2, "blkmtd: filp_open returned %ld\n", PTR_ERR(file));
     return 1;
   }
@@ -1144,7 +1144,7 @@
   DEBUG(1, "blkmtd: size = %ld\n", (long int)size);
 
   if(size == 0) {
-    printk("blkmtd: cant determine size\n");
+    printk("blkmtd: can't determine size\n");
     blkdev_put(bdev, BDEV_RAW);
     return 1;
   }
diff -ur a/drivers/net/hp100.c b/drivers/net/hp100.c
--- a/drivers/net/hp100.c	Mon Feb 24 11:05:16 2003
+++ b/drivers/net/hp100.c	Tue Feb 25 10:21:57 2003
@@ -2868,7 +2868,7 @@
 			hp100_andb(~HP100_PCI_RESET, PCICTRL2);
 			hp100_orb(HP100_PCI_RESET, PCICTRL2);
 			/* Wait for min. 300 ns */
-			/* we cant use jiffies here, because it may be */
+			/* we can't use jiffies here, because it may be */
 			/* that we have disabled the timer... */
 			udelay(400);
 			hp100_andb(~HP100_PCI_RESET, PCICTRL2);
diff -ur a/drivers/usb/media/konicawc.c b/drivers/usb/media/konicawc.c
--- a/drivers/usb/media/konicawc.c	Mon Feb 24 11:05:04 2003
+++ b/drivers/usb/media/konicawc.c	Tue Feb 25 10:22:49 2003
@@ -806,7 +806,7 @@
 				while(i--) {
 					usb_free_urb(cam->sts_urb[i]);
 				}
-				err("cant allocate urbs");
+				err("can't allocate urbs");
 				return -ENOMEM;
 			}
 		}
diff -ur a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
--- a/fs/befs/linuxvfs.c	Mon Feb 24 11:05:29 2003
+++ b/fs/befs/linuxvfs.c	Tue Feb 25 10:23:00 2003
@@ -541,7 +541,7 @@
 	wchar_t uni;
 	int unilen, utflen;
 	char *result;
-	int maxlen = in_len; /* The utf8->nls conversion cant make more chars */
+	int maxlen = in_len; /* The utf8->nls conversion can't make more chars */
 
 	befs_debug(sb, "---> utf2nls()");
 
diff -ur a/include/asm-arm/proc-fns.h b/include/asm-arm/proc-fns.h
--- a/include/asm-arm/proc-fns.h	Mon Feb 24 11:05:33 2003
+++ b/include/asm-arm/proc-fns.h	Tue Feb 25 10:23:37 2003
@@ -125,7 +125,7 @@
 
 #if 0
  * The following is to fool mkdep into generating the correct
- * dependencies.  Without this, it cant figure out that this
+ * dependencies.  Without this, it can't figure out that this
  * file does indeed depend on the cpu-*.h files.
 #include <asm/cpu-single.h>
 #include <asm/cpu-multi26.h>
diff -ur a/include/asm-m68k/swim_iop.h b/include/asm-m68k/swim_iop.h
--- a/include/asm-m68k/swim_iop.h	Mon Feb 24 11:05:10 2003
+++ b/include/asm-m68k/swim_iop.h	Tue Feb 25 10:23:46 2003
@@ -60,7 +60,7 @@
 
 #define	gcrOnMFMErr	-400	/* GCR (400/800K) on HD media */
 #define	verErr		-84	/* verify failed */
-#define	fmt2Err		-83	/* cant get enough sync during format */
+#define	fmt2Err		-83	/* can't get enough sync during format */
 #define	fmt1Err		-82	/* can't find sector 0 after track format */
 #define	sectNFErr	-81	/* can't find sector */
 #define	seekErr		-80	/* drive error during seek */
diff -ur a/include/linux/if.h b/include/linux/if.h
--- a/include/linux/if.h	Mon Feb 24 11:05:31 2003
+++ b/include/linux/if.h	Tue Feb 25 10:24:16 2003
@@ -59,7 +59,7 @@
 #define IF_IFACE_X21	0x1002		/* X.21 serial interface	*/
 #define IF_IFACE_T1	0x1003		/* T1 telco serial interface	*/
 #define IF_IFACE_E1	0x1004		/* E1 telco serial interface	*/
-#define IF_IFACE_SYNC_SERIAL 0x1005	/* cant'b be set by software	*/
+#define IF_IFACE_SYNC_SERIAL 0x1005	/* can't be set by software	*/
 
 /* For definitions see hdlc.h */
 #define IF_PROTO_HDLC	0x2000		/* raw HDLC protocol		*/
diff -ur a/sound/oss/maestro.c b/sound/oss/maestro.c
--- a/sound/oss/maestro.c	Mon Feb 24 11:05:42 2003
+++ b/sound/oss/maestro.c	Tue Feb 25 10:24:39 2003
@@ -804,7 +804,7 @@
 
 	if (read) return val;
 
-	/* oss can have many inputs, maestro cant.  try
+	/* oss can have many inputs, maestro can't.  try
 		to pick the 'new' one */
 
 	if (mask != val) mask &= ~val;
diff -ur a/sound/pci/cs46xx/dsp_spos_scb_lib.c b/sound/pci/cs46xx/dsp_spos_scb_lib.c
--- a/sound/pci/cs46xx/dsp_spos_scb_lib.c	Mon Feb 24 11:05:44 2003
+++ b/sound/pci/cs46xx/dsp_spos_scb_lib.c	Tue Feb 25 10:24:43 2003
@@ -181,7 +181,7 @@
 		      (ins->scbs + scb->index) == scb), return );
 
 #if 0
-	/* cant remove a SCB with childs before 
+	/* can't remove a SCB with childs before 
 	   removing childs first  */
 	snd_assert ( (scb->sub_list_ptr == ins->the_null_scb &&
 		      scb->next_scb_ptr == ins->the_null_scb),
