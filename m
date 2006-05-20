Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbWETVni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbWETVni (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 17:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWETVni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 17:43:38 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:10729 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932395AbWETVnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 17:43:37 -0400
Date: Sat, 20 May 2006 23:43:28 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: mszeredi@users.sourceforge.net
Subject: [PATCH] Let FUSE use MISC_MAJOR
Message-ID: <Pine.LNX.4.61.0605202338450.27403@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Have fuse.h use MISC_MAJOR rather than a hardcoded '10'.

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>


diff --fast -Ndpru linux-2.6.17-rc4~/include/linux/fuse.h linux-2.6.17-rc4+/include/linux/fuse.h
--- linux-2.6.17-rc4~/include/linux/fuse.h	2006-05-12 01:31:53.000000000 +0200
+++ linux-2.6.17-rc4+/include/linux/fuse.h	2006-05-19 23:40:32.461051000 +0200
@@ -9,6 +9,7 @@
 /* This file defines the kernel interface of FUSE */
 
 #include <asm/types.h>
+#include <linux/major.h>
 
 /** Version number of this interface */
 #define FUSE_KERNEL_VERSION 7
@@ -20,7 +21,7 @@
 #define FUSE_ROOT_ID 1
 
 /** The major number of the fuse character device */
-#define FUSE_MAJOR 10
+#define FUSE_MAJOR MISC_MAJOR
 
 /** The minor number of the fuse character device */
 #define FUSE_MINOR 229
<<eof>>

Jan Engelhardt
-- 
