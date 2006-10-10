Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030506AbWJJV4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030506AbWJJV4b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030511AbWJJVqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:46:44 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:25019 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030510AbWJJVqi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:46:38 -0400
To: torvalds@osdl.org
Subject: [PATCH] mtd: remove several bogus casts to void * in iounmap() argument
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPQr-0007Mu-9j@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:46:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/mtd/maps/physmap.c     |    2 +-
 drivers/mtd/nand/cs553x_nand.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/maps/physmap.c b/drivers/mtd/maps/physmap.c
index bc7cc71..d171776 100644
--- a/drivers/mtd/maps/physmap.c
+++ b/drivers/mtd/maps/physmap.c
@@ -62,7 +62,7 @@ #endif
 	}
 
 	if (info->map.virt != NULL)
-		iounmap((void *)info->map.virt);
+		iounmap(info->map.virt);
 
 	if (info->res != NULL) {
 		release_resource(info->res);
diff --git a/drivers/mtd/nand/cs553x_nand.c b/drivers/mtd/nand/cs553x_nand.c
index e0a1d38..94924d5 100644
--- a/drivers/mtd/nand/cs553x_nand.c
+++ b/drivers/mtd/nand/cs553x_nand.c
@@ -249,7 +249,7 @@ static int __init cs553x_init_one(int cs
 	goto out;
 
 out_ior:
-	iounmap((void *)this->IO_ADDR_R);
+	iounmap(this->IO_ADDR_R);
 out_mtd:
 	kfree(new_mtd);
 out:
-- 
1.4.2.GIT


