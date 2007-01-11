Return-Path: <linux-kernel-owner+w=401wt.eu-S1030458AbXAKNta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030458AbXAKNta (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 08:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030465AbXAKNt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 08:49:29 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4609 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030458AbXAKNt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 08:49:27 -0500
Date: Thu, 11 Jan 2007 14:49:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: [2.6 patch] include/linux/nfsd/const.h: remove NFS_SUPER_MAGIC
Message-ID: <20070111134932.GG20027@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NFS_SUPER_MAGIC is already defined in include/linux/magic.h

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 28 Nov 2006

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

