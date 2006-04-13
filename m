Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWDMHHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWDMHHL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 03:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWDMHHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 03:07:10 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:61602 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1751111AbWDMHHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 03:07:08 -0400
To: Ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC][7/21]jbd modify format strings
Message-Id: <20060413160629sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Thu, 13 Apr 2006 16:06:28 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of this patch:
  [7/21]  modify format strings in print(jbd)
          - The part which prints the signed value, related to a block
            and an inode, in decimal is corrected so that it can print
            unsigned one.

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -upNr -X linux-2.6.17-rc1.org/Documentation/dontdiff linux-2.6.17-rc1.org/fs/jbd/journal.c linux-2.6.17-rc1.tmp/fs/jbd/journal.c
--- linux-2.6.17-rc1.org/fs/jbd/journal.c	2006-03-29 11:48:27.000000000 +0900
+++ linux-2.6.17-rc1.tmp/fs/jbd/journal.c	2006-03-29 15:41:13.000000000 +0900
@@ -760,7 +760,7 @@ journal_t * journal_init_inode (struct i
 	journal->j_dev = journal->j_fs_dev = inode->i_sb->s_bdev;
 	journal->j_inode = inode;
 	jbd_debug(1,
-		  "journal %p: inode %s/%ld, size %Ld, bits %d, blksize %ld\n",
+		  "journal %p: inode %s/%u, size %Ld, bits %d, blksize %ld\n",
 		  journal, inode->i_sb->s_id, inode->i_ino, 
 		  (long long) inode->i_size,
 		  inode->i_sb->s_blocksize_bits, inode->i_sb->s_blocksize);
