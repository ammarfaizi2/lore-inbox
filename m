Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030374AbVKIBCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030374AbVKIBCS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 20:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030484AbVKIBCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 20:02:17 -0500
Received: from outmx010.isp.belgacom.be ([195.238.3.233]:5509 "EHLO
	outmx010.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1030374AbVKIBCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 20:02:17 -0500
To: ericvh@gmail.com
Subject: [PATCH] fs/9p: Replace kcalloc(1, with kzalloc.
Cc: linux-kernel@vger.kernel.org
Message-Id: <20051109010136.6B9E020A1A@localhost.localdomain>
Date: Wed,  9 Nov 2005 02:01:36 +0100 (CET)
From: takis@issaris.org (Panagiotis Issaris)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mr. Van Hensbergen,

This patch replaces one occurrence of kcalloc(1, with kzalloc.

Signed-off-by: Panagiotis Issaris <takis@issaris.org>

---

 fs/9p/vfs_super.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: c0c8a05b248582cb02cf7cf28f12b5cbe1ffb154
2b4e5bf2ea05f5d5938925e15961b26b0197be56
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 82c5b00..7aa2e66 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -123,7 +123,7 @@ static struct super_block *v9fs_get_sb(s
 
 	dprintk(DEBUG_VFS, " \n");
 
-	v9ses = kcalloc(1, sizeof(struct v9fs_session_info), GFP_KERNEL);
+	v9ses = kzalloc(sizeof(struct v9fs_session_info), GFP_KERNEL);
 	if (!v9ses)
 		return ERR_PTR(-ENOMEM);
 
---
0.99.9.GIT
