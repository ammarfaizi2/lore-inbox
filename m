Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268276AbUH2TWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268276AbUH2TWf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 15:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268279AbUH2TWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 15:22:34 -0400
Received: from smtp-vbr10.xs4all.nl ([194.109.24.30]:2060 "EHLO
	smtp-vbr10.xs4all.nl") by vger.kernel.org with ESMTP
	id S268276AbUH2TWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 15:22:32 -0400
Subject: [PATCH] 1/3: 2.6.8 zr36067 driver - correct i2c-algo-bit
	dependency in Kconfig
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@fs.tum.de>,
       mjpeg-developer@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-2nn9nnF5XxVQrBrahEwz"
Message-Id: <1093807411.2493.91.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 29 Aug 2004 21:23:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2nn9nnF5XxVQrBrahEwz
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

attached patch correctly makes the zr36067 driver depend on i2c-ago-bit
in the kernel config. Bug reported and patch sent to me by Adrian Bunk
<bunk@fs.tum.de> (6/21). It wasn't signed off.

Ronald

Signed-off-by: Ronald Bultje <rbultje@ronald.bitfreak.net>

-- 
Ronald Bultje <rbultje@ronald.bitfreak.net>

--=-2nn9nnF5XxVQrBrahEwz
Content-Disposition: attachment; filename=zoran-i2c-dep.diff
Content-Type: text/x-patch; name=zoran-i2c-dep.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: linux/drivers/media/video/Kconfig
--- linux~zoran-i2c-dep/drivers/media/video/Kconfig	2004-08-14 12:56:22.000000000 +0200
+++ linux/drivers/media/video/Kconfig	2004-08-29 18:26:46.243334816 +0200
@@ -155,7 +155,7 @@
 
 config VIDEO_ZORAN
 	tristate "Zoran ZR36057/36067 Video For Linux"
-	depends on VIDEO_DEV && PCI && I2C
+	depends on VIDEO_DEV && PCI && I2C_ALGOBIT
 	help
 	  Say Y for support for MJPEG capture cards based on the Zoran
 	  36057/36067 PCI controller chipset. This includes the Iomega

--=-2nn9nnF5XxVQrBrahEwz--

