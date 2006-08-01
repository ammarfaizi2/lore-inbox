Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbWHAXx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWHAXx7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 19:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWHAXxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 19:53:40 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:35528 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750782AbWHAXw4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 19:52:56 -0400
Subject: [PATCH 17/28] mount_is_safe(): add comment
To: linux-kernel@vger.kernel.org
Cc: viro@ftp.linux.org.uk, herbert@13thfloor.at, hch@infradead.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 01 Aug 2006 16:52:53 -0700
References: <20060801235240.82ADCA42@localhost.localdomain>
In-Reply-To: <20060801235240.82ADCA42@localhost.localdomain>
Message-Id: <20060801235253.6B3B7BD9@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This area of code is currently #ifdef'd out, so add a comment
for the time when it is actually used.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/namespace.c |    4 ++++
 1 files changed, 4 insertions(+)

diff -puN fs/namespace.c~C-elevate-writers-opens-part5 fs/namespace.c
--- lxc/fs/namespace.c~C-elevate-writers-opens-part5	2006-08-01 16:35:19.000000000 -0700
+++ lxc-dave/fs/namespace.c	2006-08-01 16:35:26.000000000 -0700
@@ -692,6 +692,10 @@ static int mount_is_safe(struct nameidat
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
