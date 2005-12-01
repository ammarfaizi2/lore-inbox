Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbVLAM7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbVLAM7R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 07:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbVLAM7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 07:59:17 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:29950 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S932210AbVLAM7P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 07:59:15 -0500
Date: Thu, 1 Dec 2005 13:59:09 +0100 (MET)
From: Richard Knutsson <ricknu-0@student.ltu.se>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Richard Knutsson <ricknu-0@student.ltu.se>
Message-Id: <20051201130418.28376.54154.sendpatchset@thinktank.campus.ltu.se>
In-Reply-To: <20051201130338.28376.65935.sendpatchset@thinktank.campus.ltu.se>
References: <20051201130338.28376.65935.sendpatchset@thinktank.campus.ltu.se>
Subject: [PATCH 2.6.15-rc3-mm1 2/3] sound: Replace pci_module_init() with pci_register_driver() in -mm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Knutsson <ricknu-0@student.ltu.se>

Replace obsolete pci_module_init() with pci_register_driver().

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

---

 oss/ad1889.c                  |    2 +-
 oss/btaudio.c                 |    2 +-
 oss/cmpci.c                   |    2 +-
 oss/cs4281/cs4281m.c          |    2 +-
 oss/cs46xx.c                  |    2 +-
 oss/emu10k1/main.c            |    2 +-
 oss/es1370.c                  |    2 +-
 oss/es1371.c                  |    2 +-
 oss/ite8172.c                 |    2 +-
 oss/kahlua.c                  |    2 +-
 oss/maestro.c                 |    2 +-
 oss/nec_vrc5477.c             |    2 +-
 oss/nm256_audio.c             |    2 +-
 oss/rme96xx.c                 |    2 +-
 oss/sonicvibes.c              |    2 +-
 oss/ymfpci.c                  |    2 +-
 pci/cs5535audio/cs5535audio.c |    2 +-
 17 files changed, 17 insertions(+), 17 deletions(-)

diff -Narup a/sound/oss/ad1889.c b/sound/oss/ad1889.c
--- a/sound/oss/ad1889.c	2005-12-01 01:35:03.000000000 +0100
+++ b/sound/oss/ad1889.c	2005-12-01 01:52:22.000000000 +0100
@@ -1089,7 +1089,7 @@ static struct pci_driver ad1889_driver =
 
 static int __init ad1889_init_module(void)
 {
-	return pci_module_init(&ad1889_driver);
+	return pci_register_driver(&ad1889_driver);
 }
 
 static void ad1889_exit_module(void)
diff -Narup a/sound/oss/btaudio.c b/sound/oss/btaudio.c
--- a/sound/oss/btaudio.c	2005-12-01 01:35:02.000000000 +0100
+++ b/sound/oss/btaudio.c	2005-12-01 01:52:22.000000000 +0100
@@ -1101,7 +1101,7 @@ static int btaudio_init_module(void)
 	       digital ? "digital" : "",
 	       analog && digital ? "+" : "",
 	       analog ? "analog" : "");
-	return pci_module_init(&btaudio_pci_driver);
+	return pci_register_driver(&btaudio_pci_driver);
 }
 
 static void btaudio_cleanup_module(void)
