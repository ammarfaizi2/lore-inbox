Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030438AbVKWWjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030438AbVKWWjy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030444AbVKWWjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:39:02 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1555 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030438AbVKWWfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:35:09 -0500
Date: Wed, 23 Nov 2005 23:35:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: zippel@linux-m68k.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/hfsplus/: move the hfsplus_inode_check() prototype to hfsplus_fs.h
Message-ID: <20051123223508.GG3963@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Function prototypes belong into header files.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/hfsplus/hfsplus_fs.h |    3 +++
 fs/hfsplus/inode.c      |    2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.15-rc2-mm1-full/fs/hfsplus/hfsplus_fs.h.old	2005-11-23 16:36:41.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/fs/hfsplus/hfsplus_fs.h	2005-11-23 16:37:19.000000000 +0100
@@ -347,6 +347,9 @@
 void hfsplus_fill_defaults(struct hfsplus_sb_info *);
 int hfsplus_show_options(struct seq_file *, struct vfsmount *);
 
+/* super.c */
+void hfsplus_inode_check(struct super_block *sb);
+
 /* tables.c */
 extern u16 hfsplus_case_fold_table[];
 extern u16 hfsplus_decompose_table[];
--- linux-2.6.15-rc2-mm1-full/fs/hfsplus/inode.c.old	2005-11-23 16:37:34.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/fs/hfsplus/inode.c	2005-11-23 16:37:48.000000000 +0100
@@ -183,7 +183,6 @@
 	hlist_add_head(&inode->i_hash, &HFSPLUS_SB(sb).rsrc_inodes);
 	mark_inode_dirty(inode);
 	{
-	void hfsplus_inode_check(struct super_block *sb);
 	atomic_inc(&HFSPLUS_SB(sb).inode_cnt);
 	hfsplus_inode_check(sb);
 	}
@@ -322,7 +321,6 @@
 		return NULL;
 
 	{
-	void hfsplus_inode_check(struct super_block *sb);
 	atomic_inc(&HFSPLUS_SB(sb).inode_cnt);
 	hfsplus_inode_check(sb);
 	}

