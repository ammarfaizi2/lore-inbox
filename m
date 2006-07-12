Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWGLSW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWGLSW4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 14:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWGLSVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 14:21:35 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:49305 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932367AbWGLSRZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 14:17:25 -0400
Subject: [RFC][PATCH 15/27] mount_is_safe(): add comment
To: viro@ftp.linux.org.uk
Cc: serue@us.ibm.com, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 12 Jul 2006 11:17:20 -0700
References: <20060712181709.5C1A4353@localhost.localdomain>
In-Reply-To: <20060712181709.5C1A4353@localhost.localdomain>
Message-Id: <20060712181720.CD9AD5A9@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This area of code is currently #ifdef'd out, so add a comment
for the time when it is actually used.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/namespace.c |    4 ++++
 1 files changed, 4 insertions(+)

diff -puN fs/namespace.c~C-elevate-writers-opens-part5 fs/namespace.c
--- lxc/fs/namespace.c~C-elevate-writers-opens-part5	2006-07-12 11:09:22.000000000 -0700
+++ lxc-dave/fs/namespace.c	2006-07-12 11:09:32.000000000 -0700
@@ -699,6 +699,10 @@ static int mount_is_safe(struct nameidat
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
