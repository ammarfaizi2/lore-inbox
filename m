Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbVHWVqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbVHWVqq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbVHWVpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:45:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20918 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932447AbVHWVo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:44:59 -0400
To: torvalds@osdl.org
Subject: [PATCH] (39/43) Kconfig fix (missing dependencies on PCI in sound/*)
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1E7gck-0007FM-GF@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:48:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

a bunch of PCI-only drivers didn't have the right dependency

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-mac-fonts/sound/oss/Kconfig RC13-rc6-git13-oss-pci/sound/oss/Kconfig
--- RC13-rc6-git13-mac-fonts/sound/oss/Kconfig	2005-08-21 13:16:47.000000000 -0400
+++ RC13-rc6-git13-oss-pci/sound/oss/Kconfig	2005-08-21 13:17:41.000000000 -0400
@@ -6,7 +6,7 @@
 # Prompt user for primary drivers.
 config SOUND_BT878
 	tristate "BT878 audio dma"
-	depends on SOUND_PRIME
+	depends on SOUND_PRIME && PCI
 	---help---
 	  Audio DMA support for bt878 based grabber boards.  As you might have
 	  already noticed, bt878 is listed with two functions in /proc/pci.
@@ -87,7 +87,7 @@
 
 config SOUND_FUSION
 	tristate "Crystal SoundFusion (CS4280/461x)"
-	depends on SOUND_PRIME
+	depends on SOUND_PRIME && PCI
 	help
 	  This module drives the Crystal SoundFusion devices (CS4280/46xx
 	  series) when wired as native sound drivers with AC97 codecs.  If
@@ -95,7 +95,7 @@
 
 config SOUND_CS4281
 	tristate "Crystal Sound CS4281"
-	depends on SOUND_PRIME
+	depends on SOUND_PRIME && PCI
 	help
 	  Picture and feature list at
 	  <http://www.pcbroker.com/crystal4281.html>.
@@ -179,7 +179,7 @@
 
 config SOUND_SONICVIBES
 	tristate "S3 SonicVibes"
-	depends on SOUND_PRIME
+	depends on SOUND_PRIME && PCI
 	help
 	  Say Y or M if you have a PCI sound card utilizing the S3
 	  SonicVibes chipset. To find out if your sound card uses a
@@ -226,7 +226,7 @@
 
 config SOUND_TRIDENT
 	tristate "Trident 4DWave DX/NX, SiS 7018 or ALi 5451 PCI Audio Core"
-	depends on SOUND_PRIME
+	depends on SOUND_PRIME && PCI
 	---help---
 	  Say Y or M if you have a PCI sound card utilizing the Trident
 	  4DWave-DX/NX chipset or your mother board chipset has SiS 7018
