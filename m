Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132479AbRDJXaI>; Tue, 10 Apr 2001 19:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132478AbRDJX3t>; Tue, 10 Apr 2001 19:29:49 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:34298 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S132474AbRDJX33>; Tue, 10 Apr 2001 19:29:29 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200104102329.f3ANTMCb000474@webber.adilger.int>
Subject: [PATCH] minor PCI fixup
To: Linux kernel development list <linux-kernel@vger.kernel.org>
Date: Tue, 10 Apr 2001 17:29:22 -0600 (MDT)
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attached is a very minor patch that is in my tree (I don't even remember why
I was in there) which uses the defined PCI vendor ID instead of a number.

Cheers, Andreas
============================================================================
diff -ru linux.orig/drivers/scsi/atp870u.c linux/drivers/scsi/atp870u.c
--- linux.orig/drivers/scsi/atp870u.c	Sat Nov 11 20:01:11 2000
+++ linux/drivers/scsi/atp870u.c	Wed Mar  7 12:58:10 2001
@@ -1668,7 +1668,7 @@
        }
        h = 0;
        while (devid[h] != 0) {
-               pdev[2] = pci_find_device(0x1191, devid[h], pdev[2]);
+               pdev[2] = pci_find_device(PCI_VENDOR_ID_ARTOP,devid[h],pdev[2]);
 		if (pdev[2] == NULL || pci_enable_device(pdev[2])) {
 			h++;
 			index = 0;
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
