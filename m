Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264767AbSLIIzl>; Mon, 9 Dec 2002 03:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264715AbSLIIym>; Mon, 9 Dec 2002 03:54:42 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:47772 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S264705AbSLIIyk>; Mon, 9 Dec 2002 03:54:40 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] [v850]  Update v850 includes to accomodate the slimming-down of sched.h
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20021209090212.CBF933706@mcspd15.ucom.lsi.nec.co.jp>
Date: Mon,  9 Dec 2002 18:02:12 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes -xm68knommu -xasm-m68knommu -xmm ../orig/linux-2.5.50/arch/v850/kernel/semaphore.c arch/v850/kernel/semaphore.c
--- ../orig/linux-2.5.50/arch/v850/kernel/semaphore.c	2002-11-05 11:25:22.000000000 +0900
+++ arch/v850/kernel/semaphore.c	2002-11-28 14:45:39.000000000 +0900
@@ -13,6 +13,7 @@
  * which was derived from the i386 version, linux/arch/i386/kernel/semaphore.c
  */
 
+#include <linux/errno.h>
 #include <linux/sched.h>
 
 #include <asm/semaphore.h>
diff -ruN -X../cludes -xm68knommu -xasm-m68knommu -xmm ../orig/linux-2.5.50/include/asm-v850/uaccess.h include/asm-v850/uaccess.h
--- ../orig/linux-2.5.50/include/asm-v850/uaccess.h	2002-11-05 11:25:32.000000000 +0900
+++ include/asm-v850/uaccess.h	2002-11-28 14:51:02.000000000 +0900
@@ -4,7 +4,9 @@
 /*
  * User space memory access functions
  */
-#include <linux/sched.h>
+
+#include <linux/errno.h>
+#include <linux/string.h>
 
 #include <asm/segment.h>
 #include <asm/machdep.h>
