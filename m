Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268179AbUIGPVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268179AbUIGPVz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 11:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268168AbUIGPTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 11:19:22 -0400
Received: from verein.lst.de ([213.95.11.210]:57242 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268333AbUIGPNm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 11:13:42 -0400
Date: Tue, 7 Sep 2004 17:13:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove set_fs_root/set_fs_pwd
Message-ID: <20040907151334.GC9577@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

not exactly something we want modules to mess around with


--- 1.65/fs/namespace.c	2004-08-27 08:42:56 +02:00
+++ edited/fs/namespace.c	2004-09-07 14:10:12 +02:00
@@ -1208,8 +1206,6 @@
 	}
 }
 
-EXPORT_SYMBOL(set_fs_root);
-
 /*
  * Replace the fs->{pwdmnt,pwd} with {mnt,dentry}. Put the old values.
  * It can block. Requires the big lock held.
@@ -1232,8 +1228,6 @@
 		mntput(old_pwdmnt);
 	}
 }
-
-EXPORT_SYMBOL(set_fs_pwd);
 
 static void chroot_fs_refs(struct nameidata *old_nd, struct nameidata *new_nd)
 {
