Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVCQWYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVCQWYJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 17:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVCQWUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 17:20:51 -0500
Received: from mailhub.lss.emc.com ([168.159.2.31]:21372 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S261259AbVCQWUT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 17:20:19 -0500
From: Brett Russ <russb@emc.com>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050317221753.53957EDF@lns1032.lss.emc.com>
In-Reply-To: <20050317221753.53957EDF@lns1032.lss.emc.com>
Subject: Re: [PATCH libata-dev-2.6 03/05] libata: update ATA PT sense desc code
Message-ID: <20050317221753.15A7ADF6@lns1032.lss.emc.com>
Date: Thu, 17 Mar 2005 17:20:16 -0500 (EST)
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='__CT 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

03_libata_update_desc_code.patch

	Change the ATA pass through sense block descriptor code to
	0x09 per SAT

Signed-off-by: Brett Russ <russb@emc.com>

 libata-scsi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: libata-dev-2.6/drivers/scsi/libata-scsi.c
===================================================================
--- libata-dev-2.6.orig/drivers/scsi/libata-scsi.c	2005-03-08 08:47:48.000000000 -0500
+++ libata-dev-2.6/drivers/scsi/libata-scsi.c	2005-03-17 17:16:58.000000000 -0500
@@ -531,7 +531,7 @@ void ata_pass_thru_cc(struct ata_queued_
 	 */
 	sb[0] = 0x72 ;
 
-	desc[0] = 0x8e ;	/* TODO: replace with official value. */
+	desc[0] = 0x09;
 
 	/*
 	 * Set length of additional sense data.
@@ -2059,7 +2059,7 @@ void ata_scsi_simulate(u16 *id,
 			ata_scsi_rbuf_fill(&args, ata_scsiop_report_luns);
 			break;
 
-		/* mandantory commands we haven't implemented yet */
+		/* mandatory commands we haven't implemented yet */
 		case REQUEST_SENSE:
 
 		/* all other commands */

