Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265457AbTCCPHC>; Mon, 3 Mar 2003 10:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265470AbTCCPHC>; Mon, 3 Mar 2003 10:07:02 -0500
Received: from mailrelay2.lanl.gov ([128.165.4.103]:17597 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S265457AbTCCPGz>; Mon, 3 Mar 2003 10:06:55 -0500
Subject: [PATCH] 2.5.63-current Spelling fixes from spell-fix.pl
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Dan Kegel <dank@kegel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 03 Mar 2003 08:13:18 -0700
Message-Id: <1046704398.6611.314.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the first fruits of the automatic spell checking and
correcting scripts written by Dan Kegel and Matthias Schniedermeyer. 
Those scripts are available here: http://www.kegel.com/kerspell/

This patch fixes these six words from the first five lines of
spell-fix.txt.  280 lines remaining.

accesible   -> accessible
accesing    -> accessing
accomodate  -> accommodate
acommodate  -> accommodate
Acknowlege  -> Acknowledge
acknoledged -> acknowledged

Steven

 arch/arm/mach-pxa/irq.c              |    2 +-
 arch/arm/mach-sa1100/irq.c           |    2 +-
 arch/cris/kernel/kgdb.c              |    2 +-
 arch/i386/mach-voyager/voyager_smp.c |    2 +-
 arch/ia64/sn/io/l1.c                 |    2 +-
 drivers/cdrom/cdrom.c                |    2 +-
 drivers/char/cd1865.h                |    6 +++---
 drivers/char/drm/i810_drm.h          |    2 +-
 drivers/char/drm/i830_drm.h          |    2 +-
 drivers/net/sk98lin/skge.c           |    4 ++--
 drivers/net/sk98lin/ski2c.c          |    2 +-
 drivers/s390/block/dasd_eckd.c       |    2 +-
 drivers/scsi/pcmcia/nsp_cs.h         |    2 +-
 fs/ufs/util.h                        |    2 +-
 sound/isa/opl3sa2.c                  |    2 +-
 sound/pci/cs46xx/dsp_spos.h          |    2 +-
 16 files changed, 19 insertions(+), 19 deletions(-)


diff -ur 2.5-current/arch/arm/mach-pxa/irq.c linux/arch/arm/mach-pxa/irq.c
--- 2.5-current/arch/arm/mach-pxa/irq.c	Mon Mar  3 07:23:06 2003
+++ linux/arch/arm/mach-pxa/irq.c	Mon Mar  3 07:32:23 2003
@@ -86,7 +86,7 @@
 }
 
 /*
- * GPIO IRQs must be acknoledged.  This is for GPIO 0 and 1.
+ * GPIO IRQs must be acknowledged.  This is for GPIO 0 and 1.
  */
 
 static void pxa_ack_low_gpio(unsigned int irq)
diff -ur 2.5-current/arch/arm/mach-sa1100/irq.c linux/arch/arm/mach-sa1100/irq.c
--- 2.5-current/arch/arm/mach-sa1100/irq.c	Mon Mar  3 07:23:09 2003
+++ linux/arch/arm/mach-sa1100/irq.c	Mon Mar  3 07:32:23 2003
@@ -68,7 +68,7 @@
 }
 
 /*
- * GPIO IRQs must be acknoledged.  This is for IRQs from 0 to 10.
+ * GPIO IRQs must be acknowledged.  This is for IRQs from 0 to 10.
  */
 static void sa1100_low_gpio_ack(unsigned int irq)
 {
diff -ur 2.5-current/arch/cris/kernel/kgdb.c linux/arch/cris/kernel/kgdb.c
--- 2.5-current/arch/cris/kernel/kgdb.c	Mon Mar  3 07:23:07 2003
+++ linux/arch/cris/kernel/kgdb.c	Mon Mar  3 07:26:01 2003
@@ -152,7 +152,7 @@
  *    (IPL too high, disabled, ...)
  *
  *  - The gdb stub is currently not reentrant, i.e. errors that happen therein
- *    (e.g. accesing invalid memory) may not be caught correctly. This could
+ *    (e.g. accessing invalid memory) may not be caught correctly. This could
  *    be removed in future by introducing a stack of struct registers.
  *
  */
diff -ur 2.5-current/arch/i386/mach-voyager/voyager_smp.c linux/arch/i386/mach-voyager/voyager_smp.c
--- 2.5-current/arch/i386/mach-voyager/voyager_smp.c	Mon Mar  3 07:22:46 2003
+++ linux/arch/i386/mach-voyager/voyager_smp.c	Mon Mar  3 07:32:20 2003
@@ -1473,7 +1473,7 @@
 		outb((__u8)cpuset, VIC_CPI_Registers[VIC_CPI_LEVEL0]);
 }
 
