Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbVB0Rtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVB0Rtu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 12:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVB0Rru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 12:47:50 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:9123 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261456AbVB0RXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 12:23:04 -0500
Message-Id: <20050227170310.810890000@blunzn.suse.de>
References: <20050227165954.566746000@blunzn.suse.de>
Date: Sun, 27 Feb 2005 17:59:55 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Olaf Kirch <okir@suse.de>, "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>
Subject: [nfsacl v2 01/16] acl kconfig cleanup
Content-Disposition: inline; filename=acl-kconfig-cleanup.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Original patch from Matt Mackall <mpm@selenic.com>.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.11-rc5/fs/Kconfig
===================================================================
--- linux-2.6.11-rc5.orig/fs/Kconfig
+++ linux-2.6.11-rc5/fs/Kconfig
@@ -29,6 +29,7 @@ config EXT2_FS_XATTR
 config EXT2_FS_POSIX_ACL
 	bool "Ext2 POSIX Access Control Lists"
 	depends on EXT2_FS_XATTR
+	select FS_POSIX_ACL
 	help
 	  Posix Access Control Lists (ACLs) support permissions for users and
 	  groups beyond the owner/group/world scheme.
@@ -97,6 +98,7 @@ config EXT3_FS_XATTR
 config EXT3_FS_POSIX_ACL
 	bool "Ext3 POSIX Access Control Lists"
 	depends on EXT3_FS_XATTR
+	select FS_POSIX_ACL
 	help
 	  Posix Access Control Lists (ACLs) support permissions for users and
 	  groups beyond the owner/group/world scheme.
@@ -224,6 +226,7 @@ config REISERFS_FS_XATTR
 config REISERFS_FS_POSIX_ACL
 	bool "ReiserFS POSIX Access Control Lists"
 	depends on REISERFS_FS_XATTR
+	select FS_POSIX_ACL
 	help
 	  Posix Access Control Lists (ACLs) support permissions for users and
 	  groups beyond the owner/group/world scheme.
@@ -257,6 +260,7 @@ config JFS_FS
 config JFS_POSIX_ACL
 	bool "JFS POSIX Access Control Lists"
 	depends on JFS_FS
+	select FS_POSIX_ACL
 	help
 	  Posix Access Control Lists (ACLs) support permissions for users and
 	  groups beyond the owner/group/world scheme.
@@ -289,8 +293,7 @@ config FS_POSIX_ACL
 # 	Never use this symbol for ifdefs.
 #
 	bool
-	depends on EXT2_FS_POSIX_ACL || EXT3_FS_POSIX_ACL || JFS_POSIX_ACL || REISERFS_FS_POSIX_ACL || NFSD_V4
-	default y
+	default n
 
 config XFS_FS
 	tristate "XFS filesystem support"
@@ -1531,6 +1534,7 @@ config NFSD_V4
 	bool "Provide NFSv4 server support (EXPERIMENTAL)"
 	depends on NFSD_V3 && EXPERIMENTAL
 	select NFSD_TCP
+	select FS_POSIX_ACL
 	help
 	  If you would like to include the NFSv4 server as well as the NFSv2
 	  and NFSv3 servers, say Y here.  This feature is experimental, and

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

