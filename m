Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbWGNHnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbWGNHnI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 03:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbWGNHnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 03:43:07 -0400
Received: from [210.76.114.181] ([210.76.114.181]:58300 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S964804AbWGNHnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 03:43:07 -0400
Message-ID: <44B74B0C.1020001@ccoss.com.cn>
Date: Fri, 14 Jul 2006 15:43:08 +0800
From: liyu <liyu@ccoss.com.cn>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: dwmw2@infradead.org
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] bugfix for one typo in drivers/mtd/nand/nand_base.c
Content-Type: multipart/mixed;
 boundary="------------090108090804050704070101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090108090804050704070101
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi:

    This is one patch that bugfix one typo in 
drivers/mtd/nand/nand_base.c. It seem we lost the
character 'x' here.
   
    This patch can apply on 2.6.18-rc1-git8 at least.

    Goodluck.

-liyu

--- nand_base.c.orig    2006-07-14 15:30:04.000000000 +0800
+++ nand_base.c 2006-07-14 15:30:46.000000000 +0800
@@ -2222,7 +2222,7 @@
        }
 
        /* Try to identify manufacturer */
-       for (maf_idx = 0; nand_manuf_ids[maf_idx].id != 0x0; maf_id++) {
+       for (maf_idx = 0; nand_manuf_ids[maf_idx].id != 0x0; maf_idx++) {
                if (nand_manuf_ids[maf_idx].id == *maf_id)
                        break;
        }


--------------090108090804050704070101
Content-Type: text/x-patch;
 name="b.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="b.patch"

--- nand_base.c.orig	2006-07-14 15:30:04.000000000 +0800
+++ nand_base.c	2006-07-14 15:30:46.000000000 +0800
@@ -2222,7 +2222,7 @@
 	}
 
 	/* Try to identify manufacturer */
-	for (maf_idx = 0; nand_manuf_ids[maf_idx].id != 0x0; maf_id++) {
+	for (maf_idx = 0; nand_manuf_ids[maf_idx].id != 0x0; maf_idx++) {
 		if (nand_manuf_ids[maf_idx].id == *maf_id)
 			break;
 	}

--------------090108090804050704070101--
