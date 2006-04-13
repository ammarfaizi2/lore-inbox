Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWDMHGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWDMHGV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 03:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWDMHGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 03:06:21 -0400
Received: from TYO206.gate.nec.co.jp ([202.32.8.206]:44285 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1751102AbWDMHGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 03:06:20 -0400
To: Ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC][5/21]bfs modify format strings
Message-Id: <20060413160542sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Thu, 13 Apr 2006 16:05:42 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of this patch:
  [5/21]  modify format strings in print(bfs)
          - As i_blocks of VFS inode gets 8 byte variable, change its
            string format to %lld.

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -upNr -X linux-2.6.17-rc1.org/Documentation/dontdiff linux-2.6.17-rc1.org/fs/bfs/inode.c linux-2.6.17-rc1.tmp/fs/bfs/inode.c
--- linux-2.6.17-rc1.org/fs/bfs/inode.c	2006-03-29 11:48:27.000000000 +0900
+++ linux-2.6.17-rc1.tmp/fs/bfs/inode.c	2006-03-29 15:37:56.000000000 +0900
@@ -75,7 +75,7 @@ static void bfs_read_inode(struct inode 
 	inode->i_nlink =  le32_to_cpu(di->i_nlink);
 	inode->i_size = BFS_FILESIZE(di);
 	inode->i_blocks = BFS_FILEBLOCKS(di);
-        if (inode->i_size || inode->i_blocks) dprintf("Registered inode with %lld size, %ld blocks\n", inode->i_size, inode->i_blocks);
+        if (inode->i_size || inode->i_blocks) dprintf("Registered inode with %lld size, %lld blocks\n", inode->i_size, inode->i_blocks);
 	inode->i_blksize = PAGE_SIZE;
 	inode->i_atime.tv_sec =  le32_to_cpu(di->i_atime);
 	inode->i_mtime.tv_sec =  le32_to_cpu(di->i_mtime);
