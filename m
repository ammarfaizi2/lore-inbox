Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263714AbUDMTx7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 15:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263716AbUDMTx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 15:53:59 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:32978 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263714AbUDMTx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 15:53:56 -0400
Date: Tue, 13 Apr 2004 21:53:45 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Meelis Roos <mroos@linux.ee>, B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [2.4 IDE PATCH] SanDisk is flash (fwd)
Message-ID: <20040413195344.GA523@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below by Meelis Roos was already included in
2.4.26-rc. It does apply against 2.6, too, so I assume it should also be
added there?

cu
Adrian


----- Forwarded message from Meelis Roos <mroos@linux.ee> -----

Date:	Thu, 1 Apr 2004 21:26:13 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [2.4 IDE PATCH] SanDisk is flash

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


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

