Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbVI3CPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbVI3CPN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 22:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbVI3CPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 22:15:13 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:32727 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932403AbVI3CPM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 22:15:12 -0400
Date: Fri, 30 Sep 2005 03:15:08 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Eric Van Hensbergen <ericvh@gmail.com>
Subject: [PATCH] missing ERR_PTR in 9fs
Message-ID: <20050930021508.GX7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc2-git6-base/fs/9p/vfs_super.c current/fs/9p/vfs_super.c
--- RC14-rc2-git6-base/fs/9p/vfs_super.c	2005-09-28 21:33:37.000000000 -0400
+++ current/fs/9p/vfs_super.c	2005-09-29 15:57:10.000000000 -0400
@@ -129,7 +129,7 @@
 
 	if ((newfid = v9fs_session_init(v9ses, dev_name, data)) < 0) {
 		dprintk(DEBUG_ERROR, "problem initiating session\n");
-		return newfid;
+		return ERR_PTR(newfid);
 	}
 
 	sb = sget(fs_type, NULL, v9fs_set_super, v9ses);
