Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269639AbTHFQZj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 12:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269950AbTHFQZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 12:25:38 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:28378 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S269639AbTHFQZL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 12:25:11 -0400
Date: Wed, 6 Aug 2003 18:25:08 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: [RESEND][PATCH 2.6] More C99 Initialisers in sound/*
Message-ID: <Pine.LNX.4.51.0308061823480.23681@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here is another bunch of C99 initialisers in sound/*

 oss/ac97_plugin_ad1980.c |   10 +++++-----
 oss/ad1889.c             |   32 ++++++++++++++++----------------
 oss/ali5455.c            |   35 +++++++++++++++++++----------------
 oss/au1000.c             |   28 ++++++++++++++--------------
 oss/forte.c              |   36 ++++++++++++++++++------------------
 oss/hal2.c               |   26 +++++++++++++-------------
 oss/harmony.c            |   32 ++++++++++++++++----------------
 oss/ite8172.c            |   28 ++++++++++++++--------------
 oss/kahlua.c             |    8 ++++----
 oss/swarm_cs4297a.c      |   24 ++++++++++++------------
 oss/via82cxxx_audio.c    |   30 +++++++++++++++---------------
 parisc/harmony.c         |    6 +++---
 12 files changed, 149 insertions(+), 146 deletions(-)

Regards,
Maciej Soltysiak


diff -Nru linux-2.6.0-test2/sound/oss/ac97_plugin_ad1980.c linux-2.6.0-test2-bk1/sound/oss/ac97_plugin_ad1980.c
--- linux-2.6.0-test2/sound/oss/ac97_plugin_ad1980.c	2003-07-27 18:55:53.000000000 +0200
+++ linux-2.6.0-test2-bk1/sound/oss/ac97_plugin_ad1980.c	2003-08-03 09:00:34.000000000 +0200
@@ -83,11 +83,11 @@


 static struct ac97_driver ad1980_driver = {
-	codec_id: 0x41445370,
-	codec_mask: 0xFFFFFFFF,
-	name: "AD1980 example",
-	probe:	ad1980_probe,
-	remove: __devexit_p(ad1980_remove),
+	.codec_id	= 0x41445370,
+	.codec_mask	= 0xFFFFFFFF,
+	.name		= "AD1980 example",
+	.probe		= ad1980_probe,
+	.remove		= __devexit_p(ad1980_remove),
 };

 /**
diff -Nru linux-2.6.0-test2/sound/oss/ad1889.c linux-2.6.0-test2-bk1/sound/oss/ad1889.c
--- linux-2.6.0-test2/sound/oss/ad1889.c	2003-07-27 19:00:25.000000000 +0200
+++ linux-2.6.0-test2-bk1/sound/oss/ad1889.c	2003-08-03 08:59:09.000000000 +0200
@@ -775,14 +775,14 @@
 }

 static struct file_operations ad1889_fops = {
-	llseek:         no_llseek,
-	read:           ad1889_read,
-	write:          ad1889_write,
-	poll:           ad1889_poll,
-	ioctl:          ad1889_ioctl,
-	mmap:           ad1889_mmap,
-	open:           ad1889_open,
-	release:        ad1889_release,
+	.llseek		= no_llseek,
+	.read		= ad1889_read,
+	.write		= ad1889_write,
+	.poll		= ad1889_poll,
+	.ioctl		= ad1889_ioctl,
+	.mmap		= ad1889_mmap,
+	.open		= ad1889_open,
+	.release	= ad1889_release,
 };

 /************************* /dev/mixer interfaces ************************ */
@@ -810,10 +810,10 @@
 }

 static struct file_operations ad1889_mixer_fops = {
-	llseek:         no_llseek,
-	ioctl:		ad1889_mixer_ioctl,
-	open:		ad1889_mixer_open,
-	release:	ad1889_mixer_release,
+	.llseek		= no_llseek,
+	.ioctl		= ad1889_mixer_ioctl,
+	.open		= ad1889_mixer_open,
+	.release	= ad1889_mixer_release,
 };

 /************************* AC97 interfaces ****************************** */
@@ -1064,10 +1064,10 @@
 MODULE_LICENSE("GPL");

 static struct pci_driver ad1889_driver = {
-	name:		DEVNAME,
-	id_table:	ad1889_id_tbl,
-	probe:		ad1889_probe,
-	remove:		__devexit_p(ad1889_remove),
+	.name		= DEVNAME,
+	.id_table	= ad1889_id_tbl,
+	.probe		= ad1889_probe,
+	.remove		= __devexit_p(ad1889_remove),
 };

 static int __init ad1889_init_module(void)
