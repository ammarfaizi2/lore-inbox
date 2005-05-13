Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262218AbVEMBEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbVEMBEq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 21:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262199AbVEMBDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 21:03:37 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45067 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262213AbVEMAsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 20:48:01 -0400
Date: Fri, 13 May 2005 02:48:00 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Al Viro <viro@www.linux.org.uk>, reiserfs-dev@namesys.com,
       reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/reiserfs/stree.c: make MAX_KEY static
Message-ID: <20050513004800.GZ3603@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since MAX_KEY no longer has any user in other files, it can be made 
static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 1 May 2005

--- linux-2.6.12-rc3-mm2-full/fs/reiserfs/stree.c.old	2005-05-01 15:33:11.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/fs/reiserfs/stree.c	2005-05-01 15:33:19.000000000 +0200
@@ -223,7 +223,7 @@
 const struct reiserfs_key  MIN_KEY = {0, 0, {{0, 0},}};
 
 /* Maximal possible key. It is never in the tree. */
-const struct reiserfs_key  MAX_KEY = {
+static const struct reiserfs_key  MAX_KEY = {
 	__constant_cpu_to_le32(0xffffffff),
 	__constant_cpu_to_le32(0xffffffff),
 	{{__constant_cpu_to_le32(0xffffffff),

