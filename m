Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWEAUVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWEAUVi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 16:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWEAUVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 16:21:38 -0400
Received: from mail.fuug.fi ([83.145.198.117]:56272 "EHLO mail.fuug.fi")
	by vger.kernel.org with ESMTP id S932222AbWEAUVh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 16:21:37 -0400
Date: Mon, 1 May 2006 23:20:52 +0300 (EEST)
From: "Petri T. Koistinen" <petri.koistinen@iki.fi>
To: Andrew Morton <akpm@osdl.org>
cc: trivial@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/isofs/namei.c: fix warnings of uninitialized variables
Message-ID: <Pine.LNX.4.64.0605012255290.15813@joo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petri T. Koistinen <petri.koistinen@iki.fi>

Remove warnings by initializing uninitialized variables.

Signed-off-by: Petri T. Koistinen <petri.koistinen@iki.fi>
---
 fs/isofs/namei.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

---
diff --git a/fs/isofs/namei.c b/fs/isofs/namei.c
index e7ba0c3..e0d6531 100644
--- a/fs/isofs/namei.c
+++ b/fs/isofs/namei.c
@@ -159,7 +159,7 @@ isofs_find_entry(struct inode *dir, stru
 struct dentry *isofs_lookup(struct inode * dir, struct dentry * dentry, struct nameidata *nd)
 {
 	int found;
-	unsigned long block, offset;
+	unsigned long block = 0, offset = 0;
 	struct inode *inode;
 	struct page *page;

