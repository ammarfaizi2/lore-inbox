Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965146AbWEYMpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965146AbWEYMpt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 08:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965148AbWEYMpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 08:45:49 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:33739 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S965146AbWEYMps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 08:45:48 -0400
To: adilger@clusterfs.com, cmm@us.ibm.com, jitendra@linsyssoft.com
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [UPDATE][7/24]bfs modify format strings
Message-Id: <20060525214540sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Thu, 25 May 2006 21:45:40 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of this patch:
  [7/24]  modify format strings in print(bfs)
          - As i_blocks of VFS inode gets 8 byte variable, change its
            string format to %lld.

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/bfs/inode.c linux-2.6.17-rc4.tmp/fs/bfs/inode.c
--- linux-2.6.17-rc4/fs/bfs/inode.c	2006-05-25 16:18:35.664795161 +0900
+++ linux-2.6.17-rc4.tmp/fs/bfs/inode.c	2006-05-25 16:32:04.666738376 +0900
@@ -75,7 +75,7 @@ static void bfs_read_inode(struct inode 
 	inode->i_nlink =  le32_to_cpu(di->i_nlink);
 	inode->i_size = BFS_FILESIZE(di);
 	inode->i_blocks = BFS_FILEBLOCKS(di);
-        if (inode->i_size || inode->i_blocks) dprintf("Registered inode with %lld size, %ld blocks\n", inode->i_size, inode->i_blocks);
+        if (inode->i_size || inode->i_blocks) dprintf("Registered inode with %lld size, %lld blocks\n", inode->i_size, inode->i_blocks);
 	inode->i_blksize = PAGE_SIZE;
 	inode->i_atime.tv_sec =  le32_to_cpu(di->i_atime);
 	inode->i_mtime.tv_sec =  le32_to_cpu(di->i_mtime);



