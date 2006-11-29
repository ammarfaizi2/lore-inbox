Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758814AbWK2KD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758814AbWK2KD5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 05:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758817AbWK2KD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 05:03:57 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:521 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1758814AbWK2KD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 05:03:56 -0500
Date: Wed, 29 Nov 2006 11:04:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, swhiteho@redhat.com
Cc: linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Subject: [-mm patch] #if 0 fs/gfs2/acl.c:gfs2_check_acl()
Message-ID: <20061129100401.GH11084@stusta.de>
References: <20061128020246.47e481eb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061128020246.47e481eb.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2006 at 02:02:46AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.19-rc6-mm1:
>...
>  git-gfs2-nmw.patch
>...
>  git trees
>...


This patch #if 0's the no longer used gfs2_check_acl().

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/gfs2/acl.c |    2 ++
 fs/gfs2/acl.h |    1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.19-rc6-mm2/fs/gfs2/acl.h.old	2006-11-29 08:49:13.000000000 +0100
+++ linux-2.6.19-rc6-mm2/fs/gfs2/acl.h	2006-11-29 08:49:22.000000000 +0100
@@ -32,7 +32,6 @@
 			  int *remove, mode_t *mode);
 int gfs2_acl_validate_remove(struct gfs2_inode *ip, int access);
 int gfs2_check_acl_locked(struct inode *inode, int mask);
-int gfs2_check_acl(struct inode *inode, int mask);
 int gfs2_acl_create(struct gfs2_inode *dip, struct gfs2_inode *ip);
 int gfs2_acl_chmod(struct gfs2_inode *ip, struct iattr *attr);
 
--- linux-2.6.19-rc6-mm2/fs/gfs2/acl.c.old	2006-11-29 08:49:31.000000000 +0100
+++ linux-2.6.19-rc6-mm2/fs/gfs2/acl.c	2006-11-29 08:49:45.000000000 +0100
@@ -170,6 +170,7 @@
 	return -EAGAIN;
 }
 
+#if 0
 int gfs2_check_acl(struct inode *inode, int mask)
 {
 	struct gfs2_inode *ip = GFS2_I(inode);
@@ -184,6 +185,7 @@
 
 	return error;
 }
+#endif  /*  0  */
 
 static int munge_mode(struct gfs2_inode *ip, mode_t mode)
 {