diff -Nru linux-2.6.0-test2/sound/oss/ali5455.c linux-2.6.0-test2-bk1/sound/oss/ali5455.c
--- linux-2.6.0-test2/sound/oss/ali5455.c	2003-07-27 19:07:14.000000000 +0200
+++ linux-2.6.0-test2-bk1/sound/oss/ali5455.c	2003-08-03 08:59:09.000000000 +0200
@@ -2933,15 +2933,15 @@
 }

 static /*const */ struct file_operations ali_audio_fops = {
-	owner:THIS_MODULE,
-	llseek:no_llseek,
-	read:ali_read,
-	write:ali_write,
-	poll:ali_poll,
-	ioctl:ali_ioctl,
-	mmap:ali_mmap,
-	open:ali_open,
-	release:ali_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= ali_read,
+	.write		= ali_write,
+	.poll		= ali_poll,
+	.ioctl		= ali_ioctl,
+	.mmap		= ali_mmap,
+	.open		= ali_open,
+	.release	= ali_release,
 };

 /* Read AC97 codec registers */
@@ -3060,10 +3060,10 @@
 }

 static /*const */ struct file_operations ali_mixer_fops = {
-	owner:THIS_MODULE,
-	llseek:no_llseek,
-	ioctl:ali_ioctl_mixdev,
-	open:ali_open_mixdev,
+	.owner	= THIS_MODULE,
+	.llseek	= no_llseek,
+	.ioctl	= ali_ioctl_mixdev,
+	.open	= ali_open_mixdev,
 };

 /* AC97 codec initialisation.  These small functions exist so we don't
@@ -3661,10 +3661,13 @@
 MODULE_PARM(controller_independent_spdif_locked, "i");
 #define ALI5455_MODULE_NAME "ali5455"
 static struct pci_driver ali_pci_driver = {
-	name:ALI5455_MODULE_NAME, id_table:ali_pci_tbl, probe:ali_probe,
-	    remove:__devexit_p(ali_remove),
+	.name		= ALI5455_MODULE_NAME,
+	.id_table	= ali_pci_tbl,
+	.probe		= ali_probe,
+	.remove		= __devexit_p(ali_remove),
 #ifdef CONFIG_PM
-	suspend:ali_pm_suspend, resume:ali_pm_resume,
+	.suspend	= ali_pm_suspend,
+	.resume		= ali_pm_resume,
 #endif				/* CONFIG_PM */
 };

diff -Nru linux-2.6.0-test2/sound/oss/au1000.c linux-2.6.0-test2-bk1/sound/oss/au1000.c
--- linux-2.6.0-test2/sound/oss/au1000.c	2003-07-27 19:04:19.000000000 +0200
+++ linux-2.6.0-test2-bk1/sound/oss/au1000.c	2003-08-03 08:59:09.000000000 +0200
@@ -911,11 +911,11 @@
 }

 static /*const */ struct file_operations au1000_mixer_fops = {
-	owner:THIS_MODULE,
-	llseek:au1000_llseek,
-	ioctl:au1000_ioctl_mixdev,
-	open:au1000_open_mixdev,
-	release:au1000_release_mixdev,
+	.owner		= THIS_MODULE,
+	.llseek		= au1000_llseek,
+	.ioctl		= au1000_ioctl_mixdev,
+	.open		= au1000_open_mixdev,
+	.release	= au1000_release_mixdev,
 };

 /* --------------------------------------------------------------------- */
@@ -1940,15 +1940,15 @@
 }

 static /*const */ struct file_operations au1000_audio_fops = {
-	owner:		THIS_MODULE,
-	llseek:		au1000_llseek,
-	read:		au1000_read,
-	write:		au1000_write,
-	poll:		au1000_poll,
-	ioctl:		au1000_ioctl,
-	mmap:		au1000_mmap,
-	open:		au1000_open,
-	release:	au1000_release,
+	.owner		= THIS_MODULE,
+	.llseek		= au1000_llseek,
+	.read		= au1000_read,
+	.write		= au1000_write,
+	.poll		= au1000_poll,
+	.ioctl		= au1000_ioctl,
+	.mmap		= au1000_mmap,
+	.open		= au1000_open,
+	.release	= au1000_release,
 };


