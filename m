Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965377AbVKHEgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965377AbVKHEgP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 23:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965345AbVKHEgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 23:36:15 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:13065 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965009AbVKHEgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 23:36:14 -0500
Date: Tue, 8 Nov 2005 05:36:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] __deprecated_for_modules the lookup_hash() prototype
Message-ID: <20051108043612.GN3847@stusta.de>
References: <20051106182447.5f571a46.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051106182447.5f571a46.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2005 at 06:24:47PM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.14-rc5-mm1:
>...
> +sanitize-lookup_hash-prototype.patch
> 
>  Various fixes, cleanups and infrastructure work in filesystems.
>...

This patch __deprecated_for_modules the lookup_hash() prototype.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.14-mm1-full/include/linux/namei.h.old	2005-11-08 05:18:29.000000000 +0100
+++ linux-2.6.14-mm1-full/include/linux/namei.h	2005-11-08 05:18:53.000000000 +0100
@@ -74,7 +74,7 @@
 extern void release_open_intent(struct nameidata *);
 
 extern struct dentry * lookup_one_len(const char *, struct dentry *, int);
-extern struct dentry * lookup_hash(struct nameidata *);
+extern __deprecated_for_modules struct dentry * lookup_hash(struct nameidata *);
 
 extern int follow_down(struct vfsmount **, struct dentry **);
 extern int follow_up(struct vfsmount **, struct dentry **);

