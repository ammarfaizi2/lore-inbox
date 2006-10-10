Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030505AbWJJVqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030505AbWJJVqK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030508AbWJJVqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:46:06 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:41412 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030493AbWJJVps
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:45:48 -0400
To: torvalds@osdl.org
Subject: [PATCH] drivers/dma trivial annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPQ3-0007LA-75@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:45:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/dma/ioatdma.c |    4 ++--
 drivers/dma/ioatdma.h |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ioatdma.c b/drivers/dma/ioatdma.c
index f3bf1e2..0358419 100644
--- a/drivers/dma/ioatdma.c
+++ b/drivers/dma/ioatdma.c
@@ -80,7 +80,7 @@ static int enumerate_dma_channels(struct
 
 static struct ioat_desc_sw *ioat_dma_alloc_descriptor(
 	struct ioat_dma_chan *ioat_chan,
-	int flags)
+	gfp_t flags)
 {
 	struct ioat_dma_descriptor *desc;
 	struct ioat_desc_sw *desc_sw;
@@ -686,7 +686,7 @@ static int __devinit ioat_probe(struct p
 {
 	int err;
 	unsigned long mmio_start, mmio_len;
-	void *reg_base;
+	void __iomem *reg_base;
 	struct ioat_device *device;
 
 	err = pci_enable_device(pdev);
diff --git a/drivers/dma/ioatdma.h b/drivers/dma/ioatdma.h
index a5d3b36..62b26a9 100644
--- a/drivers/dma/ioatdma.h
+++ b/drivers/dma/ioatdma.h
@@ -44,7 +44,7 @@ extern struct list_head dma_client_list;
 
 struct ioat_device {
 	struct pci_dev *pdev;
-	void *reg_base;
+	void __iomem *reg_base;
 	struct pci_pool *dma_pool;
 	struct pci_pool *completion_pool;
 
@@ -73,7 +73,7 @@ struct ioat_device {
 
 struct ioat_dma_chan {
 
-	void *reg_base;
+	void __iomem *reg_base;
 
 	dma_cookie_t completed_cookie;
 	unsigned long last_completion;
-- 
1.4.2.GIT


