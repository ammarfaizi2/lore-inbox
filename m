Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264962AbTARXZJ>; Sat, 18 Jan 2003 18:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265174AbTARXZJ>; Sat, 18 Jan 2003 18:25:09 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:48100 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S264962AbTARXZI>; Sat, 18 Jan 2003 18:25:08 -0500
Date: Sun, 19 Jan 2003 00:34:01 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Subject: [2.5 patch] small cleanup for include/linux/efs_fs.h
Message-ID: <20030118233401.GV10647@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below includes the following small cleanups for 
include/linux/efs_fs.h:
- remove unused #define MIN/MAX
- remove check for kernels < 2.2

I've tested the compilation with 2.5.59.

cu
Adrian


--- linux-2.5.59-full/include/linux/efs_fs.h.old	2003-01-19 00:27:21.000000000 +0100
+++ linux-2.5.59-full/include/linux/efs_fs.h	2003-01-19 00:27:56.000000000 +0100
@@ -15,14 +15,6 @@
 
 #include <asm/uaccess.h>
 
-#ifndef LINUX_VERSION_CODE
-#include <linux/version.h>
-#endif
-
-#if LINUX_VERSION_CODE < 0x20200
-#error This code is only for linux-2.2 and later.
-#endif
-
 /* 1 block is 512 bytes */
 #define	EFS_BLOCKSIZE_BITS	9
 #define	EFS_BLOCKSIZE		(1 << EFS_BLOCKSIZE_BITS)
@@ -32,13 +24,6 @@
 #include <linux/efs_fs_sb.h>
 #include <linux/efs_dir.h>
 
-#ifndef MIN
-#define MIN(a, b) (((a) < (b)) ? (a) : (b))
-#endif
-#ifndef MAX
-#define MAX(a, b) (((a) > (b)) ? (a) : (b))
-#endif
-
 static inline struct efs_inode_info *INODE_INFO(struct inode *inode)
 {
 	return container_of(inode, struct efs_inode_info, vfs_inode);
