Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030504AbWBHUC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030504AbWBHUC0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 15:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030518AbWBHUCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 15:02:15 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:37329 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030436AbWBHUBt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 15:01:49 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] sparc dependencies in drivers/video
Cc: adaplas@pol.net
Message-Id: <E1F6vVc-0008Bm-KC@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 20:01:48 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1133417732 -0500

sparc32 has no vga.h

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/video/Kconfig |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

9e06ed1a78d68fce3ce0a15fa0d5352981ddec6c
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 3e153d3..aa3a79d 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -101,7 +101,7 @@ config FB_TILEBLITTING
 
 config FB_CIRRUS
 	tristate "Cirrus Logic support"
-	depends on FB && (ZORRO || PCI)
+	depends on FB && (ZORRO || PCI) && (BROKEN || !SPARC32)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -613,7 +613,7 @@ config FB_S1D13XXX
 
 config FB_NVIDIA
 	tristate "nVidia Framebuffer Support"
-	depends on FB && PCI
+	depends on FB && PCI && (BROKEN || !SPARC32)
 	select I2C_ALGOBIT if FB_NVIDIA_I2C
 	select I2C if FB_NVIDIA_I2C
 	select FB_MODE_HELPERS
@@ -643,7 +643,7 @@ config FB_NVIDIA_I2C
 
 config FB_RIVA
 	tristate "nVidia Riva support"
-	depends on FB && PCI
+	depends on FB && PCI && (BROKEN || !SPARC32)
 	select I2C_ALGOBIT if FB_RIVA_I2C
 	select I2C if FB_RIVA_I2C
 	select FB_MODE_HELPERS
@@ -1079,7 +1079,7 @@ config FB_SIS_315
 
 config FB_NEOMAGIC
 	tristate "NeoMagic display support"
-	depends on FB && PCI
+	depends on FB && PCI && (BROKEN || !SPARC32)
 	select FB_MODE_HELPERS
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
-- 
0.99.9.GIT

