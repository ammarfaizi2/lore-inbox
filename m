Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbUDKDwW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 23:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbUDKDwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 23:52:22 -0400
Received: from ozlabs.org ([203.10.76.45]:45513 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262236AbUDKDwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 23:52:21 -0400
Date: Sun, 11 Apr 2004 13:48:26 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: binfmt_misc: attribute used or unused
Message-ID: <20040411034826.GA22471@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Any idea why we have an attribute((unused)) here? I was going to
convert it to __attribute_used__ so it handles gcc's schizophrenic
behaviour but then realised it all looks bogus.

Anton

===== fs/binfmt_misc.c 1.24 vs edited =====
--- 1.24/fs/binfmt_misc.c	Wed Feb 25 21:34:47 2004
+++ edited/fs/binfmt_misc.c	Sun Apr 11 13:42:02 2004
@@ -52,7 +52,7 @@
 	struct dentry *dentry;
 } Node;
 
-static rwlock_t entries_lock __attribute__((unused)) = RW_LOCK_UNLOCKED;
+static rwlock_t entries_lock = RW_LOCK_UNLOCKED;
 static struct vfsmount *bm_mnt;
 static int entry_count;
 
