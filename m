Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbUJZALT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbUJZALT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 20:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbUJYPG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:06:56 -0400
Received: from ip22-176.tor.istop.com ([66.11.176.22]:3241 "EHLO
	crlf.tor.istop.com") by vger.kernel.org with ESMTP id S261818AbUJYOuV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:50:21 -0400
Cc: raven@themaw.net
Subject: [PATCH 23/28] VFS: Export get_sb_pseudo
In-Reply-To: <10987157802675@sun.com>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Mon, 25 Oct 2004 10:50:11 -0400
Message-Id: <10987158112343@sun.com>
References: <10987157802675@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Mike Waychison <michael.waychison@sun.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Export get_sb_pseudo for module use.  Autofsng uses it to create files that
are used for feeding browsing information.

Signed-off-by: Mike Waychison <michael.waychison@sun.com>
---

 libfs.c |    1 +
 1 files changed, 1 insertion(+)

Index: linux-2.6.9-quilt/fs/libfs.c
===================================================================
--- linux-2.6.9-quilt.orig/fs/libfs.c	2004-08-14 01:36:11.000000000 -0400
+++ linux-2.6.9-quilt/fs/libfs.c	2004-10-22 17:17:46.009469640 -0400
@@ -222,6 +222,7 @@ Enomem:
 	deactivate_super(s);
 	return ERR_PTR(-ENOMEM);
 }
+EXPORT_SYMBOL(get_sb_pseudo);
 
 int simple_link(struct dentry *old_dentry, struct inode *dir, struct dentry *dentry)
 {

