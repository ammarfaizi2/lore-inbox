Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751818AbWFCXSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbWFCXSf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 19:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751826AbWFCXSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 19:18:35 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:13994 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1751818AbWFCXSe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 19:18:34 -0400
Date: Sun, 4 Jun 2006 00:18:28 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Prevent au1xmmc.c breakage on non-Au1200 Alchemy
Message-ID: <20060603231827.GA2788@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The driver is selectable on other than Au1200 Alchemy systems but won't
build nor work - there is no MMC hw.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 003b077..45bcf09 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -84,7 +84,7 @@ config MMC_WBSD
 
 config MMC_AU1X
 	tristate "Alchemy AU1XX0 MMC Card Interface support"
-	depends on SOC_AU1X00 && MMC
+	depends on MMC && SOC_AU1200
 	help
 	  This selects the AMD Alchemy(R) Multimedia card interface.
 	  If you have a Alchemy platform with a MMC slot, say Y or M here.
