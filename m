Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262595AbVG2LBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262595AbVG2LBg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 07:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbVG2LA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 07:00:59 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:48396 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262598AbVG2K67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 06:58:59 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] fuse: module alias
Message-Id: <E1DySZh-0004qc-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 29 Jul 2005 12:58:45 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the following patch adds MODULE_ALIAS_MISCDEV() definition for fuse
driver.  It will enable the auto-loading of the module via access to
the corresponding device file.

From: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

diff -rup linux-2.6.13-rc3-mm3/fs/fuse/dev.c linux-fuse/fs/fuse/dev.c
--- linux-2.6.13-rc3-mm3/fs/fuse/dev.c	2005-07-29 11:01:10.000000000 +0200
+++ linux-fuse/fs/fuse/dev.c	2005-07-29 10:36:59.000000000 +0200
@@ -17,6 +17,8 @@
 #include <linux/file.h>
 #include <linux/slab.h>
 
+MODULE_ALIAS_MISCDEV(FUSE_MINOR);
+
 static kmem_cache_t *fuse_req_cachep;
 
 static inline struct fuse_conn *fuse_get_conn(struct file *file)