-/* Acknowlege receipt of CPI in the QIC, clear in QIC hardware and
+/* Acknowledge receipt of CPI in the QIC, clear in QIC hardware and
  * set the cache line to shared by reading it.
  *
  * DON'T make this inline otherwise the cache line read will be
diff -ur 2.5-current/arch/ia64/sn/io/l1.c linux/arch/ia64/sn/io/l1.c
--- 2.5-current/arch/ia64/sn/io/l1.c	Mon Mar  3 07:23:07 2003
+++ linux/arch/ia64/sn/io/l1.c	Mon Mar  3 07:29:53 2003
@@ -2602,7 +2602,7 @@
 {
     sc_cq_t *q;         /* receive queue */
     int before_wrap,    /* packet may be split into two different       */
-        after_wrap;     /*   pieces to acommodate queue wraparound      */
+        after_wrap;     /*   pieces to accommodate queue wraparound      */
 
     /* pull message off the receive queue */
     q = subch->iqp;
diff -ur 2.5-current/drivers/cdrom/cdrom.c linux/drivers/cdrom/cdrom.c
--- 2.5-current/drivers/cdrom/cdrom.c	Mon Mar  3 07:22:40 2003
+++ linux/drivers/cdrom/cdrom.c	Mon Mar  3 07:30:08 2003
@@ -173,7 +173,7 @@
   -- Fixed the CDROMREADxxx ioctls.
   -- CDROMPLAYTRKIND uses the GPCMD_PLAY_AUDIO_MSF command - too few
   drives supported it. We lose the index part, however.
-  -- Small modifications to accomodate opens of /dev/hdc1, required
+  -- Small modifications to accommodate opens of /dev/hdc1, required
   for ide-cd to handle multisession discs.
   -- Export cdrom_mode_sense and cdrom_mode_select.
   -- init_cdrom_command() for setting up a cgc command.
diff -ur 2.5-current/drivers/char/cd1865.h linux/drivers/char/cd1865.h
--- 2.5-current/drivers/char/cd1865.h	Mon Mar  3 07:22:57 2003
+++ linux/drivers/char/cd1865.h	Mon Mar  3 07:32:32 2003
@@ -54,9 +54,9 @@
 #define CD186x_RCSR      0x7a    /* Receiver Character Status Register      */
 #define CD186x_TDR       0x7b    /* Transmit Data Register                  */
 #define CD186x_EOIR      0x7f    /* End of Interrupt Register               */
-#define CD186x_MRAR      0x75    /* Modem Request Acknowlege register       */
-#define CD186x_TRAR      0x76    /* Transmit Request Acknowlege register    */
-#define CD186x_RRAR      0x77    /* Receive Request Acknowlege register     */
+#define CD186x_MRAR      0x75    /* Modem Request Acknowledge register       */
+#define CD186x_TRAR      0x76    /* Transmit Request Acknowledge register    */
+#define CD186x_RRAR      0x77    /* Receive Request Acknowledge register     */
 #define CD186x_SRCR      0x66    /* Service Request Configuration register  */
 
 /* Channel Registers */
diff -ur 2.5-current/drivers/char/drm/i810_drm.h linux/drivers/char/drm/i810_drm.h
--- 2.5-current/drivers/char/drm/i810_drm.h	Mon Mar  3 07:22:36 2003
+++ linux/drivers/char/drm/i810_drm.h	Mon Mar  3 07:30:02 2003
@@ -38,7 +38,7 @@
  *    - zbuffer linear offset and pitch -- also invarient
  *    - drawing origin in back and depth buffers.
  *
- * Keep the depth/back buffer state here to acommodate private buffers
+ * Keep the depth/back buffer state here to accommodate private buffers
  * in the future.
  */
 #define I810_DESTREG_DI0  0	/* CMD_OP_DESTBUFFER_INFO (2 dwords) */
diff -ur 2.5-current/drivers/char/drm/i830_drm.h linux/drivers/char/drm/i830_drm.h
--- 2.5-current/drivers/char/drm/i830_drm.h	Mon Mar  3 07:22:46 2003
+++ linux/drivers/char/drm/i830_drm.h	Mon Mar  3 07:30:02 2003
@@ -68,7 +68,7 @@
  *    - zbuffer linear offset and pitch -- also invarient
  *    - drawing origin in back and depth buffers.
  *
- * Keep the depth/back buffer state here to acommodate private buffers
+ * Keep the depth/back buffer state here to accommodate private buffers
  * in the future.
  */
 
diff -ur 2.5-current/drivers/net/sk98lin/skge.c linux/drivers/net/sk98lin/skge.c
--- 2.5-current/drivers/net/sk98lin/skge.c	Mon Mar  3 07:22:40 2003
+++ linux/drivers/net/sk98lin/skge.c	Mon Mar  3 07:26:07 2003
@@ -3627,7 +3627,7 @@
  * Description:
  *	This routine writes a 16 bit value to the pci configuration
  *	space. The flag PciConfigUp indicates whether the config space
- *	is accesible or must be set up first.
+ *	is accessible or must be set up first.
  *
  * Returns:
  *	0 - indicate everything worked ok.
@@ -3650,7 +3650,7 @@
  * Description:
  *	This routine writes a 8 bit value to the pci configuration
  *	space. The flag PciConfigUp indicates whether the config space
