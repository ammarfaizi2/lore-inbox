Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTHTIGn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 04:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbTHTIEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 04:04:00 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:53453 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S261814AbTHTIDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 04:03:48 -0400
Date: Wed, 20 Aug 2003 18:04:56 +1000
Message-Id: <200308200804.h7K84uxA011782@theirongiant.lochness.weebeastie.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 13/16] C99: 2.6.0-t3-bk7/fs
Cc: Linus Torvalds <torvalds@osdl.org>
From: CaT <cat@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -aur linux.backup/fs/affs/file.c linux/fs/affs/file.c
--- linux.backup/fs/affs/file.c	Mon Jan 27 13:41:42 2003
+++ linux/fs/affs/file.c	Wed Aug 20 16:40:22 2003
@@ -793,8 +793,8 @@
 
 struct address_space_operations affs_aops_ofs = {
 	.readpage = affs_readpage_ofs,
-	//writepage: affs_writepage_ofs,
-	//sync_page: affs_sync_page_ofs,
+	//.writepage = affs_writepage_ofs,
+	//.sync_page = affs_sync_page_ofs,
 	.prepare_write = affs_prepare_write_ofs,
 	.commit_write = affs_commit_write_ofs
 };
diff -aur linux.backup/fs/jffs2/wbuf.c linux/fs/jffs2/wbuf.c
--- linux.backup/fs/jffs2/wbuf.c	Thu Jun 26 23:47:48 2003
+++ linux/fs/jffs2/wbuf.c	Wed Aug 20 16:40:22 2003
@@ -37,8 +37,8 @@
 #define NAND_JFFS2_OOB16_FSDALEN	8
 
 struct nand_oobinfo jffs2_oobinfo = {
-	useecc: 1,
-	eccpos: {JFFS2_OOB_ECCPOS0, JFFS2_OOB_ECCPOS1, JFFS2_OOB_ECCPOS2, JFFS2_OOB_ECCPOS3, JFFS2_OOB_ECCPOS4, JFFS2_OOB_ECCPOS5}
+	.useecc = 1,
+	.eccpos = {JFFS2_OOB_ECCPOS0, JFFS2_OOB_ECCPOS1, JFFS2_OOB_ECCPOS2, JFFS2_OOB_ECCPOS3, JFFS2_OOB_ECCPOS4, JFFS2_OOB_ECCPOS5}
 };
 
 static inline void jffs2_refile_wbuf_blocks(struct jffs2_sb_info *c)
