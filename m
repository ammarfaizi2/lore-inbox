Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265681AbUBPQlk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 11:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265692AbUBPQlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 11:41:40 -0500
Received: from h80ad2711.async.vt.edu ([128.173.39.17]:47395 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265681AbUBPQli (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 11:41:38 -0500
Message-Id: <200402161641.i1GGfZsS029378@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: 2.6.3-rc3-mm1 - compile whoops in fs/ext3/super.c
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 16 Feb 2004 11:41:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got a spare open-curly that peeved the gcc parser.  Patch appended.  If there's
supposed to be a closing curly someplace else, please let me know... :)

--- linux-2.6.3-rc3-mm1/fs/ext3/super.c.dist	2004-02-16 11:37:26.715311815 -0500
+++ linux-2.6.3-rc3-mm1/fs/ext3/super.c	2004-02-16 11:38:21.151415057 -0500
@@ -2209,7 +2209,7 @@
 		return err;
 	if (nd.mnt->mnt_sb != sb)	/* Quotafile not on the same fs? */
 		return -EXDEV;
-	if (nd.dentry->d_parent->d_inode != sb->s_root->d_inode) {
+	if (nd.dentry->d_parent->d_inode != sb->s_root->d_inode)
 		/* Quotafile not of fs root? */
 		printk(KERN_WARNING "EXT3-fs: Quota file not on filesystem "
 				"root. Journalled quota will not work\n");


