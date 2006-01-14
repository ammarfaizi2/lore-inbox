Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945973AbWANCKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945973AbWANCKG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 21:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423274AbWANCKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 21:10:05 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:21778 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1423268AbWANCJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 21:09:53 -0500
Date: Sat, 14 Jan 2006 03:09:53 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: James.Bottomley@SteelEye.com, James Smart <James.Smart@Emulex.Com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/lpfc/lpfc_scsi.c: make lpfc_get_scsi_buf() static
Message-ID: <20060114020953.GD29663@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global function lpfc_sli_get_scsi_buf()
static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: James Smart <James.Smart@Emulex.Com>

---

This patch was already sent on:
- 6 Jan 2006

--- linux-2.6.15-mm1-full/drivers/scsi/lpfc/lpfc_scsi.c.old	2006-01-06 19:50:38.000000000 +0100
+++ linux-2.6.15-mm1-full/drivers/scsi/lpfc/lpfc_scsi.c	2006-01-06 19:50:46.000000000 +0100
@@ -150,7 +150,7 @@
 	return psb;
 }
 
-struct  lpfc_scsi_buf*
+static struct lpfc_scsi_buf*
 lpfc_get_scsi_buf(struct lpfc_hba * phba)
 {
 	struct  lpfc_scsi_buf * lpfc_cmd = NULL;

