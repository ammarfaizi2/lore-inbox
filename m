Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287629AbSAHD5F>; Mon, 7 Jan 2002 22:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287630AbSAHD4z>; Mon, 7 Jan 2002 22:56:55 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:11277 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S287629AbSAHD4s>; Mon, 7 Jan 2002 22:56:48 -0500
Date: Mon, 7 Jan 2002 22:56:49 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@portland.hansa.lan
To: linux-kernel@vger.kernel.org, Daniel Pirkl <daniel.pirkl@emai.cz>
Subject: What's the licence of the ufs module?
Message-ID: <Pine.LNX.4.43.0201072249150.1583-100000@portland.hansa.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The "ufs" module in Linux-2.4.18pre2 has no license tag.  "ufs" is a
filesystem used primarily on *BSD, but the code is part of the Linux tree,
so it should be under GPL (IMHO).  I couldn't find any indications that
the license used by the ufs module differs from the rest of the kernel.

If my reasoning is correct, then the following patch should be applied:

==============================
--- linux.orig/fs/ufs/super.c
+++ linux/fs/ufs/super.c
@@ -981,3 +981,4 @@
 
 module_init(init_ufs_fs)
 module_exit(exit_ufs_fs)
+MODULE_LICENSE("GPL");
==============================

-- 
Regards,
Pavel Roskin

