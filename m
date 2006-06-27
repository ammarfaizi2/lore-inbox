Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422672AbWF0WWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422672AbWF0WWA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422671AbWF0WTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:19:54 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:17120 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030450AbWF0WOx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:14:53 -0400
Subject: [PATCH 09/20] mount_is_safe(): add comment
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, herbert@13thfloor.at, viro@ftp.linux.org.uk,
       serue@us.ibm.com, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 27 Jun 2006 15:14:48 -0700
References: <20060627221436.77CCB048@localhost.localdomain>
In-Reply-To: <20060627221436.77CCB048@localhost.localdomain>
Message-Id: <20060627221448.D8A7AB7C@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This area of code is currently #ifdef'd out, so add a comment
for the time when it is actually used.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/namespace.c |    4 ++++
 1 files changed, 4 insertions(+)

diff -puN fs/namespace.c~C-elevate-writers-opens-part5 fs/namespace.c
--- lxc/fs/namespace.c~C-elevate-writers-opens-part5	2006-06-27 10:40:29.000000000 -0700
+++ lxc-dave/fs/namespace.c	2006-06-27 10:40:29.000000000 -0700
@@ -688,6 +688,10 @@ static int mount_is_safe(struct nameidat
 		if (current->uid != nd->dentry->d_inode->i_uid)
 			return -EPERM;
 	}
+	/*
+	 * We will eventually check for the mnt->writer_count here,
+	 * but since the code is not used now, skip it - Dave Hansen
+	 */
 	if (vfs_permission(nd, MAY_WRITE))
 		return -EPERM;
 	return 0;
_
