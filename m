Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262634AbUEFPip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbUEFPip (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 11:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbUEFPip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 11:38:45 -0400
Received: from tardis.ee.ethz.ch ([129.132.2.217]:65269 "EHLO
	ntardis.ee.ethz.ch") by vger.kernel.org with ESMTP id S262634AbUEFPio
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 11:38:44 -0400
From: Nicolas Vollmar <nv1@gmx.ch>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: "PowerMac IDE DMA support"
Date: Thu, 6 May 2004 17:39:39 +0000
User-Agent: KMail/1.6.1
Cc: Linus Torvalds <torvalds@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405061739.39372.nv1@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I tried to compile a new Kernel on my iBook and get a compile Error from the 
IDE PMAC Driver. I had some time to find out that "Generic PCI bus-master DMA 
support" is needed to compile cleanly.

It may be better if BLK_DEV_IDEDMA_PMAC depends on BLK_DEV_IDEDMA_PCI?

mfg
Nicolas Vollmar


diff -Nru linux-2.6.5-rc3/drivers/ide/Kconfig 
linux-2.6.5-rc3-1/drivers/ide/Kconfig
--- linux-2.6.5-rc3/drivers/ide/Kconfig	2004-04-04 03:37:06.000000000 +0000
+++ linux-2.6.5-rc3-1/drivers/ide/Kconfig	2004-05-06 17:17:45.225351696 +0000
@@ -826,7 +826,7 @@
 
 config BLK_DEV_IDEDMA_PMAC
 	bool "PowerMac IDE DMA support"
-	depends on BLK_DEV_IDE_PMAC
+	depends on BLK_DEV_IDE_PMAC && BLK_DEV_IDEDMA_PCI
 	help
 	  This option allows the driver for the built-in IDE controller on
 	  Power Macintoshes and PowerBooks to use DMA (direct memory access)
