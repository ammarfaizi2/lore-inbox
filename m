Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbVKSEOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbVKSEOt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 23:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbVKSEOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 23:14:49 -0500
Received: from c-67-182-200-232.hsd1.ut.comcast.net ([67.182.200.232]:42997
	"EHLO sshock.homelinux.net") by vger.kernel.org with ESMTP
	id S1750877AbVKSEOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 23:14:48 -0500
Date: Fri, 18 Nov 2005 21:14:42 -0700
From: Phillip Hellewell <phillip@hellewell.homeip.net>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, yoder1@us.ibm.com
Subject: [PATCH 1/12: eCryptfs] Makefile and Kconfig 
Message-ID: <20051119041442.GA15747@sshock.rn.byu.edu>
References: <20051119041130.GA15559@sshock.rn.byu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051119041130.GA15559@sshock.rn.byu.edu>
X-URL: http://hellewell.homeip.net/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These patches modify fs/Makefile and fs/Kconfig to provide build
support for eCryptfs.

Signed-off-by: Phillip Hellewell <phillip@hellewell.homeip.net>
Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 Kconfig  |   10 ++++++++++
 Makefile |    1 +
 2 files changed, 11 insertions(+)
--- linux-2.6.15-rc1-mm1/fs/Makefile	2005-11-18 11:38:19.000000000 -0600
+++ linux-2.6.15-rc1-mm1-ecryptfs/fs/Makefile	2005-11-18 11:40:30.000000000 -0600
@@ -67,6 +67,7 @@
 obj-$(CONFIG_ISO9660_FS)	+= isofs/
 obj-$(CONFIG_DEVFS_FS)		+= devfs/
 obj-$(CONFIG_HFSPLUS_FS)	+= hfsplus/ # Before hfs to find wrapped HFS+
+obj-$(CONFIG_ECRYPTFS)		+= ecryptfs/
 obj-$(CONFIG_HFS_FS)		+= hfs/
 obj-$(CONFIG_VXFS_FS)		+= freevxfs/
 obj-$(CONFIG_NFS_FS)		+= nfs/
--- linux-2.6.15-rc1-mm1/fs/Kconfig	2005-11-18 11:38:19.000000000 -0600
+++ linux-2.6.15-rc1-mm1-ecryptfs/fs/Kconfig	2005-11-18 11:40:30.000000000 -0600
@@ -989,6 +989,16 @@
 
 	  If unsure, say N.
 
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
