Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbWEPP2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWEPP2A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWEPP2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:28:00 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:46597 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932096AbWEPP17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:27:59 -0400
Date: Tue, 16 May 2006 17:27:57 +0200
From: Adrian Bunk <bunk@stusta.de>
To: reiserfs-dev@namesys.com
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] make fs/reiser4/super_ops.c:reiser4_get_sb() static
Message-ID: <20060516152757.GB5677@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global reiser4_get_sb() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-rc4-mm1-full/fs/reiser4/super_ops.c.old	2006-05-16 13:19:25.000000000 +0200
+++ linux-2.6.17-rc4-mm1-full/fs/reiser4/super_ops.c	2006-05-16 13:19:45.000000000 +0200
@@ -549,8 +549,9 @@
  *
  * Reiser4 mount entry.
  */
-int reiser4_get_sb(struct file_system_type *fs_type, int flags,
-			const char *dev_name, void *data, struct vfsmount *mnt)
+static int reiser4_get_sb(struct file_system_type *fs_type, int flags,
+			  const char *dev_name, void *data,
+			  struct vfsmount *mnt)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, fill_super, mnt);
 }

