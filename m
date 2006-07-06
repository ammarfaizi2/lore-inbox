Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWGFUhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWGFUhL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 16:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWGFUhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 16:37:11 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:17925 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750826AbWGFUhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 16:37:08 -0400
Date: Thu, 6 Jul 2006 22:37:08 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, mark.fasheh@oracle.com,
       kurt.hackel@oracle.com, ocfs2-devel@oss.oracle.com
Subject: [-mm patch] fs/ocfs2/inode.c:ocfs2_refresh_inode(): remove unused variable
Message-ID: <20060706203708.GQ26941@stusta.de>
References: <20060703030355.420c7155.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060703030355.420c7155.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 03:03:55AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-mm5:
>...
> +inode-diet-eliminate-i_blksize-and-use-a-per-superblock-default.patch
>...
>  Misc updates.
>...

This patch removes a no longer used variable.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-mm6-full/fs/ocfs2/inode.c.old	2006-07-06 21:10:23.000000000 +0200
+++ linux-2.6.17-mm6-full/fs/ocfs2/inode.c	2006-07-06 21:13:44.000000000 +0200
@@ -1163,8 +1163,6 @@
 void ocfs2_refresh_inode(struct inode *inode,
 			 struct ocfs2_dinode *fe)
 {
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
-
 	spin_lock(&OCFS2_I(inode)->ip_lock);
 
 	OCFS2_I(inode)->ip_clusters = le32_to_cpu(fe->i_clusters);

