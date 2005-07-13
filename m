Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262729AbVGMUWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbVGMUWA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 16:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262749AbVGMUTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 16:19:41 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:5257 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262729AbVGMURu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 16:17:50 -0400
Date: Wed, 13 Jul 2005 22:17:39 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: mszeredi@users.sourceforge.net
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fuse chardevice number
Message-ID: <Pine.LNX.4.61.0507132213450.23970@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miklos and LKML,



could this patch be useful? It's rather cosmetics, but at least fuse did not 
die of MISC_DYNAMIC_MINOR.

(Base is a linux-2.6.13-rc1)

diff -Pdpru S0706/include/linux/fuse.h AS17/include/linux/fuse.h
--- S0706/include/linux/fuse.h	2005-07-07 20:53:42.000000000 +0200
+++ AS17/include/linux/fuse.h	2005-07-09 11:38:55.000000000 +0200
@@ -9,6 +9,8 @@
 /* This file defines the kernel interface of FUSE */
 
 #include <asm/types.h>
+#include <linux/major.h>
+#include <linux/miscdevice.h>
 
 /** Version number of this interface */
 #define FUSE_KERNEL_VERSION 7
@@ -20,10 +22,10 @@
 #define FUSE_ROOT_ID 1
 
 /** The major number of the fuse character device */
-#define FUSE_MAJOR 10
+#define FUSE_MAJOR MISC_MAJOR
 
 /** The minor number of the fuse character device */
-#define FUSE_MINOR 229
+#define FUSE_MINOR MISC_DYNAMIC_MINOR
 
 /* Make sure all structures are padded to 64bit boundary, so 32bit
    userspace works under 64bit kernels */
#### EOF


Jan Engelhardt
-- 
