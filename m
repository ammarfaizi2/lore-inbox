Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266791AbUFYQkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266791AbUFYQkQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 12:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266792AbUFYQkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 12:40:16 -0400
Received: from f24.mail.ru ([194.67.57.160]:21764 "EHLO f24.mail.ru")
	by vger.kernel.org with ESMTP id S266791AbUFYQkE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 12:40:04 -0400
From: Alexey Dobriyan <adobriyan@mail.ru>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove include/arch-*/init.h
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [194.85.81.172]
Date: Fri, 25 Jun 2004 20:38:25 +0400
Reply-To: Alexey Dobriyan <adobriyan@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1Bdtib-000NEl-00.adobriyan-mail-ru@f24.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's no reason to keep files that
a) nobody #include's
b) produce #error 

--- a/include/asm-alpha/init.h	2004-06-16 09:19:42.000000000 +0400
+++ /dev/null	2003-01-30 13:24:37.000000000 +0300
@@ -1 +0,0 @@
-#error "<asm/init.h> should never be used - use <linux/init.h> instead"
--- a/include/asm-h8300/init.h	2004-06-16 09:19:01.000000000 +0400
+++ /dev/null	2003-01-30 13:24:37.000000000 +0300
@@ -1,11 +0,0 @@
-#ifndef _H8300_INIT_H
-#define _H8300_INIT_H
-
-#define __init __attribute__ ((__section__ (".text.init")))
-#define __initdata __attribute__ ((__section__ (".data.init")))
-/* For assembly routines */
-#define __INIT		.section	".text.init",#alloc,#execinstr
-#define __FINIT		.previous
-#define __INITDATA	.section	".data.init",#alloc,#write
-
-#endif
--- a/include/asm-i386/init.h	2004-06-16 09:19:42.000000000 +0400
+++ /dev/null	2003-01-30 13:24:37.000000000 +0300
@@ -1 +0,0 @@
-#error "<asm/init.h> should never be used - use <linux/init.h> instead"
--- a/include/asm-m68k/init.h	2004-06-16 09:19:43.000000000 +0400
+++ /dev/null	2003-01-30 13:24:37.000000000 +0300
@@ -1,11 +0,0 @@
-#ifndef _M68K_INIT_H
-#define _M68K_INIT_H
-
-#define __init __attribute__ ((__section__ (".text.init")))
-#define __initdata __attribute__ ((__section__ (".data.init")))
-/* For assembly routines */
-#define __INIT		.section	".text.init",#alloc,#execinstr
-#define __FINIT		.previous
-#define __INITDATA	.section	".data.init",#alloc,#write
-
-#endif
--- a/include/asm-m68knommu/init.h	2004-06-16 09:19:22.000000000 +0400
+++ /dev/null	2003-01-30 13:24:37.000000000 +0300
@@ -1 +0,0 @@
-#include <asm-m68k/init.h>
--- a/include/asm-mips/init.h	2004-06-16 09:18:57.000000000 +0400
+++ /dev/null	2003-01-30 13:24:37.000000000 +0300
@@ -1 +0,0 @@
-#error "<asm/init.h> should never be used - use <linux/init.h> instead"
--- a/include/asm-ppc64/init.h	2004-06-16 09:18:59.000000000 +0400
+++ /dev/null	2003-01-30 13:24:37.000000000 +0300
@@ -1 +0,0 @@
-#error "<asm/init.h> should never be used - use <linux/init.h> instead"
--- a/include/asm-s390/init.h	2004-06-16 09:20:20.000000000 +0400
+++ /dev/null	2003-01-30 13:24:37.000000000 +0300
@@ -1,7 +0,0 @@
-/*
- *  include/asm-s390/init.h
- *
- *  S390 version
- */
-
-#error "<asm/init.h> should never be used - use <linux/init.h> instead"
--- a/include/asm-sh/init.h	2004-06-16 09:19:42.000000000 +0400
+++ /dev/null	2003-01-30 13:24:37.000000000 +0300
@@ -1 +0,0 @@
-#error "<asm/init.h> should never be used - use <linux/init.h> instead"
--- a/include/asm-sparc/init.h	2004-06-16 09:19:52.000000000 +0400
+++ /dev/null	2003-01-30 13:24:37.000000000 +0300
@@ -1 +0,0 @@
-#error "<asm/init.h> should never be used - use <linux/init.h> instead"
--- a/include/asm-sparc64/init.h	2004-06-16 09:19:23.000000000 +0400
+++ /dev/null	2003-01-30 13:24:37.000000000 +0300
@@ -1 +0,0 @@
-#error "<asm/init.h> should never be used - use <linux/init.h> instead"
--- a/include/asm-um/init.h	2004-06-16 09:19:52.000000000 +0400
+++ /dev/null	2003-01-30 13:24:37.000000000 +0300
@@ -1,11 +0,0 @@
-#ifndef _UM_INIT_H
-#define _UM_INIT_H
-
-#ifdef notdef
-#define __init
-#define __initdata
-#define __initfunc(__arginit) __arginit
-#define __cacheline_aligned 
-#endif
-
-#endif
--- a/include/asm-x86_64/init.h	2004-06-16 09:19:13.000000000 +0400
+++ /dev/null	2003-01-30 13:24:37.000000000 +0300
@@ -1 +0,0 @@
-#error "<asm/init.h> should never be used - use <linux/init.h> instead"

