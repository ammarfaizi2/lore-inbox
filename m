Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbVBRUIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVBRUIv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 15:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbVBRUHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 15:07:39 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:27398 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261487AbVBRUGt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 15:06:49 -0500
Date: Fri, 18 Feb 2005 15:06:37 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: [patch libata-dev-2.6 4/5] libata: minor style changes in ata_scsi_pass_thru
Message-ID: <20050218200637.GE3197@tuxdriver.com>
Mail-Followup-To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	jgarzik@pobox.com
References: <20050218195027.GB3197@tuxdriver.com> <20050218195512.GC3197@tuxdriver.com> <20050218200337.GD3197@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050218200337.GD3197@tuxdriver.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some curlies around single-line if statements.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/scsi/libata-scsi.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

--- sata-smart-2.6/drivers/scsi/libata-scsi.c.style	2005-02-17 16:50:03.907040725 -0500
+++ sata-smart-2.6/drivers/scsi/libata-scsi.c	2005-02-17 16:50:40.819113315 -0500
@@ -1713,9 +1713,8 @@ ata_scsi_pass_thru(struct ata_queued_cmd
 	struct ata_taskfile *tf = &(qc->tf);
 	struct scsi_cmnd *cmd = qc->scsicmd;
 
-	if ((tf->protocol = ata_scsi_map_proto(scsicmd[1])) == ATA_PROT_UNKNOWN) {
+	if ((tf->protocol = ata_scsi_map_proto(scsicmd[1])) == ATA_PROT_UNKNOWN)
 		return 1;
-	}
 
 	/*
 	 * 12 and 16 byte CDBs use different offsets to
@@ -1734,9 +1733,8 @@ ata_scsi_pass_thru(struct ata_queued_cmd
 			tf->hob_lbam = scsicmd[9];
 			tf->hob_lbah = scsicmd[11];
 			tf->flags |= ATA_TFLAG_LBA48 ;
-		} else {
+		} else
 			tf->flags &= ~ATA_TFLAG_LBA48 ;
-		}
 
 		/*
 		 * Always copy low byte, device and command registers.
@@ -1781,9 +1779,8 @@ ata_scsi_pass_thru(struct ata_queued_cmd
 	 */
 	tf->flags |= (ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE) ;
 
-	if (cmd->sc_data_direction == SCSI_DATA_WRITE) {
+	if (cmd->sc_data_direction == SCSI_DATA_WRITE)
 		tf->flags |= ATA_TFLAG_WRITE;
-	}
 
 	/*
 	 * Set transfer length.
-- 
John W. Linville
linville@tuxdriver.com
