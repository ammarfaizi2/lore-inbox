Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbVEAQJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVEAQJp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 12:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbVEAQFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 12:05:55 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:58632 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261684AbVEAPr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 11:47:28 -0400
Date: Sun, 1 May 2005 17:47:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Al Viro <viro@www.linux.org.uk>
Cc: reiserfs-dev@namesys.com, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: [-mm patch] fs/reiserfs/stree.c: make MAX_KEY static
Message-ID: <20050501154723.GV3592@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since MAX_KEY no longer has any user in other files, it can be made 
static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

