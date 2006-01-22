Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWAVRM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWAVRM5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 12:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWAVRM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 12:12:57 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:40719 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932251AbWAVRM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 12:12:56 -0500
Date: Sun, 22 Jan 2006 18:12:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: dwmw2@infradead.org, LKML <linux-kernel@vger.kernel.org>,
       linux-mtd@lists.infradead.org, Richard Purdie <rpurdie@rpsys.net>
Subject: [RFC: 2.6 patch] MTD_NAND_SHARPSL and MTD_NAND_NANDSIM should be tristate's
Message-ID: <20060122171256.GE10003@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MTD_NAND=m and MTD_NAND_SHARPSL=y or MTD_NAND_NANDSIM=y are illegal 
combinations that mustn't be allowed.

This patch fixes this bug by making MTD_NAND_SHARPSL and 
MTD_NAND_NANDSIM tristate's.

Additionally, it fixes some whitespace damage at these options.


Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Richard Purdie <rpurdie@rpsys.net>

---

This patch was already sent on:
- 13 Jan 2006
- 31 Dec 2005

--- linux-git/drivers/mtd/nand/Kconfig.old	2005-12-31 12:20:12.000000000 +0100
+++ linux-git/drivers/mtd/nand/Kconfig	2005-12-31 12:21:35.000000000 +0100
@@ -178,17 +178,16 @@
 	  Even if you leave this disabled, you can enable BBT writes at module
 	  load time (assuming you build diskonchip as a module) with the module
 	  parameter "inftl_bbt_write=1".
-	  
- config MTD_NAND_SHARPSL
- 	bool "Support for NAND Flash on Sharp SL Series (C7xx + others)"
- 	depends on MTD_NAND && ARCH_PXA
- 
- config MTD_NAND_NANDSIM
- 	bool "Support for NAND Flash Simulator"
- 	depends on MTD_NAND && MTD_PARTITIONS
 
+config MTD_NAND_SHARPSL
+	tristate "Support for NAND Flash on Sharp SL Series (C7xx + others)"
+	depends on MTD_NAND && ARCH_PXA
+
+config MTD_NAND_NANDSIM
+	tristate "Support for NAND Flash Simulator"
+	depends on MTD_NAND && MTD_PARTITIONS
 	help
 	  The simulator may simulate verious NAND flash chips for the
 	  MTD nand layer.
- 
+
 endmenu

