Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbWAXXuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWAXXuo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 18:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbWAXXun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 18:50:43 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:54538 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750867AbWAXXun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 18:50:43 -0500
Date: Wed, 25 Jan 2006 00:50:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: dwmw2@infradead.org
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] Kconfig help: MTD_JEDECPROBE already supports Intel chips
Message-ID: <20060124235038.GL3590@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unless I'm misunderstanding the code in jedec_probe.c, Intel chips are 
already supported.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/mtd/chips/Kconfig |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- linux-2.6.16-rc1-mm2-full/drivers/mtd/chips/Kconfig.old	2006-01-25 00:42:51.000000000 +0100
+++ linux-2.6.16-rc1-mm2-full/drivers/mtd/chips/Kconfig	2006-01-25 00:43:20.000000000 +0100
@@ -19,21 +19,20 @@
 config MTD_JEDECPROBE
 	tristate "Detect non-CFI AMD/JEDEC-compatible flash chips"
 	depends on MTD
 	select MTD_GEN_PROBE
 	help
 	  This option enables JEDEC-style probing of flash chips which are not
 	  compatible with the Common Flash Interface, but will use the common
 	  CFI-targetted flash drivers for any chips which are identified which
 	  are in fact compatible in all but the probe method. This actually
-	  covers most AMD/Fujitsu-compatible chips, and will shortly cover also
-	  non-CFI Intel chips (that code is in MTD CVS and should shortly be sent
-	  for inclusion in Linus' tree)
+	  covers most AMD/Fujitsu-compatible chips and also non-CFI
+	  Intel chips.
 
 config MTD_GEN_PROBE
 	tristate
 	select OBSOLETE_INTERMODULE
 
 config MTD_CFI_ADV_OPTIONS
 	bool "Flash chip driver advanced configuration options"
 	depends on MTD_GEN_PROBE
 	help

