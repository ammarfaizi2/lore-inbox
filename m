Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbVKTWut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbVKTWut (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 17:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbVKTWut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 17:50:49 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:18960 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932095AbVKTWus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 17:50:48 -0500
Date: Sun, 20 Nov 2005 23:50:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: james.smart@emulex.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/lpfc/lpfc_scsi.c: make lpfc_sli_get_scsi_buf() static
Message-ID: <20051120225047.GY16060@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global function lpfc_sli_get_scsi_buf() 
static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

