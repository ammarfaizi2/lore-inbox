Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267446AbSKQDRe>; Sat, 16 Nov 2002 22:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267447AbSKQDRe>; Sat, 16 Nov 2002 22:17:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44296 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267446AbSKQDRb>;
	Sat, 16 Nov 2002 22:17:31 -0500
Date: Sun, 17 Nov 2002 03:24:28 +0000
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org,
       Janitors <kernel-janitor-discuss@lists.sourceforge.net>
Subject: [PATCH] remove sched.h from parport.h
Message-ID: <20021117032428.Y20070@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


parport only needs jiffies.h, not sched.h

diff -urpNX dontdiff linux-2.5.47/include/linux/parport.h linux-2.5.47-pci/include/linux/parport.h
--- linux-2.5.47/include/linux/parport.h	2002-10-01 03:07:39.000000000 -0400
+++ linux-2.5.47-pci/include/linux/parport.h	2002-11-16 21:50:26.000000000 -0500
@@ -8,7 +8,6 @@
 
 #ifndef _PARPORT_H_
 #define _PARPORT_H_
-#include <linux/sched.h>
 
 /* Start off with user-visible constants */
 
@@ -97,13 +96,14 @@ typedef enum {
 /* The rest is for the kernel only */
 #ifdef __KERNEL__
 
-#include <linux/wait.h>
+#include <linux/config.h>
+#include <linux/jiffies.h>
+#include <linux/proc_fs.h>
 #include <linux/spinlock.h>
+#include <linux/wait.h>
 #include <asm/system.h>
 #include <asm/ptrace.h>
 #include <asm/semaphore.h>
-#include <linux/proc_fs.h>
-#include <linux/config.h>
 
 #define PARPORT_NEED_GENERIC_OPS
 

-- 
Revolutions do not require corporate support.
