Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264818AbUEPUrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264818AbUEPUrI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 16:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264821AbUEPUrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 16:47:08 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:36288 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S264818AbUEPUrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 16:47:03 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix userspace include of linux/fs.h
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Date: Sun, 16 May 2004 22:47:00 +0200
Message-ID: <yw1xekpkdrqz.fsf@ford.guide>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes compilation of programs that #include linux/fs.h.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/05/16 22:34:26+02:00 mru@ford.guide 
#   fix userspace use of linux/fs.h
# 
# include/linux/fs.h
#   2004/05/16 22:28:34+02:00 mru@ford.guide +3 -3
#   move some #includes inside #ifdef __KERNEL__ to allow userspace inclusion
# 
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Sun May 16 22:43:07 2004
+++ b/include/linux/fs.h	Sun May 16 22:43:07 2004
@@ -13,14 +13,11 @@
 #include <linux/types.h>
 #include <linux/kdev_t.h>
 #include <linux/ioctl.h>
-#include <linux/list.h>
 #include <linux/dcache.h>
 #include <linux/stat.h>
 #include <linux/cache.h>
-#include <linux/radix-tree.h>
 #include <linux/kobject.h>
 #include <asm/atomic.h>
-#include <linux/audit.h>
 
 struct iovec;
 struct nameidata;
@@ -213,6 +210,9 @@
 
 #ifdef __KERNEL__
 
+#include <linux/list.h>
+#include <linux/radix-tree.h>
+#include <linux/audit.h>
 #include <asm/semaphore.h>
 #include <asm/byteorder.h>
 