- *	is accesible or must be set up first.
+ *	is accessible or must be set up first.
  *
  * Returns:
  *	0 - indicate everything worked ok.
diff -ur 2.5-current/drivers/net/sk98lin/ski2c.c linux/drivers/net/sk98lin/ski2c.c
--- 2.5-current/drivers/net/sk98lin/ski2c.c	Mon Mar  3 07:22:36 2003
+++ linux/drivers/net/sk98lin/ski2c.c	Mon Mar  3 07:32:26 2003
@@ -444,7 +444,7 @@
 /*
  * Receive an ACK.
  *
- * returns	0 If acknoledged
+ * returns	0 If acknowledged
  *		1 in case of an error
  */
 int SkI2cRcvAck(
diff -ur 2.5-current/drivers/s390/block/dasd_eckd.c linux/drivers/s390/block/dasd_eckd.c
--- 2.5-current/drivers/s390/block/dasd_eckd.c	Mon Mar  3 07:22:36 2003
+++ linux/drivers/s390/block/dasd_eckd.c	Mon Mar  3 07:26:06 2003
@@ -19,7 +19,7 @@
  * 10/04/00 changed RW-CCWS to R/W Key and Data
  * 10/10/00 reverted last change according to ESS exploitation
  * 10/10/00 now dequeuing init_cqr before freeing *ouch*
- * 26/10/00 fixed ITPM20144ASC (problems when accesing a device formatted by VIF)
+ * 26/10/00 fixed ITPM20144ASC (problems when accessing a device formatted by VIF)
  * 01/23/01 fixed kmalloc statement in dump_sense to be GFP_ATOMIC
  *	    fixed partition handling and HDIO_GETGEO
  * 2002/01/04 Created 2.4-2.5 compatibility mode
diff -ur 2.5-current/drivers/scsi/pcmcia/nsp_cs.h linux/drivers/scsi/pcmcia/nsp_cs.h
--- 2.5-current/drivers/scsi/pcmcia/nsp_cs.h	Mon Mar  3 07:22:46 2003
+++ linux/drivers/scsi/pcmcia/nsp_cs.h	Mon Mar  3 07:32:33 2003
@@ -183,7 +183,7 @@
 #define S_ATN		0x80	/**/
 #define S_SELECT	0x40	/**/
 #define S_REQUEST	0x20    /* Request line from SCSI bus*/
-#define S_ACK		0x10    /* Acknowlege line from SCSI bus*/
+#define S_ACK		0x10    /* Acknowledge line from SCSI bus*/
 #define S_BUSY		0x08    /* Busy line from SCSI bus*/
 #define S_CD		0x04    /* Command/Data line from SCSI bus*/
 #define S_IO		0x02    /* Input/Output line from SCSI bus*/
diff -ur 2.5-current/fs/ufs/util.h linux/fs/ufs/util.h
--- 2.5-current/fs/ufs/util.h	Mon Mar  3 07:22:55 2003
+++ linux/fs/ufs/util.h	Mon Mar  3 07:26:21 2003
@@ -25,7 +25,7 @@
 

 /*
- * macros used for accesing structures
+ * macros used for accessing structures
  */
 static inline s32
 ufs_get_fs_state(struct super_block *sb, struct ufs_super_block_first *usb1,
diff -ur 2.5-current/sound/isa/opl3sa2.c linux/sound/isa/opl3sa2.c
--- 2.5-current/sound/isa/opl3sa2.c	Mon Mar  3 07:23:16 2003
+++ linux/sound/isa/opl3sa2.c	Mon Mar  3 07:26:33 2003
@@ -268,7 +268,7 @@
 		snd_printd("OPL3-SA [0x%lx] detect (1) = 0x%x (0x%x)\n", port, tmp, tmp1);
 		return -ENODEV;
 	}
-	/* try if the MIC register is accesible */
+	/* try if the MIC register is accessible */
 	tmp = snd_opl3sa2_read(chip, OPL3SA2_MIC);
 	snd_opl3sa2_write(chip, OPL3SA2_MIC, 0x8a);
 	if (((tmp1 = snd_opl3sa2_read(chip, OPL3SA2_MIC)) & 0x9f) != 0x8a) {
diff -ur 2.5-current/sound/pci/cs46xx/dsp_spos.h linux/sound/pci/cs46xx/dsp_spos.h
--- 2.5-current/sound/pci/cs46xx/dsp_spos.h	Mon Mar  3 07:22:37 2003
+++ linux/sound/pci/cs46xx/dsp_spos.h	Mon Mar  3 07:26:32 2003
@@ -173,7 +173,7 @@
 #define BG_INTERVAL_TIMER_PERIOD                0x0100
 

-/* Only SP accesible registers */
+/* Only SP accessible registers */
 #define SP_ASER_COUNTDOWN 0x8040
 #define SP_SPDOUT_FIFO    0x0108
 #define SP_SPDIN_MI_FIFO  0x01E0



