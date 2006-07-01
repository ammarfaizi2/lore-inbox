Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932626AbWGAPCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626AbWGAPCD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbWGAPCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 11:02:00 -0400
Received: from www.osadl.org ([213.239.205.134]:14245 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751863AbWGAO5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:57:43 -0400
Message-Id: <20060701145228.252011000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:55:10 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, perex@suse.cz
Subject: [RFC][patch 43/44] sound: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-sound.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 include/sound/initval.h             |    2 +-
 sound/arm/aaci.c                    |    2 +-
 sound/drivers/mpu401/mpu401.c       |    2 +-
 sound/drivers/mtpav.c               |    2 +-
 sound/drivers/serial-u16550.c       |    2 +-
 sound/isa/ad1816a/ad1816a.c         |    2 +-
 sound/isa/ad1816a/ad1816a_lib.c     |    2 +-
 sound/isa/ad1848/ad1848_lib.c       |    2 +-
 sound/isa/als100.c                  |    2 +-
 sound/isa/azt2320.c                 |    2 +-
 sound/isa/cs423x/cs4231.c           |    2 +-
 sound/isa/cs423x/cs4231_lib.c       |    2 +-
 sound/isa/cs423x/cs4236.c           |    2 +-
 sound/isa/dt019x.c                  |    2 +-
 sound/isa/es1688/es1688.c           |    2 +-
 sound/isa/es1688/es1688_lib.c       |    2 +-
 sound/isa/es18xx.c                  |    2 +-
 sound/isa/gus/gus_main.c            |    2 +-
 sound/isa/gus/gusextreme.c          |    2 +-
 sound/isa/gus/gusmax.c              |    2 +-
 sound/isa/gus/interwave.c           |    2 +-
 sound/isa/opl3sa2.c                 |    2 +-
 sound/isa/opti9xx/miro.c            |    2 +-
 sound/isa/opti9xx/opti92x-ad1848.c  |    4 ++--
 sound/isa/sb/sb_common.c            |    2 +-
 sound/isa/sgalaxy.c                 |    2 +-
 sound/isa/sscape.c                  |    2 +-
 sound/isa/wavefront/wavefront.c     |    4 ++--
 sound/mips/au1x00.c                 |    4 ++--
 sound/oss/ad1889.c                  |    2 +-
 sound/oss/ali5455.c                 |    2 +-
 sound/oss/au1000.c                  |    4 ++--
 sound/oss/btaudio.c                 |    2 +-
 sound/oss/cmpci.c                   |    2 +-
 sound/oss/cs4281/cs4281m.c          |    2 +-
 sound/oss/cs46xx.c                  |    2 +-
 sound/oss/emu10k1/main.c            |    2 +-
 sound/oss/es1370.c                  |    2 +-
 sound/oss/es1371.c                  |    2 +-
 sound/oss/esssolo1.c                |    2 +-
 sound/oss/forte.c                   |    2 +-
 sound/oss/hal2.c                    |    2 +-
 sound/oss/i810_audio.c              |    2 +-
 sound/oss/ite8172.c                 |    2 +-
 sound/oss/maestro.c                 |    2 +-
 sound/oss/maestro3.c                |    2 +-
 sound/oss/nec_vrc5477.c             |    2 +-
 sound/oss/nm256_audio.c             |    2 +-
 sound/oss/rme96xx.c                 |    2 +-
 sound/oss/sb_common.c               |    2 +-
 sound/oss/sh_dac_audio.c            |    2 +-
 sound/oss/sonicvibes.c              |    2 +-
 sound/oss/trident.c                 |    2 +-
 sound/oss/via82cxxx_audio.c         |    4 ++--
 sound/oss/wavfront.c                |    2 +-
 sound/oss/wf_midi.c                 |    2 +-
 sound/oss/ymfpci.c                  |    2 +-
 sound/pci/ad1889.c                  |    2 +-
 sound/pci/ali5451/ali5451.c         |    2 +-
 sound/pci/als300.c                  |    2 +-
 sound/pci/atiixp.c                  |    2 +-
 sound/pci/atiixp_modem.c            |    2 +-
 sound/pci/au88x0/au88x0.c           |    2 +-
 sound/pci/azt3328.c                 |    2 +-
 sound/pci/bt87x.c                   |    2 +-
 sound/pci/ca0106/ca0106_main.c      |    2 +-
 sound/pci/cmipci.c                  |    2 +-
 sound/pci/cs4281.c                  |    2 +-
 sound/pci/cs46xx/cs46xx_lib.c       |    2 +-
 sound/pci/cs5535audio/cs5535audio.c |    2 +-
 sound/pci/echoaudio/echoaudio.c     |    2 +-
 sound/pci/emu10k1/emu10k1_main.c    |    2 +-
 sound/pci/emu10k1/emu10k1x.c        |    2 +-
 sound/pci/ens1370.c                 |    2 +-
 sound/pci/es1938.c                  |    4 ++--
 sound/pci/es1968.c                  |    2 +-
 sound/pci/fm801.c                   |    2 +-
 sound/pci/hda/hda_intel.c           |    2 +-
 sound/pci/ice1712/ice1712.c         |    2 +-
 sound/pci/ice1712/ice1724.c         |    2 +-
 sound/pci/intel8x0.c                |    4 ++--
 sound/pci/intel8x0m.c               |    2 +-
 sound/pci/korg1212/korg1212.c       |    2 +-
 sound/pci/maestro3.c                |    2 +-
 sound/pci/mixart/mixart.c           |    2 +-
 sound/pci/nm256/nm256.c             |    2 +-
 sound/pci/pcxhr/pcxhr.c             |    2 +-
 sound/pci/riptide/riptide.c         |    2 +-
 sound/pci/rme32.c                   |    2 +-
 sound/pci/rme96.c                   |    2 +-
 sound/pci/rme9652/hdsp.c            |    2 +-
 sound/pci/rme9652/hdspm.c           |    2 +-
 sound/pci/rme9652/rme9652.c         |    2 +-
 sound/pci/sonicvibes.c              |    2 +-
 sound/pci/trident/trident_main.c    |    2 +-
 sound/pci/via82xx.c                 |    2 +-
 sound/pci/via82xx_modem.c           |    2 +-
 sound/pci/vx222/vx222.c             |    2 +-
 sound/pci/ymfpci/ymfpci_main.c      |    2 +-
 sound/sparc/amd7930.c               |    2 +-
 sound/sparc/cs4231.c                |    2 +-
 sound/sparc/dbri.c                  |    2 +-
 102 files changed, 109 insertions(+), 109 deletions(-)

Index: linux-2.6.git/include/sound/initval.h
===================================================================
--- linux-2.6.git.orig/include/sound/initval.h	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/include/sound/initval.h	2006-07-01 16:51:50.000000000 +0200
@@ -62,7 +62,7 @@ static int snd_legacy_find_free_irq(int 
 {
 	while (*irq_table != -1) {
 		if (!request_irq(*irq_table, snd_legacy_empty_irq_handler,
-				 SA_INTERRUPT | SA_PROBEIRQ, "ALSA Test IRQ",
+				 IRQF_DISABLED | IRQF_PROBE_SHARED, "ALSA Test IRQ",
 				 (void *) irq_table)) {
 			free_irq(*irq_table, (void *) irq_table);
 			return *irq_table;
Index: linux-2.6.git/sound/arm/aaci.c
===================================================================
--- linux-2.6.git.orig/sound/arm/aaci.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/arm/aaci.c	2006-07-01 16:51:50.000000000 +0200
@@ -360,7 +360,7 @@ static int aaci_pcm_open(struct aaci *aa
 	if (ret)
 		goto out;
 
-	ret = request_irq(aaci->dev->irq[0], aaci_irq, SA_SHIRQ|SA_INTERRUPT,
+	ret = request_irq(aaci->dev->irq[0], aaci_irq, IRQF_SHARED|IRQF_DISABLED,
 			  DRIVER_NAME, aaci);
 	if (ret)
 		goto out;
Index: linux-2.6.git/sound/drivers/mtpav.c
===================================================================
--- linux-2.6.git.orig/sound/drivers/mtpav.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/drivers/mtpav.c	2006-07-01 16:51:50.000000000 +0200
@@ -590,7 +590,7 @@ static int __init snd_mtpav_get_ISA(stru
 		return -EBUSY;
 	}
 	mcard->port = port;
-	if (request_irq(irq, snd_mtpav_irqh, SA_INTERRUPT, "MOTU MTPAV", mcard)) {
+	if (request_irq(irq, snd_mtpav_irqh, IRQF_DISABLED, "MOTU MTPAV", mcard)) {
 		snd_printk("MTVAP IRQ %d busy\n", irq);
 		return -EBUSY;
 	}
Index: linux-2.6.git/sound/drivers/serial-u16550.c
===================================================================
--- linux-2.6.git.orig/sound/drivers/serial-u16550.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/drivers/serial-u16550.c	2006-07-01 16:51:50.000000000 +0200
@@ -795,7 +795,7 @@ static int __init snd_uart16550_create(s
 
 	if (irq >= 0 && irq != SNDRV_AUTO_IRQ) {
 		if (request_irq(irq, snd_uart16550_interrupt,
-				SA_INTERRUPT, "Serial MIDI", (void *) uart)) {
+				IRQF_DISABLED, "Serial MIDI", (void *) uart)) {
 			snd_printk("irq %d busy. Using Polling.\n", irq);
 		} else {
 			uart->irq = irq;
Index: linux-2.6.git/sound/drivers/mpu401/mpu401.c
===================================================================
--- linux-2.6.git.orig/sound/drivers/mpu401/mpu401.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/drivers/mpu401/mpu401.c	2006-07-01 16:51:50.000000000 +0200
@@ -83,7 +83,7 @@ static int snd_mpu401_create(int dev, st
 	if ((err = snd_mpu401_uart_new(card, 0,
 				       MPU401_HW_MPU401,
 				       port[dev], 0,
-				       irq[dev], irq[dev] >= 0 ? SA_INTERRUPT : 0, NULL)) < 0) {
+				       irq[dev], irq[dev] >= 0 ? IRQF_DISABLED : 0, NULL)) < 0) {
 		printk(KERN_ERR "MPU401 not detected at 0x%lx\n", port[dev]);
 		goto _err;
 	}
Index: linux-2.6.git/sound/isa/als100.c
===================================================================
--- linux-2.6.git.orig/sound/isa/als100.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/isa/als100.c	2006-07-01 16:51:50.000000000 +0200
@@ -250,7 +250,7 @@ static int __devinit snd_card_als100_pro
 	if (mpu_port[dev] > 0 && mpu_port[dev] != SNDRV_AUTO_PORT) {
 		if (snd_mpu401_uart_new(card, 0, MPU401_HW_ALS100,
 					mpu_port[dev], 0, 
-					mpu_irq[dev], SA_INTERRUPT,
+					mpu_irq[dev], IRQF_DISABLED,
 					NULL) < 0)
 			snd_printk(KERN_ERR PFX "no MPU-401 device at 0x%lx\n", mpu_port[dev]);
 	}
Index: linux-2.6.git/sound/isa/azt2320.c
===================================================================
--- linux-2.6.git.orig/sound/isa/azt2320.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/isa/azt2320.c	2006-07-01 16:51:50.000000000 +0200
@@ -279,7 +279,7 @@ static int __devinit snd_card_azt2320_pr
 	if (mpu_port[dev] > 0 && mpu_port[dev] != SNDRV_AUTO_PORT) {
 		if (snd_mpu401_uart_new(card, 0, MPU401_HW_AZT2320,
 				mpu_port[dev], 0,
-				mpu_irq[dev], SA_INTERRUPT,
+				mpu_irq[dev], IRQF_DISABLED,
 				NULL) < 0)
 			snd_printk(KERN_ERR PFX "no MPU-401 device at 0x%lx\n", mpu_port[dev]);
 	}
Index: linux-2.6.git/sound/isa/dt019x.c
===================================================================
--- linux-2.6.git.orig/sound/isa/dt019x.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/isa/dt019x.c	2006-07-01 16:51:50.000000000 +0200
@@ -240,7 +240,7 @@ static int __devinit snd_card_dt019x_pro
 					MPU401_HW_MPU401,
 					mpu_port[dev], 0,
 					mpu_irq[dev],
-					mpu_irq[dev] >= 0 ? SA_INTERRUPT : 0,
+					mpu_irq[dev] >= 0 ? IRQF_DISABLED : 0,
 					NULL) < 0)
 			snd_printk(KERN_ERR PFX "no MPU-401 device at 0x%lx ?\n", mpu_port[dev]);
 	}
Index: linux-2.6.git/sound/isa/es18xx.c
===================================================================
--- linux-2.6.git.orig/sound/isa/es18xx.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/isa/es18xx.c	2006-07-01 16:51:50.000000000 +0200
@@ -1837,7 +1837,7 @@ static int __devinit snd_es18xx_new_devi
 		return -EBUSY;
 	}
 
-	if (request_irq(irq, snd_es18xx_interrupt, SA_INTERRUPT, "ES18xx", (void *) chip)) {
+	if (request_irq(irq, snd_es18xx_interrupt, IRQF_DISABLED, "ES18xx", (void *) chip)) {
 		snd_es18xx_free(chip);
 		snd_printk(KERN_ERR PFX "unable to grap IRQ %d\n", irq);
 		return -EBUSY;
Index: linux-2.6.git/sound/isa/opl3sa2.c
===================================================================
--- linux-2.6.git.orig/sound/isa/opl3sa2.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/isa/opl3sa2.c	2006-07-01 16:51:50.000000000 +0200
@@ -683,7 +683,7 @@ static int __devinit snd_opl3sa2_probe(s
 		chip->single_dma = 1;
 	if ((err = snd_opl3sa2_detect(chip)) < 0)
 		return err;
-	if (request_irq(xirq, snd_opl3sa2_interrupt, SA_INTERRUPT, "OPL3-SA2", chip)) {
+	if (request_irq(xirq, snd_opl3sa2_interrupt, IRQF_DISABLED, "OPL3-SA2", chip)) {
 		snd_printk(KERN_ERR PFX "can't grab IRQ %d\n", xirq);
 		return -ENODEV;
 	}
Index: linux-2.6.git/sound/isa/sgalaxy.c
===================================================================
--- linux-2.6.git.orig/sound/isa/sgalaxy.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/isa/sgalaxy.c	2006-07-01 16:51:50.000000000 +0200
@@ -147,7 +147,7 @@ static int __init snd_sgalaxy_setup_wss(
         if (tmp < 0)
                 return -EINVAL;
 
-	if (request_irq(irq, snd_sgalaxy_dummy_interrupt, SA_INTERRUPT, "sgalaxy", NULL)) {
+	if (request_irq(irq, snd_sgalaxy_dummy_interrupt, IRQF_DISABLED, "sgalaxy", NULL)) {
 		snd_printk(KERN_ERR "sgalaxy: can't grab irq %d\n", irq);
 		return -EIO;
 	}
Index: linux-2.6.git/sound/isa/sscape.c
===================================================================
--- linux-2.6.git.orig/sound/isa/sscape.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/isa/sscape.c	2006-07-01 16:51:50.000000000 +0200
@@ -900,7 +900,7 @@ static int __devinit create_mpu401(struc
 	if ((err = snd_mpu401_uart_new(card, devnum,
 	                               MPU401_HW_MPU401,
 	                               port, MPU401_INFO_INTEGRATED,
-	                               irq, SA_INTERRUPT,
+	                               irq, IRQF_DISABLED,
 	                               &rawmidi)) == 0) {
 		struct snd_mpu401 *mpu = (struct snd_mpu401 *) rawmidi->private_data;
 		mpu->open_input = mpu401_open;
Index: linux-2.6.git/sound/isa/ad1816a/ad1816a.c
===================================================================
--- linux-2.6.git.orig/sound/isa/ad1816a/ad1816a.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/isa/ad1816a/ad1816a.c	2006-07-01 16:51:50.000000000 +0200
@@ -232,7 +232,7 @@ static int __devinit snd_card_ad1816a_pr
 
 	if (mpu_port[dev] > 0) {
 		if (snd_mpu401_uart_new(card, 0, MPU401_HW_MPU401,
-					mpu_port[dev], 0, mpu_irq[dev], SA_INTERRUPT,
+					mpu_port[dev], 0, mpu_irq[dev], IRQF_DISABLED,
 					NULL) < 0)
 			printk(KERN_ERR PFX "no MPU-401 device at 0x%lx.\n", mpu_port[dev]);
 	}
Index: linux-2.6.git/sound/isa/ad1816a/ad1816a_lib.c
===================================================================
--- linux-2.6.git.orig/sound/isa/ad1816a/ad1816a_lib.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/isa/ad1816a/ad1816a_lib.c	2006-07-01 16:51:50.000000000 +0200
@@ -599,7 +599,7 @@ int __devinit snd_ad1816a_create(struct 
 		snd_ad1816a_free(chip);
 		return -EBUSY;
 	}
-	if (request_irq(irq, snd_ad1816a_interrupt, SA_INTERRUPT, "AD1816A", (void *) chip)) {
+	if (request_irq(irq, snd_ad1816a_interrupt, IRQF_DISABLED, "AD1816A", (void *) chip)) {
 		snd_printk(KERN_ERR "ad1816a: can't grab IRQ %d\n", irq);
 		snd_ad1816a_free(chip);
 		return -EBUSY;
Index: linux-2.6.git/sound/isa/ad1848/ad1848_lib.c
===================================================================
--- linux-2.6.git.orig/sound/isa/ad1848/ad1848_lib.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/isa/ad1848/ad1848_lib.c	2006-07-01 16:51:50.000000000 +0200
@@ -902,7 +902,7 @@ int snd_ad1848_create(struct snd_card *c
 		snd_ad1848_free(chip);
 		return -EBUSY;
 	}
-	if (request_irq(irq, snd_ad1848_interrupt, SA_INTERRUPT, "AD1848", (void *) chip)) {
+	if (request_irq(irq, snd_ad1848_interrupt, IRQF_DISABLED, "AD1848", (void *) chip)) {
 		snd_printk(KERN_ERR "ad1848: can't grab IRQ %d\n", irq);
 		snd_ad1848_free(chip);
 		return -EBUSY;
Index: linux-2.6.git/sound/isa/cs423x/cs4231.c
===================================================================
--- linux-2.6.git.orig/sound/isa/cs423x/cs4231.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/isa/cs423x/cs4231.c	2006-07-01 16:51:50.000000000 +0200
@@ -122,7 +122,7 @@ static int __init snd_cs4231_probe(struc
 		if (snd_mpu401_uart_new(card, 0, MPU401_HW_CS4232,
 					mpu_port[dev], 0,
 					mpu_irq[dev],
-					mpu_irq[dev] >= 0 ? SA_INTERRUPT : 0,
+					mpu_irq[dev] >= 0 ? IRQF_DISABLED : 0,
 					NULL) < 0)
 			printk(KERN_WARNING "cs4231: MPU401 not detected\n");
 	}
Index: linux-2.6.git/sound/isa/cs423x/cs4231_lib.c
===================================================================
--- linux-2.6.git.orig/sound/isa/cs423x/cs4231_lib.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/isa/cs423x/cs4231_lib.c	2006-07-01 16:51:50.000000000 +0200
@@ -1454,7 +1454,7 @@ int snd_cs4231_create(struct snd_card *c
 		return -ENODEV;
 	}
 	chip->cport = cport;
-	if (!(hwshare & CS4231_HWSHARE_IRQ) && request_irq(irq, snd_cs4231_interrupt, SA_INTERRUPT, "CS4231", (void *) chip)) {
+	if (!(hwshare & CS4231_HWSHARE_IRQ) && request_irq(irq, snd_cs4231_interrupt, IRQF_DISABLED, "CS4231", (void *) chip)) {
 		snd_printk(KERN_ERR "cs4231: can't grab IRQ %d\n", irq);
 		snd_cs4231_free(chip);
 		return -EBUSY;
Index: linux-2.6.git/sound/isa/cs423x/cs4236.c
===================================================================
--- linux-2.6.git.orig/sound/isa/cs423x/cs4236.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/isa/cs423x/cs4236.c	2006-07-01 16:51:50.000000000 +0200
@@ -535,7 +535,7 @@ static int __devinit snd_cs423x_probe(st
 		if (snd_mpu401_uart_new(card, 0, MPU401_HW_CS4232,
 					mpu_port[dev], 0,
 					mpu_irq[dev],
-					mpu_irq[dev] >= 0 ? SA_INTERRUPT : 0, NULL) < 0)
+					mpu_irq[dev] >= 0 ? IRQF_DISABLED : 0, NULL) < 0)
 			printk(KERN_WARNING IDENT ": MPU401 not detected\n");
 	}
 
Index: linux-2.6.git/sound/isa/es1688/es1688.c
===================================================================
--- linux-2.6.git.orig/sound/isa/es1688/es1688.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/isa/es1688/es1688.c	2006-07-01 16:51:50.000000000 +0200
@@ -153,7 +153,7 @@ static int __init snd_es1688_probe(struc
 		if ((err = snd_mpu401_uart_new(card, 0, MPU401_HW_ES1688,
 					       chip->mpu_port, 0,
 					       xmpu_irq,
-					       SA_INTERRUPT,
+					       IRQF_DISABLED,
 					       NULL)) < 0)
 			goto _err;
 	}
Index: linux-2.6.git/sound/isa/es1688/es1688_lib.c
===================================================================
--- linux-2.6.git.orig/sound/isa/es1688/es1688_lib.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/isa/es1688/es1688_lib.c	2006-07-01 16:51:50.000000000 +0200
@@ -659,7 +659,7 @@ int snd_es1688_create(struct snd_card *c
 		snd_es1688_free(chip);
 		return -EBUSY;
 	}
-	if (request_irq(irq, snd_es1688_interrupt, SA_INTERRUPT, "ES1688", (void *) chip)) {
+	if (request_irq(irq, snd_es1688_interrupt, IRQF_DISABLED, "ES1688", (void *) chip)) {
 		snd_printk(KERN_ERR "es1688: can't grab IRQ %d\n", irq);
 		snd_es1688_free(chip);
 		return -EBUSY;
Index: linux-2.6.git/sound/isa/gus/gusextreme.c
===================================================================
--- linux-2.6.git.orig/sound/isa/gus/gusextreme.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/isa/gus/gusextreme.c	2006-07-01 16:51:50.000000000 +0200
@@ -301,7 +301,7 @@ static int __init snd_gusextreme_probe(s
 	    (err = snd_mpu401_uart_new(card, 0, MPU401_HW_ES1688,
 					       es1688->mpu_port, 0,
 					       xmpu_irq,
-					       SA_INTERRUPT,
+					       IRQF_DISABLED,
 					       NULL)) < 0)
 		goto out;
 
Index: linux-2.6.git/sound/isa/gus/gus_main.c
===================================================================
--- linux-2.6.git.orig/sound/isa/gus/gus_main.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/isa/gus/gus_main.c	2006-07-01 16:51:50.000000000 +0200
@@ -179,7 +179,7 @@ int snd_gus_create(struct snd_card *card
 		snd_gus_free(gus);
 		return -EBUSY;
 	}
-	if (irq >= 0 && request_irq(irq, snd_gus_interrupt, SA_INTERRUPT, "GUS GF1", (void *) gus)) {
+	if (irq >= 0 && request_irq(irq, snd_gus_interrupt, IRQF_DISABLED, "GUS GF1", (void *) gus)) {
 		snd_printk(KERN_ERR "gus: can't grab irq %d\n", irq);
 		snd_gus_free(gus);
 		return -EBUSY;
Index: linux-2.6.git/sound/isa/gus/gusmax.c
===================================================================
--- linux-2.6.git.orig/sound/isa/gus/gusmax.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/isa/gus/gusmax.c	2006-07-01 16:51:50.000000000 +0200
@@ -292,7 +292,7 @@ static int __init snd_gusmax_probe(struc
 		goto _err;
 	}
 
-	if (request_irq(xirq, snd_gusmax_interrupt, SA_INTERRUPT, "GUS MAX", (void *)maxcard)) {
+	if (request_irq(xirq, snd_gusmax_interrupt, IRQF_DISABLED, "GUS MAX", (void *)maxcard)) {
 		snd_printk(KERN_ERR PFX "unable to grab IRQ %d\n", xirq);
 		err = -EBUSY;
 		goto _err;
Index: linux-2.6.git/sound/isa/gus/interwave.c
===================================================================
--- linux-2.6.git.orig/sound/isa/gus/interwave.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/isa/gus/interwave.c	2006-07-01 16:51:50.000000000 +0200
@@ -706,7 +706,7 @@ static int __devinit snd_interwave_probe
 	if ((err = snd_gus_initialize(gus)) < 0)
 		return err;
 
-	if (request_irq(xirq, snd_interwave_interrupt, SA_INTERRUPT,
+	if (request_irq(xirq, snd_interwave_interrupt, IRQF_DISABLED,
 			"InterWave", iwcard)) {
 		snd_printk(KERN_ERR PFX "unable to grab IRQ %d\n", xirq);
 		return -EBUSY;
Index: linux-2.6.git/sound/isa/opti9xx/miro.c
===================================================================
--- linux-2.6.git.orig/sound/isa/opti9xx/miro.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/isa/opti9xx/miro.c	2006-07-01 16:51:50.000000000 +0200
@@ -1382,7 +1382,7 @@ static int __init snd_miro_probe(struct 
 		rmidi = NULL;
 	else
 		if ((error = snd_mpu401_uart_new(card, 0, MPU401_HW_MPU401,
-				miro->mpu_port, 0, miro->mpu_irq, SA_INTERRUPT,
+				miro->mpu_port, 0, miro->mpu_irq, IRQF_DISABLED,
 				&rmidi)))
 			snd_printk(KERN_WARNING "no MPU-401 device at 0x%lx?\n", miro->mpu_port);
 
Index: linux-2.6.git/sound/isa/opti9xx/opti92x-ad1848.c
===================================================================
--- linux-2.6.git.orig/sound/isa/opti9xx/opti92x-ad1848.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/isa/opti9xx/opti92x-ad1848.c	2006-07-01 16:51:50.000000000 +0200
@@ -1291,7 +1291,7 @@ static int snd_opti93x_create(struct snd
 	}
 	codec->dma2 = chip->dma2;
 
-	if (request_irq(chip->irq, snd_opti93x_interrupt, SA_INTERRUPT, DRIVER_NAME" - WSS", codec)) {
+	if (request_irq(chip->irq, snd_opti93x_interrupt, IRQF_DISABLED, DRIVER_NAME" - WSS", codec)) {
 		snd_printk(KERN_ERR "opti9xx: can't grab IRQ %d\n", chip->irq);
 		snd_opti93x_free(codec);
 		return -EBUSY;
@@ -1863,7 +1863,7 @@ static int __init snd_opti9xx_probe(stru
 		rmidi = NULL;
 	else
 		if ((error = snd_mpu401_uart_new(card, 0, MPU401_HW_MPU401,
-				chip->mpu_port, 0, chip->mpu_irq, SA_INTERRUPT,
+				chip->mpu_port, 0, chip->mpu_irq, IRQF_DISABLED,
 				&rmidi)))
 			snd_printk(KERN_WARNING "no MPU-401 device at 0x%lx?\n",
 				   chip->mpu_port);
Index: linux-2.6.git/sound/isa/sb/sb_common.c
===================================================================
--- linux-2.6.git.orig/sound/isa/sb/sb_common.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/isa/sb/sb_common.c	2006-07-01 16:51:50.000000000 +0200
@@ -232,7 +232,7 @@ int snd_sbdsp_create(struct snd_card *ca
 	chip->port = port;
 	
 	if (request_irq(irq, irq_handler, hardware == SB_HW_ALS4000 ?
-			SA_INTERRUPT | SA_SHIRQ : SA_INTERRUPT,
+			IRQF_DISABLED | IRQF_SHARED : IRQF_DISABLED,
 			"SoundBlaster", (void *) chip)) {
 		snd_printk(KERN_ERR "sb: can't grab irq %d\n", irq);
 		snd_sbdsp_free(chip);
Index: linux-2.6.git/sound/isa/wavefront/wavefront.c
===================================================================
--- linux-2.6.git.orig/sound/isa/wavefront/wavefront.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/isa/wavefront/wavefront.c	2006-07-01 16:51:50.000000000 +0200
@@ -467,7 +467,7 @@ snd_wavefront_probe (struct snd_card *ca
 		return -EBUSY;
 	}
 	if (request_irq(ics2115_irq[dev], snd_wavefront_ics2115_interrupt,
-			SA_INTERRUPT, "ICS2115", acard)) {
+			IRQF_DISABLED, "ICS2115", acard)) {
 		snd_printk(KERN_ERR "unable to use ICS2115 IRQ %d\n", ics2115_irq[dev]);
 		return -EBUSY;
 	}
@@ -497,7 +497,7 @@ snd_wavefront_probe (struct snd_card *ca
 		if ((err = snd_mpu401_uart_new(card, midi_dev, MPU401_HW_CS4232,
 					       cs4232_mpu_port[dev], 0,
 					       cs4232_mpu_irq[dev],
-					       SA_INTERRUPT,
+					       IRQF_DISABLED,
 					       NULL)) < 0) {
 			snd_printk (KERN_ERR "can't allocate CS4232 MPU-401 device\n");
 			return err;
Index: linux-2.6.git/sound/mips/au1x00.c
===================================================================
--- linux-2.6.git.orig/sound/mips/au1x00.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/mips/au1x00.c	2006-07-01 16:51:50.000000000 +0200
@@ -465,13 +465,13 @@ snd_au1000_pcm_new(struct snd_au1000 *au
 
 	flags = claim_dma_lock();
 	if ((au1000->stream[PLAYBACK]->dma = request_au1000_dma(DMA_ID_AC97C_TX,
-			"AC97 TX", au1000_dma_interrupt, SA_INTERRUPT,
+			"AC97 TX", au1000_dma_interrupt, IRQF_DISABLED,
 			au1000->stream[PLAYBACK])) < 0) {
 		release_dma_lock(flags);
 		return -EBUSY;
 	}
 	if ((au1000->stream[CAPTURE]->dma = request_au1000_dma(DMA_ID_AC97C_RX,
-			"AC97 RX", au1000_dma_interrupt, SA_INTERRUPT,
+			"AC97 RX", au1000_dma_interrupt, IRQF_DISABLED,
 			au1000->stream[CAPTURE])) < 0){
 		release_dma_lock(flags);
 		return -EBUSY;
Index: linux-2.6.git/sound/oss/ad1889.c
===================================================================
--- linux-2.6.git.orig/sound/oss/ad1889.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/oss/ad1889.c	2006-07-01 16:51:50.000000000 +0200
@@ -1010,7 +1010,7 @@ static int __devinit ad1889_probe(struct
 		goto out2;
 	}
 
-	if (request_irq(pcidev->irq, ad1889_interrupt, SA_SHIRQ, DEVNAME, dev) != 0) {
+	if (request_irq(pcidev->irq, ad1889_interrupt, IRQF_SHARED, DEVNAME, dev) != 0) {
 		printk(KERN_ERR DEVNAME ": unable to request interrupt\n");
 		goto out3;
 	}
Index: linux-2.6.git/sound/oss/ali5455.c
===================================================================
--- linux-2.6.git.orig/sound/oss/ali5455.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/oss/ali5455.c	2006-07-01 16:51:50.000000000 +0200
@@ -3460,7 +3460,7 @@ static int __devinit ali_probe(struct pc
 	card->channel[4].num = 4;
 	/* claim our iospace and irq */
 	request_region(card->iobase, 256, card_names[pci_id->driver_data]);
-	if (request_irq(card->irq, &ali_interrupt, SA_SHIRQ,
+	if (request_irq(card->irq, &ali_interrupt, IRQF_SHARED,
 			card_names[pci_id->driver_data], card)) {
 		printk(KERN_ERR "ali_audio: unable to allocate irq %d\n",
 		       card->irq);
Index: linux-2.6.git/sound/oss/au1000.c
===================================================================
--- linux-2.6.git.orig/sound/oss/au1000.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/oss/au1000.c	2006-07-01 16:51:50.000000000 +0200
@@ -2015,14 +2015,14 @@ static int __devinit au1000_probe(void)
 	if ((s->dma_dac.dmanr = request_au1000_dma(DMA_ID_AC97C_TX,
 						   "audio DAC",
 						   dac_dma_interrupt,
-						   SA_INTERRUPT, s)) < 0) {
+						   IRQF_DISABLED, s)) < 0) {
 		err("Can't get DAC DMA");
 		goto err_dma1;
 	}
 	if ((s->dma_adc.dmanr = request_au1000_dma(DMA_ID_AC97C_RX,
 						   "audio ADC",
 						   adc_dma_interrupt,
-						   SA_INTERRUPT, s)) < 0) {
+						   IRQF_DISABLED, s)) < 0) {
 		err("Can't get ADC DMA");
 		goto err_dma2;
 	}
Index: linux-2.6.git/sound/oss/btaudio.c
===================================================================
--- linux-2.6.git.orig/sound/oss/btaudio.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/oss/btaudio.c	2006-07-01 16:51:50.000000000 +0200
@@ -966,7 +966,7 @@ static int __devinit btaudio_probe(struc
         btwrite(~0U, REG_INT_STAT);
 	pci_set_master(pci_dev);
 
-	if ((rc = request_irq(bta->irq, btaudio_irq, SA_SHIRQ|SA_INTERRUPT,
+	if ((rc = request_irq(bta->irq, btaudio_irq, IRQF_SHARED|IRQF_DISABLED,
 			      "btaudio",(void *)bta)) < 0) {
 		printk(KERN_WARNING
 		       "btaudio: can't request irq (rc=%d)\n",rc);
Index: linux-2.6.git/sound/oss/cmpci.c
===================================================================
--- linux-2.6.git.orig/sound/oss/cmpci.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/oss/cmpci.c	2006-07-01 16:51:50.000000000 +0200
@@ -3122,7 +3122,7 @@ static int __devinit cm_probe(struct pci
 	wrmixer(s, DSP_MIX_DATARESETIDX, 0);
 
 	/* request irq */
-	if ((ret = request_irq(s->irq, cm_interrupt, SA_SHIRQ, "cmpci", s))) {
+	if ((ret = request_irq(s->irq, cm_interrupt, IRQF_SHARED, "cmpci", s))) {
 		printk(KERN_ERR "cmpci: irq %u in use\n", s->irq);
 		goto err_irq;
 	}
Index: linux-2.6.git/sound/oss/cs46xx.c
===================================================================
--- linux-2.6.git.orig/sound/oss/cs46xx.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/oss/cs46xx.c	2006-07-01 16:51:50.000000000 +0200
@@ -5177,7 +5177,7 @@ static int __devinit cs46xx_probe(struct
 		card->ba1.name.reg == 0)
 		goto fail2;
 		
-	if (request_irq(card->irq, &cs_interrupt, SA_SHIRQ, "cs46xx", card)) {
+	if (request_irq(card->irq, &cs_interrupt, IRQF_SHARED, "cs46xx", card)) {
 		printk(KERN_ERR "cs46xx: unable to allocate irq %d\n", card->irq);
 		goto fail2;
 	}
Index: linux-2.6.git/sound/oss/es1370.c
===================================================================
--- linux-2.6.git.orig/sound/oss/es1370.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/oss/es1370.c	2006-07-01 16:51:50.000000000 +0200
@@ -2650,7 +2650,7 @@ static int __devinit es1370_probe(struct
 		ret = -EBUSY;
 		goto err_region;
 	}
-	if ((ret=request_irq(s->irq, es1370_interrupt, SA_SHIRQ, "es1370",s))) {
+	if ((ret=request_irq(s->irq, es1370_interrupt, IRQF_SHARED, "es1370",s))) {
 		printk(KERN_ERR "es1370: irq %u in use\n", s->irq);
 		goto err_irq;
 	}
Index: linux-2.6.git/sound/oss/es1371.c
===================================================================
--- linux-2.6.git.orig/sound/oss/es1371.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/oss/es1371.c	2006-07-01 16:51:50.000000000 +0200
@@ -2905,7 +2905,7 @@ static int __devinit es1371_probe(struct
 		res = -EBUSY;
 		goto err_region;
 	}
-	if ((res=request_irq(s->irq, es1371_interrupt, SA_SHIRQ, "es1371",s))) {
+	if ((res=request_irq(s->irq, es1371_interrupt, IRQF_SHARED, "es1371",s))) {
 		printk(KERN_ERR PFX "irq %u in use\n", s->irq);
 		goto err_irq;
 	}
Index: linux-2.6.git/sound/oss/esssolo1.c
===================================================================
--- linux-2.6.git.orig/sound/oss/esssolo1.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/oss/esssolo1.c	2006-07-01 16:51:50.000000000 +0200
@@ -2392,7 +2392,7 @@ static int __devinit solo1_probe(struct 
 		printk(KERN_ERR "solo1: io ports in use\n");
 		goto err_region4;
 	}
-	if ((ret=request_irq(s->irq,solo1_interrupt,SA_SHIRQ,"ESS Solo1",s))) {
+	if ((ret=request_irq(s->irq,solo1_interrupt,IRQF_SHARED,"ESS Solo1",s))) {
 		printk(KERN_ERR "solo1: irq %u in use\n", s->irq);
 		goto err_irq;
 	}
Index: linux-2.6.git/sound/oss/forte.c
===================================================================
--- linux-2.6.git.orig/sound/oss/forte.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/oss/forte.c	2006-07-01 16:51:50.000000000 +0200
@@ -2026,7 +2026,7 @@ forte_probe (struct pci_dev *pci_dev, co
 	chip->iobase = pci_resource_start (pci_dev, 0);
 	chip->irq = pci_dev->irq;
 
-	if (request_irq (chip->irq, forte_interrupt, SA_SHIRQ, DRIVER_NAME,
+	if (request_irq (chip->irq, forte_interrupt, IRQF_SHARED, DRIVER_NAME,
 			 chip)) {
 		printk (KERN_WARNING PFX "Unable to reserve IRQ");
 		ret = -EIO;
Index: linux-2.6.git/sound/oss/hal2.c
===================================================================
--- linux-2.6.git.orig/sound/oss/hal2.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/oss/hal2.c	2006-07-01 16:51:50.000000000 +0200
@@ -1479,7 +1479,7 @@ static int hal2_init_card(struct hal2_ca
 	hpc3->pbus_dmacfg[hal2->dac.pbus.pbusnr][0] = 0x8208844;
 	hpc3->pbus_dmacfg[hal2->adc.pbus.pbusnr][0] = 0x8208844;
 
-	if (request_irq(SGI_HPCDMA_IRQ, hal2_interrupt, SA_SHIRQ,
+	if (request_irq(SGI_HPCDMA_IRQ, hal2_interrupt, IRQF_SHARED,
 			hal2str, hal2)) {
 		printk(KERN_ERR "HAL2: Can't get irq %d\n", SGI_HPCDMA_IRQ);
 		ret = -EAGAIN;
Index: linux-2.6.git/sound/oss/i810_audio.c
===================================================================
--- linux-2.6.git.orig/sound/oss/i810_audio.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/oss/i810_audio.c	2006-07-01 16:51:50.000000000 +0200
@@ -3413,7 +3413,7 @@ static int __devinit i810_probe(struct p
 		goto out_iospace;
 	}
 
-	if (request_irq(card->irq, &i810_interrupt, SA_SHIRQ,
+	if (request_irq(card->irq, &i810_interrupt, IRQF_SHARED,
 			card_names[pci_id->driver_data], card)) {
 		printk(KERN_ERR "i810_audio: unable to allocate irq %d\n", card->irq);
 		goto out_iospace;
Index: linux-2.6.git/sound/oss/ite8172.c
===================================================================
--- linux-2.6.git.orig/sound/oss/ite8172.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/oss/ite8172.c	2006-07-01 16:51:50.000000000 +0200
@@ -2019,7 +2019,7 @@ static int __devinit it8172_probe(struct
 		    s->io, s->io + pci_resource_len(pcidev,0)-1);
 		goto err_region;
 	}
-	if (request_irq(s->irq, it8172_interrupt, SA_INTERRUPT,
+	if (request_irq(s->irq, it8172_interrupt, IRQF_DISABLED,
 			IT8172_MODULE_NAME, s)) {
 		err("irq %u in use", s->irq);
 		goto err_irq;
Index: linux-2.6.git/sound/oss/maestro3.c
===================================================================
--- linux-2.6.git.orig/sound/oss/maestro3.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/oss/maestro3.c	2006-07-01 16:51:50.000000000 +0200
@@ -2694,7 +2694,7 @@ static int __devinit m3_probe(struct pci
         }
     }
     
-    if(request_irq(card->irq, m3_interrupt, SA_SHIRQ, card_names[card->card_type], card)) {
+    if(request_irq(card->irq, m3_interrupt, IRQF_SHARED, card_names[card->card_type], card)) {
 
         printk(KERN_ERR PFX "unable to allocate irq %d,\n", card->irq);
 
Index: linux-2.6.git/sound/oss/maestro.c
===================================================================
--- linux-2.6.git.orig/sound/oss/maestro.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/oss/maestro.c	2006-07-01 16:51:50.000000000 +0200
@@ -3545,7 +3545,7 @@ maestro_probe(struct pci_dev *pcidev,con
 		mixer_push_state(card);
 	}
 	
-	if((ret=request_irq(card->irq, ess_interrupt, SA_SHIRQ, card_names[card_type], card)))
+	if((ret=request_irq(card->irq, ess_interrupt, IRQF_SHARED, card_names[card_type], card)))
 	{
 		printk(KERN_ERR "maestro: unable to allocate irq %d,\n", card->irq);
 		unregister_sound_mixer(card->dev_mixer);
Index: linux-2.6.git/sound/oss/nec_vrc5477.c
===================================================================
--- linux-2.6.git.orig/sound/oss/nec_vrc5477.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/oss/nec_vrc5477.c	2006-07-01 16:51:50.000000000 +0200
@@ -1909,7 +1909,7 @@ static int __devinit vrc5477_ac97_probe(
 		       s->io, s->io + pci_resource_len(pcidev,0)-1);
 		goto err_region;
 	}
-	if (request_irq(s->irq, vrc5477_ac97_interrupt, SA_INTERRUPT,
+	if (request_irq(s->irq, vrc5477_ac97_interrupt, IRQF_DISABLED,
 			VRC5477_AC97_MODULE_NAME, s)) {
 		printk(KERN_ERR PFX "irq %u in use\n", s->irq);
 		goto err_irq;
Index: linux-2.6.git/sound/oss/nm256_audio.c
===================================================================
--- linux-2.6.git.orig/sound/oss/nm256_audio.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/oss/nm256_audio.c	2006-07-01 16:51:50.000000000 +0200
@@ -733,7 +733,7 @@ static int
 nm256_grabInterrupt (struct nm256_info *card)
 {
     if (card->has_irq++ == 0) {
-	if (request_irq (card->irq, card->introutine, SA_SHIRQ,
+	if (request_irq (card->irq, card->introutine, IRQF_SHARED,
 			 "NM256_audio", card) < 0) {
 	    printk (KERN_ERR "NM256: can't obtain IRQ %d\n", card->irq);
 	    return -1;
Index: linux-2.6.git/sound/oss/rme96xx.c
===================================================================
--- linux-2.6.git.orig/sound/oss/rme96xx.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/oss/rme96xx.c	2006-07-01 16:51:50.000000000 +0200
@@ -994,7 +994,7 @@ static int __devinit rme96xx_probe(struc
 
 	if (pci_enable_device(pcidev))
 		goto err_irq;
-	if (request_irq(s->irq, rme96xx_interrupt, SA_SHIRQ, "rme96xx", s)) {
+	if (request_irq(s->irq, rme96xx_interrupt, IRQF_SHARED, "rme96xx", s)) {
 		printk(KERN_ERR RME_MESS" irq %u in use\n", s->irq);
 		goto err_irq;
 	}
Index: linux-2.6.git/sound/oss/sb_common.c
===================================================================
--- linux-2.6.git.orig/sound/oss/sb_common.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/oss/sb_common.c	2006-07-01 16:51:50.000000000 +0200
@@ -677,7 +677,7 @@ int sb_dsp_init(struct address_info *hw_
 		 *	will get shared PCI irq lines we must cope.
 		 */
 		 
-		int i=(devc->caps&SB_PCI_IRQ)?SA_SHIRQ:0;
+		int i=(devc->caps&SB_PCI_IRQ)?IRQF_SHARED:0;
 		
 		if (request_irq(hw_config->irq, sbintr, i, "soundblaster", devc) < 0)
 		{
Index: linux-2.6.git/sound/oss/sh_dac_audio.c
===================================================================
--- linux-2.6.git.orig/sound/oss/sh_dac_audio.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/oss/sh_dac_audio.c	2006-07-01 16:51:50.000000000 +0200
@@ -297,7 +297,7 @@ static int __init dac_audio_init(void)
 	dac_audio_set_rate();
 
 	retval =
-	    request_irq(TIMER1_IRQ, timer1_interrupt, SA_INTERRUPT, MODNAME, 0);
+	    request_irq(TIMER1_IRQ, timer1_interrupt, IRQF_DISABLED, MODNAME, 0);
 	if (retval < 0) {
 		printk(KERN_ERR "sh_dac_audio: IRQ %d request failed\n",
 		       TIMER1_IRQ);
Index: linux-2.6.git/sound/oss/sonicvibes.c
===================================================================
--- linux-2.6.git.orig/sound/oss/sonicvibes.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/oss/sonicvibes.c	2006-07-01 16:51:50.000000000 +0200
@@ -2632,7 +2632,7 @@ static int __devinit sv_probe(struct pci
 	wrindir(s, SV_CIPCMSR1, ((8000 * 65536 / FULLRATE) >> 8) & 0xff);
 	wrindir(s, SV_CIADCOUTPUT, 0);
 	/* request irq */
-	if ((ret=request_irq(s->irq,sv_interrupt,SA_SHIRQ,"S3 SonicVibes",s))) {
+	if ((ret=request_irq(s->irq,sv_interrupt,IRQF_SHARED,"S3 SonicVibes",s))) {
 		printk(KERN_ERR "sv: irq %u in use\n", s->irq);
 		goto err_irq;
 	}
Index: linux-2.6.git/sound/oss/trident.c
===================================================================
--- linux-2.6.git.orig/sound/oss/trident.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/oss/trident.c	2006-07-01 16:51:50.000000000 +0200
@@ -4472,7 +4472,7 @@ trident_probe(struct pci_dev *pci_dev, c
 
 	/* claim our irq */
 	rc = -ENODEV;
-	if (request_irq(card->irq, &trident_interrupt, SA_SHIRQ, 
+	if (request_irq(card->irq, &trident_interrupt, IRQF_SHARED, 
 			card_names[pci_id->driver_data], card)) {
 		printk(KERN_ERR "trident: unable to allocate irq %d\n", 
 		       card->irq);
Index: linux-2.6.git/sound/oss/via82cxxx_audio.c
===================================================================
--- linux-2.6.git.orig/sound/oss/via82cxxx_audio.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/oss/via82cxxx_audio.c	2006-07-01 16:51:50.000000000 +0200
@@ -2013,7 +2013,7 @@ static int via_interrupt_init (struct vi
 			tmp8 |= VIA_CR48_FM_TRAP_TO_NMI;
 			pci_write_config_byte (card->pdev, VIA_FM_NMI_CTRL, tmp8);
 		}
-		if (request_irq (card->pdev->irq, via_interrupt, SA_SHIRQ, VIA_MODULE_NAME, card)) {
+		if (request_irq (card->pdev->irq, via_interrupt, IRQF_SHARED, VIA_MODULE_NAME, card)) {
 			printk (KERN_ERR PFX "unable to obtain IRQ %d, aborting\n",
 				card->pdev->irq);
 			DPRINTK ("EXIT, returning -EBUSY\n");
@@ -2022,7 +2022,7 @@ static int via_interrupt_init (struct vi
 	}
 	else 
 	{
-		if (request_irq (card->pdev->irq, via_new_interrupt, SA_SHIRQ, VIA_MODULE_NAME, card)) {
+		if (request_irq (card->pdev->irq, via_new_interrupt, IRQF_SHARED, VIA_MODULE_NAME, card)) {
 			printk (KERN_ERR PFX "unable to obtain IRQ %d, aborting\n",
 				card->pdev->irq);
 			DPRINTK ("EXIT, returning -EBUSY\n");
Index: linux-2.6.git/sound/oss/wavfront.c
===================================================================
--- linux-2.6.git.orig/sound/oss/wavfront.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/oss/wavfront.c	2006-07-01 16:51:50.000000000 +0200
@@ -2268,7 +2268,7 @@ static int __init wavefront_hw_reset (vo
 	}
 
 	if (request_irq (dev.irq, wavefrontintr,
-			 SA_INTERRUPT|SA_SHIRQ,
+			 IRQF_DISABLED|IRQF_SHARED,
 			 "wavefront synth", &dev) < 0) {
 		printk (KERN_WARNING LOGNAME "IRQ %d not available!\n",
 			dev.irq);
Index: linux-2.6.git/sound/oss/wf_midi.c
===================================================================
--- linux-2.6.git.orig/sound/oss/wf_midi.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/oss/wf_midi.c	2006-07-01 16:51:50.000000000 +0200
@@ -820,7 +820,7 @@ int __init install_wf_mpu (void)
 
 	/* OK, now we're configured to handle an interrupt ... */
 
-	if (request_irq (phys_dev->irq, wf_mpuintr, SA_INTERRUPT|SA_SHIRQ,
+	if (request_irq (phys_dev->irq, wf_mpuintr, IRQF_DISABLED|IRQF_SHARED,
 			 "wavefront midi", phys_dev) < 0) {
 
 		printk (KERN_ERR "WF-MPU: Failed to allocate IRQ%d\n",
Index: linux-2.6.git/sound/oss/ymfpci.c
===================================================================
--- linux-2.6.git.orig/sound/oss/ymfpci.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/oss/ymfpci.c	2006-07-01 16:51:50.000000000 +0200
@@ -2573,7 +2573,7 @@ static int __devinit ymf_probe_one(struc
 		goto out_disable_dsp;
 	ymf_memload(codec);
 
-	if (request_irq(pcidev->irq, ymf_interrupt, SA_SHIRQ, "ymfpci", codec) != 0) {
+	if (request_irq(pcidev->irq, ymf_interrupt, IRQF_SHARED, "ymfpci", codec) != 0) {
 		printk(KERN_ERR "ymfpci: unable to request IRQ %d\n",
 		    pcidev->irq);
 		goto out_memfree;
Index: linux-2.6.git/sound/oss/cs4281/cs4281m.c
===================================================================
--- linux-2.6.git.orig/sound/oss/cs4281/cs4281m.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/oss/cs4281/cs4281m.c	2006-07-01 16:51:50.000000000 +0200
@@ -4346,7 +4346,7 @@ static int __devinit cs4281_probe(struct
 	s->pcidev = pcidev;
 	s->irq = pcidev->irq;
 	if (request_irq
-	    (s->irq, cs4281_interrupt, SA_SHIRQ, "Crystal CS4281", s)) {
+	    (s->irq, cs4281_interrupt, IRQF_SHARED, "Crystal CS4281", s)) {
 		CS_DBGOUT(CS_INIT | CS_ERROR, 1,
 			  printk(KERN_ERR "cs4281: irq %u in use\n", s->irq));
 		goto err_irq;
Index: linux-2.6.git/sound/oss/emu10k1/main.c
===================================================================
--- linux-2.6.git.orig/sound/oss/emu10k1/main.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/oss/emu10k1/main.c	2006-07-01 16:51:50.000000000 +0200
@@ -1301,7 +1301,7 @@ static int __devinit emu10k1_probe(struc
 	card->pci_dev = pci_dev;
 
 	/* Reserve IRQ Line */
-	if (request_irq(card->irq, emu10k1_interrupt, SA_SHIRQ, card_names[pci_id->driver_data], card)) {
+	if (request_irq(card->irq, emu10k1_interrupt, IRQF_SHARED, card_names[pci_id->driver_data], card)) {
 		printk(KERN_ERR "emu10k1: IRQ in use\n");
 		ret = -EBUSY;
 		goto err_irq;
Index: linux-2.6.git/sound/pci/ad1889.c
===================================================================
--- linux-2.6.git.orig/sound/pci/ad1889.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/ad1889.c	2006-07-01 16:51:50.000000000 +0200
@@ -947,7 +947,7 @@ snd_ad1889_create(struct snd_card *card,
 	spin_lock_init(&chip->lock);	/* only now can we call ad1889_free */
 
 	if (request_irq(pci->irq, snd_ad1889_interrupt,
-			SA_INTERRUPT|SA_SHIRQ, card->driver, (void*)chip)) {
+			IRQF_DISABLED|IRQF_SHARED, card->driver, (void*)chip)) {
 		printk(KERN_ERR PFX "cannot obtain IRQ %d\n", pci->irq);
 		snd_ad1889_free(chip);
 		return -EBUSY;
Index: linux-2.6.git/sound/pci/als300.c
===================================================================
--- linux-2.6.git.orig/sound/pci/als300.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/als300.c	2006-07-01 16:51:50.000000000 +0200
@@ -724,7 +724,7 @@ static int __devinit snd_als300_create(s
 	else
 		irq_handler = snd_als300_interrupt;
 
-	if (request_irq(pci->irq, irq_handler, SA_INTERRUPT|SA_SHIRQ,
+	if (request_irq(pci->irq, irq_handler, IRQF_DISABLED|IRQF_SHARED,
 					card->shortname, (void *)chip)) {
 		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
 		snd_als300_free(chip);
Index: linux-2.6.git/sound/pci/atiixp.c
===================================================================
--- linux-2.6.git.orig/sound/pci/atiixp.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/atiixp.c	2006-07-01 16:51:50.000000000 +0200
@@ -1578,7 +1578,7 @@ static int __devinit snd_atiixp_create(s
 		return -EIO;
 	}
 
-	if (request_irq(pci->irq, snd_atiixp_interrupt, SA_INTERRUPT|SA_SHIRQ,
+	if (request_irq(pci->irq, snd_atiixp_interrupt, IRQF_DISABLED|IRQF_SHARED,
 			card->shortname, chip)) {
 		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
 		snd_atiixp_free(chip);
Index: linux-2.6.git/sound/pci/atiixp_modem.c
===================================================================
--- linux-2.6.git.orig/sound/pci/atiixp_modem.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/atiixp_modem.c	2006-07-01 16:51:50.000000000 +0200
@@ -1251,7 +1251,7 @@ static int __devinit snd_atiixp_create(s
 		return -EIO;
 	}
 
-	if (request_irq(pci->irq, snd_atiixp_interrupt, SA_INTERRUPT|SA_SHIRQ,
+	if (request_irq(pci->irq, snd_atiixp_interrupt, IRQF_DISABLED|IRQF_SHARED,
 			card->shortname, chip)) {
 		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
 		snd_atiixp_free(chip);
Index: linux-2.6.git/sound/pci/azt3328.c
===================================================================
--- linux-2.6.git.orig/sound/pci/azt3328.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/azt3328.c	2006-07-01 16:51:50.000000000 +0200
@@ -1724,7 +1724,7 @@ snd_azf3328_create(struct snd_card *card
 	chip->synth_port = pci_resource_start(pci, 3);
 	chip->mixer_port = pci_resource_start(pci, 4);
 
-	if (request_irq(pci->irq, snd_azf3328_interrupt, SA_INTERRUPT|SA_SHIRQ, card->shortname, (void *)chip)) {
+	if (request_irq(pci->irq, snd_azf3328_interrupt, IRQF_DISABLED|IRQF_SHARED, card->shortname, (void *)chip)) {
 		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
 		err = -EBUSY;
 		goto out_err;
Index: linux-2.6.git/sound/pci/bt87x.c
===================================================================
--- linux-2.6.git.orig/sound/pci/bt87x.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/bt87x.c	2006-07-01 16:51:50.000000000 +0200
@@ -747,7 +747,7 @@ static int __devinit snd_bt87x_create(st
 	snd_bt87x_writel(chip, REG_INT_MASK, 0);
 	snd_bt87x_writel(chip, REG_INT_STAT, MY_INTERRUPTS);
 
-	if (request_irq(pci->irq, snd_bt87x_interrupt, SA_INTERRUPT | SA_SHIRQ,
+	if (request_irq(pci->irq, snd_bt87x_interrupt, IRQF_DISABLED | IRQF_SHARED,
 			"Bt87x audio", chip)) {
 		snd_bt87x_free(chip);
 		snd_printk(KERN_ERR "cannot grab irq\n");
Index: linux-2.6.git/sound/pci/cmipci.c
===================================================================
--- linux-2.6.git.orig/sound/pci/cmipci.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/cmipci.c	2006-07-01 16:51:50.000000000 +0200
@@ -2862,7 +2862,7 @@ static int __devinit snd_cmipci_create(s
 	cm->iobase = pci_resource_start(pci, 0);
 
 	if (request_irq(pci->irq, snd_cmipci_interrupt,
-			SA_INTERRUPT|SA_SHIRQ, card->driver, cm)) {
+			IRQF_DISABLED|IRQF_SHARED, card->driver, cm)) {
 		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
 		snd_cmipci_free(cm);
 		return -EBUSY;
Index: linux-2.6.git/sound/pci/cs4281.c
===================================================================
--- linux-2.6.git.orig/sound/pci/cs4281.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/cs4281.c	2006-07-01 16:51:50.000000000 +0200
@@ -1386,7 +1386,7 @@ static int __devinit snd_cs4281_create(s
 		return -ENOMEM;
 	}
 	
-	if (request_irq(pci->irq, snd_cs4281_interrupt, SA_INTERRUPT|SA_SHIRQ,
+	if (request_irq(pci->irq, snd_cs4281_interrupt, IRQF_DISABLED|IRQF_SHARED,
 			"CS4281", chip)) {
 		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
 		snd_cs4281_free(chip);
Index: linux-2.6.git/sound/pci/ens1370.c
===================================================================
--- linux-2.6.git.orig/sound/pci/ens1370.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/ens1370.c	2006-07-01 16:51:50.000000000 +0200
@@ -2135,7 +2135,7 @@ static int __devinit snd_ensoniq_create(
 		return err;
 	}
 	ensoniq->port = pci_resource_start(pci, 0);
-	if (request_irq(pci->irq, snd_audiopci_interrupt, SA_INTERRUPT|SA_SHIRQ,
+	if (request_irq(pci->irq, snd_audiopci_interrupt, IRQF_DISABLED|IRQF_SHARED,
 			"Ensoniq AudioPCI", ensoniq)) {
 		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
 		snd_ensoniq_free(ensoniq);
Index: linux-2.6.git/sound/pci/es1938.c
===================================================================
--- linux-2.6.git.orig/sound/pci/es1938.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/es1938.c	2006-07-01 16:51:50.000000000 +0200
@@ -1429,7 +1429,7 @@ static int es1938_resume(struct pci_dev 
 	pci_restore_state(pci);
 	pci_enable_device(pci);
 	request_irq(pci->irq, snd_es1938_interrupt,
-		    SA_INTERRUPT|SA_SHIRQ, "ES1938", chip);
+		    IRQF_DISABLED|IRQF_SHARED, "ES1938", chip);
 	chip->irq = pci->irq;
 	snd_es1938_chip_init(chip);
 
@@ -1544,7 +1544,7 @@ static int __devinit snd_es1938_create(s
 	chip->vc_port = pci_resource_start(pci, 2);
 	chip->mpu_port = pci_resource_start(pci, 3);
 	chip->game_port = pci_resource_start(pci, 4);
-	if (request_irq(pci->irq, snd_es1938_interrupt, SA_INTERRUPT|SA_SHIRQ,
+	if (request_irq(pci->irq, snd_es1938_interrupt, IRQF_DISABLED|IRQF_SHARED,
 			"ES1938", chip)) {
 		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
 		snd_es1938_free(chip);
Index: linux-2.6.git/sound/pci/es1968.c
===================================================================
--- linux-2.6.git.orig/sound/pci/es1968.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/es1968.c	2006-07-01 16:51:50.000000000 +0200
@@ -2597,7 +2597,7 @@ static int __devinit snd_es1968_create(s
 		return err;
 	}
 	chip->io_port = pci_resource_start(pci, 0);
-	if (request_irq(pci->irq, snd_es1968_interrupt, SA_INTERRUPT|SA_SHIRQ,
+	if (request_irq(pci->irq, snd_es1968_interrupt, IRQF_DISABLED|IRQF_SHARED,
 			"ESS Maestro", (void*)chip)) {
 		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
 		snd_es1968_free(chip);
Index: linux-2.6.git/sound/pci/fm801.c
===================================================================
--- linux-2.6.git.orig/sound/pci/fm801.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/fm801.c	2006-07-01 16:51:50.000000000 +0200
@@ -1371,7 +1371,7 @@ static int __devinit snd_fm801_create(st
 		return err;
 	}
 	chip->port = pci_resource_start(pci, 0);
-	if (request_irq(pci->irq, snd_fm801_interrupt, SA_INTERRUPT|SA_SHIRQ,
+	if (request_irq(pci->irq, snd_fm801_interrupt, IRQF_DISABLED|IRQF_SHARED,
 			"FM801", chip)) {
 		snd_printk(KERN_ERR "unable to grab IRQ %d\n", chip->irq);
 		snd_fm801_free(chip);
Index: linux-2.6.git/sound/pci/intel8x0.c
===================================================================
--- linux-2.6.git.orig/sound/pci/intel8x0.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/intel8x0.c	2006-07-01 16:51:50.000000000 +0200
@@ -2475,7 +2475,7 @@ static int intel8x0_resume(struct pci_de
 	pci_restore_state(pci);
 	pci_enable_device(pci);
 	pci_set_master(pci);
-	request_irq(pci->irq, snd_intel8x0_interrupt, SA_INTERRUPT|SA_SHIRQ,
+	request_irq(pci->irq, snd_intel8x0_interrupt, IRQF_DISABLED|IRQF_SHARED,
 		    card->shortname, chip);
 	chip->irq = pci->irq;
 	synchronize_irq(chip->irq);
@@ -2848,7 +2848,7 @@ static int __devinit snd_intel8x0_create
 
 	/* request irq after initializaing int_sta_mask, etc */
 	if (request_irq(pci->irq, snd_intel8x0_interrupt,
-			SA_INTERRUPT|SA_SHIRQ, card->shortname, chip)) {
+			IRQF_DISABLED|IRQF_SHARED, card->shortname, chip)) {
 		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
 		snd_intel8x0_free(chip);
 		return -EBUSY;
Index: linux-2.6.git/sound/pci/intel8x0m.c
===================================================================
--- linux-2.6.git.orig/sound/pci/intel8x0m.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/intel8x0m.c	2006-07-01 16:51:50.000000000 +0200
@@ -1185,7 +1185,7 @@ static int __devinit snd_intel8x0m_creat
 	}
 
  port_inited:
-	if (request_irq(pci->irq, snd_intel8x0_interrupt, SA_INTERRUPT|SA_SHIRQ,
+	if (request_irq(pci->irq, snd_intel8x0_interrupt, IRQF_DISABLED|IRQF_SHARED,
 			card->shortname, chip)) {
 		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
 		snd_intel8x0_free(chip);
Index: linux-2.6.git/sound/pci/maestro3.c
===================================================================
--- linux-2.6.git.orig/sound/pci/maestro3.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/maestro3.c	2006-07-01 16:51:50.000000000 +0200
@@ -2760,7 +2760,7 @@ snd_m3_create(struct snd_card *card, str
 
 	tasklet_init(&chip->hwvol_tq, snd_m3_update_hw_volume, (unsigned long)chip);
 
-	if (request_irq(pci->irq, snd_m3_interrupt, SA_INTERRUPT|SA_SHIRQ,
+	if (request_irq(pci->irq, snd_m3_interrupt, IRQF_DISABLED|IRQF_SHARED,
 			card->driver, chip)) {
 		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
 		snd_m3_free(chip);
Index: linux-2.6.git/sound/pci/rme32.c
===================================================================
--- linux-2.6.git.orig/sound/pci/rme32.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/rme32.c	2006-07-01 16:51:50.000000000 +0200
@@ -1374,7 +1374,7 @@ static int __devinit snd_rme32_create(st
 		return -ENOMEM;
 	}
 
-	if (request_irq(pci->irq, snd_rme32_interrupt, SA_INTERRUPT | SA_SHIRQ, "RME32", (void *) rme32)) {
+	if (request_irq(pci->irq, snd_rme32_interrupt, IRQF_DISABLED | IRQF_SHARED, "RME32", (void *) rme32)) {
 		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
 		return -EBUSY;
 	}
Index: linux-2.6.git/sound/pci/rme96.c
===================================================================
--- linux-2.6.git.orig/sound/pci/rme96.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/rme96.c	2006-07-01 16:51:50.000000000 +0200
@@ -1588,7 +1588,7 @@ snd_rme96_create(struct rme96 *rme96)
 		return -ENOMEM;
 	}
 
-	if (request_irq(pci->irq, snd_rme96_interrupt, SA_INTERRUPT|SA_SHIRQ, "RME96", (void *)rme96)) {
+	if (request_irq(pci->irq, snd_rme96_interrupt, IRQF_DISABLED|IRQF_SHARED, "RME96", (void *)rme96)) {
 		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
 		return -EBUSY;
 	}
Index: linux-2.6.git/sound/pci/sonicvibes.c
===================================================================
--- linux-2.6.git.orig/sound/pci/sonicvibes.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/sonicvibes.c	2006-07-01 16:51:50.000000000 +0200
@@ -1257,7 +1257,7 @@ static int __devinit snd_sonicvibes_crea
 	sonic->midi_port = pci_resource_start(pci, 3);
 	sonic->game_port = pci_resource_start(pci, 4);
 
-	if (request_irq(pci->irq, snd_sonicvibes_interrupt, SA_INTERRUPT|SA_SHIRQ, "S3 SonicVibes", (void *)sonic)) {
+	if (request_irq(pci->irq, snd_sonicvibes_interrupt, IRQF_DISABLED|IRQF_SHARED, "S3 SonicVibes", (void *)sonic)) {
 		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
 		snd_sonicvibes_free(sonic);
 		return -EBUSY;
Index: linux-2.6.git/sound/pci/via82xx.c
===================================================================
--- linux-2.6.git.orig/sound/pci/via82xx.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/via82xx.c	2006-07-01 16:51:50.000000000 +0200
@@ -2281,7 +2281,7 @@ static int __devinit snd_via82xx_create(
 	if (request_irq(pci->irq,
 			chip_type == TYPE_VIA8233 ?
 			snd_via8233_interrupt :	snd_via686_interrupt,
-			SA_INTERRUPT|SA_SHIRQ,
+			IRQF_DISABLED|IRQF_SHARED,
 			card->driver, chip)) {
 		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
 		snd_via82xx_free(chip);
Index: linux-2.6.git/sound/pci/via82xx_modem.c
===================================================================
--- linux-2.6.git.orig/sound/pci/via82xx_modem.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/via82xx_modem.c	2006-07-01 16:51:50.000000000 +0200
@@ -1118,7 +1118,7 @@ static int __devinit snd_via82xx_create(
 		return err;
 	}
 	chip->port = pci_resource_start(pci, 0);
-	if (request_irq(pci->irq, snd_via82xx_interrupt, SA_INTERRUPT|SA_SHIRQ,
+	if (request_irq(pci->irq, snd_via82xx_interrupt, IRQF_DISABLED|IRQF_SHARED,
 			card->driver, chip)) {
 		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
 		snd_via82xx_free(chip);
Index: linux-2.6.git/sound/pci/ali5451/ali5451.c
===================================================================
--- linux-2.6.git.orig/sound/pci/ali5451/ali5451.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/ali5451/ali5451.c	2006-07-01 16:51:50.000000000 +0200
@@ -2185,7 +2185,7 @@ static int __devinit snd_ali_resources(s
 		return err;
 	codec->port = pci_resource_start(codec->pci, 0);
 
-	if (request_irq(codec->pci->irq, snd_ali_card_interrupt, SA_INTERRUPT|SA_SHIRQ, "ALI 5451", (void *)codec)) {
+	if (request_irq(codec->pci->irq, snd_ali_card_interrupt, IRQF_DISABLED|IRQF_SHARED, "ALI 5451", (void *)codec)) {
 		snd_printk(KERN_ERR "Unable to request irq.\n");
 		return -EBUSY;
 	}
Index: linux-2.6.git/sound/pci/au88x0/au88x0.c
===================================================================
--- linux-2.6.git.orig/sound/pci/au88x0/au88x0.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/au88x0/au88x0.c	2006-07-01 16:51:50.000000000 +0200
@@ -197,7 +197,7 @@ snd_vortex_create(struct snd_card *card,
 	}
 
 	if ((err = request_irq(pci->irq, vortex_interrupt,
-	                       SA_INTERRUPT | SA_SHIRQ, CARD_NAME_SHORT,
+	                       IRQF_DISABLED | IRQF_SHARED, CARD_NAME_SHORT,
 	                       chip)) != 0) {
 		printk(KERN_ERR "cannot grab irq\n");
 		goto irq_out;
Index: linux-2.6.git/sound/pci/ca0106/ca0106_main.c
===================================================================
--- linux-2.6.git.orig/sound/pci/ca0106/ca0106_main.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/ca0106/ca0106_main.c	2006-07-01 16:51:50.000000000 +0200
@@ -1268,7 +1268,7 @@ static int __devinit snd_ca0106_create(s
 	}
 
 	if (request_irq(pci->irq, snd_ca0106_interrupt,
-			SA_INTERRUPT|SA_SHIRQ, "snd_ca0106",
+			IRQF_DISABLED|IRQF_SHARED, "snd_ca0106",
 			(void *)chip)) {
 		snd_ca0106_free(chip);
 		printk(KERN_ERR "cannot grab irq\n");
Index: linux-2.6.git/sound/pci/cs46xx/cs46xx_lib.c
===================================================================
--- linux-2.6.git.orig/sound/pci/cs46xx/cs46xx_lib.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/cs46xx/cs46xx_lib.c	2006-07-01 16:51:50.000000000 +0200
@@ -3853,7 +3853,7 @@ int __devinit snd_cs46xx_create(struct s
 		}
 	}
 
-	if (request_irq(pci->irq, snd_cs46xx_interrupt, SA_INTERRUPT|SA_SHIRQ,
+	if (request_irq(pci->irq, snd_cs46xx_interrupt, IRQF_DISABLED|IRQF_SHARED,
 			"CS46XX", chip)) {
 		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
 		snd_cs46xx_free(chip);
Index: linux-2.6.git/sound/pci/cs5535audio/cs5535audio.c
===================================================================
--- linux-2.6.git.orig/sound/pci/cs5535audio/cs5535audio.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/cs5535audio/cs5535audio.c	2006-07-01 16:51:50.000000000 +0200
@@ -321,7 +321,7 @@ static int __devinit snd_cs5535audio_cre
 	cs5535au->port = pci_resource_start(pci, 0);
 
 	if (request_irq(pci->irq, snd_cs5535audio_interrupt,
-			SA_INTERRUPT|SA_SHIRQ, "CS5535 Audio", cs5535au)) {
+			IRQF_DISABLED|IRQF_SHARED, "CS5535 Audio", cs5535au)) {
 		snd_printk("unable to grab IRQ %d\n", pci->irq);
 		err = -EBUSY;
 		goto sndfail;
Index: linux-2.6.git/sound/pci/echoaudio/echoaudio.c
===================================================================
--- linux-2.6.git.orig/sound/pci/echoaudio/echoaudio.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/echoaudio/echoaudio.c	2006-07-01 16:51:50.000000000 +0200
@@ -1951,7 +1951,7 @@ static __devinit int snd_echo_create(str
 	chip->dsp_registers = (volatile u32 __iomem *)
 		ioremap_nocache(chip->dsp_registers_phys, sz);
 
-	if (request_irq(pci->irq, snd_echo_interrupt, SA_INTERRUPT | SA_SHIRQ,
+	if (request_irq(pci->irq, snd_echo_interrupt, IRQF_DISABLED | IRQF_SHARED,
 						ECHOCARD_NAME, (void *)chip)) {
 		snd_echo_free(chip);
 		snd_printk(KERN_ERR "cannot grab irq\n");
Index: linux-2.6.git/sound/pci/emu10k1/emu10k1_main.c
===================================================================
--- linux-2.6.git.orig/sound/pci/emu10k1/emu10k1_main.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/emu10k1/emu10k1_main.c	2006-07-01 16:51:50.000000000 +0200
@@ -1233,7 +1233,7 @@ int __devinit snd_emu10k1_create(struct 
 	}
 	emu->port = pci_resource_start(pci, 0);
 
-	if (request_irq(pci->irq, snd_emu10k1_interrupt, SA_INTERRUPT|SA_SHIRQ, "EMU10K1", (void *)emu)) {
+	if (request_irq(pci->irq, snd_emu10k1_interrupt, IRQF_DISABLED|IRQF_SHARED, "EMU10K1", (void *)emu)) {
 		err = -EBUSY;
 		goto error;
 	}
Index: linux-2.6.git/sound/pci/emu10k1/emu10k1x.c
===================================================================
--- linux-2.6.git.orig/sound/pci/emu10k1/emu10k1x.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/emu10k1/emu10k1x.c	2006-07-01 16:51:50.000000000 +0200
@@ -928,7 +928,7 @@ static int __devinit snd_emu10k1x_create
 	}
 
 	if (request_irq(pci->irq, snd_emu10k1x_interrupt,
-			SA_INTERRUPT|SA_SHIRQ, "EMU10K1X",
+			IRQF_DISABLED|IRQF_SHARED, "EMU10K1X",
 			(void *)chip)) {
 		snd_printk(KERN_ERR "emu10k1x: cannot grab irq %d\n", pci->irq);
 		snd_emu10k1x_free(chip);
Index: linux-2.6.git/sound/pci/hda/hda_intel.c
===================================================================
--- linux-2.6.git.orig/sound/pci/hda/hda_intel.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/hda/hda_intel.c	2006-07-01 16:51:50.000000000 +0200
@@ -1486,7 +1486,7 @@ static int __devinit azx_create(struct s
 		goto errout;
 	}
 
-	if (request_irq(pci->irq, azx_interrupt, SA_INTERRUPT|SA_SHIRQ,
+	if (request_irq(pci->irq, azx_interrupt, IRQF_DISABLED|IRQF_SHARED,
 			"HDA Intel", (void*)chip)) {
 		snd_printk(KERN_ERR SFX "unable to grab IRQ %d\n", pci->irq);
 		err = -EBUSY;
Index: linux-2.6.git/sound/pci/ice1712/ice1712.c
===================================================================
--- linux-2.6.git.orig/sound/pci/ice1712/ice1712.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/ice1712/ice1712.c	2006-07-01 16:51:50.000000000 +0200
@@ -2606,7 +2606,7 @@ static int __devinit snd_ice1712_create(
 	ice->dmapath_port = pci_resource_start(pci, 2);
 	ice->profi_port = pci_resource_start(pci, 3);
 
-	if (request_irq(pci->irq, snd_ice1712_interrupt, SA_INTERRUPT|SA_SHIRQ,
+	if (request_irq(pci->irq, snd_ice1712_interrupt, IRQF_DISABLED|IRQF_SHARED,
 			"ICE1712", ice)) {
 		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
 		snd_ice1712_free(ice);
Index: linux-2.6.git/sound/pci/ice1712/ice1724.c
===================================================================
--- linux-2.6.git.orig/sound/pci/ice1712/ice1724.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/ice1712/ice1724.c	2006-07-01 16:51:50.000000000 +0200
@@ -2253,7 +2253,7 @@ static int __devinit snd_vt1724_create(s
 	ice->profi_port = pci_resource_start(pci, 1);
 
 	if (request_irq(pci->irq, snd_vt1724_interrupt,
-			SA_INTERRUPT|SA_SHIRQ, "ICE1724", ice)) {
+			IRQF_DISABLED|IRQF_SHARED, "ICE1724", ice)) {
 		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
 		snd_vt1724_free(ice);
 		return -EIO;
Index: linux-2.6.git/sound/pci/korg1212/korg1212.c
===================================================================
--- linux-2.6.git.orig/sound/pci/korg1212/korg1212.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/korg1212/korg1212.c	2006-07-01 16:51:50.000000000 +0200
@@ -2237,7 +2237,7 @@ static int __devinit snd_korg1212_create
         }
 
         err = request_irq(pci->irq, snd_korg1212_interrupt,
-                          SA_INTERRUPT|SA_SHIRQ,
+                          IRQF_DISABLED|IRQF_SHARED,
                           "korg1212", korg1212);
 
         if (err) {
Index: linux-2.6.git/sound/pci/mixart/mixart.c
===================================================================
--- linux-2.6.git.orig/sound/pci/mixart/mixart.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/mixart/mixart.c	2006-07-01 16:51:50.000000000 +0200
@@ -1319,7 +1319,7 @@ static int __devinit snd_mixart_probe(st
 						   pci_resource_len(pci, i));
 	}
 
-	if (request_irq(pci->irq, snd_mixart_interrupt, SA_INTERRUPT|SA_SHIRQ, CARD_NAME, (void *)mgr)) {
+	if (request_irq(pci->irq, snd_mixart_interrupt, IRQF_DISABLED|IRQF_SHARED, CARD_NAME, (void *)mgr)) {
 		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
 		snd_mixart_free(mgr);
 		return -EBUSY;
Index: linux-2.6.git/sound/pci/nm256/nm256.c
===================================================================
--- linux-2.6.git.orig/sound/pci/nm256/nm256.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/nm256/nm256.c	2006-07-01 16:51:50.000000000 +0200
@@ -465,7 +465,7 @@ static int snd_nm256_acquire_irq(struct 
 {
 	mutex_lock(&chip->irq_mutex);
 	if (chip->irq < 0) {
-		if (request_irq(chip->pci->irq, chip->interrupt, SA_INTERRUPT|SA_SHIRQ,
+		if (request_irq(chip->pci->irq, chip->interrupt, IRQF_DISABLED|IRQF_SHARED,
 				chip->card->driver, chip)) {
 			snd_printk(KERN_ERR "unable to grab IRQ %d\n", chip->pci->irq);
 			mutex_unlock(&chip->irq_mutex);
Index: linux-2.6.git/sound/pci/pcxhr/pcxhr.c
===================================================================
--- linux-2.6.git.orig/sound/pci/pcxhr/pcxhr.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/pcxhr/pcxhr.c	2006-07-01 16:51:50.000000000 +0200
@@ -1250,7 +1250,7 @@ static int __devinit pcxhr_probe(struct 
 	mgr->pci = pci;
 	mgr->irq = -1;
 
-	if (request_irq(pci->irq, pcxhr_interrupt, SA_INTERRUPT|SA_SHIRQ,
+	if (request_irq(pci->irq, pcxhr_interrupt, IRQF_DISABLED|IRQF_SHARED,
 			card_name, mgr)) {
 		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
 		pcxhr_free(mgr);
Index: linux-2.6.git/sound/pci/riptide/riptide.c
===================================================================
--- linux-2.6.git.orig/sound/pci/riptide/riptide.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/riptide/riptide.c	2006-07-01 16:51:50.000000000 +0200
@@ -1892,7 +1892,7 @@ snd_riptide_create(struct snd_card *card
 	UNSET_AIE(hwport);
 
 	if (request_irq
-	    (pci->irq, snd_riptide_interrupt, SA_INTERRUPT | SA_SHIRQ,
+	    (pci->irq, snd_riptide_interrupt, IRQF_DISABLED | IRQF_SHARED,
 	     "RIPTIDE", chip)) {
 		snd_printk(KERN_ERR "Riptide: unable to grab IRQ %d\n",
 			   pci->irq);
Index: linux-2.6.git/sound/pci/rme9652/hdsp.c
===================================================================
--- linux-2.6.git.orig/sound/pci/rme9652/hdsp.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/rme9652/hdsp.c	2006-07-01 16:51:50.000000000 +0200
@@ -4912,7 +4912,7 @@ static int __devinit snd_hdsp_create(str
 		return -EBUSY;
 	}
 
-	if (request_irq(pci->irq, snd_hdsp_interrupt, SA_INTERRUPT|SA_SHIRQ, "hdsp", (void *)hdsp)) {
+	if (request_irq(pci->irq, snd_hdsp_interrupt, IRQF_DISABLED|IRQF_SHARED, "hdsp", (void *)hdsp)) {
 		snd_printk(KERN_ERR "Hammerfall-DSP: unable to use IRQ %d\n", pci->irq);
 		return -EBUSY;
 	}
Index: linux-2.6.git/sound/pci/rme9652/hdspm.c
===================================================================
--- linux-2.6.git.orig/sound/pci/rme9652/hdspm.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/rme9652/hdspm.c	2006-07-01 16:51:50.000000000 +0200
@@ -3497,7 +3497,7 @@ static int __devinit snd_hdspm_create(st
 		   hdspm->port + io_extent - 1);
 
 	if (request_irq(pci->irq, snd_hdspm_interrupt,
-			SA_INTERRUPT | SA_SHIRQ, "hdspm",
+			IRQF_DISABLED | IRQF_SHARED, "hdspm",
 			(void *) hdspm)) {
 		snd_printk(KERN_ERR "HDSPM: unable to use IRQ %d\n", pci->irq);
 		return -EBUSY;
Index: linux-2.6.git/sound/pci/rme9652/rme9652.c
===================================================================
--- linux-2.6.git.orig/sound/pci/rme9652/rme9652.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/rme9652/rme9652.c	2006-07-01 16:51:50.000000000 +0200
@@ -2500,7 +2500,7 @@ static int __devinit snd_rme9652_create(
 		return -EBUSY;
 	}
 	
-	if (request_irq(pci->irq, snd_rme9652_interrupt, SA_INTERRUPT|SA_SHIRQ, "rme9652", (void *)rme9652)) {
+	if (request_irq(pci->irq, snd_rme9652_interrupt, IRQF_DISABLED|IRQF_SHARED, "rme9652", (void *)rme9652)) {
 		snd_printk(KERN_ERR "unable to request IRQ %d\n", pci->irq);
 		return -EBUSY;
 	}
Index: linux-2.6.git/sound/pci/trident/trident_main.c
===================================================================
--- linux-2.6.git.orig/sound/pci/trident/trident_main.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/trident/trident_main.c	2006-07-01 16:51:50.000000000 +0200
@@ -3599,7 +3599,7 @@ int __devinit snd_trident_create(struct 
 	}
 	trident->port = pci_resource_start(pci, 0);
 
-	if (request_irq(pci->irq, snd_trident_interrupt, SA_INTERRUPT|SA_SHIRQ,
+	if (request_irq(pci->irq, snd_trident_interrupt, IRQF_DISABLED|IRQF_SHARED,
 			"Trident Audio", trident)) {
 		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
 		snd_trident_free(trident);
Index: linux-2.6.git/sound/pci/vx222/vx222.c
===================================================================
--- linux-2.6.git.orig/sound/pci/vx222/vx222.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/vx222/vx222.c	2006-07-01 16:51:50.000000000 +0200
@@ -162,7 +162,7 @@ static int __devinit snd_vx222_create(st
 	for (i = 0; i < 2; i++)
 		vx->port[i] = pci_resource_start(pci, i + 1);
 
-	if (request_irq(pci->irq, snd_vx_irq_handler, SA_INTERRUPT|SA_SHIRQ,
+	if (request_irq(pci->irq, snd_vx_irq_handler, IRQF_DISABLED|IRQF_SHARED,
 			CARD_NAME, (void *) chip)) {
 		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
 		snd_vx222_free(chip);
Index: linux-2.6.git/sound/pci/ymfpci/ymfpci_main.c
===================================================================
--- linux-2.6.git.orig/sound/pci/ymfpci/ymfpci_main.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/pci/ymfpci/ymfpci_main.c	2006-07-01 16:51:50.000000000 +0200
@@ -2288,7 +2288,7 @@ int __devinit snd_ymfpci_create(struct s
 		snd_ymfpci_free(chip);
 		return -EBUSY;
 	}
-	if (request_irq(pci->irq, snd_ymfpci_interrupt, SA_INTERRUPT|SA_SHIRQ, "YMFPCI", (void *) chip)) {
+	if (request_irq(pci->irq, snd_ymfpci_interrupt, IRQF_DISABLED|IRQF_SHARED, "YMFPCI", (void *) chip)) {
 		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
 		snd_ymfpci_free(chip);
 		return -EBUSY;
Index: linux-2.6.git/sound/sparc/amd7930.c
===================================================================
--- linux-2.6.git.orig/sound/sparc/amd7930.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/sparc/amd7930.c	2006-07-01 16:51:50.000000000 +0200
@@ -973,7 +973,7 @@ static int __init snd_amd7930_create(str
 	amd7930_idle(amd);
 
 	if (request_irq(irq, snd_amd7930_interrupt,
-			SA_INTERRUPT | SA_SHIRQ, "amd7930", amd)) {
+			IRQF_DISABLED | IRQF_SHARED, "amd7930", amd)) {
 		snd_printk("amd7930-%d: Unable to grab IRQ %d\n",
 			   dev, irq);
 		snd_amd7930_free(amd);
Index: linux-2.6.git/sound/sparc/cs4231.c
===================================================================
--- linux-2.6.git.orig/sound/sparc/cs4231.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/sparc/cs4231.c	2006-07-01 16:51:50.000000000 +0200
@@ -2001,7 +2001,7 @@ static int __init snd_cs4231_sbus_create
 	chip->c_dma.preallocate = sbus_dma_preallocate;
 
 	if (request_irq(sdev->irqs[0], snd_cs4231_sbus_interrupt,
-			SA_SHIRQ, "cs4231", chip)) {
+			IRQF_SHARED, "cs4231", chip)) {
 		snd_printdd("cs4231-%d: Unable to grab SBUS IRQ %d\n",
 			    dev, sdev->irqs[0]);
 		snd_cs4231_sbus_free(chip);
Index: linux-2.6.git/sound/sparc/dbri.c
===================================================================
--- linux-2.6.git.orig/sound/sparc/dbri.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/sound/sparc/dbri.c	2006-07-01 16:51:50.000000000 +0200
@@ -2569,7 +2569,7 @@ static int __init snd_dbri_create(struct
 		return -EIO;
 	}
 
-	err = request_irq(dbri->irq, snd_dbri_interrupt, SA_SHIRQ,
+	err = request_irq(dbri->irq, snd_dbri_interrupt, IRQF_SHARED,
 			  "DBRI audio", dbri);
 	if (err) {
 		printk(KERN_ERR "DBRI: Can't get irq %d\n", dbri->irq);

--

