Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbUKNKDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbUKNKDa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 05:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbUKNKDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 05:03:30 -0500
Received: from verein.lst.de ([213.95.11.210]:13237 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261271AbUKNKD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 05:03:28 -0500
Date: Sun, 14 Nov 2004 11:03:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@osdl.org, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix sata_svw compile
Message-ID: <20041114100320.GA31506@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Current BK doesn't compile with the G5 defconfig because the last
libata updated missed to change sata_svw to the new conventions.


--- 1.28/drivers/scsi/sata_svw.c	2004-11-13 20:24:05 +01:00
+++ edited/drivers/scsi/sata_svw.c	2004-11-14 10:52:21 +01:00
@@ -245,7 +245,7 @@
 		return 0;
 
 	/* Find the OF node for the PCI device proper */
-	np = pci_device_to_OF_node(ap->host_set->pdev);
+	np = pci_device_to_OF_node(to_pci_dev(ap->host_set->dev));
 	if (np == NULL)
 		return 0;
 
