Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbVFBFtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbVFBFtg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 01:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVFBFte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 01:49:34 -0400
Received: from c-24-10-129-155.hsd1.ut.comcast.net ([24.10.129.155]:56008 "EHLO
	sshock.homelinux.net") by vger.kernel.org with ESMTP
	id S261578AbVFBFs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 01:48:27 -0400
Date: Wed, 1 Jun 2005 23:49:29 -0600
From: Phillip Hellewell <phillip@hellewell.homeip.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] eCryptfs: Kconfig and Makefile
Message-ID: <20050602054929.GC4514@sshock.rn.byu.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
X-URL: http://hellewell.homeip.net/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is the third in a series of three patches for the eCryptfs kernel
module.

This patch includes the changes to Kconfig and Makefile (in linux/fs)
needed for building eCryptfs.

-- 
Phillip Hellewell <phillip AT hellewell.homeip.net>

--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-2.6.12-rc4-mm2-ecryptfs-3_of_3-kconfig-makefile.diff"

--- linux-2.6.12-rc4-mm2/fs/Kconfig	2005-05-23 21:20:30.214356232 -0600
+++ linux-2.6.12-rc4-mm2-ecryptfs/fs/Kconfig	2005-05-23 21:45:33.124879104 -0600
@@ -1001,6 +1001,16 @@
 	  To compile this file system support as a module, choose M here: the
 	  module will be called affs.  If unsure, say N.
 
+config ECRYPTFS
+	tristate "eCrypt filesystem layer support (EXPERIMENTAL)"
+	depends on EXPERIMENTAL && KEYS && CRYPTO
+	help
+	  Encrypted filesystem that operates on the VFS layer.  See
+	  Documentation/ecryptfs.txt to learn more about eCryptfs.
+
+	  To compile this file system support as a module, choose M here: the
+	  module will be called ecryptfs.
+
 config HFS_FS
 	tristate "Apple Macintosh file system support (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
--- linux-2.6.12-rc4-mm2/fs/Makefile	2005-05-23 21:20:30.254350152 -0600
+++ linux-2.6.12-rc4-mm2-ecryptfs/fs/Makefile	2005-05-23 21:45:33.135877432 -0600
@@ -68,6 +68,7 @@
 obj-$(CONFIG_ISO9660_FS)	+= isofs/
 obj-$(CONFIG_DEVFS_FS)		+= devfs/
 obj-$(CONFIG_HFSPLUS_FS)	+= hfsplus/ # Before hfs to find wrapped HFS+
+obj-$(CONFIG_ECRYPTFS)		+= ecryptfs/
 obj-$(CONFIG_HFS_FS)		+= hfs/
 obj-$(CONFIG_VXFS_FS)		+= freevxfs/
 obj-$(CONFIG_NFS_FS)		+= nfs/

--jho1yZJdad60DJr+--
