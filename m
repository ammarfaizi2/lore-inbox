Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263772AbUFFQMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbUFFQMj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 12:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUFFQMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 12:12:39 -0400
Received: from may.priocom.com ([213.156.65.50]:42239 "EHLO may.priocom.com")
	by vger.kernel.org with ESMTP id S263772AbUFFQMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 12:12:35 -0400
Subject: [PATCH] 2.6.6 memory allocation checks in mtdblock_open()
From: Yury Umanets <torque@ukrpost.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1086538383.2793.78.camel@firefly>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 06 Jun 2004 19:13:03 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes memory allocation check in mtdblock_open()

 ./linux-2.6.6-modified/drivers/mtd/mtdblock.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Signed-off-by: Yury Umanets <torque@ukrpost.net>

diff -rupN ./linux-2.6.6/drivers/mtd/mtdblock.c
./linux-2.6.6-modified/drivers/mtd/mtdblock.c
--- ./linux-2.6.6/drivers/mtd/mtdblock.c	Mon May 10 05:32:28 2004
+++ ./linux-2.6.6-modified/drivers/mtd/mtdblock.c	Wed Jun  2 14:27:36
2004
@@ -275,7 +275,7 @@ static int mtdblock_open(struct mtd_blkt
 	
 	/* OK, it's not open. Create cache info for it */
 	mtdblk = kmalloc(sizeof(struct mtdblk_dev), GFP_KERNEL);
-	if (!mtdblks)
+	if (!mtdblk)
 		return -ENOMEM;
 
 	memset(mtdblk, 0, sizeof(*mtdblk));


-- 
umka

