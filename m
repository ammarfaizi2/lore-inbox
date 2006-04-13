Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbWDMHGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbWDMHGn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 03:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWDMHGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 03:06:43 -0400
Received: from TYO206.gate.nec.co.jp ([202.32.8.206]:2558 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1751109AbWDMHGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 03:06:41 -0400
To: Ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC][6/21]efs modify format strings
Message-Id: <20060413160603sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Thu, 13 Apr 2006 16:06:03 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of this patch:
  [6/21]  modify format strings in print(efs)
          - As i_blocks of VFS inode gets 8 byte variable, change its
            string format to %lld.

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -upNr -X linux-2.6.17-rc1.org/Documentation/dontdiff linux-2.6.17-rc1.org/fs/efs/file.c linux-2.6.17-rc1.tmp/fs/efs/file.c
--- linux-2.6.17-rc1.org/fs/efs/file.c	2006-03-29 11:48:27.000000000 +0900
+++ linux-2.6.17-rc1.tmp/fs/efs/file.c	2006-03-29 15:40:22.000000000 +0900
@@ -22,7 +22,7 @@ int efs_get_block(struct inode *inode, s
 		/*
 		 * i have no idea why this happens as often as it does
 		 */
-		printk(KERN_WARNING "EFS: bmap(): block %d >= %ld (filesize %ld)\n",
+		printk(KERN_WARNING "EFS: bmap(): block %d >= %lld (filesize %ld)\n",
 			block,
 			inode->i_blocks,
 			inode->i_size);
@@ -48,7 +48,7 @@ int efs_bmap(struct inode *inode, efs_bl
 		/*
 		 * i have no idea why this happens as often as it does
 		 */
-		printk(KERN_WARNING "EFS: bmap(): block %d >= %ld (filesize %ld)\n",
+		printk(KERN_WARNING "EFS: bmap(): block %d >= %lld (filesize %ld)\n",
 			block,
 			inode->i_blocks,
 			inode->i_size);
