Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263231AbUEWSS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263231AbUEWSS5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 14:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263295AbUEWSS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 14:18:57 -0400
Received: from mail.broadpark.no ([217.13.4.2]:48525 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S263231AbUEWSSx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 14:18:53 -0400
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: [PATCH] Fix userspace inclusion of linux/fs.h (resend)
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Date: Sun, 23 May 2004 20:22:18 +0200
Message-ID: <yw1x1xlb6m1x.fsf@kth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixes compilation of userspace using linux/fs.h.  The
patch is against Linux 2.6.6.  Please apply of fix some other way.

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
--- a/include/linux/fs.h	2004-05-23 20:11:46 +02:00
+++ b/include/linux/fs.h	2004-05-23 20:11:46 +02:00
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
 

-- 
Måns Rullgård
mru@kth.se
