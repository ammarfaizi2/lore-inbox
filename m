Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270869AbTHATgf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 15:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270882AbTHATfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 15:35:36 -0400
Received: from mail.kroah.org ([65.200.24.183]:7871 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270678AbTHATcZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 15:32:25 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10597663132258@kroah.com>
Subject: [PATCH] PCI fixes for 2.6.0-test2
In-Reply-To: <20030801192924.GA31210@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Aug 2003 12:31:53 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1547.10.1, 2003/07/31 16:05:44-07:00, greg@kroah.com

[PATCH] PCI: pci_device_id can not be marked __devinitdata.  Fixes up sound/*


 sound/oss/ad1889.c            |    2 +-
 sound/oss/ali5455.c           |    2 +-
 sound/oss/btaudio.c           |    2 +-
 sound/oss/cs4281/cs4281m.c    |    2 +-
 sound/oss/cs46xx.c            |    2 +-
 sound/oss/es1370.c            |    2 +-
 sound/oss/es1371.c            |    2 +-
 sound/oss/esssolo1.c          |    2 +-
 sound/oss/forte.c             |    2 +-
 sound/oss/i810_audio.c        |    2 +-
 sound/oss/ite8172.c           |    2 +-
 sound/oss/kahlua.c            |    2 +-
 sound/oss/maestro.c           |    2 +-
 sound/oss/maestro3.c          |    2 +-
 sound/oss/nec_vrc5477.c       |    2 +-
 sound/oss/nm256_audio.c       |    2 +-
 sound/oss/rme96xx.c           |    2 +-
 sound/oss/sonicvibes.c        |    2 +-
 sound/oss/trident.c           |    2 +-
 sound/oss/via82cxxx_audio.c   |    2 +-
 sound/oss/ymfpci.c            |    2 +-
 sound/pci/ali5451/ali5451.c   |    2 +-
 sound/pci/als4000.c           |    2 +-
 sound/pci/azt3328.c           |    2 +-
 sound/pci/cmipci.c            |    2 +-
 sound/pci/cs4281.c            |    2 +-
 sound/pci/cs46xx/cs46xx.c     |    2 +-
 sound/pci/emu10k1/emu10k1.c   |    2 +-
 sound/pci/ens1370.c           |    2 +-
 sound/pci/es1938.c            |    2 +-
 sound/pci/es1968.c            |    2 +-
 sound/pci/fm801.c             |    2 +-
 sound/pci/ice1712/ice1712.c   |    2 +-
 sound/pci/ice1712/ice1724.c   |    2 +-
 sound/pci/intel8x0.c          |    4 ++--
 sound/pci/korg1212/korg1212.c |    2 +-
 sound/pci/maestro3.c          |    2 +-
 sound/pci/nm256/nm256.c       |    2 +-
 sound/pci/rme32.c             |    2 +-
 sound/pci/rme96.c             |    2 +-
 sound/pci/rme9652/hdsp.c      |    2 +-
 sound/pci/rme9652/rme9652.c   |    2 +-
 sound/pci/sonicvibes.c        |    2 +-
 sound/pci/trident/trident.c   |    2 +-
 sound/pci/via82xx.c           |    2 +-
 sound/pci/vx222/vx222.c       |    2 +-
 sound/pci/ymfpci/ymfpci.c     |    2 +-
 47 files changed, 48 insertions(+), 48 deletions(-)


diff -Nru a/sound/oss/ad1889.c b/sound/oss/ad1889.c
--- a/sound/oss/ad1889.c	Fri Aug  1 12:19:19 2003
+++ b/sound/oss/ad1889.c	Fri Aug  1 12:19:19 2003
@@ -918,7 +918,7 @@
 
 /************************* PCI interfaces ****************************** */
 /* PCI device table */
-static struct pci_device_id ad1889_id_tbl[] __devinitdata = {
+static struct pci_device_id ad1889_id_tbl[] = {
 	{ PCI_VENDOR_ID_ANALOG_DEVICES, PCI_DEVICE_ID_AD1889JS, PCI_ANY_ID, 
 	  PCI_ANY_ID, 0, 0, (unsigned long)DEVNAME },
 	{ },
diff -Nru a/sound/oss/ali5455.c b/sound/oss/ali5455.c
--- a/sound/oss/ali5455.c	Fri Aug  1 12:19:19 2003
+++ b/sound/oss/ali5455.c	Fri Aug  1 12:19:19 2003
@@ -216,7 +216,7 @@
 	"ALI 5455"
 };
 
-static struct pci_device_id ali_pci_tbl[] __initdata = {
+static struct pci_device_id ali_pci_tbl[] = {
 	{PCI_VENDOR_ID_ALI, PCI_DEVICE_ID_ALI_5455,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, ALI5455},
 	{0,}
diff -Nru a/sound/oss/btaudio.c b/sound/oss/btaudio.c
--- a/sound/oss/btaudio.c	Fri Aug  1 12:19:19 2003
+++ b/sound/oss/btaudio.c	Fri Aug  1 12:19:19 2003
@@ -1060,7 +1060,7 @@
 
 /* -------------------------------------------------------------- */
 
-static struct pci_device_id btaudio_pci_tbl[] __devinitdata = {
+static struct pci_device_id btaudio_pci_tbl[] = {
         {
 		.vendor		= PCI_VENDOR_ID_BROOKTREE,
 		.device		= 0x0878,
diff -Nru a/sound/oss/cs4281/cs4281m.c b/sound/oss/cs4281/cs4281m.c
--- a/sound/oss/cs4281/cs4281m.c	Fri Aug  1 12:19:19 2003
+++ b/sound/oss/cs4281/cs4281m.c	Fri Aug  1 12:19:19 2003
@@ -4458,7 +4458,7 @@
 		 "cs4281: cs4281_remove()-: remove successful\n"));
 }
 
-static struct pci_device_id cs4281_pci_tbl[] __devinitdata = {
+static struct pci_device_id cs4281_pci_tbl[] = {
 	{
 		.vendor    = PCI_VENDOR_ID_CIRRUS,
 		.device    = PCI_DEVICE_ID_CRYSTAL_CS4281,
diff -Nru a/sound/oss/cs46xx.c b/sound/oss/cs46xx.c
--- a/sound/oss/cs46xx.c	Fri Aug  1 12:19:18 2003
+++ b/sound/oss/cs46xx.c	Fri Aug  1 12:19:18 2003
@@ -5705,7 +5705,7 @@
 	CS46XX_4615,  	/* same as 4624 */
 };
 
-static struct pci_device_id cs46xx_pci_tbl[] __devinitdata = {
+static struct pci_device_id cs46xx_pci_tbl[] = {
 	{
 		.vendor	     = PCI_VENDOR_ID_CIRRUS,
 		.device	     = PCI_DEVICE_ID_CIRRUS_4610,
diff -Nru a/sound/oss/es1370.c b/sound/oss/es1370.c
--- a/sound/oss/es1370.c	Fri Aug  1 12:19:19 2003
+++ b/sound/oss/es1370.c	Fri Aug  1 12:19:19 2003
@@ -2719,7 +2719,7 @@
 	pci_set_drvdata(dev, NULL);
 }
 
-static struct pci_device_id id_table[] __devinitdata = {
+static struct pci_device_id id_table[] = {
 	{ PCI_VENDOR_ID_ENSONIQ, PCI_DEVICE_ID_ENSONIQ_ES1370, PCI_ANY_ID, PCI_ANY_ID, 0, 0 },
 	{ 0, }
 };
diff -Nru a/sound/oss/es1371.c b/sound/oss/es1371.c
--- a/sound/oss/es1371.c	Fri Aug  1 12:19:19 2003
+++ b/sound/oss/es1371.c	Fri Aug  1 12:19:19 2003
@@ -3030,7 +3030,7 @@
 	pci_set_drvdata(dev, NULL);
 }
 
-static struct pci_device_id id_table[] __devinitdata = {
+static struct pci_device_id id_table[] = {
 	{ PCI_VENDOR_ID_ENSONIQ, PCI_DEVICE_ID_ENSONIQ_ES1371, PCI_ANY_ID, PCI_ANY_ID, 0, 0 },
 	{ PCI_VENDOR_ID_ENSONIQ, PCI_DEVICE_ID_ENSONIQ_CT5880, PCI_ANY_ID, PCI_ANY_ID, 0, 0 },
 	{ PCI_VENDOR_ID_ECTIVA, PCI_DEVICE_ID_ECTIVA_EV1938, PCI_ANY_ID, PCI_ANY_ID, 0, 0 },
diff -Nru a/sound/oss/esssolo1.c b/sound/oss/esssolo1.c
--- a/sound/oss/esssolo1.c	Fri Aug  1 12:19:18 2003
+++ b/sound/oss/esssolo1.c	Fri Aug  1 12:19:18 2003
@@ -2436,7 +2436,7 @@
 	pci_set_drvdata(dev, NULL);
 }
 
-static struct pci_device_id id_table[] __devinitdata = {
+static struct pci_device_id id_table[] = {
 	{ PCI_VENDOR_ID_ESS, PCI_DEVICE_ID_ESS_SOLO1, PCI_ANY_ID, PCI_ANY_ID, 0, 0 },
 	{ 0, }
 };
diff -Nru a/sound/oss/forte.c b/sound/oss/forte.c
--- a/sound/oss/forte.c	Fri Aug  1 12:19:19 2003
+++ b/sound/oss/forte.c	Fri Aug  1 12:19:19 2003
@@ -2092,7 +2092,7 @@
 }
 
 
-static struct pci_device_id forte_pci_ids[] __devinitdata = {
+static struct pci_device_id forte_pci_ids[] = {
 	{ 0x1319, 0x0801, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
 	{ 0, }
 };
diff -Nru a/sound/oss/i810_audio.c b/sound/oss/i810_audio.c
--- a/sound/oss/i810_audio.c	Fri Aug  1 12:19:19 2003
+++ b/sound/oss/i810_audio.c	Fri Aug  1 12:19:19 2003
@@ -316,7 +316,7 @@
 	/*@FIXME to be verified*/	{  3, 0x0001 }, /* AMD8111 */
 };
 
-static struct pci_device_id i810_pci_tbl [] __initdata = {
+static struct pci_device_id i810_pci_tbl [] = {
 	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, ICH82801AA},
 	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82901,
diff -Nru a/sound/oss/ite8172.c b/sound/oss/ite8172.c
--- a/sound/oss/ite8172.c	Fri Aug  1 12:19:19 2003
+++ b/sound/oss/ite8172.c	Fri Aug  1 12:19:19 2003
@@ -2187,7 +2187,7 @@
 
 
 
-static struct pci_device_id id_table[] __devinitdata = {
+static struct pci_device_id id_table[] = {
 	{ PCI_VENDOR_ID_ITE, PCI_DEVICE_ID_ITE_IT8172G_AUDIO, PCI_ANY_ID,
 	  PCI_ANY_ID, 0, 0 },
 	{ 0, }
diff -Nru a/sound/oss/kahlua.c b/sound/oss/kahlua.c
--- a/sound/oss/kahlua.c	Fri Aug  1 12:19:19 2003
+++ b/sound/oss/kahlua.c	Fri Aug  1 12:19:19 2003
@@ -195,7 +195,7 @@
  *	5530 only. The 5510/5520 decode is different.
  */
 
-static struct pci_device_id id_tbl[] __devinitdata = {
+static struct pci_device_id id_tbl[] = {
 	{ PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5530_AUDIO, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ }
 };
diff -Nru a/sound/oss/maestro.c b/sound/oss/maestro.c
--- a/sound/oss/maestro.c	Fri Aug  1 12:19:19 2003
+++ b/sound/oss/maestro.c	Fri Aug  1 12:19:19 2003
@@ -3610,7 +3610,7 @@
 	pci_set_drvdata(pcidev,NULL);
 }
 
-static struct pci_device_id maestro_pci_tbl[] __devinitdata = {
+static struct pci_device_id maestro_pci_tbl[] = {
 	{PCI_VENDOR_ESS, PCI_DEVICE_ID_ESS_ESS1968, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_MAESTRO2},
 	{PCI_VENDOR_ESS, PCI_DEVICE_ID_ESS_ESS1978, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_MAESTRO2E},
 	{PCI_VENDOR_ESS_OLD, PCI_DEVICE_ID_ESS_ESS0100, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_MAESTRO},
diff -Nru a/sound/oss/maestro3.c b/sound/oss/maestro3.c
--- a/sound/oss/maestro3.c	Fri Aug  1 12:19:19 2003
+++ b/sound/oss/maestro3.c	Fri Aug  1 12:19:19 2003
@@ -328,7 +328,7 @@
 .driver_data = TYPE,				\
 }
 
-static struct pci_device_id m3_id_table[] __initdata = {
+static struct pci_device_id m3_id_table[] = {
     M3_DEVICE(0x1988, ESS_ALLEGRO),
     M3_DEVICE(0x1998, ESS_MAESTRO3),
     M3_DEVICE(0x199a, ESS_MAESTRO3HW),
diff -Nru a/sound/oss/nec_vrc5477.c b/sound/oss/nec_vrc5477.c
--- a/sound/oss/nec_vrc5477.c	Fri Aug  1 12:19:19 2003
+++ b/sound/oss/nec_vrc5477.c	Fri Aug  1 12:19:19 2003
@@ -1989,7 +1989,7 @@
 }
 
 
-static struct pci_device_id id_table[] __devinitdata = {
+static struct pci_device_id id_table[] = {
     { PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_VRC5477_AC97, 
       PCI_ANY_ID, PCI_ANY_ID, 0, 0 },
     { 0, }
diff -Nru a/sound/oss/nm256_audio.c b/sound/oss/nm256_audio.c
--- a/sound/oss/nm256_audio.c	Fri Aug  1 12:19:19 2003
+++ b/sound/oss/nm256_audio.c	Fri Aug  1 12:19:19 2003
@@ -1660,7 +1660,7 @@
 	.local_qlen		= nm256_audio_local_qlen,
 };
 
-static struct pci_device_id nm256_pci_tbl[] __devinitdata = {
+static struct pci_device_id nm256_pci_tbl[] = {
 	{PCI_VENDOR_ID_NEOMAGIC, PCI_DEVICE_ID_NEOMAGIC_NM256AV_AUDIO,
 	PCI_ANY_ID, PCI_ANY_ID, 0, 0},
 	{PCI_VENDOR_ID_NEOMAGIC, PCI_DEVICE_ID_NEOMAGIC_NM256ZX_AUDIO,
diff -Nru a/sound/oss/rme96xx.c b/sound/oss/rme96xx.c
--- a/sound/oss/rme96xx.c	Fri Aug  1 12:19:19 2003
+++ b/sound/oss/rme96xx.c	Fri Aug  1 12:19:19 2003
@@ -1072,7 +1072,7 @@
 #define PCI_ANY_ID 0
 #endif
 
-static struct pci_device_id id_table[] __devinitdata = {
+static struct pci_device_id id_table[] = {
 	{
 		.vendor	   = PCI_VENDOR_ID_RME,
 		.device	   = PCI_DEVICE_ID_RME9652,
diff -Nru a/sound/oss/sonicvibes.c b/sound/oss/sonicvibes.c
--- a/sound/oss/sonicvibes.c	Fri Aug  1 12:19:19 2003
+++ b/sound/oss/sonicvibes.c	Fri Aug  1 12:19:19 2003
@@ -2707,7 +2707,7 @@
 	pci_set_drvdata(dev, NULL);
 }
 
-static struct pci_device_id id_table[] __devinitdata = {
+static struct pci_device_id id_table[] = {
        { PCI_VENDOR_ID_S3, PCI_DEVICE_ID_S3_SONICVIBES, PCI_ANY_ID, PCI_ANY_ID, 0, 0 },
        { 0, }
 };
diff -Nru a/sound/oss/trident.c b/sound/oss/trident.c
--- a/sound/oss/trident.c	Fri Aug  1 12:19:19 2003
+++ b/sound/oss/trident.c	Fri Aug  1 12:19:19 2003
@@ -265,7 +265,7 @@
 	"Tvia/IGST CyberPro 5050"
 };
 
-static struct pci_device_id trident_pci_tbl [] __devinitdata = {
+static struct pci_device_id trident_pci_tbl [] = {
 	{PCI_VENDOR_ID_TRIDENT, PCI_DEVICE_ID_TRIDENT_4DWAVE_DX,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, TRIDENT_4D_DX},
 	{PCI_VENDOR_ID_TRIDENT, PCI_DEVICE_ID_TRIDENT_4DWAVE_NX,
diff -Nru a/sound/oss/via82cxxx_audio.c b/sound/oss/via82cxxx_audio.c
--- a/sound/oss/via82cxxx_audio.c	Fri Aug  1 12:19:19 2003
+++ b/sound/oss/via82cxxx_audio.c	Fri Aug  1 12:19:19 2003
@@ -387,7 +387,7 @@
  */
 
 
-static struct pci_device_id via_pci_tbl[] __initdata = {
+static struct pci_device_id via_pci_tbl[] = {
 	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8233_5,
diff -Nru a/sound/oss/ymfpci.c b/sound/oss/ymfpci.c
--- a/sound/oss/ymfpci.c	Fri Aug  1 12:19:19 2003
+++ b/sound/oss/ymfpci.c	Fri Aug  1 12:19:19 2003
@@ -105,7 +105,7 @@
  *  constants
  */
 
-static struct pci_device_id ymf_id_tbl[] __devinitdata = {
+static struct pci_device_id ymf_id_tbl[] = {
 #define DEV(v, d, data) \
   { PCI_VENDOR_ID_##v, PCI_DEVICE_ID_##v##_##d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (unsigned long)data }
 	DEV (YAMAHA, 724,  "YMF724"),
diff -Nru a/sound/pci/ali5451/ali5451.c b/sound/pci/ali5451/ali5451.c
--- a/sound/pci/ali5451/ali5451.c	Fri Aug  1 12:19:19 2003
+++ b/sound/pci/ali5451/ali5451.c	Fri Aug  1 12:19:19 2003
@@ -277,7 +277,7 @@
 #endif
 };
 
-static struct pci_device_id snd_ali_ids[] __devinitdata = {
+static struct pci_device_id snd_ali_ids[] = {
 	{0x10b9, 0x5451, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
 	{0, }
 };
diff -Nru a/sound/pci/als4000.c b/sound/pci/als4000.c
--- a/sound/pci/als4000.c	Fri Aug  1 12:19:19 2003
+++ b/sound/pci/als4000.c	Fri Aug  1 12:19:19 2003
@@ -107,7 +107,7 @@
 	unsigned long gcr;
 } snd_card_als4000_t;
 
-static struct pci_device_id snd_als4000_ids[] __devinitdata = {
+static struct pci_device_id snd_als4000_ids[] = {
 	{ 0x4005, 0x4000, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },   /* ALS4000 */
 	{ 0, }
 };
diff -Nru a/sound/pci/azt3328.c b/sound/pci/azt3328.c
--- a/sound/pci/azt3328.c	Fri Aug  1 12:19:19 2003
+++ b/sound/pci/azt3328.c	Fri Aug  1 12:19:19 2003
@@ -205,7 +205,7 @@
 	spinlock_t reg_lock;
 };
 
-static struct pci_device_id snd_azf3328_ids[] __devinitdata = {
+static struct pci_device_id snd_azf3328_ids[] = {
 	{ 0x122D, 0x50DC, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },   /* PCI168/3328 */
 	{ 0x122D, 0x80DA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },   /* 3328 */
 	{ 0, }
diff -Nru a/sound/pci/cmipci.c b/sound/pci/cmipci.c
--- a/sound/pci/cmipci.c	Fri Aug  1 12:19:19 2003
+++ b/sound/pci/cmipci.c	Fri Aug  1 12:19:19 2003
@@ -2819,7 +2819,7 @@
 }
 
 
-static struct pci_device_id snd_cmipci_ids[] __devinitdata = {
+static struct pci_device_id snd_cmipci_ids[] = {
 	{PCI_VENDOR_ID_CMEDIA, PCI_DEVICE_ID_CMEDIA_CM8338A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{PCI_VENDOR_ID_CMEDIA, PCI_DEVICE_ID_CMEDIA_CM8338B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{PCI_VENDOR_ID_CMEDIA, PCI_DEVICE_ID_CMEDIA_CM8738, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
diff -Nru a/sound/pci/cs4281.c b/sound/pci/cs4281.c
--- a/sound/pci/cs4281.c	Fri Aug  1 12:19:19 2003
+++ b/sound/pci/cs4281.c	Fri Aug  1 12:19:19 2003
@@ -513,7 +513,7 @@
 
 static irqreturn_t snd_cs4281_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 
-static struct pci_device_id snd_cs4281_ids[] __devinitdata = {
+static struct pci_device_id snd_cs4281_ids[] = {
 	{ 0x1013, 0x6005, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },	/* CS4281 */
 	{ 0, }
 };
diff -Nru a/sound/pci/cs46xx/cs46xx.c b/sound/pci/cs46xx/cs46xx.c
--- a/sound/pci/cs46xx/cs46xx.c	Fri Aug  1 12:19:19 2003
+++ b/sound/pci/cs46xx/cs46xx.c	Fri Aug  1 12:19:19 2003
@@ -72,7 +72,7 @@
 MODULE_PARM_DESC(mmap_valid, "Support OSS mmap.");
 MODULE_PARM_SYNTAX(mmap_valid, SNDRV_ENABLED "," SNDRV_BOOLEAN_FALSE_DESC);
 
-static struct pci_device_id snd_cs46xx_ids[] __devinitdata = {
+static struct pci_device_id snd_cs46xx_ids[] = {
         { 0x1013, 0x6001, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },   /* CS4280 */
         { 0x1013, 0x6003, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },   /* CS4612 */
         { 0x1013, 0x6004, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },   /* CS4615 */
diff -Nru a/sound/pci/emu10k1/emu10k1.c b/sound/pci/emu10k1/emu10k1.c
--- a/sound/pci/emu10k1/emu10k1.c	Fri Aug  1 12:19:18 2003
+++ b/sound/pci/emu10k1/emu10k1.c	Fri Aug  1 12:19:18 2003
@@ -78,7 +78,7 @@
 MODULE_PARM_DESC(enable_ir, "Enable IR.");
 MODULE_PARM_SYNTAX(enable_ir, SNDRV_ENABLE_DESC);
 
-static struct pci_device_id snd_emu10k1_ids[] __devinitdata = {
+static struct pci_device_id snd_emu10k1_ids[] = {
 	{ 0x1102, 0x0002, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },	/* EMU10K1 */
 	{ 0x1102, 0x0006, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },	/* Dell OEM version (EMU10K1) */
 	{ 0x1102, 0x0004, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1 },	/* Audigy */
diff -Nru a/sound/pci/ens1370.c b/sound/pci/ens1370.c
--- a/sound/pci/ens1370.c	Fri Aug  1 12:19:19 2003
+++ b/sound/pci/ens1370.c	Fri Aug  1 12:19:19 2003
@@ -417,7 +417,7 @@
 
 static irqreturn_t snd_audiopci_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 
-static struct pci_device_id snd_audiopci_ids[] __devinitdata = {
+static struct pci_device_id snd_audiopci_ids[] = {
 #ifdef CHIP1370
 	{ 0x1274, 0x5000, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },	/* ES1370 */
 #endif
diff -Nru a/sound/pci/es1938.c b/sound/pci/es1938.c
--- a/sound/pci/es1938.c	Fri Aug  1 12:19:19 2003
+++ b/sound/pci/es1938.c	Fri Aug  1 12:19:19 2003
@@ -251,7 +251,7 @@
 
 static irqreturn_t snd_es1938_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 
-static struct pci_device_id snd_es1938_ids[] __devinitdata = {
+static struct pci_device_id snd_es1938_ids[] = {
         { 0x125d, 0x1969, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },   /* Solo-1 */
 	{ 0, }
 };
diff -Nru a/sound/pci/es1968.c b/sound/pci/es1968.c
--- a/sound/pci/es1968.c	Fri Aug  1 12:19:19 2003
+++ b/sound/pci/es1968.c	Fri Aug  1 12:19:19 2003
@@ -602,7 +602,7 @@
 
 static irqreturn_t snd_es1968_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 
-static struct pci_device_id snd_es1968_ids[] __devinitdata = {
+static struct pci_device_id snd_es1968_ids[] = {
 	/* Maestro 1 */
         { 0x1285, 0x0100, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_MULTIMEDIA_AUDIO << 8, 0xffff00, TYPE_MAESTRO },
 	/* Maestro 2 */
diff -Nru a/sound/pci/fm801.c b/sound/pci/fm801.c
--- a/sound/pci/fm801.c	Fri Aug  1 12:19:19 2003
+++ b/sound/pci/fm801.c	Fri Aug  1 12:19:19 2003
@@ -163,7 +163,7 @@
 	snd_info_entry_t *proc_entry;
 };
 
-static struct pci_device_id snd_fm801_ids[] __devinitdata = {
+static struct pci_device_id snd_fm801_ids[] = {
 	{ 0x1319, 0x0801, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_MULTIMEDIA_AUDIO << 8, 0xffff00, 0, },   /* FM801 */
 	{ 0, }
 };
diff -Nru a/sound/pci/ice1712/ice1712.c b/sound/pci/ice1712/ice1712.c
--- a/sound/pci/ice1712/ice1712.c	Fri Aug  1 12:19:19 2003
+++ b/sound/pci/ice1712/ice1712.c	Fri Aug  1 12:19:19 2003
@@ -103,7 +103,7 @@
 #define PCI_DEVICE_ID_ICE_1712		0x1712
 #endif
 
-static struct pci_device_id snd_ice1712_ids[] __devinitdata = {
+static struct pci_device_id snd_ice1712_ids[] = {
 	{ PCI_VENDOR_ID_ICE, PCI_DEVICE_ID_ICE_1712, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },   /* ICE1712 */
 	{ 0, }
 };
diff -Nru a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
--- a/sound/pci/ice1712/ice1724.c	Fri Aug  1 12:19:19 2003
+++ b/sound/pci/ice1712/ice1724.c	Fri Aug  1 12:19:19 2003
@@ -77,7 +77,7 @@
 #define PCI_DEVICE_ID_VT1724		0x1724
 #endif
 
-static struct pci_device_id snd_vt1724_ids[] __devinitdata = {
+static struct pci_device_id snd_vt1724_ids[] = {
 	{ PCI_VENDOR_ID_ICE, PCI_DEVICE_ID_VT1724, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0, }
 };
diff -Nru a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
--- a/sound/pci/intel8x0.c	Fri Aug  1 12:19:19 2003
+++ b/sound/pci/intel8x0.c	Fri Aug  1 12:19:19 2003
@@ -395,7 +395,7 @@
 #endif
 };
 
-static struct pci_device_id snd_intel8x0_ids[] __devinitdata = {
+static struct pci_device_id snd_intel8x0_ids[] = {
 	{ 0x8086, 0x2415, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL },	/* 82801AA */
 	{ 0x8086, 0x2425, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL },	/* 82901AB */
 	{ 0x8086, 0x2445, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL },	/* 82801BA */
@@ -2479,7 +2479,7 @@
 	return 0;
 }
 
-static struct pci_device_id snd_intel8x0_joystick_ids[] __devinitdata = {
+static struct pci_device_id snd_intel8x0_joystick_ids[] = {
 	{ 0x8086, 0x2410, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },	/* 82801AA */
 	{ 0x8086, 0x2420, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },	/* 82901AB */
 	{ 0x8086, 0x2440, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* ICH2 */
diff -Nru a/sound/pci/korg1212/korg1212.c b/sound/pci/korg1212/korg1212.c
--- a/sound/pci/korg1212/korg1212.c	Fri Aug  1 12:19:18 2003
+++ b/sound/pci/korg1212/korg1212.c	Fri Aug  1 12:19:18 2003
@@ -423,7 +423,7 @@
 MODULE_PARM_SYNTAX(enable, SNDRV_ENABLE_DESC);
 MODULE_AUTHOR("Haroldo Gamal <gamal@alternex.com.br>");
 
-static struct pci_device_id snd_korg1212_ids[] __devinitdata = {
+static struct pci_device_id snd_korg1212_ids[] = {
 	{
 		.vendor	   = 0x10b5,
 		.device	   = 0x906d,
diff -Nru a/sound/pci/maestro3.c b/sound/pci/maestro3.c
--- a/sound/pci/maestro3.c	Fri Aug  1 12:19:19 2003
+++ b/sound/pci/maestro3.c	Fri Aug  1 12:19:19 2003
@@ -894,7 +894,7 @@
 #define PCI_DEVICE_ID_ESS_MAESTRO3_2	0x199b
 #endif
 
-static struct pci_device_id snd_m3_ids[] __devinitdata = {
+static struct pci_device_id snd_m3_ids[] = {
 	{PCI_VENDOR_ID_ESS, PCI_DEVICE_ID_ESS_ALLEGRO_1, PCI_ANY_ID, PCI_ANY_ID,
 	 PCI_CLASS_MULTIMEDIA_AUDIO << 8, 0xffff00, 0},
 	{PCI_VENDOR_ID_ESS, PCI_DEVICE_ID_ESS_ALLEGRO, PCI_ANY_ID, PCI_ANY_ID,
diff -Nru a/sound/pci/nm256/nm256.c b/sound/pci/nm256/nm256.c
--- a/sound/pci/nm256/nm256.c	Fri Aug  1 12:19:19 2003
+++ b/sound/pci/nm256/nm256.c	Fri Aug  1 12:19:19 2003
@@ -276,7 +276,7 @@
 #endif
 
 
-static struct pci_device_id snd_nm256_ids[] __devinitdata = {
+static struct pci_device_id snd_nm256_ids[] = {
 	{PCI_VENDOR_ID_NEOMAGIC, PCI_DEVICE_ID_NEOMAGIC_NM256AV_AUDIO, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{PCI_VENDOR_ID_NEOMAGIC, PCI_DEVICE_ID_NEOMAGIC_NM256ZX_AUDIO, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{0,},
diff -Nru a/sound/pci/rme32.c b/sound/pci/rme32.c
--- a/sound/pci/rme32.c	Fri Aug  1 12:19:19 2003
+++ b/sound/pci/rme32.c	Fri Aug  1 12:19:19 2003
@@ -223,7 +223,7 @@
 	snd_kcontrol_t *spdif_ctl;
 } rme32_t;
 
-static struct pci_device_id snd_rme32_ids[] __devinitdata = {
+static struct pci_device_id snd_rme32_ids[] = {
 	{PCI_VENDOR_ID_XILINX_RME, PCI_DEVICE_ID_DIGI32,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0,},
 	{PCI_VENDOR_ID_XILINX_RME, PCI_DEVICE_ID_DIGI32_8,
diff -Nru a/sound/pci/rme96.c b/sound/pci/rme96.c
--- a/sound/pci/rme96.c	Fri Aug  1 12:19:19 2003
+++ b/sound/pci/rme96.c	Fri Aug  1 12:19:19 2003
@@ -260,7 +260,7 @@
 	snd_kcontrol_t	   *spdif_ctl;
 } rme96_t;
 
-static struct pci_device_id snd_rme96_ids[] __devinitdata = {
+static struct pci_device_id snd_rme96_ids[] = {
 	{ PCI_VENDOR_ID_XILINX, PCI_DEVICE_ID_DIGI96,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
 	{ PCI_VENDOR_ID_XILINX, PCI_DEVICE_ID_DIGI96_8,
diff -Nru a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
--- a/sound/pci/rme9652/hdsp.c	Fri Aug  1 12:19:19 2003
+++ b/sound/pci/rme9652/hdsp.c	Fri Aug  1 12:19:19 2003
@@ -437,7 +437,7 @@
 extern void snd_hammerfall_free_buffer(struct pci_dev *, void *ptr);
 #endif
 
-static struct pci_device_id snd_hdsp_ids[] __devinitdata = {
+static struct pci_device_id snd_hdsp_ids[] = {
 	{
 		.vendor = PCI_VENDOR_ID_XILINX,
 		.device = PCI_DEVICE_ID_XILINX_HAMMERFALL_DSP, 
diff -Nru a/sound/pci/rme9652/rme9652.c b/sound/pci/rme9652/rme9652.c
--- a/sound/pci/rme9652/rme9652.c	Fri Aug  1 12:19:19 2003
+++ b/sound/pci/rme9652/rme9652.c	Fri Aug  1 12:19:19 2003
@@ -313,7 +313,7 @@
 extern void snd_hammerfall_free_buffer(struct pci_dev *, void *ptr);
 #endif
 
-static struct pci_device_id snd_rme9652_ids[] __devinitdata = {
+static struct pci_device_id snd_rme9652_ids[] = {
 	{
 		.vendor	   = 0x10ee,
 		.device	   = 0x3fc4,
diff -Nru a/sound/pci/sonicvibes.c b/sound/pci/sonicvibes.c
--- a/sound/pci/sonicvibes.c	Fri Aug  1 12:19:19 2003
+++ b/sound/pci/sonicvibes.c	Fri Aug  1 12:19:19 2003
@@ -259,7 +259,7 @@
 #endif
 };
 
-static struct pci_device_id snd_sonic_ids[] __devinitdata = {
+static struct pci_device_id snd_sonic_ids[] = {
 	{ 0x5333, 0xca00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
         { 0, }
 };
diff -Nru a/sound/pci/trident/trident.c b/sound/pci/trident/trident.c
--- a/sound/pci/trident/trident.c	Fri Aug  1 12:19:18 2003
+++ b/sound/pci/trident/trident.c	Fri Aug  1 12:19:18 2003
@@ -69,7 +69,7 @@
 MODULE_PARM_DESC(wavetable_size, "Maximum memory size in kB for wavetable synth.");
 MODULE_PARM_SYNTAX(wavetable_size, SNDRV_ENABLED ",default:8192,skill:advanced");
 
-static struct pci_device_id snd_trident_ids[] __devinitdata = {
+static struct pci_device_id snd_trident_ids[] = {
 	{ 0x1023, 0x2000, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },	/* Trident 4DWave DX PCI Audio */
 	{ 0x1023, 0x2001, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },	/* Trident 4DWave NX PCI Audio */
 	{ 0x1039, 0x7018, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },	/* SiS SI7018 PCI Audio */
diff -Nru a/sound/pci/via82xx.c b/sound/pci/via82xx.c
--- a/sound/pci/via82xx.c	Fri Aug  1 12:19:19 2003
+++ b/sound/pci/via82xx.c	Fri Aug  1 12:19:19 2003
@@ -452,7 +452,7 @@
 	snd_info_entry_t *proc_entry;
 };
 
-static struct pci_device_id snd_via82xx_ids[] __devinitdata = {
+static struct pci_device_id snd_via82xx_ids[] = {
 	{ 0x1106, 0x3058, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_CARD_VIA686, },	/* 686A */
 	{ 0x1106, 0x3059, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_CARD_VIA8233, },	/* VT8233 */
 	{ 0, }
diff -Nru a/sound/pci/vx222/vx222.c b/sound/pci/vx222/vx222.c
--- a/sound/pci/vx222/vx222.c	Fri Aug  1 12:19:19 2003
+++ b/sound/pci/vx222/vx222.c	Fri Aug  1 12:19:19 2003
@@ -68,7 +68,7 @@
 	VX_PCI_VX222_NEW
 };
 
-static struct pci_device_id snd_vx222_ids[] __devinitdata = {
+static struct pci_device_id snd_vx222_ids[] = {
 	{ 0x10b5, 0x9050, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VX_PCI_VX222_OLD, },   /* PLX */
 	{ 0x10b5, 0x9030, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VX_PCI_VX222_NEW, },   /* PLX */
 	{ 0, }
diff -Nru a/sound/pci/ymfpci/ymfpci.c b/sound/pci/ymfpci/ymfpci.c
--- a/sound/pci/ymfpci/ymfpci.c	Fri Aug  1 12:19:19 2003
+++ b/sound/pci/ymfpci/ymfpci.c	Fri Aug  1 12:19:19 2003
@@ -67,7 +67,7 @@
 MODULE_PARM_DESC(rear_switch, "Enable shared rear/line-in switch");
 MODULE_PARM_SYNTAX(rear_switch, SNDRV_ENABLED "," SNDRV_BOOLEAN_FALSE_DESC);
 
-static struct pci_device_id snd_ymfpci_ids[] __devinitdata = {
+static struct pci_device_id snd_ymfpci_ids[] = {
         { 0x1073, 0x0004, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },   /* YMF724 */
         { 0x1073, 0x000d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },   /* YMF724F */
         { 0x1073, 0x000a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },   /* YMF740 */

