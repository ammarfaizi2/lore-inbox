Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262141AbVCOAIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbVCOAIq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 19:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262140AbVCOAHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 19:07:38 -0500
Received: from fire.osdl.org ([65.172.181.4]:49117 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262141AbVCOAHM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 19:07:12 -0500
Date: Mon, 14 Mar 2005 16:04:23 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] reiserfs: use NULL instead of 0
Message-Id: <20050314160423.56167ca0.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(resend)

Use NULL instead of 0 for pointer (sparse warning):
fs/reiserfs/namei.c:611:50: warning: Using plain integer as NULL pointer

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 fs/reiserfs/namei.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./fs/reiserfs/namei.c~reiserfs_null ./fs/reiserfs/namei.c
--- ./fs/reiserfs/namei.c~reiserfs_null	2005-02-15 13:48:46.327310224 -0800
+++ ./fs/reiserfs/namei.c	2005-02-15 20:53:22.903281976 -0800
@@ -608,7 +608,7 @@ static int reiserfs_create (struct inode
         goto out_failed;
     }
 
-    retval = reiserfs_new_inode (&th, dir, mode, 0, 0/*i_size*/, dentry, inode);
+    retval = reiserfs_new_inode (&th, dir, mode, NULL, 0/*i_size*/, dentry, inode);
     if (retval)
         goto out_failed;
 	


---
