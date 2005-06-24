Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbVFXID2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVFXID2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 04:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262858AbVFXID2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 04:03:28 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3334 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261429AbVFXIDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 04:03:20 -0400
Date: Fri, 24 Jun 2005 10:03:15 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Joel Becker <joel.becker@oracle.com>
Cc: ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [-mm patch] CONFIGFS_FS shouldn't be user-visible
Message-ID: <20050624080315.GC26545@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't found any reason why CONFIGFS_FS is user-visible.
Other parts of the kernel using configfs should simply select it.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-mm1-full/fs/Kconfig.old	2005-06-21 23:19:19.000000000 +0200
+++ linux-2.6.12-mm1-full/fs/Kconfig	2005-06-21 23:22:30.000000000 +0200
@@ -981,16 +981,7 @@
 	  ramfs.
 
 config CONFIGFS_FS
-	tristate "Userspace-driven configuration filesystem (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	help
-	  configfs is a ram-based filesystem that provides the converse
-	  of sysfs's functionality. Where sysfs is a filesystem-based
-	  view of kernel objects, configfs is a filesystem-based manager
-	  of kernel objects, or config_items.
-
-	  Both sysfs and configfs can and should exist together on the
-	  same system. One is not a replacement for the other.
+	tristate
 
 config RELAYFS_FS
 	tristate "Relayfs file system support"

