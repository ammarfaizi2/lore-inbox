Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965197AbVHSXoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965197AbVHSXoq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 19:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965201AbVHSXop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 19:44:45 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14099 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965197AbVHSXoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 19:44:44 -0400
Date: Sat, 20 Aug 2005 01:44:43 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/adfs/adfs.h: "extern inline" doesn't make sense
Message-ID: <20050819234443.GG3615@stusta.de>
References: <20050819234119.GD3615@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050819234119.GD3615@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ this time with a better subject ]

"extern inline" doesn't make sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc6-mm1-full/fs/adfs/adfs.h.old	2005-08-19 23:21:33.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/fs/adfs/adfs.h	2005-08-19 23:22:07.000000000 +0200
@@ -97,7 +97,7 @@
 extern struct inode_operations adfs_file_inode_operations;
 extern struct file_operations adfs_file_operations;
 
-extern inline __u32 signed_asl(__u32 val, signed int shift)
+static inline __u32 signed_asl(__u32 val, signed int shift)
 {
 	if (shift >= 0)
 		val <<= shift;
@@ -112,7 +112,7 @@
  *
  * The root directory ID should always be looked up in the map [3.4]
  */
-extern inline int
+static inline int
 __adfs_block_map(struct super_block *sb, unsigned int object_id,
 		 unsigned int block)
 {

