Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935516AbWK1Ey3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935516AbWK1Ey3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 23:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935563AbWK1Ey3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 23:54:29 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:55559 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S935516AbWK1Ey2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 23:54:28 -0500
Date: Tue, 28 Nov 2006 05:54:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] include/linux/nfsd/const.h: remove NFS_SUPER_MAGIC
Message-ID: <20061128045431.GZ15364@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NFS_SUPER_MAGIC is already defined in include/linux/magic.h

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/nfs/super.c             |    1 +
 include/linux/nfsd/const.h |    4 ----
 2 files changed, 1 insertion(+), 4 deletions(-)

--- linux-2.6.19-rc6-mm1/include/linux/nfsd/const.h.old	2006-11-28 05:06:16.000000000 +0100
+++ linux-2.6.19-rc6-mm1/include/linux/nfsd/const.h	2006-11-28 05:06:35.000000000 +0100
@@ -30,10 +30,6 @@
 
 #include <linux/sunrpc/msg_prot.h>
 
-#ifndef NFS_SUPER_MAGIC
-# define NFS_SUPER_MAGIC	0x6969
-#endif
-
 /*
  * Largest number of bytes we need to allocate for an NFS
  * call or reply.  Used to control buffer sizes.  We use
--- linux-2.6.19-rc6-mm1/fs/nfs/super.c.old	2006-11-28 05:06:51.000000000 +0100
+++ linux-2.6.19-rc6-mm1/fs/nfs/super.c	2006-11-28 05:07:08.000000000 +0100
@@ -44,6 +44,7 @@
 #include <linux/vfs.h>
 #include <linux/inet.h>
 #include <linux/nfs_xdr.h>
+#include <linux/magic.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>

