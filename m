Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbWIQBvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbWIQBvz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 21:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbWIQBvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 21:51:54 -0400
Received: from mrs.stonybrook.edu ([129.49.1.206]:12935 "EHLO
	mrs.stonybrook.edu") by vger.kernel.org with ESMTP id S964903AbWIQBvw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 21:51:52 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 3 of 11] MTD: Use SEEK_{SET, CUR,
	END} instead of hardcoded values
X-Mercurial-Node: 7d3e8ba1ace3bd0315cc2a0a14404be334fc94c0
Message-Id: <7d3e8ba1ace3bd0315cc.1158455369@turing.ams.sunysb.edu>
In-Reply-To: <patchbomb.1158455366@turing.ams.sunysb.edu>
Date: Sat, 16 Sep 2006 21:09:29 -0400
From: "Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>
To: linux-kernel@vger.kernel.org
Cc: dwmw2@infradead.org, akpm@osdl.org, dhowells@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MTD: Use SEEK_{SET,CUR,END} instead of hardcoded values

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

--

diff -r e90cdef08ec3 -r 7d3e8ba1ace3 drivers/mtd/mtdchar.c
--- a/drivers/mtd/mtdchar.c	Sat Sep 16 21:00:45 2006 -0400
+++ b/drivers/mtd/mtdchar.c	Sat Sep 16 21:00:45 2006 -0400
@@ -62,15 +62,12 @@ static loff_t mtd_lseek (struct file *fi
 	struct mtd_info *mtd = mfi->mtd;
 
 	switch (orig) {
-	case 0:
-		/* SEEK_SET */
-		break;
-	case 1:
-		/* SEEK_CUR */
+	case SEEK_SET:
+		break;
+	case SEEK_CUR:
 		offset += file->f_pos;
 		break;
-	case 2:
-		/* SEEK_END */
+	case SEEK_END:
 		offset += mtd->size;
 		break;
 	default:


