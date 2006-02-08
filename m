Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWBHDSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWBHDSi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWBHDSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:18:37 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:59264 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751141AbWBHDSc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:18:32 -0500
To: torvalds@osdl.org
Subject: [PATCH 08/29] drivers/scsi/mac53c94.c __iomem annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1F6fqi-0006C7-0y@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 03:18:32 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1133866874 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/scsi/mac53c94.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

7be7cbf684b372abaa8d6723eabedfa6ad79ee43
diff --git a/drivers/scsi/mac53c94.c b/drivers/scsi/mac53c94.c
index 311a412..93edaa8 100644
--- a/drivers/scsi/mac53c94.c
+++ b/drivers/scsi/mac53c94.c
@@ -537,9 +537,9 @@ static int mac53c94_remove(struct macio_
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

