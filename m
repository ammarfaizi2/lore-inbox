Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbUKIKpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbUKIKpk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 05:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261483AbUKIKpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 05:45:11 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:55447 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261493AbUKIKl0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 05:41:26 -0500
Subject: [PATCH 9/11] oprofile: update s390 for api changes
From: Greg Banks <gnb@melbourne.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: OProfile List <oprofile-list@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-C0DLs0mVTmARf0nuP1db"
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1099996871.1985.797.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 09 Nov 2004 21:41:11 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-C0DLs0mVTmARf0nuP1db
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


--=-C0DLs0mVTmARf0nuP1db
Content-Disposition: attachment; filename=oprofile-callgraph-s390
Content-Type: text/plain; name=oprofile-callgraph-s390; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

oprofile s390 arch updates, including some internal
API changes.

Signed-off-by: John Levon <levon@movementarian.org>
Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
---

 arch/s390/oprofile/init.c |    7 +------
 1 files changed, 1 insertion(+), 6 deletions(-)

Index: linux/arch/s390/oprofile/init.c
===================================================================
--- linux.orig/arch/s390/oprofile/init.c	2004-10-19 07:54:39.%N +1000
+++ linux/arch/s390/oprofile/init.c	2004-11-06 01:26:59.%N +1100
@@ -12,13 +12,8 @@
 #include <linux/init.h>
 #include <linux/errno.h>
 
-//extern int irq_init(struct oprofile_operations** ops);
-extern void timer_init(struct oprofile_operations** ops);
-
-int __init oprofile_arch_init(struct oprofile_operations** ops)
+void __init oprofile_arch_init(struct oprofile_operations* ops)
 {
-	timer_init(ops);
-	return 0;
 }
 
 void oprofile_arch_exit(void)

--=-C0DLs0mVTmARf0nuP1db--

