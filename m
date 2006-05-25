Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965149AbWEYMqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbWEYMqP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 08:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965148AbWEYMqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 08:46:15 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:4263 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S965151AbWEYMqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 08:46:12 -0400
To: adilger@clusterfs.com, cmm@us.ibm.com, jitendra@linsyssoft.com
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [UPDATE][8/24]efs modify format strings
Message-Id: <20060525214605sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Thu, 25 May 2006 21:46:05 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of this patch:
  [8/24]  modify format strings in print(efs)
          - As i_blocks of VFS inode gets 8 byte variable, change its
            string format to %lld.

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/efs/file.c linux-2.6.17-rc4.tmp/fs/efs/file.c
--- linux-2.6.17-rc4/fs/efs/file.c	2006-03-20 14:53:29.000000000 +0900
+++ linux-2.6.17-rc4.tmp/fs/efs/file.c	2006-05-25 16:32:28.543691208 +0900
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