diff -Nru linux-2.6.0-test2/sound/oss/forte.c linux-2.6.0-test2-bk1/sound/oss/forte.c
--- linux-2.6.0-test2/sound/oss/forte.c	2003-07-27 19:00:29.000000000 +0200
+++ linux-2.6.0-test2-bk1/sound/oss/forte.c	2003-08-03 08:59:09.000000000 +0200
@@ -361,11 +361,11 @@


 static struct file_operations forte_mixer_fops = {
-	owner:	    		THIS_MODULE,
-	llseek:         	no_llseek,
-	ioctl:          	forte_mixer_ioctl,
-	open:           	forte_mixer_open,
-	release:        	forte_mixer_release,
+	.owner			= THIS_MODULE,
+	.llseek         	= no_llseek,
+	.ioctl          	= forte_mixer_ioctl,
+	.open           	= forte_mixer_open,
+	.release        	= forte_mixer_release,
 };


@@ -1632,15 +1632,15 @@


 static struct file_operations forte_dsp_fops = {
-	owner:			THIS_MODULE,
-	llseek:     		&no_llseek,
-	read:       		&forte_dsp_read,
-	write:      		&forte_dsp_write,
-	poll:       		&forte_dsp_poll,
-	ioctl:      		&forte_dsp_ioctl,
-	open:       		&forte_dsp_open,
-	release:    		&forte_dsp_release,
-	mmap:			&forte_dsp_mmap,
+	.owner			= THIS_MODULE,
+	.llseek     		= &no_llseek,
+	.read       		= &forte_dsp_read,
+	.write      		= &forte_dsp_write,
+	.poll       		= &forte_dsp_poll,
+	.ioctl      		= &forte_dsp_ioctl,
+	.open       		= &forte_dsp_open,
+	.release    		= &forte_dsp_release,
+	.mmap			= &forte_dsp_mmap,
 };


@@ -2099,10 +2099,10 @@


 static struct pci_driver forte_pci_driver = {
-	name:       		DRIVER_NAME,
-	id_table:   		forte_pci_ids,
-	probe:      		forte_probe,
-	remove:     		forte_remove,
+	.name			= DRIVER_NAME,
+	.id_table		= forte_pci_ids,
+	.probe	 		= forte_probe,
+	.remove			= forte_remove,

 };

diff -Nru linux-2.6.0-test2/sound/oss/hal2.c linux-2.6.0-test2-bk1/sound/oss/hal2.c
--- linux-2.6.0-test2/sound/oss/hal2.c	2003-08-03 09:15:09.651638104 +0200
+++ linux-2.6.0-test2-bk1/sound/oss/hal2.c	2003-08-03 08:59:09.000000000 +0200
@@ -1313,22 +1313,22 @@
 }

 static struct file_operations hal2_audio_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	read:		hal2_read,
-	write:		hal2_write,
-	poll:		hal2_poll,
-	ioctl:		hal2_ioctl,
-	open:		hal2_open,
-	release:	hal2_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= hal2_read,
+	.write		= hal2_write,
+	.poll		= hal2_poll,
+	.ioctl		= hal2_ioctl,
+	.open		= hal2_open,
+	.release	= hal2_release,
 };

 static struct file_operations hal2_mixer_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	ioctl:		hal2_ioctl_mixdev,
-	open:		hal2_open_mixdev,
-	release:	hal2_release_mixdev,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.ioctl		= hal2_ioctl_mixdev,
+	.open		= hal2_open_mixdev,
+	.release	= hal2_release_mixdev,
 };

 static int hal2_request_irq(hal2_card_t *hal2, int irq)
diff -Nru linux-2.6.0-test2/sound/oss/harmony.c linux-2.6.0-test2-bk1/sound/oss/harmony.c
--- linux-2.6.0-test2/sound/oss/harmony.c	2003-08-03 09:15:09.653637800 +0200
+++ linux-2.6.0-test2-bk1/sound/oss/harmony.c	2003-08-03 08:59:09.000000000 +0200
@@ -822,14 +822,14 @@
  */

 static struct file_operations harmony_audio_fops = {
-	owner:	THIS_MODULE,
-	llseek:	no_llseek,
-	read: 	harmony_audio_read,
-	write:	harmony_audio_write,
-	poll: 	harmony_audio_poll,
-	ioctl: 	harmony_audio_ioctl,
-	open: 	harmony_audio_open,
-	release:harmony_audio_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= harmony_audio_read,
+	.write		= harmony_audio_write,
+	.poll		= harmony_audio_poll,
+	.ioctl		= harmony_audio_ioctl,
+	.open		= harmony_audio_open,
+	.release	= harmony_audio_release,
 };

 static int harmony_audio_init(void)