diff -Narup a/sound/oss/cmpci.c b/sound/oss/cmpci.c
--- a/sound/oss/cmpci.c	2005-12-01 01:35:02.000000000 +0100
+++ b/sound/oss/cmpci.c	2005-12-01 01:52:22.000000000 +0100
@@ -3366,7 +3366,7 @@ static struct pci_driver cm_driver = {
 static int __init init_cmpci(void)
 {
 	printk(KERN_INFO "cmpci: version $Revision: 6.82 $ time " __TIME__ " " __DATE__ "\n");
-	return pci_module_init(&cm_driver);
+	return pci_register_driver(&cm_driver);
 }
 
 static void __exit cleanup_cmpci(void)
diff -Narup a/sound/oss/cs4281/cs4281m.c b/sound/oss/cs4281/cs4281m.c
--- a/sound/oss/cs4281/cs4281m.c	2005-12-01 01:35:02.000000000 +0100
+++ b/sound/oss/cs4281/cs4281m.c	2005-12-01 01:52:22.000000000 +0100
@@ -4461,7 +4461,7 @@ static int __init cs4281_init_module(voi
 	printk(KERN_INFO "cs4281: version v%d.%02d.%d time " __TIME__ " "
 	       __DATE__ "\n", CS4281_MAJOR_VERSION, CS4281_MINOR_VERSION,
 	       CS4281_ARCH);
-	rtn = pci_module_init(&cs4281_pci_driver);
+	rtn = pci_register_driver(&cs4281_pci_driver);
 
 	CS_DBGOUT(CS_INIT | CS_FUNCTION, 2,
 		  printk(KERN_INFO "cs4281: cs4281_init_module()- (%d)\n",rtn));
diff -Narup a/sound/oss/cs46xx.c b/sound/oss/cs46xx.c
--- a/sound/oss/cs46xx.c	2005-12-01 01:35:02.000000000 +0100
+++ b/sound/oss/cs46xx.c	2005-12-01 01:52:22.000000000 +0100
@@ -5690,7 +5690,7 @@ static int __init cs46xx_init_module(voi
 	int rtn = 0;
 	CS_DBGOUT(CS_INIT | CS_FUNCTION, 2, printk(KERN_INFO 
 		"cs46xx: cs46xx_init_module()+ \n"));
-	rtn = pci_module_init(&cs46xx_pci_driver);
+	rtn = pci_register_driver(&cs46xx_pci_driver);
 
 	if(rtn == -ENODEV)
 	{
diff -Narup a/sound/oss/emu10k1/main.c b/sound/oss/emu10k1/main.c
--- a/sound/oss/emu10k1/main.c	2005-12-01 01:35:03.000000000 +0100
+++ b/sound/oss/emu10k1/main.c	2005-12-01 01:52:22.000000000 +0100
@@ -1428,7 +1428,7 @@ static int __init emu10k1_init_module(vo
 {
 	printk(KERN_INFO "Creative EMU10K1 PCI Audio Driver, version " DRIVER_VERSION ", " __TIME__ " " __DATE__ "\n");
 
-	return pci_module_init(&emu10k1_pci_driver);
+	return pci_register_driver(&emu10k1_pci_driver);
 }
 
 static void __exit emu10k1_cleanup_module(void)
diff -Narup a/sound/oss/es1370.c b/sound/oss/es1370.c
--- a/sound/oss/es1370.c	2005-12-01 01:35:03.000000000 +0100
+++ b/sound/oss/es1370.c	2005-12-01 01:52:23.000000000 +0100
@@ -2779,7 +2779,7 @@ static struct pci_driver es1370_driver =
 static int __init init_es1370(void)
 {
 	printk(KERN_INFO "es1370: version v0.38 time " __TIME__ " " __DATE__ "\n");
-	return pci_module_init(&es1370_driver);
+	return pci_register_driver(&es1370_driver);
 }
 
 static void __exit cleanup_es1370(void)
diff -Narup a/sound/oss/es1371.c b/sound/oss/es1371.c
--- a/sound/oss/es1371.c	2005-12-01 01:35:03.000000000 +0100
+++ b/sound/oss/es1371.c	2005-12-01 01:52:23.000000000 +0100
@@ -3090,7 +3090,7 @@ static struct pci_driver es1371_driver =
 static int __init init_es1371(void)
 {
 	printk(KERN_INFO PFX "version v0.32 time " __TIME__ " " __DATE__ "\n");
-	return pci_module_init(&es1371_driver);
+	return pci_register_driver(&es1371_driver);
 }
 
 static void __exit cleanup_es1371(void)
diff -Narup a/sound/oss/ite8172.c b/sound/oss/ite8172.c
--- a/sound/oss/ite8172.c	2005-12-01 01:35:02.000000000 +0100
+++ b/sound/oss/ite8172.c	2005-12-01 01:52:22.000000000 +0100
@@ -2206,7 +2206,7 @@ static struct pci_driver it8172_driver =
 static int __init init_it8172(void)
 {
 	info("version v0.5 time " __TIME__ " " __DATE__);
-	return pci_module_init(&it8172_driver);
+	return pci_register_driver(&it8172_driver);
 }
 
 static void __exit cleanup_it8172(void)
diff -Narup a/sound/oss/kahlua.c b/sound/oss/kahlua.c
--- a/sound/oss/kahlua.c	2005-12-01 01:35:02.000000000 +0100
+++ b/sound/oss/kahlua.c	2005-12-01 01:52:22.000000000 +0100
@@ -218,7 +218,7 @@ static struct pci_driver kahlua_driver =
 static int __init kahlua_init_module(void)
 {
 	printk(KERN_INFO "Cyrix Kahlua VSA1 XpressAudio support (c) Copyright 2003 Red Hat Inc\n");
-	return pci_module_init(&kahlua_driver);
+	return pci_register_driver(&kahlua_driver);
 }
 
 static void __devexit kahlua_cleanup_module(void)
diff -Narup a/sound/oss/maestro.c b/sound/oss/maestro.c
--- a/sound/oss/maestro.c	2005-12-01 01:35:02.000000000 +0100
+++ b/sound/oss/maestro.c	2005-12-01 01:52:22.000000000 +0100
@@ -3624,7 +3624,7 @@ static int __init init_maestro(void)
 {
 	int rc;
 
-	rc = pci_module_init(&maestro_pci_driver);
+	rc = pci_register_driver(&maestro_pci_driver);
 	if (rc < 0)
 		return rc;
 
diff -Narup a/sound/oss/nec_vrc5477.c b/sound/oss/nec_vrc5477.c
--- a/sound/oss/nec_vrc5477.c	2005-12-01 01:35:02.000000000 +0100
+++ b/sound/oss/nec_vrc5477.c	2005-12-01 01:52:22.000000000 +0100
@@ -2045,7 +2045,7 @@ static struct pci_driver vrc5477_ac97_dr
 static int __init init_vrc5477_ac97(void)
 {
 	printk("Vrc5477 AC97 driver: version v0.2 time " __TIME__ " " __DATE__ " by Jun Sun\n");
-	return pci_module_init(&vrc5477_ac97_driver);
+	return pci_register_driver(&vrc5477_ac97_driver);
 }
 
 static void __exit cleanup_vrc5477_ac97(void)
diff -Narup a/sound/oss/nm256_audio.c b/sound/oss/nm256_audio.c
--- a/sound/oss/nm256_audio.c	2005-12-01 01:35:02.000000000 +0100
+++ b/sound/oss/nm256_audio.c	2005-12-01 01:52:22.000000000 +0100
@@ -1644,7 +1644,7 @@ module_param(force_load, bool, 0);
 static int __init do_init_nm256(void)
 {
     printk (KERN_INFO "NeoMagic 256AV/256ZX audio driver, version 1.1p\n");
-    return pci_module_init(&nm256_pci_driver);
+    return pci_register_driver(&nm256_pci_driver);
 }
 
 static void __exit cleanup_nm256 (void)
diff -Narup a/sound/oss/rme96xx.c b/sound/oss/rme96xx.c
--- a/sound/oss/rme96xx.c	2005-12-01 01:35:02.000000000 +0100
+++ b/sound/oss/rme96xx.c	2005-12-01 01:52:22.000000000 +0100
@@ -1095,7 +1095,7 @@ static int __init init_rme96xx(void)
 	devices = ((devices-1) & RME96xx_MASK_DEVS) + 1;
 	printk(KERN_INFO RME_MESS" reserving %d dsp device(s)\n",devices);
         numcards = 0;
-	return pci_module_init(&rme96xx_driver);
+	return pci_register_driver(&rme96xx_driver);
 }
 
 static void __exit cleanup_rme96xx(void)
diff -Narup a/sound/oss/sonicvibes.c b/sound/oss/sonicvibes.c
--- a/sound/oss/sonicvibes.c	2005-12-01 01:35:02.000000000 +0100
+++ b/sound/oss/sonicvibes.c	2005-12-01 01:52:22.000000000 +0100
@@ -2765,7 +2765,7 @@ static int __init init_sonicvibes(void)
 	if (!(wavetable_mem = __get_free_pages(GFP_KERNEL, 20-PAGE_SHIFT)))
 		printk(KERN_INFO "sv: cannot allocate 1MB of contiguous nonpageable memory for wavetable data\n");
 #endif
-	return pci_module_init(&sv_driver);
+	return pci_register_driver(&sv_driver);
 }
 
 static void __exit cleanup_sonicvibes(void)
diff -Narup a/sound/oss/ymfpci.c b/sound/oss/ymfpci.c
--- a/sound/oss/ymfpci.c	2005-12-01 01:35:03.000000000 +0100
+++ b/sound/oss/ymfpci.c	2005-12-01 01:52:23.000000000 +0100
@@ -2680,7 +2680,7 @@ static struct pci_driver ymfpci_driver =
 
 static int __init ymf_init_module(void)
 {
-	return pci_module_init(&ymfpci_driver);
+	return pci_register_driver(&ymfpci_driver);
 }
 
 static void __exit ymf_cleanup_module (void)
diff -Narup a/sound/pci/cs5535audio/cs5535audio.c b/sound/pci/cs5535audio/cs5535audio.c
--- a/sound/pci/cs5535audio/cs5535audio.c	2005-12-01 01:35:03.000000000 +0100
+++ b/sound/pci/cs5535audio/cs5535audio.c	2005-12-01 01:52:23.000000000 +0100
@@ -385,7 +385,7 @@ static struct pci_driver driver = {
 
 static int __init alsa_card_cs5535audio_init(void)
 {
-	return pci_module_init(&driver);
+	return pci_register_driver(&driver);
 }
 
 static void __exit alsa_card_cs5535audio_exit(void)
