Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264061AbUDBOxQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 09:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264066AbUDBOxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 09:53:16 -0500
Received: from math.ut.ee ([193.40.5.125]:25021 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S264061AbUDBOxO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 09:53:14 -0500
Date: Fri, 2 Apr 2004 17:53:11 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [2.6 IDE PATCH] SanDisk is flash - like in 2.4
Message-ID: <Pine.GSO.4.44.0404021750550.17950-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Former SunDisk AFA flash disk maker renamed itself to SanDisk and now
there are flash disks with both names. This is the same patch that went
into 2.4, only rediffed against current 2.6 BK.

===== drivers/ide/ide-probe.c 1.71 vs edited =====
--- 1.71/drivers/ide/ide-probe.c	Wed Mar 17 00:12:28 2004
+++ edited/drivers/ide/ide-probe.c	Fri Apr  2 17:50:06 2004
@@ -103,7 +103,8 @@
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



