Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422656AbVLOJZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422656AbVLOJZO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422647AbVLOJYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:24:24 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:14506 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1422646AbVLOJSK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:18:10 -0500
To: torvalds@osdl.org
Subject: [PATCH] cyber2000fb.c __iomem annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EmpFa-0007zW-1A@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 15 Dec 2005 09:18:10 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>


---

 drivers/video/cyber2000fb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

d4d9193e1e51ad227030f69bc1ee87264eb8ed09
diff --git a/drivers/video/cyber2000fb.c b/drivers/video/cyber2000fb.c
index c589d23..a9300f9 100644
--- a/drivers/video/cyber2000fb.c
+++ b/drivers/video/cyber2000fb.c
@@ -1512,7 +1512,7 @@ static int cyberpro_pci_enable_mmio(stru
 	 * I/O cycles storing into a reserved memory space at
 	 * physical address 0x3000000
 	 */
-	unsigned char *iop;
+	unsigned char __iomem *iop;
 
 	iop = ioremap(0x3000000, 0x5000);
 	if (iop == NULL) {
@@ -1526,7 +1526,7 @@ static int cyberpro_pci_enable_mmio(stru
 	writeb(EXT_BIU_MISC, iop + 0x3ce);
 	writeb(EXT_BIU_MISC_LIN_ENABLE, iop + 0x3cf);
 
-	iounmap((void *)iop);
+	iounmap(iop);
 #else
 	/*
 	 * Most other machine types are "normal", so
-- 
0.99.9.GIT

