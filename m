Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030530AbWJJVtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030530AbWJJVtU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030527AbWJJVsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:48:50 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:31675 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030513AbWJJVsI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:48:08 -0400
To: torvalds@osdl.org
Subject: [PATCH] trivial iomem annotations: sata_promise
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPSJ-0007PT-Dg@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:48:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/ata/sata_promise.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index d636ede..8bcdfa6 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -360,7 +360,7 @@ static void pdc_sata_phy_reset(struct at
 static void pdc_pata_cbl_detect(struct ata_port *ap)
 {
 	u8 tmp;
-	void __iomem *mmio = (void *) ap->ioaddr.cmd_addr + PDC_CTLSTAT + 0x03;
+	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr + PDC_CTLSTAT + 0x03;
 
 	tmp = readb(mmio);
 
-- 
1.4.2.GIT


