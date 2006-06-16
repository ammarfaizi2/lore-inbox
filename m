Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbWFPXNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbWFPXNn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 19:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWFPXMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 19:12:39 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:29369 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751554AbWFPXMZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 19:12:25 -0400
Subject: [RFC][PATCH 09/20] mount_is_safe(): add comment
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, herbert@13thfloor.at, viro@ftp.linux.org.uk,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 16 Jun 2006 16:12:20 -0700
References: <20060616231213.D4C5D6AF@localhost.localdomain>
In-Reply-To: <20060616231213.D4C5D6AF@localhost.localdomain>
Message-Id: <20060616231220.DA420885@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This area of code is currently #ifdef'd out, so add a comment
for the time when it is actually used.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/namespace.c |    4 ++++
 1 files changed, 4 insertions(+)

diff -puN fs/namespace.c~C-elevate-writers-opens-part5 fs/namespace.c
--- lxc/fs/namespace.c~C-elevate-writers-opens-part5	2006-06-16 15:58:04.000000000 -0700
+++ lxc-dave/fs/namespace.c	2006-06-16 15:58:04.000000000 -0700
@@ -679,6 +679,10 @@ static int mount_is_safe(struct nameidat
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
