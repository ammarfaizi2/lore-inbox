Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbULHBQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbULHBQc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 20:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbULHBO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 20:14:57 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:15634 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261984AbULHBOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 20:14:33 -0500
Date: Wed, 8 Dec 2004 02:14:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: jgarzik@pobox.com, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] scsi/ahci.c: remove an unused function (fwd)
Message-ID: <20041208011429.GF5496@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below still applies and compiles against 
2.6.10-rc2-mm4.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Fri, 29 Oct 2004 02:26:13 +0200
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [2.6 patch] scsi/ahci.c: remove an unused function

The patch below removes an unused function from drivers/scsi/ahci.c


diffstat output:
 drivers/scsi/ahci.c |    9 ---------
 1 files changed, 9 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm1-full/drivers/scsi/ahci.c.old	2004-10-28 23:28:09.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/scsi/ahci.c	2004-10-28 23:28:17.000000000 +0200
@@ -504,15 +504,6 @@
 	ahci_fill_sg(qc);
 }
 
-static inline void ahci_dma_complete (struct ata_port *ap,
-                                     struct ata_queued_cmd *qc,
-				     int have_err)
-{
-	/* get drive status; clear intr; complete txn */
-	ata_qc_complete(ata_qc_from_tag(ap, ap->active_tag),
-			have_err ? ATA_ERR : 0);
-}
-
 static void ahci_intr_error(struct ata_port *ap, u32 irq_stat)
 {
 	void *mmio = ap->host_set->mmio_base;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

