Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263595AbTDXMBG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 08:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263599AbTDXMBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 08:01:06 -0400
Received: from mid-2.inet.it ([213.92.5.19]:10952 "EHLO mid-2.inet.it")
	by vger.kernel.org with ESMTP id S263595AbTDXMBF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 08:01:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Paolo Ornati <javaman@katamail.com>
To: marcelo@conectiva.com.br
Subject: [PATCH 2.4.x] explicit support for nVidia nForce...
Date: Thu, 24 Apr 2003 14:13:16 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <S263595AbTDXMBF/20030424120105Z+4118@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch explicit the support for nVidia nForce chip...
please apply.

bye,
Paolo

diff -urN a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	Thu Apr 24 14:02:27 2003
+++ b/Documentation/Configure.help	Thu Apr 24 13:52:51 2003
@@ -1105,10 +1105,12 @@
 
   SAY N!
 
-AMD Viper (7401/7409/7411) chipset support
+AMD and nVidia IDE support
 CONFIG_BLK_DEV_AMD74XX
-  This driver ensures (U)DMA support for the AMD756/760 Viper
-  chipsets.
+  This driver adds explicit support for AMD-7xx and AMD-8111 chips
+  and also for the nVidia nForce chip.  This allows the kernel to
+  change PIO, DMA and UDMA speeds and to configure the chip to
+  optimum performance.
 
   If you say Y here, you also need to say Y to "Use DMA by default
   when available", above.
diff -urN a/drivers/ide/Config.in b/drivers/ide/Config.in
--- a/drivers/ide/Config.in	Thu Apr 24 11:23:57 2003
+++ b/drivers/ide/Config.in	Thu Apr 24 13:52:51 2003
@@ -47,7 +47,7 @@
 	    dep_tristate '    AEC62XX chipset support' CONFIG_BLK_DEV_AEC62XX 
$CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_tristate '    ALI M15x3 chipset support' CONFIG_BLK_DEV_ALI15X3 
$CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_mbool    '      ALI M15x3 WDC support (DANGEROUS)' 
CONFIG_WDC_ALI15X3 $CONFIG_BLK_DEV_ALI15X3
-	    dep_tristate '    AMD Viper support' CONFIG_BLK_DEV_AMD74XX 
$CONFIG_BLK_DEV_IDEDMA_PCI
+	    dep_tristate '    AMD and nVidia IDE support' CONFIG_BLK_DEV_AMD74XX 
$CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_mbool    '      AMD Viper ATA-66 Override' CONFIG_AMD74XX_OVERRIDE 
$CONFIG_BLK_DEV_AMD74XX
 	    dep_tristate '    CMD64{3|6|8|9} chipset support' CONFIG_BLK_DEV_CMD64X 
$CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_tristate '    Compaq Triflex IDE support' CONFIG_BLK_DEV_TRIFLEX 
$CONFIG_BLK_DEV_IDEDMA_PCI
