Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263422AbRFKFfj>; Mon, 11 Jun 2001 01:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263426AbRFKFfZ>; Mon, 11 Jun 2001 01:35:25 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:8111 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263421AbRFKFem>;
	Mon, 11 Jun 2001 01:34:42 -0400
Date: Mon, 11 Jun 2001 01:34:41 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fs/super.c stuff (3/10)
In-Reply-To: <Pine.GSO.4.21.0106110133160.24249-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0106110134230.24249-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN S6-pre2-fsync_no_super/include/linux/fs.h S6-pre2-put_super/include/linux/fs.h
--- S6-pre2-fsync_no_super/include/linux/fs.h	Sun Jun 10 18:36:27 2001
+++ S6-pre2-put_super/include/linux/fs.h	Sun Jun 10 18:39:04 2001
@@ -1320,7 +1320,6 @@
 
 extern struct file_system_type *get_fs_type(const char *name);
 extern struct super_block *get_super(kdev_t);
-extern void put_super(kdev_t);
 static inline int is_mounted(kdev_t dev)
 {
 	struct super_block *sb = get_super(dev);


