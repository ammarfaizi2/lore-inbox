Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262903AbVG2WlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262903AbVG2WlR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 18:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbVG2Wiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 18:38:46 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:56583 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262899AbVG2WgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 18:36:20 -0400
Date: Sat, 30 Jul 2005 00:36:19 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: mchehab@brturbo.com.br, video4linux-list@redhat.com,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] VIDEO_BT848: remove not required part of the help text
Message-ID: <20050729223619.GC5590@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Things that are already expressed through the dependencies don't have to 
be mentioned in the help text.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 17 Jul 2005

--- linux-2.6.13-rc3-mm1-full/drivers/media/video/Kconfig.old	2005-07-17 16:15:00.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/drivers/media/video/Kconfig	2005-07-17 16:15:34.000000000 +0200
@@ -10,33 +10,30 @@
 config VIDEO_BT848
 	tristate "BT848 Video For Linux"
 	depends on VIDEO_DEV && PCI && I2C
 	select I2C_ALGOBIT
 	select FW_LOADER
 	select VIDEO_BTCX
 	select VIDEO_BUF
 	select VIDEO_IR
 	select VIDEO_TUNER
 	select VIDEO_TVEEPROM
 	---help---
 	  Support for BT848 based frame grabber/overlay boards. This includes
 	  the Miro, Hauppauge and STB boards. Please read the material in
 	  <file:Documentation/video4linux/bttv/> for more information.
 
-	  If you say Y or M here, you need to say Y or M to "I2C support" and
-	  "I2C bit-banging interfaces" in the device drivers section.
-
 	  To compile this driver as a module, choose M here: the
 	  module will be called bttv.
 
 config VIDEO_PMS
 	tristate "Mediavision Pro Movie Studio Video For Linux"
 	depends on VIDEO_DEV && ISA
 	help
 	  Say Y if you have such a thing.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called pms.
 
 config VIDEO_PLANB
 	tristate "PlanB Video-In on PowerMac"
 	depends on PPC_PMAC && VIDEO_DEV && BROKEN
