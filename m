Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbWGMIEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWGMIEx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 04:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWGMIEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 04:04:53 -0400
Received: from fc-cn.com ([218.25.172.144]:6918 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S964845AbWGMIEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 04:04:52 -0400
Date: Thu, 13 Jul 2006 16:05:38 +0800
From: Qi Yong <qiyong@fc-cn.com>
To: akpm@osdl.org
Cc: sct@redhat.com, adilger@clusterfs.com, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [patch] ext3: remove btree_dir
Message-ID: <20060713080538.GA20259@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove support for EXT3_FEATURE_RO_COMPAT_BTREE_DIR, so mount can
safely fail out when some new feature added using 0x0004. 

Signed-off-by: Qi Yong <qiyong@fc-cn.com>
---

diff --git a/include/linux/ext2_fs.h b/include/linux/ext2_fs.h
index facf34e..d63d2ec 100644
--- a/include/linux/ext2_fs.h
+++ b/include/linux/ext2_fs.h
@@ -463,7 +463,6 @@ #define EXT2_FEATURE_COMPAT_ANY			0xffff
 
 #define EXT2_FEATURE_RO_COMPAT_SPARSE_SUPER	0x0001
 #define EXT2_FEATURE_RO_COMPAT_LARGE_FILE	0x0002
-#define EXT2_FEATURE_RO_COMPAT_BTREE_DIR	0x0004
 #define EXT2_FEATURE_RO_COMPAT_ANY		0xffffffff
 
 #define EXT2_FEATURE_INCOMPAT_COMPRESSION	0x0001
@@ -477,8 +476,7 @@ #define EXT2_FEATURE_COMPAT_SUPP	EXT2_FE
 #define EXT2_FEATURE_INCOMPAT_SUPP	(EXT2_FEATURE_INCOMPAT_FILETYPE| \
 					 EXT2_FEATURE_INCOMPAT_META_BG)
 #define EXT2_FEATURE_RO_COMPAT_SUPP	(EXT2_FEATURE_RO_COMPAT_SPARSE_SUPER| \
-					 EXT2_FEATURE_RO_COMPAT_LARGE_FILE| \
-					 EXT2_FEATURE_RO_COMPAT_BTREE_DIR)
+					 EXT2_FEATURE_RO_COMPAT_LARGE_FILE)
 #define EXT2_FEATURE_RO_COMPAT_UNSUPPORTED	~EXT2_FEATURE_RO_COMPAT_SUPP
 #define EXT2_FEATURE_INCOMPAT_UNSUPPORTED	~EXT2_FEATURE_INCOMPAT_SUPP
 
diff --git a/include/linux/ext3_fs.h b/include/linux/ext3_fs.h
index 5607e64..7974c44 100644
--- a/include/linux/ext3_fs.h
+++ b/include/linux/ext3_fs.h
@@ -553,7 +553,6 @@ #define EXT3_FEATURE_COMPAT_DIR_INDEX		0
 
 #define EXT3_FEATURE_RO_COMPAT_SPARSE_SUPER	0x0001
 #define EXT3_FEATURE_RO_COMPAT_LARGE_FILE	0x0002
-#define EXT3_FEATURE_RO_COMPAT_BTREE_DIR	0x0004
 
 #define EXT3_FEATURE_INCOMPAT_COMPRESSION	0x0001
 #define EXT3_FEATURE_INCOMPAT_FILETYPE		0x0002
@@ -566,8 +565,7 @@ #define EXT3_FEATURE_INCOMPAT_SUPP	(EXT3
 					 EXT3_FEATURE_INCOMPAT_RECOVER| \
 					 EXT3_FEATURE_INCOMPAT_META_BG)
 #define EXT3_FEATURE_RO_COMPAT_SUPP	(EXT3_FEATURE_RO_COMPAT_SPARSE_SUPER| \
-					 EXT3_FEATURE_RO_COMPAT_LARGE_FILE| \
-					 EXT3_FEATURE_RO_COMPAT_BTREE_DIR)
+					 EXT3_FEATURE_RO_COMPAT_LARGE_FILE)
 
 /*
  * Default values for user and/or group using reserved blocks

-- 
Qi Yong
