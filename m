Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265872AbUGEMRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265872AbUGEMRG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 08:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265923AbUGEMRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 08:17:06 -0400
Received: from outmx023.isp.belgacom.be ([195.238.2.204]:54741 "EHLO
	outmx023.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S265872AbUGEMQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 08:16:49 -0400
Subject: [Patch 2.6.7-mm4] adfs : obsolete comments
From: FabF <fabian.frederick@skynet.be>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-pAkMCLnzaXr0NJhkWhHp"
Message-Id: <1089029775.2423.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 05 Jul 2004 14:16:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pAkMCLnzaXr0NJhkWhHp
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

	Here are some trivial adfs comment updates.

Regards,
FabF

--=-pAkMCLnzaXr0NJhkWhHp
Content-Disposition: attachment; filename=adfs_fix1.patch
Content-Type: text/x-patch; name=adfs_fix1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Trivial adfs comments update
	-reserved_lookup no longer exists
	-get_empty_inode as well

Signed off by FabF
---


diff -puN fs/adfs/dir.c~adfs_fix1 fs/adfs/dir.c
--- linux-2.6.7/fs/adfs/dir.c~adfs_fix1	2004-07-03 20:31:40.000000000 +0200
+++ linux-2.6.7-heatwave/fs/adfs/dir.c	2004-07-05 14:08:59.624800231 +0200
@@ -160,7 +160,7 @@ adfs_dir_lookup_byname(struct inode *ino
 	obj->parent_id = inode->i_ino;
 
 	/*
-	 * '.' is handled by reserved_lookup() in fs/namei.c
+	 * '.' is handled by link_path_walk() in fs/namei.c
 	 */
 	if (name->len == 2 && name->name[0] == '.' && name->name[1] == '.') {
 		/*
@@ -280,8 +280,7 @@ struct dentry *adfs_lookup(struct inode 
 	if (error == 0) {
 		error = -EACCES;
 		/*
-		 * This only returns NULL if get_empty_inode
-		 * fails.
+		 * This only returns NULL if new_inode fails
 		 */
 		inode = adfs_iget(dir->i_sb, &obj);
 		if (inode)
_

--=-pAkMCLnzaXr0NJhkWhHp--

