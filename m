Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262864AbVCWUp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbVCWUp6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 15:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbVCWUor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 15:44:47 -0500
Received: from mailhub.lss.emc.com ([168.159.2.31]:7578 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S262909AbVCWUjc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 15:39:32 -0500
From: Brett Russ <russb@emc.com>
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050323203514.D62A1893@lns1032.lss.emc.com>
In-Reply-To: <20050323203514.D62A1893@lns1032.lss.emc.com>
Subject: Re: [PATCH libata-dev-2.6 01/03] libata: whitespace updates
Message-ID: <20050323203514.DE0042D8@lns1032.lss.emc.com>
Date: Wed, 23 Mar 2005 15:39:29 -0500 (EST)
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.0.3.0, Antispam-Data: 2005.3.23.11
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='__CT 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

01_libata_libata-whitespace.patch

	This patch adjusts some whitespace to bring the format of
	libata-scsi.c to a consistent state.

Signed-off-by: Brett Russ <russb@emc.com>

 libata-scsi.c |  112 +++++++++++++++++++++++++---------------------------------
 1 files changed, 50 insertions(+), 62 deletions(-)

Index: libata-dev-2.6/drivers/scsi/libata-scsi.c
===================================================================
--- libata-dev-2.6.orig/drivers/scsi/libata-scsi.c	2005-03-23 15:35:08.000000000 -0500
+++ libata-dev-2.6/drivers/scsi/libata-scsi.c	2005-03-23 15:35:09.000000000 -0500
@@ -397,56 +397,46 @@ void ata_to_sense_error(struct ata_queue
 	 *	Is this an error we can process/parse
 	 */
 
-	if(drv_stat & ATA_ERR)
-		/* Read the err bits */
-		err = ata_chk_err(qc->ap);
+	if (drv_stat & ATA_ERR)
+		err = ata_chk_err(qc->ap);	/* Read the err bits */
 
 	/* Display the ATA level error info */
 
 	printk(KERN_WARNING "ata%u: status=0x%02x { ", qc->ap->id, drv_stat);
-	if(drv_stat & 0x80)
-	{
+	if (drv_stat & 0x80) {
 		printk("Busy ");
 		err = 0;	/* Data is not valid in this case */
-	}
-	else {
-		if(drv_stat & 0x40)	printk("DriveReady ");
-		if(drv_stat & 0x20)	printk("DeviceFault ");
-		if(drv_stat & 0x10)	printk("SeekComplete ");
-		if(drv_stat & 0x08)	printk("DataRequest ");
-		if(drv_stat & 0x04)	printk("CorrectedError ");
-		if(drv_stat & 0x02)	printk("Index ");
-		if(drv_stat & 0x01)	printk("Error ");
+	} else {
+		if (drv_stat & 0x40)	printk("DriveReady ");
+		if (drv_stat & 0x20)	printk("DeviceFault ");
+		if (drv_stat & 0x10)	printk("SeekComplete ");
+		if (drv_stat & 0x08)	printk("DataRequest ");
+		if (drv_stat & 0x04)	printk("CorrectedError ");
+		if (drv_stat & 0x02)	printk("Index ");
+		if (drv_stat & 0x01)	printk("Error ");
 	}
 	printk("}\n");
 
-	if(err)
-	{
+	if (err) {
 		printk(KERN_WARNING "ata%u: error=0x%02x { ", qc->ap->id, err);
-		if(err & 0x04)		printk("DriveStatusError ");
-		if(err & 0x80)
-		{
-			if(err & 0x04)
-				printk("BadCRC ");
-			else
-				printk("Sector ");
+		if (err & 0x04)		printk("DriveStatusError ");
+		if (err & 0x80) {
+			if (err & 0x04)	printk("BadCRC ");
+			else		printk("Sector ");
 		}
-		if(err & 0x40)		printk("UncorrectableError ");
-		if(err & 0x10)		printk("SectorIdNotFound ");
-		if(err & 0x02)		printk("TrackZeroNotFound ");
-		if(err & 0x01)		printk("AddrMarkNotFound ");
+		if (err & 0x40)		printk("UncorrectableError ");
+		if (err & 0x10)		printk("SectorIdNotFound ");
+		if (err & 0x02)		printk("TrackZeroNotFound ");
+		if (err & 0x01)		printk("AddrMarkNotFound ");
 		printk("}\n");
 
 		/* Should we dump sector info here too ?? */
 	}
 
-
 	/* Look for err */
-	while(sense_table[i][0] != 0xFF)
-	{
+	while (sense_table[i][0] != 0xFF) {
 		/* Look for best matches first */
-		if((sense_table[i][0] & err) == sense_table[i][0])
-		{
+		if ((sense_table[i][0] & err) == sense_table[i][0]) {
 			sb[0] = 0x70;
 			sb[2] = sense_table[i][1];
 			sb[7] = 0x0a;
@@ -457,15 +447,13 @@ void ata_to_sense_error(struct ata_queue
 		i++;
 	}
 	/* No immediate match */
-	if(err)
+	if (err)
 		printk(KERN_DEBUG "ata%u: no sense translation for 0x%02x\n", qc->ap->id, err);
 
 	i = 0;
 	/* Fall back to interpreting status bits */
-	while(stat_table[i][0] != 0xFF)
-	{
-		if(stat_table[i][0] & drv_stat)
-		{
+	while (stat_table[i][0] != 0xFF) {
+		if (stat_table[i][0] & drv_stat) {
 			sb[0] = 0x70;
 			sb[2] = stat_table[i][1];
 			sb[7] = 0x0a;
@@ -508,7 +496,7 @@ void ata_pass_thru_cc(struct ata_queued_
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->tf;
 	unsigned char *sb = cmd->sense_buffer;
-	unsigned char *desc = sb + 8 ;
+	unsigned char *desc = sb + 8;
 
 	cmd->result = SAM_STAT_CHECK_CONDITION;
 
@@ -520,16 +508,16 @@ void ata_pass_thru_cc(struct ata_queued_
 	 * TODO: reorganise better, by splitting ata_to_sense_error()
 	 */
 	if (unlikely(drv_stat & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ))) {
-		ata_to_sense_error(qc, drv_stat) ;
+		ata_to_sense_error(qc, drv_stat);
 	} else {
-		sb[3] = sb[2] = sb[1] = 0x00 ;
+		sb[3] = sb[2] = sb[1] = 0x00;
 	}
 
 	/*
 	 * Sense data is current and format is
 	 * descriptor.
 	 */
-	sb[0] = 0x72 ;
+	sb[0] = 0x72;
 
 	desc[0] = 0x09;
 
@@ -538,7 +526,7 @@ void ata_pass_thru_cc(struct ata_queued_
 	 * Since we only populate descriptor 0, the total
 	 * length is the same (fixed) length as descriptor 0.
 	 */
-	desc[1] = sb[7] = 14 ;
+	desc[1] = sb[7] = 14;
 
 	/*
 	 * Read the controller registers.
@@ -548,25 +536,25 @@ void ata_pass_thru_cc(struct ata_queued_
 	/*
 	 * Copy registers into sense buffer.
 	 */
-	desc[2] = 0x00 ;
-	desc[3] = tf->feature ;	/* Note: becomes error register when read. */
-	desc[5] = tf->nsect ;
-	desc[7] = tf->lbal ;
-	desc[9] = tf->lbam ;
-	desc[11] = tf->lbah ;
-	desc[12] = tf->device ;
-	desc[13] = drv_stat ;
+	desc[2] = 0x00;
+	desc[3] = tf->feature;	/* Note: becomes error register when read. */
+	desc[5] = tf->nsect;
+	desc[7] = tf->lbal;
+	desc[9] = tf->lbam;
+	desc[11] = tf->lbah;
+	desc[12] = tf->device;
+	desc[13] = drv_stat;
 
 	/*
 	 * Fill in Extend bit, and the high order bytes
 	 * if applicable.
 	 */
 	if (tf->flags & ATA_TFLAG_LBA48) {
-		desc[2] |= 0x01 ;
-		desc[4] = tf->hob_nsect ;
-		desc[6] = tf->hob_lbal ;
-		desc[8] = tf->hob_lbam ;
-		desc[10] = tf->hob_lbah ;
+		desc[2] |= 0x01;
+		desc[4] = tf->hob_nsect;
+		desc[6] = tf->hob_lbal;
+		desc[8] = tf->hob_lbam;
+		desc[10] = tf->hob_lbah;
 	}
 }
 
@@ -957,7 +945,7 @@ static int ata_scsi_qc_complete(struct a
 	 */
 	if (((cmd->cmnd[0] == ATA_16) || (cmd->cmnd[0] == ATA_12)) &&
 						(cmd->cmnd[2] & 0x20)) {
-		ata_pass_thru_cc(qc, drv_stat) ;
+		ata_pass_thru_cc(qc, drv_stat);
 	} else {
 		if (unlikely(drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ)))
 			ata_to_sense_error(qc, drv_stat);
@@ -1811,9 +1799,9 @@ ata_scsi_pass_thru(struct ata_queued_cmd
 			tf->hob_lbal = scsicmd[7];
 			tf->hob_lbam = scsicmd[9];
 			tf->hob_lbah = scsicmd[11];
-			tf->flags |= ATA_TFLAG_LBA48 ;
+			tf->flags |= ATA_TFLAG_LBA48;
 		} else
-			tf->flags &= ~ATA_TFLAG_LBA48 ;
+			tf->flags &= ~ATA_TFLAG_LBA48;
 
 		/*
 		 * Always copy low byte, device and command registers.
@@ -1829,7 +1817,7 @@ ata_scsi_pass_thru(struct ata_queued_cmd
 		/*
 		 * 12-byte CDB - incapable of extended commands.
 		 */
-		tf->flags &= ~ATA_TFLAG_LBA48 ;
+		tf->flags &= ~ATA_TFLAG_LBA48;
 
 		tf->feature = scsicmd[3];
 		tf->nsect = scsicmd[4];
@@ -1856,7 +1844,7 @@ ata_scsi_pass_thru(struct ata_queued_cmd
 	 * and pass on write indication (used for PIO/DMA
 	 * setup.)
 	 */
-	tf->flags |= (ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE) ;
+	tf->flags |= (ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE);
 
 	if (cmd->sc_data_direction == SCSI_DATA_WRITE)
 		tf->flags |= ATA_TFLAG_WRITE;
@@ -1867,7 +1855,7 @@ ata_scsi_pass_thru(struct ata_queued_cmd
 	 * TODO: find out if we need to do more here to
 	 *       cover scatter/gather case.
 	 */
-	qc->nsect = cmd->bufflen / ATA_SECT_SIZE ;
+	qc->nsect = cmd->bufflen / ATA_SECT_SIZE;
 
 	return 0;
 }
@@ -1907,7 +1895,7 @@ static inline ata_xlat_func_t ata_get_xl
 
 	case ATA_12:
 	case ATA_16:
-		return ata_scsi_pass_thru ;
+		return ata_scsi_pass_thru;
 	}
 
 	return NULL;

