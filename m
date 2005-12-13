Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbVLMC2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbVLMC2Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 21:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbVLMC2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 21:28:24 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:55045 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932360AbVLMC2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 21:28:24 -0500
Date: Tue, 13 Dec 2005 03:28:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: james.smart@emulex.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/lpfc/lpfc_scsi.c: make lpfc_sli_get_scsi_buf() static
Message-ID: <20051213022823.GY23349@stusta.de>
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
- 20 Nov 2005

--- linux-2.6.15-rc1-mm2-full/drivers/scsi/lpfc/lpfc_scsi.c.old	2005-11-20 19:52:28.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/scsi/lpfc/lpfc_scsi.c	2005-11-20 19:52:45.000000000 +0100
@@ -136,7 +136,7 @@
 	return psb;
 }
 
-struct  lpfc_scsi_buf*
+static struct lpfc_scsi_buf*
 lpfc_sli_get_scsi_buf(struct lpfc_hba * phba)
 {
 	struct  lpfc_scsi_buf * lpfc_cmd = NULL;


