Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275499AbTHSGlC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 02:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275386AbTHSGkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 02:40:49 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:7040 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S275499AbTHSGgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 02:36:42 -0400
Date: Tue, 19 Aug 2003 16:37:54 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 7/10] 2.6.0-t3: struct C99 initialiser conversion
Message-ID: <20030819063754.GM643@zip.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3ecMC0kzqsE2ddMN"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3ecMC0kzqsE2ddMN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

linux/fs/ patch

-- 
"How can I not love the Americans? They helped me with a flat tire the
other day," he said.
	- http://tinyurl.com/h6fo

--3ecMC0kzqsE2ddMN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.6.0-t3.c99.fs.patch"

diff -aur linux.backup/fs/affs/file.c linux/fs/affs/file.c
--- linux.backup/fs/affs/file.c	Mon Jan 27 13:41:42 2003
+++ linux/fs/affs/file.c	Sun Aug 17 00:03:08 2003
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
+++ linux/fs/jffs2/wbuf.c	Sun Aug 17 00:04:26 2003
@@ -37,8 +37,8 @@
 #define NAND_JFFS2_OOB16_FSDALEN	8
 
 struct nand_oobinfo jffs2_oobinfo = {
-	useecc: 1,
-	eccpos: {JFFS2_OOB_ECCPOS0, JFFS2_OOB_ECCPOS1, JFFS2_OOB_ECCPOS2, JFFS2_OOB_ECCPOS3, JFFS2_OOB_ECCPOS4, JFFS2_OOB_ECCPOS5}
+	.useecc = 1,
+	.eccpos = {JFFS2_OOB_ECCPOS0, JFFS2_OOB_ECCPOS1, JFFS2_OOB_ECCPOS2, JFFS2_OOB_ECCPOS3, JFFS2_OOB_ECCPOS4, JFFS2_OOB_ECCPOS5}
 };
 
 static inline void jffs2_refile_wbuf_blocks(struct jffs2_sb_info *c)

--3ecMC0kzqsE2ddMN--