@@ -1144,11 +1144,11 @@
 }

 static struct file_operations harmony_mixer_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	open:		harmony_mixer_open,
-	release:	harmony_mixer_release,
-	ioctl:		harmony_mixer_ioctl,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.open		= harmony_mixer_open,
+	.release	= harmony_mixer_release,
+	.ioctl		= harmony_mixer_ioctl,
 };


@@ -1274,9 +1274,9 @@
 MODULE_DEVICE_TABLE(parisc, harmony_tbl);

 static struct parisc_driver harmony_driver = {
-	name:		"Lasi Harmony",
-	id_table:	harmony_tbl,
-	probe:		harmony_driver_callback,
+	.name		= "Lasi Harmony",
+	.id_table	= harmony_tbl,
+	.probe		= harmony_driver_callback,
 };

 static int __init init_harmony(void)
diff -Nru linux-2.6.0-test2/sound/oss/ite8172.c linux-2.6.0-test2-bk1/sound/oss/ite8172.c
--- linux-2.6.0-test2/sound/oss/ite8172.c	2003-07-27 18:57:51.000000000 +0200
+++ linux-2.6.0-test2-bk1/sound/oss/ite8172.c	2003-08-03 09:02:01.000000000 +0200
@@ -1003,11 +1003,11 @@
 }

 static /*const*/ struct file_operations it8172_mixer_fops = {
-	owner:	THIS_MODULE,
-	llseek:	it8172_llseek,
-	ioctl:	it8172_ioctl_mixdev,
-	open:	it8172_open_mixdev,
-	release:	it8172_release_mixdev,
+	.owner		= THIS_MODULE,
+	.llseek		= it8172_llseek,
+	.ioctl		= it8172_ioctl_mixdev,
+	.open		= it8172_open_mixdev,
+	.release	= it8172_release_mixdev,
 };

 /* --------------------------------------------------------------------- */
@@ -1872,15 +1872,15 @@
 }

 static /*const*/ struct file_operations it8172_audio_fops = {
-	owner:	THIS_MODULE,
-	llseek:	it8172_llseek,
-	read:	it8172_read,
-	write:	it8172_write,
-	poll:	it8172_poll,
-	ioctl:	it8172_ioctl,
-	mmap:	it8172_mmap,
-	open:	it8172_open,
-	release:	it8172_release,
+	.owner		= THIS_MODULE,
+	.llseek		= it8172_llseek,
+	.read		= it8172_read,
+	.write		= it8172_write,
+	.poll		= it8172_poll,
+	.ioctl		= it8172_ioctl,
+	.mmap		= it8172_mmap,
+	.open		= it8172_open,
+	.release	= it8172_release,
 };


diff -Nru linux-2.6.0-test2/sound/oss/kahlua.c linux-2.6.0-test2-bk1/sound/oss/kahlua.c
--- linux-2.6.0-test2/sound/oss/kahlua.c	2003-07-27 19:09:14.000000000 +0200
+++ linux-2.6.0-test2-bk1/sound/oss/kahlua.c	2003-08-03 09:03:22.000000000 +0200
@@ -203,10 +203,10 @@
 MODULE_DEVICE_TABLE(pci, id_tbl);

 static struct pci_driver kahlua_driver = {
-	name:		"kahlua",
-	id_table:	id_tbl,
-	probe:		probe_one,
-	remove:         __devexit_p(remove_one),
+	.name		= "kahlua",
+	.id_table	= id_tbl,
+	.probe		= probe_one,
+	.remove		= __devexit_p(remove_one),
 };


diff -Nru linux-2.6.0-test2/sound/oss/swarm_cs4297a.c linux-2.6.0-test2-bk1/sound/oss/swarm_cs4297a.c
--- linux-2.6.0-test2/sound/oss/swarm_cs4297a.c	2003-08-03 09:15:09.668635520 +0200
+++ linux-2.6.0-test2-bk1/sound/oss/swarm_cs4297a.c	2003-08-03 09:04:24.000000000 +0200
@@ -1590,10 +1590,10 @@
 //   Mixer file operations struct.
 // ******************************************************************************************
 static /*const */ struct file_operations cs4297a_mixer_fops = {
-	llseek:cs4297a_llseek,
-	ioctl:cs4297a_ioctl_mixdev,
-	open:cs4297a_open_mixdev,
-	release:cs4297a_release_mixdev,
+	.llseek		= cs4297a_llseek,
+	.ioctl		= cs4297a_ioctl_mixdev,
+	.open		= cs4297a_open_mixdev,
+	.release	= cs4297a_release_mixdev,
 };

 // ---------------------------------------------------------------------
