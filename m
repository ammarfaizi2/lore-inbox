Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030184AbVLMRBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030184AbVLMRBz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 12:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbVLMRBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 12:01:55 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56589 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964943AbVLMRBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 12:01:55 -0500
Date: Tue, 13 Dec 2005 18:01:41 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: zippel@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/hfsplus/: move the hfsplus_inode_check() prototype to hfsplus_fs.h
Message-ID: <20051213170137.GL23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Function prototypes belong into header files.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 23 Nov 2005

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

