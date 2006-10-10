Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030521AbWJJVsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030521AbWJJVsH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030525AbWJJVsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:48:04 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:30651 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030516AbWJJVrs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:47:48 -0400
To: torvalds@osdl.org
Subject: [PATCH] gfp annotations: scsi_error
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPRz-0007On-D6@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:47:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/scsi/scsi_error.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 3d355d0..aff1b0c 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -495,7 +495,7 @@ static int scsi_send_eh_cmnd(struct scsi
 	memcpy(scmd->cmnd, cmnd, cmnd_size);
 
 	if (copy_sense) {
-		int gfp_mask = GFP_ATOMIC;
+		gfp_t gfp_mask = GFP_ATOMIC;
 
 		if (shost->hostt->unchecked_isa_dma)
 			gfp_mask |= __GFP_DMA;
-- 
1.4.2.GIT


