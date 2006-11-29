Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966640AbWK2KED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966640AbWK2KED (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 05:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758818AbWK2KED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 05:04:03 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1545 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1758817AbWK2KEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 05:04:01 -0500
Date: Wed, 29 Nov 2006 11:04:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: hch@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/sysv/: proper prototypes for 2 functions
Message-ID: <20061129100405.GI11084@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds proper prototypes for sysv_{init,destroy}_icache()
in sysv.h

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/sysv/super.c |    3 ---
 fs/sysv/sysv.h  |    3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.19-rc6-mm2/fs/sysv/sysv.h.old	2006-11-29 09:21:02.000000000 +0100
+++ linux-2.6.19-rc6-mm2/fs/sysv/sysv.h	2006-11-29 09:21:52.000000000 +0100
@@ -143,6 +143,9 @@
 extern int sysv_sync_file(struct file *, struct dentry *, int);
 extern void sysv_set_inode(struct inode *, dev_t);
 extern int sysv_getattr(struct vfsmount *, struct dentry *, struct kstat *);
+int sysv_init_icache(void);
+void sysv_destroy_icache(void);
+
 
 /* dir.c */
 extern struct sysv_dir_entry *sysv_find_entry(struct dentry *, struct page **);
--- linux-2.6.19-rc6-mm2/fs/sysv/super.c.old	2006-11-29 09:21:55.000000000 +0100
+++ linux-2.6.19-rc6-mm2/fs/sysv/super.c	2006-11-29 09:22:04.000000000 +0100
@@ -528,9 +528,6 @@
 	.fs_flags	= FS_REQUIRES_DEV,
 };
 
-extern int sysv_init_icache(void) __init;
-extern void sysv_destroy_icache(void);
-
 static int __init init_sysv_fs(void)
 {
 	int error;

