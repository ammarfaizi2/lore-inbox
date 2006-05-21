Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964908AbWEUTCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbWEUTCw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 15:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWEUTCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 15:02:52 -0400
Received: from imf18aec.mail.bellsouth.net ([205.152.59.66]:43395 "EHLO
	imf18aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S964908AbWEUTCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 15:02:51 -0400
Date: Sun, 21 May 2006 15:02:34 -0400 (EDT)
From: Ameer Armaly <ameer@bellsouth.net>
X-X-Sender: ameer@sg1
To: linux-kernel@vger.kernel.org
Subject: [patch] initialize variables in fs/isofs/namei.c
Message-ID: <Pine.LNX.4.61.0605211501150.2255@sg1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes un-initialized variable warnings for block and offset in namei.c, which are later initialized through a call to isofs_find_entry().

diff --git a/fs/isofs/namei.c b/fs/isofs/namei.c
index e7ba0c3..e0d6531 100644
--- a/fs/isofs/namei.c
+++ b/fs/isofs/namei.c
@@ -159,7 +159,7 @@ #endif
  struct dentry *isofs_lookup(struct inode * dir, struct dentry * dentry, struct nameidata *nd)
  {
  	int found;
-	unsigned long block, offset;
+	unsigned long block = 0, offset = 0;
  	struct inode *inode;
  	struct page *page;

