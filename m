Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272130AbTHRRPp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 13:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272132AbTHRRPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 13:15:45 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:56505 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S272130AbTHRRPW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 13:15:22 -0400
Date: Mon, 18 Aug 2003 19:15:17 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: alan@redhat.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6][RESEND] C99 initialisers for sound/oss
Message-ID: <Pine.LNX.4.51.0308181908110.6284@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-23717851-603958653-1061226917=:6284"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---23717851-603958653-1061226917=:6284
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi Alan, Linus,

this is a batch of C99 initialisers for sound/oss.
If this is sent to the wrong person please either cc or point the email
address.

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
Maciej

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
---23717851-603958653-1061226917=:6284
Content-Type: TEXT/plain; name="c99.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.51.0308181915170.6284@dns.toxicfilms.tv>
Content-Description: c99.diff
Content-Disposition: attachment; filename="c99.diff"

ZGlmZiAtTnJ1IGxpbnV4LTIuNi4wLXRlc3QyL3NvdW5kL29zcy9hYzk3X3Bs
dWdpbl9hZDE5ODAuYyBsaW51eC0yLjYuMC10ZXN0Mi1iazEvc291bmQvb3Nz
L2FjOTdfcGx1Z2luX2FkMTk4MC5jDQotLS0gbGludXgtMi42LjAtdGVzdDIv
c291bmQvb3NzL2FjOTdfcGx1Z2luX2FkMTk4MC5jCTIwMDMtMDctMjcgMTg6
NTU6NTMuMDAwMDAwMDAwICswMjAwDQorKysgbGludXgtMi42LjAtdGVzdDIt
YmsxL3NvdW5kL29zcy9hYzk3X3BsdWdpbl9hZDE5ODAuYwkyMDAzLTA4LTAz
IDA5OjAwOjM0LjAwMDAwMDAwMCArMDIwMA0KQEAgLTgzLDExICs4MywxMSBA
QA0KIAkNCiAgDQogc3RhdGljIHN0cnVjdCBhYzk3X2RyaXZlciBhZDE5ODBf
ZHJpdmVyID0gew0KLQljb2RlY19pZDogMHg0MTQ0NTM3MCwNCi0JY29kZWNf
bWFzazogMHhGRkZGRkZGRiwNCi0JbmFtZTogIkFEMTk4MCBleGFtcGxlIiwN
Ci0JcHJvYmU6CWFkMTk4MF9wcm9iZSwNCi0JcmVtb3ZlOiBfX2RldmV4aXRf
cChhZDE5ODBfcmVtb3ZlKSwNCisJLmNvZGVjX2lkCT0gMHg0MTQ0NTM3MCwN
CisJLmNvZGVjX21hc2sJPSAweEZGRkZGRkZGLA0KKwkubmFtZQkJPSAiQUQx
OTgwIGV4YW1wbGUiLA0KKwkucHJvYmUJCT0gYWQxOTgwX3Byb2JlLA0KKwku
cmVtb3ZlCQk9IF9fZGV2ZXhpdF9wKGFkMTk4MF9yZW1vdmUpLA0KIH07DQog
DQogLyoqDQpkaWZmIC1OcnUgbGludXgtMi42LjAtdGVzdDIvc291bmQvb3Nz
L2FkMTg4OS5jIGxpbnV4LTIuNi4wLXRlc3QyLWJrMS9zb3VuZC9vc3MvYWQx
ODg5LmMNCi0tLSBsaW51eC0yLjYuMC10ZXN0Mi9zb3VuZC9vc3MvYWQxODg5
LmMJMjAwMy0wNy0yNyAxOTowMDoyNS4wMDAwMDAwMDAgKzAyMDANCisrKyBs
aW51eC0yLjYuMC10ZXN0Mi1iazEvc291bmQvb3NzL2FkMTg4OS5jCTIwMDMt
MDgtMDMgMDg6NTk6MDkuMDAwMDAwMDAwICswMjAwDQpAQCAtNzc1LDE0ICs3
NzUsMTQgQEANCiB9DQogDQogc3RhdGljIHN0cnVjdCBmaWxlX29wZXJhdGlv
bnMgYWQxODg5X2ZvcHMgPSB7DQotCWxsc2VlazogICAgICAgICBub19sbHNl
ZWssDQotCXJlYWQ6ICAgICAgICAgICBhZDE4ODlfcmVhZCwNCi0Jd3JpdGU6
ICAgICAgICAgIGFkMTg4OV93cml0ZSwNCi0JcG9sbDogICAgICAgICAgIGFk
MTg4OV9wb2xsLA0KLQlpb2N0bDogICAgICAgICAgYWQxODg5X2lvY3RsLA0K
LQltbWFwOiAgICAgICAgICAgYWQxODg5X21tYXAsDQotCW9wZW46ICAgICAg
ICAgICBhZDE4ODlfb3BlbiwNCi0JcmVsZWFzZTogICAgICAgIGFkMTg4OV9y
ZWxlYXNlLA0KKwkubGxzZWVrCQk9IG5vX2xsc2VlaywNCisJLnJlYWQJCT0g
YWQxODg5X3JlYWQsDQorCS53cml0ZQkJPSBhZDE4ODlfd3JpdGUsDQorCS5w
b2xsCQk9IGFkMTg4OV9wb2xsLA0KKwkuaW9jdGwJCT0gYWQxODg5X2lvY3Rs
LA0KKwkubW1hcAkJPSBhZDE4ODlfbW1hcCwNCisJLm9wZW4JCT0gYWQxODg5
X29wZW4sDQorCS5yZWxlYXNlCT0gYWQxODg5X3JlbGVhc2UsDQogfTsNCiAN
CiAvKioqKioqKioqKioqKioqKioqKioqKioqKiAvZGV2L21peGVyIGludGVy
ZmFjZXMgKioqKioqKioqKioqKioqKioqKioqKioqICovDQpAQCAtODEwLDEw
ICs4MTAsMTAgQEANCiB9DQogDQogc3RhdGljIHN0cnVjdCBmaWxlX29wZXJh
dGlvbnMgYWQxODg5X21peGVyX2ZvcHMgPSB7DQotCWxsc2VlazogICAgICAg
ICBub19sbHNlZWssDQotCWlvY3RsOgkJYWQxODg5X21peGVyX2lvY3RsLA0K
LQlvcGVuOgkJYWQxODg5X21peGVyX29wZW4sDQotCXJlbGVhc2U6CWFkMTg4
OV9taXhlcl9yZWxlYXNlLA0KKwkubGxzZWVrCQk9IG5vX2xsc2VlaywNCisJ
LmlvY3RsCQk9IGFkMTg4OV9taXhlcl9pb2N0bCwNCisJLm9wZW4JCT0gYWQx
ODg5X21peGVyX29wZW4sDQorCS5yZWxlYXNlCT0gYWQxODg5X21peGVyX3Jl
bGVhc2UsDQogfTsNCiANCiAvKioqKioqKioqKioqKioqKioqKioqKioqKiBB
Qzk3IGludGVyZmFjZXMgKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
ICovDQpAQCAtMTA2NCwxMCArMTA2NCwxMCBAQA0KIE1PRFVMRV9MSUNFTlNF
KCJHUEwiKTsNCiANCiBzdGF0aWMgc3RydWN0IHBjaV9kcml2ZXIgYWQxODg5
X2RyaXZlciA9IHsNCi0JbmFtZToJCURFVk5BTUUsDQotCWlkX3RhYmxlOglh
ZDE4ODlfaWRfdGJsLA0KLQlwcm9iZToJCWFkMTg4OV9wcm9iZSwNCi0JcmVt
b3ZlOgkJX19kZXZleGl0X3AoYWQxODg5X3JlbW92ZSksDQorCS5uYW1lCQk9
IERFVk5BTUUsDQorCS5pZF90YWJsZQk9IGFkMTg4OV9pZF90YmwsDQorCS5w
cm9iZQkJPSBhZDE4ODlfcHJvYmUsDQorCS5yZW1vdmUJCT0gX19kZXZleGl0
X3AoYWQxODg5X3JlbW92ZSksDQogfTsNCiANCiBzdGF0aWMgaW50IF9faW5p
dCBhZDE4ODlfaW5pdF9tb2R1bGUodm9pZCkNCmRpZmYgLU5ydSBsaW51eC0y
LjYuMC10ZXN0Mi9zb3VuZC9vc3MvYWxpNTQ1NS5jIGxpbnV4LTIuNi4wLXRl
c3QyLWJrMS9zb3VuZC9vc3MvYWxpNTQ1NS5jDQotLS0gbGludXgtMi42LjAt
dGVzdDIvc291bmQvb3NzL2FsaTU0NTUuYwkyMDAzLTA3LTI3IDE5OjA3OjE0
LjAwMDAwMDAwMCArMDIwMA0KKysrIGxpbnV4LTIuNi4wLXRlc3QyLWJrMS9z
b3VuZC9vc3MvYWxpNTQ1NS5jCTIwMDMtMDgtMDMgMDg6NTk6MDkuMDAwMDAw
MDAwICswMjAwDQpAQCAtMjkzMywxNSArMjkzMywxNSBAQA0KIH0NCiANCiBz
dGF0aWMgLypjb25zdCAqLyBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25zIGFsaV9h
dWRpb19mb3BzID0gew0KLQlvd25lcjpUSElTX01PRFVMRSwgDQotCWxsc2Vl
azpub19sbHNlZWssIA0KLQlyZWFkOmFsaV9yZWFkLA0KLQl3cml0ZTphbGlf
d3JpdGUsIA0KLQlwb2xsOmFsaV9wb2xsLA0KLQlpb2N0bDphbGlfaW9jdGws
DQotCW1tYXA6YWxpX21tYXAsDQotCW9wZW46YWxpX29wZW4sDQotCXJlbGVh
c2U6YWxpX3JlbGVhc2UsDQorCS5vd25lcgkJPSBUSElTX01PRFVMRSwgDQor
CS5sbHNlZWsJCT0gbm9fbGxzZWVrLCANCisJLnJlYWQJCT0gYWxpX3JlYWQs
DQorCS53cml0ZQkJPSBhbGlfd3JpdGUsIA0KKwkucG9sbAkJPSBhbGlfcG9s
bCwNCisJLmlvY3RsCQk9IGFsaV9pb2N0bCwNCisJLm1tYXAJCT0gYWxpX21t
YXAsDQorCS5vcGVuCQk9IGFsaV9vcGVuLA0KKwkucmVsZWFzZQk9IGFsaV9y
ZWxlYXNlLA0KIH07DQogDQogLyogUmVhZCBBQzk3IGNvZGVjIHJlZ2lzdGVy
cyAqLw0KQEAgLTMwNjAsMTAgKzMwNjAsMTAgQEANCiB9DQogDQogc3RhdGlj
IC8qY29uc3QgKi8gc3RydWN0IGZpbGVfb3BlcmF0aW9ucyBhbGlfbWl4ZXJf
Zm9wcyA9IHsNCi0Jb3duZXI6VEhJU19NT0RVTEUsIA0KLQlsbHNlZWs6bm9f
bGxzZWVrLCANCi0JaW9jdGw6YWxpX2lvY3RsX21peGRldiwNCi0Jb3Blbjph
bGlfb3Blbl9taXhkZXYsDQorCS5vd25lcgk9IFRISVNfTU9EVUxFLCANCisJ
Lmxsc2Vlawk9IG5vX2xsc2VlaywgDQorCS5pb2N0bAk9IGFsaV9pb2N0bF9t
aXhkZXYsDQorCS5vcGVuCT0gYWxpX29wZW5fbWl4ZGV2LA0KIH07DQogDQog
LyogQUM5NyBjb2RlYyBpbml0aWFsaXNhdGlvbi4gIFRoZXNlIHNtYWxsIGZ1
bmN0aW9ucyBleGlzdCBzbyB3ZSBkb24ndA0KQEAgLTM2NjEsMTAgKzM2NjEs
MTMgQEANCiBNT0RVTEVfUEFSTShjb250cm9sbGVyX2luZGVwZW5kZW50X3Nw
ZGlmX2xvY2tlZCwgImkiKTsNCiAjZGVmaW5lIEFMSTU0NTVfTU9EVUxFX05B
TUUgImFsaTU0NTUiDQogc3RhdGljIHN0cnVjdCBwY2lfZHJpdmVyIGFsaV9w
Y2lfZHJpdmVyID0gew0KLQluYW1lOkFMSTU0NTVfTU9EVUxFX05BTUUsIGlk
X3RhYmxlOmFsaV9wY2lfdGJsLCBwcm9iZTphbGlfcHJvYmUsDQotCSAgICBy
ZW1vdmU6X19kZXZleGl0X3AoYWxpX3JlbW92ZSksDQorCS5uYW1lCQk9IEFM
STU0NTVfTU9EVUxFX05BTUUsDQorCS5pZF90YWJsZQk9IGFsaV9wY2lfdGJs
LA0KKwkucHJvYmUJCT0gYWxpX3Byb2JlLA0KKwkucmVtb3ZlCQk9IF9fZGV2
ZXhpdF9wKGFsaV9yZW1vdmUpLA0KICNpZmRlZiBDT05GSUdfUE0NCi0Jc3Vz
cGVuZDphbGlfcG1fc3VzcGVuZCwgcmVzdW1lOmFsaV9wbV9yZXN1bWUsDQor
CS5zdXNwZW5kCT0gYWxpX3BtX3N1c3BlbmQsDQorCS5yZXN1bWUJCT0gYWxp
X3BtX3Jlc3VtZSwNCiAjZW5kaWYJCQkJLyogQ09ORklHX1BNICovDQogfTsN
CiANCmRpZmYgLU5ydSBsaW51eC0yLjYuMC10ZXN0Mi9zb3VuZC9vc3MvYXUx
MDAwLmMgbGludXgtMi42LjAtdGVzdDItYmsxL3NvdW5kL29zcy9hdTEwMDAu
Yw0KLS0tIGxpbnV4LTIuNi4wLXRlc3QyL3NvdW5kL29zcy9hdTEwMDAuYwky
MDAzLTA3LTI3IDE5OjA0OjE5LjAwMDAwMDAwMCArMDIwMA0KKysrIGxpbnV4
LTIuNi4wLXRlc3QyLWJrMS9zb3VuZC9vc3MvYXUxMDAwLmMJMjAwMy0wOC0w
MyAwODo1OTowOS4wMDAwMDAwMDAgKzAyMDANCkBAIC05MTEsMTEgKzkxMSwx
MSBAQA0KIH0NCiANCiBzdGF0aWMgLypjb25zdCAqLyBzdHJ1Y3QgZmlsZV9v
cGVyYXRpb25zIGF1MTAwMF9taXhlcl9mb3BzID0gew0KLQlvd25lcjpUSElT
X01PRFVMRSwNCi0JbGxzZWVrOmF1MTAwMF9sbHNlZWssDQotCWlvY3RsOmF1
MTAwMF9pb2N0bF9taXhkZXYsDQotCW9wZW46YXUxMDAwX29wZW5fbWl4ZGV2
LA0KLQlyZWxlYXNlOmF1MTAwMF9yZWxlYXNlX21peGRldiwNCisJLm93bmVy
CQk9IFRISVNfTU9EVUxFLA0KKwkubGxzZWVrCQk9IGF1MTAwMF9sbHNlZWss
DQorCS5pb2N0bAkJPSBhdTEwMDBfaW9jdGxfbWl4ZGV2LA0KKwkub3BlbgkJ
PSBhdTEwMDBfb3Blbl9taXhkZXYsDQorCS5yZWxlYXNlCT0gYXUxMDAwX3Jl
bGVhc2VfbWl4ZGV2LA0KIH07DQogDQogLyogLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tICovDQpAQCAtMTk0MCwxNSArMTk0MCwxNSBAQA0KIH0NCiANCiBz
dGF0aWMgLypjb25zdCAqLyBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25zIGF1MTAw
MF9hdWRpb19mb3BzID0gew0KLQlvd25lcjoJCVRISVNfTU9EVUxFLA0KLQls
bHNlZWs6CQlhdTEwMDBfbGxzZWVrLA0KLQlyZWFkOgkJYXUxMDAwX3JlYWQs
DQotCXdyaXRlOgkJYXUxMDAwX3dyaXRlLA0KLQlwb2xsOgkJYXUxMDAwX3Bv
bGwsDQotCWlvY3RsOgkJYXUxMDAwX2lvY3RsLA0KLQltbWFwOgkJYXUxMDAw
X21tYXAsDQotCW9wZW46CQlhdTEwMDBfb3BlbiwNCi0JcmVsZWFzZToJYXUx
MDAwX3JlbGVhc2UsDQorCS5vd25lcgkJPSBUSElTX01PRFVMRSwNCisJLmxs
c2VlawkJPSBhdTEwMDBfbGxzZWVrLA0KKwkucmVhZAkJPSBhdTEwMDBfcmVh
ZCwNCisJLndyaXRlCQk9IGF1MTAwMF93cml0ZSwNCisJLnBvbGwJCT0gYXUx
MDAwX3BvbGwsDQorCS5pb2N0bAkJPSBhdTEwMDBfaW9jdGwsDQorCS5tbWFw
CQk9IGF1MTAwMF9tbWFwLA0KKwkub3BlbgkJPSBhdTEwMDBfb3BlbiwNCisJ
LnJlbGVhc2UJPSBhdTEwMDBfcmVsZWFzZSwNCiB9Ow0KIA0KIA0KZGlmZiAt
TnJ1IGxpbnV4LTIuNi4wLXRlc3QyL3NvdW5kL29zcy9mb3J0ZS5jIGxpbnV4
LTIuNi4wLXRlc3QyLWJrMS9zb3VuZC9vc3MvZm9ydGUuYw0KLS0tIGxpbnV4
LTIuNi4wLXRlc3QyL3NvdW5kL29zcy9mb3J0ZS5jCTIwMDMtMDctMjcgMTk6
MDA6MjkuMDAwMDAwMDAwICswMjAwDQorKysgbGludXgtMi42LjAtdGVzdDIt
YmsxL3NvdW5kL29zcy9mb3J0ZS5jCTIwMDMtMDgtMDMgMDg6NTk6MDkuMDAw
MDAwMDAwICswMjAwDQpAQCAtMzYxLDExICszNjEsMTEgQEANCiANCiANCiBz
dGF0aWMgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyBmb3J0ZV9taXhlcl9mb3Bz
ID0gew0KLQlvd25lcjoJICAgIAkJVEhJU19NT0RVTEUsDQotCWxsc2Vlazog
ICAgICAgICAJbm9fbGxzZWVrLA0KLQlpb2N0bDogICAgICAgICAgCWZvcnRl
X21peGVyX2lvY3RsLA0KLQlvcGVuOiAgICAgICAgICAgCWZvcnRlX21peGVy
X29wZW4sDQotCXJlbGVhc2U6ICAgICAgICAJZm9ydGVfbWl4ZXJfcmVsZWFz
ZSwNCisJLm93bmVyCQkJPSBUSElTX01PRFVMRSwNCisJLmxsc2VlayAgICAg
ICAgIAk9IG5vX2xsc2VlaywNCisJLmlvY3RsICAgICAgICAgIAk9IGZvcnRl
X21peGVyX2lvY3RsLA0KKwkub3BlbiAgICAgICAgICAgCT0gZm9ydGVfbWl4
ZXJfb3BlbiwNCisJLnJlbGVhc2UgICAgICAgIAk9IGZvcnRlX21peGVyX3Jl
bGVhc2UsDQogfTsNCiANCiANCkBAIC0xNjMyLDE1ICsxNjMyLDE1IEBADQog
DQogDQogc3RhdGljIHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgZm9ydGVfZHNw
X2ZvcHMgPSB7DQotCW93bmVyOgkJCVRISVNfTU9EVUxFLA0KLQlsbHNlZWs6
ICAgICAJCSZub19sbHNlZWssDQotCXJlYWQ6ICAgICAgIAkJJmZvcnRlX2Rz
cF9yZWFkLA0KLQl3cml0ZTogICAgICAJCSZmb3J0ZV9kc3Bfd3JpdGUsDQot
CXBvbGw6ICAgICAgIAkJJmZvcnRlX2RzcF9wb2xsLA0KLQlpb2N0bDogICAg
ICAJCSZmb3J0ZV9kc3BfaW9jdGwsDQotCW9wZW46ICAgICAgIAkJJmZvcnRl
X2RzcF9vcGVuLA0KLQlyZWxlYXNlOiAgICAJCSZmb3J0ZV9kc3BfcmVsZWFz
ZSwNCi0JbW1hcDoJCQkmZm9ydGVfZHNwX21tYXAsDQorCS5vd25lcgkJCT0g
VEhJU19NT0RVTEUsDQorCS5sbHNlZWsgICAgIAkJPSAmbm9fbGxzZWVrLA0K
KwkucmVhZCAgICAgICAJCT0gJmZvcnRlX2RzcF9yZWFkLA0KKwkud3JpdGUg
ICAgICAJCT0gJmZvcnRlX2RzcF93cml0ZSwNCisJLnBvbGwgICAgICAgCQk9
ICZmb3J0ZV9kc3BfcG9sbCwNCisJLmlvY3RsICAgICAgCQk9ICZmb3J0ZV9k
c3BfaW9jdGwsDQorCS5vcGVuICAgICAgIAkJPSAmZm9ydGVfZHNwX29wZW4s
DQorCS5yZWxlYXNlICAgIAkJPSAmZm9ydGVfZHNwX3JlbGVhc2UsDQorCS5t
bWFwCQkJPSAmZm9ydGVfZHNwX21tYXAsDQogfTsNCiANCiANCkBAIC0yMDk5
LDEwICsyMDk5LDEwIEBADQogDQogDQogc3RhdGljIHN0cnVjdCBwY2lfZHJp
dmVyIGZvcnRlX3BjaV9kcml2ZXIgPSB7DQotCW5hbWU6ICAgICAgIAkJRFJJ
VkVSX05BTUUsDQotCWlkX3RhYmxlOiAgIAkJZm9ydGVfcGNpX2lkcywNCi0J
cHJvYmU6ICAgICAgCQlmb3J0ZV9wcm9iZSwNCi0JcmVtb3ZlOiAgICAgCQlm
b3J0ZV9yZW1vdmUsDQorCS5uYW1lCQkJPSBEUklWRVJfTkFNRSwNCisJLmlk
X3RhYmxlCQk9IGZvcnRlX3BjaV9pZHMsDQorCS5wcm9iZQkgCQk9IGZvcnRl
X3Byb2JlLA0KKwkucmVtb3ZlCQkJPSBmb3J0ZV9yZW1vdmUsDQogDQogfTsN
CiANCmRpZmYgLU5ydSBsaW51eC0yLjYuMC10ZXN0Mi9zb3VuZC9vc3MvaGFs
Mi5jIGxpbnV4LTIuNi4wLXRlc3QyLWJrMS9zb3VuZC9vc3MvaGFsMi5jDQot
LS0gbGludXgtMi42LjAtdGVzdDIvc291bmQvb3NzL2hhbDIuYwkyMDAzLTA4
LTAzIDA5OjE1OjA5LjY1MTYzODEwNCArMDIwMA0KKysrIGxpbnV4LTIuNi4w
LXRlc3QyLWJrMS9zb3VuZC9vc3MvaGFsMi5jCTIwMDMtMDgtMDMgMDg6NTk6
MDkuMDAwMDAwMDAwICswMjAwDQpAQCAtMTMxMywyMiArMTMxMywyMiBAQA0K
IH0NCiANCiBzdGF0aWMgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyBoYWwyX2F1
ZGlvX2ZvcHMgPSB7DQotCW93bmVyOgkJVEhJU19NT0RVTEUsDQotCWxsc2Vl
azoJCW5vX2xsc2VlaywNCi0JcmVhZDoJCWhhbDJfcmVhZCwNCi0Jd3JpdGU6
CQloYWwyX3dyaXRlLA0KLQlwb2xsOgkJaGFsMl9wb2xsLA0KLQlpb2N0bDoJ
CWhhbDJfaW9jdGwsDQotCW9wZW46CQloYWwyX29wZW4sDQotCXJlbGVhc2U6
CWhhbDJfcmVsZWFzZSwNCisJLm93bmVyCQk9IFRISVNfTU9EVUxFLA0KKwku
bGxzZWVrCQk9IG5vX2xsc2VlaywNCisJLnJlYWQJCT0gaGFsMl9yZWFkLA0K
Kwkud3JpdGUJCT0gaGFsMl93cml0ZSwNCisJLnBvbGwJCT0gaGFsMl9wb2xs
LA0KKwkuaW9jdGwJCT0gaGFsMl9pb2N0bCwNCisJLm9wZW4JCT0gaGFsMl9v
cGVuLA0KKwkucmVsZWFzZQk9IGhhbDJfcmVsZWFzZSwNCiB9Ow0KIA0KIHN0
YXRpYyBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25zIGhhbDJfbWl4ZXJfZm9wcyA9
IHsNCi0Jb3duZXI6CQlUSElTX01PRFVMRSwNCi0JbGxzZWVrOgkJbm9fbGxz
ZWVrLA0KLQlpb2N0bDoJCWhhbDJfaW9jdGxfbWl4ZGV2LA0KLQlvcGVuOgkJ
aGFsMl9vcGVuX21peGRldiwNCi0JcmVsZWFzZToJaGFsMl9yZWxlYXNlX21p
eGRldiwNCisJLm93bmVyCQk9IFRISVNfTU9EVUxFLA0KKwkubGxzZWVrCQk9
IG5vX2xsc2VlaywNCisJLmlvY3RsCQk9IGhhbDJfaW9jdGxfbWl4ZGV2LA0K
Kwkub3BlbgkJPSBoYWwyX29wZW5fbWl4ZGV2LA0KKwkucmVsZWFzZQk9IGhh
bDJfcmVsZWFzZV9taXhkZXYsDQogfTsNCiANCiBzdGF0aWMgaW50IGhhbDJf
cmVxdWVzdF9pcnEoaGFsMl9jYXJkX3QgKmhhbDIsIGludCBpcnEpDQpkaWZm
IC1OcnUgbGludXgtMi42LjAtdGVzdDIvc291bmQvb3NzL2hhcm1vbnkuYyBs
aW51eC0yLjYuMC10ZXN0Mi1iazEvc291bmQvb3NzL2hhcm1vbnkuYw0KLS0t
IGxpbnV4LTIuNi4wLXRlc3QyL3NvdW5kL29zcy9oYXJtb255LmMJMjAwMy0w
OC0wMyAwOToxNTowOS42NTM2Mzc4MDAgKzAyMDANCisrKyBsaW51eC0yLjYu
MC10ZXN0Mi1iazEvc291bmQvb3NzL2hhcm1vbnkuYwkyMDAzLTA4LTAzIDA4
OjU5OjA5LjAwMDAwMDAwMCArMDIwMA0KQEAgLTgyMiwxNCArODIyLDE0IEBA
DQogICovDQogDQogc3RhdGljIHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgaGFy
bW9ueV9hdWRpb19mb3BzID0gew0KLQlvd25lcjoJVEhJU19NT0RVTEUsDQot
CWxsc2VlazoJbm9fbGxzZWVrLA0KLQlyZWFkOiAJaGFybW9ueV9hdWRpb19y
ZWFkLA0KLQl3cml0ZToJaGFybW9ueV9hdWRpb193cml0ZSwNCi0JcG9sbDog
CWhhcm1vbnlfYXVkaW9fcG9sbCwNCi0JaW9jdGw6IAloYXJtb255X2F1ZGlv
X2lvY3RsLA0KLQlvcGVuOiAJaGFybW9ueV9hdWRpb19vcGVuLA0KLQlyZWxl
YXNlOmhhcm1vbnlfYXVkaW9fcmVsZWFzZSwNCisJLm93bmVyCQk9IFRISVNf
TU9EVUxFLA0KKwkubGxzZWVrCQk9IG5vX2xsc2VlaywNCisJLnJlYWQJCT0g
aGFybW9ueV9hdWRpb19yZWFkLA0KKwkud3JpdGUJCT0gaGFybW9ueV9hdWRp
b193cml0ZSwNCisJLnBvbGwJCT0gaGFybW9ueV9hdWRpb19wb2xsLA0KKwku
aW9jdGwJCT0gaGFybW9ueV9hdWRpb19pb2N0bCwNCisJLm9wZW4JCT0gaGFy
bW9ueV9hdWRpb19vcGVuLA0KKwkucmVsZWFzZQk9IGhhcm1vbnlfYXVkaW9f
cmVsZWFzZSwNCiB9Ow0KIA0KIHN0YXRpYyBpbnQgaGFybW9ueV9hdWRpb19p
bml0KHZvaWQpDQpAQCAtMTE0NCwxMSArMTE0NCwxMSBAQA0KIH0NCiANCiBz
dGF0aWMgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyBoYXJtb255X21peGVyX2Zv
cHMgPSB7DQotCW93bmVyOgkJVEhJU19NT0RVTEUsDQotCWxsc2VlazoJCW5v
X2xsc2VlaywNCi0Jb3BlbjoJCWhhcm1vbnlfbWl4ZXJfb3BlbiwNCi0JcmVs
ZWFzZToJaGFybW9ueV9taXhlcl9yZWxlYXNlLA0KLQlpb2N0bDoJCWhhcm1v
bnlfbWl4ZXJfaW9jdGwsDQorCS5vd25lcgkJPSBUSElTX01PRFVMRSwNCisJ
Lmxsc2VlawkJPSBub19sbHNlZWssDQorCS5vcGVuCQk9IGhhcm1vbnlfbWl4
ZXJfb3BlbiwNCisJLnJlbGVhc2UJPSBoYXJtb255X21peGVyX3JlbGVhc2Us
DQorCS5pb2N0bAkJPSBoYXJtb255X21peGVyX2lvY3RsLA0KIH07DQogDQog
DQpAQCAtMTI3NCw5ICsxMjc0LDkgQEANCiBNT0RVTEVfREVWSUNFX1RBQkxF
KHBhcmlzYywgaGFybW9ueV90YmwpOw0KIA0KIHN0YXRpYyBzdHJ1Y3QgcGFy
aXNjX2RyaXZlciBoYXJtb255X2RyaXZlciA9IHsNCi0JbmFtZToJCSJMYXNp
IEhhcm1vbnkiLA0KLQlpZF90YWJsZToJaGFybW9ueV90YmwsDQotCXByb2Jl
OgkJaGFybW9ueV9kcml2ZXJfY2FsbGJhY2ssDQorCS5uYW1lCQk9ICJMYXNp
IEhhcm1vbnkiLA0KKwkuaWRfdGFibGUJPSBoYXJtb255X3RibCwNCisJLnBy
b2JlCQk9IGhhcm1vbnlfZHJpdmVyX2NhbGxiYWNrLA0KIH07DQogDQogc3Rh
dGljIGludCBfX2luaXQgaW5pdF9oYXJtb255KHZvaWQpDQpkaWZmIC1OcnUg
bGludXgtMi42LjAtdGVzdDIvc291bmQvb3NzL2l0ZTgxNzIuYyBsaW51eC0y
LjYuMC10ZXN0Mi1iazEvc291bmQvb3NzL2l0ZTgxNzIuYw0KLS0tIGxpbnV4
LTIuNi4wLXRlc3QyL3NvdW5kL29zcy9pdGU4MTcyLmMJMjAwMy0wNy0yNyAx
ODo1Nzo1MS4wMDAwMDAwMDAgKzAyMDANCisrKyBsaW51eC0yLjYuMC10ZXN0
Mi1iazEvc291bmQvb3NzL2l0ZTgxNzIuYwkyMDAzLTA4LTAzIDA5OjAyOjAx
LjAwMDAwMDAwMCArMDIwMA0KQEAgLTEwMDMsMTEgKzEwMDMsMTEgQEANCiB9
DQogDQogc3RhdGljIC8qY29uc3QqLyBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25z
IGl0ODE3Ml9taXhlcl9mb3BzID0gew0KLQlvd25lcjoJVEhJU19NT0RVTEUs
DQotCWxsc2VlazoJaXQ4MTcyX2xsc2VlaywNCi0JaW9jdGw6CWl0ODE3Ml9p
b2N0bF9taXhkZXYsDQotCW9wZW46CWl0ODE3Ml9vcGVuX21peGRldiwNCi0J
cmVsZWFzZToJaXQ4MTcyX3JlbGVhc2VfbWl4ZGV2LA0KKwkub3duZXIJCT0g
VEhJU19NT0RVTEUsDQorCS5sbHNlZWsJCT0gaXQ4MTcyX2xsc2VlaywNCisJ
LmlvY3RsCQk9IGl0ODE3Ml9pb2N0bF9taXhkZXYsDQorCS5vcGVuCQk9IGl0
ODE3Ml9vcGVuX21peGRldiwNCisJLnJlbGVhc2UJPSBpdDgxNzJfcmVsZWFz
ZV9taXhkZXYsDQogfTsNCiANCiAvKiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0gKi8NCkBAIC0xODcyLDE1ICsxODcyLDE1IEBADQogfQ0KIA0KIHN0YXRp
YyAvKmNvbnN0Ki8gc3RydWN0IGZpbGVfb3BlcmF0aW9ucyBpdDgxNzJfYXVk
aW9fZm9wcyA9IHsNCi0Jb3duZXI6CVRISVNfTU9EVUxFLA0KLQlsbHNlZWs6
CWl0ODE3Ml9sbHNlZWssDQotCXJlYWQ6CWl0ODE3Ml9yZWFkLA0KLQl3cml0
ZToJaXQ4MTcyX3dyaXRlLA0KLQlwb2xsOglpdDgxNzJfcG9sbCwNCi0JaW9j
dGw6CWl0ODE3Ml9pb2N0bCwNCi0JbW1hcDoJaXQ4MTcyX21tYXAsDQotCW9w
ZW46CWl0ODE3Ml9vcGVuLA0KLQlyZWxlYXNlOglpdDgxNzJfcmVsZWFzZSwN
CisJLm93bmVyCQk9IFRISVNfTU9EVUxFLA0KKwkubGxzZWVrCQk9IGl0ODE3
Ml9sbHNlZWssDQorCS5yZWFkCQk9IGl0ODE3Ml9yZWFkLA0KKwkud3JpdGUJ
CT0gaXQ4MTcyX3dyaXRlLA0KKwkucG9sbAkJPSBpdDgxNzJfcG9sbCwNCisJ
LmlvY3RsCQk9IGl0ODE3Ml9pb2N0bCwNCisJLm1tYXAJCT0gaXQ4MTcyX21t
YXAsDQorCS5vcGVuCQk9IGl0ODE3Ml9vcGVuLA0KKwkucmVsZWFzZQk9IGl0
ODE3Ml9yZWxlYXNlLA0KIH07DQogDQogDQpkaWZmIC1OcnUgbGludXgtMi42
LjAtdGVzdDIvc291bmQvb3NzL2thaGx1YS5jIGxpbnV4LTIuNi4wLXRlc3Qy
LWJrMS9zb3VuZC9vc3Mva2FobHVhLmMNCi0tLSBsaW51eC0yLjYuMC10ZXN0
Mi9zb3VuZC9vc3Mva2FobHVhLmMJMjAwMy0wNy0yNyAxOTowOToxNC4wMDAw
MDAwMDAgKzAyMDANCisrKyBsaW51eC0yLjYuMC10ZXN0Mi1iazEvc291bmQv
b3NzL2thaGx1YS5jCTIwMDMtMDgtMDMgMDk6MDM6MjIuMDAwMDAwMDAwICsw
MjAwDQpAQCAtMjAzLDEwICsyMDMsMTAgQEANCiBNT0RVTEVfREVWSUNFX1RB
QkxFKHBjaSwgaWRfdGJsKTsNCiANCiBzdGF0aWMgc3RydWN0IHBjaV9kcml2
ZXIga2FobHVhX2RyaXZlciA9IHsNCi0JbmFtZToJCSJrYWhsdWEiLA0KLQlp
ZF90YWJsZToJaWRfdGJsLA0KLQlwcm9iZToJCXByb2JlX29uZSwNCi0JcmVt
b3ZlOiAgICAgICAgIF9fZGV2ZXhpdF9wKHJlbW92ZV9vbmUpLA0KKwkubmFt
ZQkJPSAia2FobHVhIiwNCisJLmlkX3RhYmxlCT0gaWRfdGJsLA0KKwkucHJv
YmUJCT0gcHJvYmVfb25lLA0KKwkucmVtb3ZlCQk9IF9fZGV2ZXhpdF9wKHJl
bW92ZV9vbmUpLA0KIH07DQogDQogDQpkaWZmIC1OcnUgbGludXgtMi42LjAt
dGVzdDIvc291bmQvb3NzL3N3YXJtX2NzNDI5N2EuYyBsaW51eC0yLjYuMC10
ZXN0Mi1iazEvc291bmQvb3NzL3N3YXJtX2NzNDI5N2EuYw0KLS0tIGxpbnV4
LTIuNi4wLXRlc3QyL3NvdW5kL29zcy9zd2FybV9jczQyOTdhLmMJMjAwMy0w
OC0wMyAwOToxNTowOS42Njg2MzU1MjAgKzAyMDANCisrKyBsaW51eC0yLjYu
MC10ZXN0Mi1iazEvc291bmQvb3NzL3N3YXJtX2NzNDI5N2EuYwkyMDAzLTA4
LTAzIDA5OjA0OjI0LjAwMDAwMDAwMCArMDIwMA0KQEAgLTE1OTAsMTAgKzE1
OTAsMTAgQEANCiAvLyAgIE1peGVyIGZpbGUgb3BlcmF0aW9ucyBzdHJ1Y3Qu
DQogLy8gKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqDQogc3RhdGljIC8qY29uc3QgKi8gc3RydWN0IGZpbGVfb3BlcmF0
aW9ucyBjczQyOTdhX21peGVyX2ZvcHMgPSB7DQotCWxsc2VlazpjczQyOTdh
X2xsc2VlaywNCi0JaW9jdGw6Y3M0Mjk3YV9pb2N0bF9taXhkZXYsDQotCW9w
ZW46Y3M0Mjk3YV9vcGVuX21peGRldiwNCi0JcmVsZWFzZTpjczQyOTdhX3Jl
bGVhc2VfbWl4ZGV2LA0KKwkubGxzZWVrCQk9IGNzNDI5N2FfbGxzZWVrLA0K
KwkuaW9jdGwJCT0gY3M0Mjk3YV9pb2N0bF9taXhkZXYsDQorCS5vcGVuCQk9
IGNzNDI5N2Ffb3Blbl9taXhkZXYsDQorCS5yZWxlYXNlCT0gY3M0Mjk3YV9y
ZWxlYXNlX21peGRldiwNCiB9Ow0KIA0KIC8vIC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLSANCkBAIC0yNTA4LDE0ICsyNTA4LDE0IEBADQogLy8gICBXYXZl
IChhdWRpbykgZmlsZSBvcGVyYXRpb25zIHN0cnVjdC4NCiAvLyAqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioNCiBzdGF0
aWMgLypjb25zdCAqLyBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25zIGNzNDI5N2Ff
YXVkaW9fZm9wcyA9IHsNCi0JbGxzZWVrOmNzNDI5N2FfbGxzZWVrLA0KLQly
ZWFkOmNzNDI5N2FfcmVhZCwNCi0Jd3JpdGU6Y3M0Mjk3YV93cml0ZSwNCi0J
cG9sbDpjczQyOTdhX3BvbGwsDQotCWlvY3RsOmNzNDI5N2FfaW9jdGwsDQot
CW1tYXA6Y3M0Mjk3YV9tbWFwLA0KLQlvcGVuOmNzNDI5N2Ffb3BlbiwNCi0J
cmVsZWFzZTpjczQyOTdhX3JlbGVhc2UsDQorCS5sbHNlZWsJCT0gY3M0Mjk3
YV9sbHNlZWssDQorCS5yZWFkCQk9IGNzNDI5N2FfcmVhZCwNCisJLndyaXRl
CQk9IGNzNDI5N2Ffd3JpdGUsDQorCS5wb2xsCQk9IGNzNDI5N2FfcG9sbCwN
CisJLmlvY3RsCQk9IGNzNDI5N2FfaW9jdGwsDQorCS5tbWFwCQk9IGNzNDI5
N2FfbW1hcCwNCisJLm9wZW4JCT0gY3M0Mjk3YV9vcGVuLA0KKwkucmVsZWFz
ZQk9IGNzNDI5N2FfcmVsZWFzZSwNCiB9Ow0KIA0KIHN0YXRpYyBpcnFyZXR1
cm5fdCBjczQyOTdhX2ludGVycnVwdChpbnQgaXJxLCB2b2lkICpkZXZfaWQs
IHN0cnVjdCBwdF9yZWdzICpyZWdzKQ0KZGlmZiAtTnJ1IGxpbnV4LTIuNi4w
LXRlc3QyL3NvdW5kL29zcy92aWE4MmN4eHhfYXVkaW8uYyBsaW51eC0yLjYu
MC10ZXN0Mi1iazEvc291bmQvb3NzL3ZpYTgyY3h4eF9hdWRpby5jDQotLS0g
bGludXgtMi42LjAtdGVzdDIvc291bmQvb3NzL3ZpYTgyY3h4eF9hdWRpby5j
CTIwMDMtMDctMjcgMTg6NTk6MzkuMDAwMDAwMDAwICswMjAwDQorKysgbGlu
dXgtMi42LjAtdGVzdDItYmsxL3NvdW5kL29zcy92aWE4MmN4eHhfYXVkaW8u
YwkyMDAzLTA4LTAzIDA5OjA1OjI2LjAwMDAwMDAwMCArMDIwMA0KQEAgLTM5
OCwxMCArMzk4LDEwIEBADQogDQogDQogc3RhdGljIHN0cnVjdCBwY2lfZHJp
dmVyIHZpYV9kcml2ZXIgPSB7DQotCW5hbWU6CQlWSUFfTU9EVUxFX05BTUUs
DQotCWlkX3RhYmxlOgl2aWFfcGNpX3RibCwNCi0JcHJvYmU6CQl2aWFfaW5p
dF9vbmUsDQotCXJlbW92ZToJCV9fZGV2ZXhpdF9wKHZpYV9yZW1vdmVfb25l
KSwNCisJLm5hbWUJCT0gVklBX01PRFVMRV9OQU1FLA0KKwkuaWRfdGFibGUJ
PSB2aWFfcGNpX3RibCwNCisJLnByb2JlCQk9IHZpYV9pbml0X29uZSwNCisJ
LnJlbW92ZQkJPSBfX2RldmV4aXRfcCh2aWFfcmVtb3ZlX29uZSksDQogfTsN
CiANCiANCkBAIC0yMDU3LDE1ICsyMDU3LDE1IEBADQogICovDQogDQogc3Rh
dGljIHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgdmlhX2RzcF9mb3BzID0gew0K
LQlvd25lcjoJCVRISVNfTU9EVUxFLA0KLQlvcGVuOgkJdmlhX2RzcF9vcGVu
LA0KLQlyZWxlYXNlOgl2aWFfZHNwX3JlbGVhc2UsDQotCXJlYWQ6CQl2aWFf
ZHNwX3JlYWQsDQotCXdyaXRlOgkJdmlhX2RzcF93cml0ZSwNCi0JcG9sbDoJ
CXZpYV9kc3BfcG9sbCwNCi0JbGxzZWVrOiAJbm9fbGxzZWVrLA0KLQlpb2N0
bDoJCXZpYV9kc3BfaW9jdGwsDQotCW1tYXA6CQl2aWFfZHNwX21tYXAsDQor
CS5vd25lcgkJPSBUSElTX01PRFVMRSwNCisJLm9wZW4JCT0gdmlhX2RzcF9v
cGVuLA0KKwkucmVsZWFzZQk9IHZpYV9kc3BfcmVsZWFzZSwNCisJLnJlYWQJ
CT0gdmlhX2RzcF9yZWFkLA0KKwkud3JpdGUJCT0gdmlhX2RzcF93cml0ZSwN
CisJLnBvbGwJCT0gdmlhX2RzcF9wb2xsLA0KKwkubGxzZWVrCQk9IG5vX2xs
c2VlaywNCisJLmlvY3RsCQk9IHZpYV9kc3BfaW9jdGwsDQorCS5tbWFwCQk9
IHZpYV9kc3BfbW1hcCwNCiB9Ow0KIA0KIA0KQEAgLTIxNzksMTAgKzIxNzks
MTAgQEANCiANCiANCiBzdHJ1Y3Qgdm1fb3BlcmF0aW9uc19zdHJ1Y3Qgdmlh
X21tX29wcyA9IHsNCi0Jbm9wYWdlOgkJdmlhX21tX25vcGFnZSwNCisJLm5v
cGFnZQkJPSB2aWFfbW1fbm9wYWdlLA0KIA0KICNpZm5kZWYgVk1fUkVTRVJW
RUQNCi0Jc3dhcG91dDoJdmlhX21tX3N3YXBvdXQsDQorCS5zd2Fwb3V0CT0g
dmlhX21tX3N3YXBvdXQsDQogI2VuZGlmDQogfTsNCiANCmRpZmYgLU5ydSBs
aW51eC0yLjYuMC10ZXN0Mi9zb3VuZC9wYXJpc2MvaGFybW9ueS5jIGxpbnV4
LTIuNi4wLXRlc3QyLWJrMS9zb3VuZC9wYXJpc2MvaGFybW9ueS5jDQotLS0g
bGludXgtMi42LjAtdGVzdDIvc291bmQvcGFyaXNjL2hhcm1vbnkuYwkyMDAz
LTA3LTI3IDE5OjAxOjA2LjAwMDAwMDAwMCArMDIwMA0KKysrIGxpbnV4LTIu
Ni4wLXRlc3QyLWJrMS9zb3VuZC9wYXJpc2MvaGFybW9ueS5jCTIwMDMtMDgt
MDMgMDk6MTA6MTcuMDAwMDAwMDAwICswMjAwDQpAQCAtMTEwNyw5ICsxMTA3
LDkgQEANCiAgKi8NCiANCiBzdGF0aWMgc3RydWN0IHBhcmlzY19kcml2ZXIg
c25kX2NhcmRfaGFybW9ueV9kcml2ZXIgPSB7DQotCW5hbWU6CQkiTGFzaSBB
TFNBIEhhcm1vbnkiLA0KLQlpZF90YWJsZToJc25kX2NhcmRfaGFybW9ueV9k
ZXZpY2V0YmwsDQotCXByb2JlOgkJc25kX2NhcmRfaGFybW9ueV9wcm9iZSwN
CisJLm5hbWUJCT0gIkxhc2kgQUxTQSBIYXJtb255IiwNCisJLmlkX3RhYmxl
CT0gc25kX2NhcmRfaGFybW9ueV9kZXZpY2V0YmwsDQorCS5wcm9iZQkJPSBz
bmRfY2FyZF9oYXJtb255X3Byb2JlLA0KIH07DQogDQogc3RhdGljIGludCBf
X2luaXQgYWxzYV9jYXJkX2hhcm1vbnlfaW5pdCh2b2lkKQ0K

---23717851-603958653-1061226917=:6284--
