Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263033AbUDAS1a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 13:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263034AbUDAS1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 13:27:30 -0500
Received: from math.ut.ee ([193.40.5.125]:62344 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S263033AbUDAS0R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 13:26:17 -0500
Date: Thu, 1 Apr 2004 21:26:13 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [2.4 IDE PATCH] SanDisk is flash
Message-ID: <Pine.GSO.4.44.0404012119560.15708-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is self-explanatory - former SunDisk renamed itself to SanDisk and
now there are flash disks with both names.

===== drivers/ide/ide-probe.c 1.21 vs edited =====
--- 1.21/drivers/ide/ide-probe.c	Mon Nov 24 00:05:18 2003
+++ edited/drivers/ide/ide-probe.c	Thu Apr  1 21:15:22 2004
@@ -102,7 +102,8 @@
 		if (id->config == 0x848a) return 1;	/* CompactFlash */
 		if (!strncmp(id->model, "KODAK ATA_FLASH", 15)	/* Kodak */
 		 || !strncmp(id->model, "Hitachi CV", 10)	/* Hitachi */
-		 || !strncmp(id->model, "SunDisk SDCFB", 13)	/* SunDisk */
+		 || !strncmp(id->model, "SunDisk SDCFB", 13)	/* old SanDisk */
+		 || !strncmp(id->model, "SanDisk SDCFB", 13)	/* SanDisk */
 		 || !strncmp(id->model, "HAGIWARA HPC", 12)	/* Hagiwara */
 		 || !strncmp(id->model, "LEXAR ATA_FLASH", 15)	/* Lexar */
 		 || !strncmp(id->model, "ATA_FLASH", 9))	/* Simple Tech */

-- 
Meelis Roos (mroos@linux.ee)


