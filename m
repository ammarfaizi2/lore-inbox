Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262274AbVDLSfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbVDLSfL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbVDLSdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 14:33:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:41163 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262311AbVDLKgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:36:15 -0400
Message-Id: <200504121033.j3CAX0El005740@shell0.pdx.osdl.net>
Subject: [patch 148/198] let SOUND_AD1889 depend on PCI
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, bunk@stusta.de
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Adrian Bunk <bunk@stusta.de>

Compiling SOUND_AD1889 with PCI=n results in the following compile 
error:

sound/built-in.o(.text+0x24f0c): In function `ad1889_remove':
: undefined reference to `pci_release_region'

This patch adds the missing dependency on PCI.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/sound/oss/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN sound/oss/Kconfig~let-sound_ad1889-depend-on-pci sound/oss/Kconfig
--- 25/sound/oss/Kconfig~let-sound_ad1889-depend-on-pci	2005-04-12 03:21:38.857229704 -0700
+++ 25-akpm/sound/oss/Kconfig	2005-04-12 03:21:38.860229248 -0700
@@ -556,7 +556,7 @@ config SOUND_AD1816
 
 config SOUND_AD1889
 	tristate "AD1889 based cards (AD1819 codec) (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && SOUND_OSS
+	depends on EXPERIMENTAL && SOUND_OSS && PCI
 	help
 	  Say M here if you have a sound card based on the Analog Devices
 	  AD1889 chip.
_
