Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136197AbRD0UFL>; Fri, 27 Apr 2001 16:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136199AbRD0UFC>; Fri, 27 Apr 2001 16:05:02 -0400
Received: from tomts8.bellnexxia.net ([209.226.175.52]:9629 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S136197AbRD0UEr>; Fri, 27 Apr 2001 16:04:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: 2.4.4-pre8 undefined symbols
Date: Fri, 27 Apr 2001 16:04:39 -0400
X-Mailer: KMail [version 1.2]
Cc: Jeff Chua <jeffchua@silk.corp.fedex.com>,
        Linus Torvalds <torvalds@transmeta.com>
MIME-Version: 1.0
Message-Id: <01042716043900.00794@oscar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 

The following patch adpated from the fix in the ac series, fixes the undefined
symbols in the various drm modules in pre7/8.

---------
--- linux/lib/rwsem.c.orig	Fri Apr 27 13:24:48 2001
+++ linux/lib/rwsem.c	Fri Apr 27 13:25:08 2001
@@ -6,6 +6,7 @@
 #include <linux/rwsem.h>
 #include <linux/sched.h>
 #include <linux/module.h>
+#include <linux/compiler.h>
 
 struct rwsem_waiter {
 	struct list_head	list;
@@ -202,9 +203,9 @@
 	return sem;
 }
 
-EXPORT_SYMBOL(rwsem_down_read_failed);
-EXPORT_SYMBOL(rwsem_down_write_failed);
-EXPORT_SYMBOL(rwsem_wake);
+EXPORT_SYMBOL_NOVERS(rwsem_down_read_failed);
+EXPORT_SYMBOL_NOVERS(rwsem_down_write_failed);
+EXPORT_SYMBOL_NOVERS(rwsem_wake);
 #if RWSEM_DEBUG
 EXPORT_SYMBOL(rwsemtrace);
 #endif
-------------

Ed Tomlinson