@@ -2508,14 +2508,14 @@
 //   Wave (audio) file operations struct.
 // ******************************************************************************************
 static /*const */ struct file_operations cs4297a_audio_fops = {
-	llseek:cs4297a_llseek,
-	read:cs4297a_read,
-	write:cs4297a_write,
-	poll:cs4297a_poll,
-	ioctl:cs4297a_ioctl,
-	mmap:cs4297a_mmap,
-	open:cs4297a_open,
-	release:cs4297a_release,
+	.llseek		= cs4297a_llseek,
+	.read		= cs4297a_read,
+	.write		= cs4297a_write,
+	.poll		= cs4297a_poll,
+	.ioctl		= cs4297a_ioctl,
+	.mmap		= cs4297a_mmap,
+	.open		= cs4297a_open,
+	.release	= cs4297a_release,
 };

 static irqreturn_t cs4297a_interrupt(int irq, void *dev_id, struct pt_regs *regs)
diff -Nru linux-2.6.0-test2/sound/oss/via82cxxx_audio.c linux-2.6.0-test2-bk1/sound/oss/via82cxxx_audio.c
--- linux-2.6.0-test2/sound/oss/via82cxxx_audio.c	2003-07-27 18:59:39.000000000 +0200
+++ linux-2.6.0-test2-bk1/sound/oss/via82cxxx_audio.c	2003-08-03 09:05:26.000000000 +0200
@@ -398,10 +398,10 @@


 static struct pci_driver via_driver = {
-	name:		VIA_MODULE_NAME,
-	id_table:	via_pci_tbl,
-	probe:		via_init_one,
-	remove:		__devexit_p(via_remove_one),
+	.name		= VIA_MODULE_NAME,
+	.id_table	= via_pci_tbl,
+	.probe		= via_init_one,
+	.remove		= __devexit_p(via_remove_one),
 };


@@ -2057,15 +2057,15 @@
  */

 static struct file_operations via_dsp_fops = {
-	owner:		THIS_MODULE,
-	open:		via_dsp_open,
-	release:	via_dsp_release,
-	read:		via_dsp_read,
-	write:		via_dsp_write,
-	poll:		via_dsp_poll,
-	llseek: 	no_llseek,
-	ioctl:		via_dsp_ioctl,
-	mmap:		via_dsp_mmap,
+	.owner		= THIS_MODULE,
+	.open		= via_dsp_open,
+	.release	= via_dsp_release,
+	.read		= via_dsp_read,
+	.write		= via_dsp_write,
+	.poll		= via_dsp_poll,
+	.llseek		= no_llseek,
+	.ioctl		= via_dsp_ioctl,
+	.mmap		= via_dsp_mmap,
 };


@@ -2179,10 +2179,10 @@


 struct vm_operations_struct via_mm_ops = {
-	nopage:		via_mm_nopage,
+	.nopage		= via_mm_nopage,

 #ifndef VM_RESERVED
-	swapout:	via_mm_swapout,
+	.swapout	= via_mm_swapout,
 #endif
 };

diff -Nru linux-2.6.0-test2/sound/parisc/harmony.c linux-2.6.0-test2-bk1/sound/parisc/harmony.c
--- linux-2.6.0-test2/sound/parisc/harmony.c	2003-07-27 19:01:06.000000000 +0200
+++ linux-2.6.0-test2-bk1/sound/parisc/harmony.c	2003-08-03 09:10:17.000000000 +0200
@@ -1107,9 +1107,9 @@
  */

 static struct parisc_driver snd_card_harmony_driver = {
-	name:		"Lasi ALSA Harmony",
-	id_table:	snd_card_harmony_devicetbl,
-	probe:		snd_card_harmony_probe,
+	.name		= "Lasi ALSA Harmony",
+	.id_table	= snd_card_harmony_devicetbl,
+	.probe		= snd_card_harmony_probe,
 };

 static int __init alsa_card_harmony_init(void)
