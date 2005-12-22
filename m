Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965101AbVLVEwC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965101AbVLVEwC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 23:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965104AbVLVEvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:51:55 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:38096 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965099AbVLVEvu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:51:50 -0500
To: linux-m68k@vger.kernel.org
Subject: [PATCH 33/36] m68k: drivers/scsi/mac53c94.c __iomem annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EpIQf-0004tx-Oh@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 22 Dec 2005 04:51:49 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1133866874 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/scsi/mac53c94.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

c142eb4b3a51224952b8760cff73051398dac312
diff --git a/drivers/scsi/mac53c94.c b/drivers/scsi/mac53c94.c
index 932dcf0..a853fb4 100644
--- a/drivers/scsi/mac53c94.c
+++ b/drivers/scsi/mac53c94.c
@@ -531,9 +531,9 @@ static int mac53c94_remove(struct macio_
 	free_irq(fp->intr, fp);
 
 	if (fp->regs)
-		iounmap((void *) fp->regs);
+		iounmap(fp->regs);
 	if (fp->dma)
-		iounmap((void *) fp->dma);
+		iounmap(fp->dma);
 	kfree(fp->dma_cmd_space);
 
 	scsi_host_put(host);
-- 
0.99.9.GIT

