Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965148AbWEYMqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965148AbWEYMqj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 08:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965153AbWEYMqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 08:46:39 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:14284 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S965148AbWEYMqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 08:46:37 -0400
To: adilger@clusterfs.com, cmm@us.ibm.com, jitendra@linsyssoft.com
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [UPDATE][9/24]jbd modify format strings
Message-Id: <20060525214630sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Thu, 25 May 2006 21:46:30 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of this patch:
  [9/24]  modify format strings in print(jbd)
          - The part which prints the signed value, related to a block
            and an inode, in decimal is corrected so that it can print
            unsigned one.

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/jbd/journal.c linux-2.6.17-rc4.tmp/fs/jbd/journal.c
--- linux-2.6.17-rc4/fs/jbd/journal.c	2006-05-25 16:18:35.892334221 +0900
+++ linux-2.6.17-rc4.tmp/fs/jbd/journal.c	2006-05-25 16:32:49.434315952 +0900
@@ -760,7 +760,7 @@ journal_t * journal_init_inode (struct i
 	journal->j_dev = journal->j_fs_dev = inode->i_sb->s_bdev;
 	journal->j_inode = inode;
 	jbd_debug(1,
-		  "journal %p: inode %s/%ld, size %Ld, bits %d, blksize %ld\n",
+		  "journal %p: inode %s/%u, size %Ld, bits %d, blksize %ld\n",
 		  journal, inode->i_sb->s_id, inode->i_ino, 
 		  (long long) inode->i_size,
 		  inode->i_sb->s_blocksize_bits, inode->i_sb->s_blocksize);



