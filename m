Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267841AbUHERyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267841AbUHERyh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 13:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267840AbUHERyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 13:54:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:153 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267841AbUHERww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 13:52:52 -0400
Date: Thu, 5 Aug 2004 13:52:36 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp83-102.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: rddunlap@osdl.org, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] increase mlock limit to 32k
In-Reply-To: <20040805102933.0c95d12a.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0408051351290.8229-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2004, Andrew Morton wrote:

> An incremental patch might be saner..

Here you are.  The following patch replaces the numbers with
a define called MLOCK_LIMIT.

Signed-off-by: Rik van Riel <riel@redhat.com>

--- linux-2.6.8-rc3/include/asm-x86_64/resource.h.cleanup	2004-08-05 13:42:06.916010295 -0400
+++ linux-2.6.8-rc3/include/asm-x86_64/resource.h	2004-08-05 13:47:30.195214447 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{         32768,         32768 },		\
+	{   MLOCK_LIMIT,   MLOCK_LIMIT },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.8-rc3/include/asm-ppc64/resource.h.cleanup	2004-08-05 13:42:06.751059190 -0400
+++ linux-2.6.8-rc3/include/asm-ppc64/resource.h	2004-08-05 13:45:47.718581254 -0400
@@ -45,7 +45,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{         32768,         32768 },		\
+	{   MLOCK_LIMIT,   MLOCK_LIMIT },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.8-rc3/include/asm-mips/resource.h.cleanup	2004-08-05 13:42:06.717069265 -0400
+++ linux-2.6.8-rc3/include/asm-mips/resource.h	2004-08-05 13:45:23.380792896 -0400
@@ -53,7 +53,7 @@
 	{ INR_OPEN,      INR_OPEN      },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ 0,             0             },		\
+	{ MLOCK_LIMIT,     MLOCK_LIMIT },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.8-rc3/include/asm-m68k/resource.h.cleanup	2004-08-05 13:42:06.705072821 -0400
+++ linux-2.6.8-rc3/include/asm-m68k/resource.h	2004-08-05 13:44:42.160006853 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{         32768,         32768 },		\
+	{   MLOCK_LIMIT,   MLOCK_LIMIT },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.8-rc3/include/asm-parisc/resource.h.cleanup	2004-08-05 13:42:06.727066302 -0400
+++ linux-2.6.8-rc3/include/asm-parisc/resource.h	2004-08-05 13:45:38.153415570 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{         32768,         32768 },		\
+	{   MLOCK_LIMIT,   MLOCK_LIMIT },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.8-rc3/include/asm-ppc/resource.h.cleanup	2004-08-05 13:42:06.768054152 -0400
+++ linux-2.6.8-rc3/include/asm-ppc/resource.h	2004-08-05 13:45:58.287449497 -0400
@@ -36,7 +36,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{         32768,         32768 },		\
+	{   MLOCK_LIMIT,   MLOCK_LIMIT },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.8-rc3/include/asm-ia64/resource.h.cleanup	2004-08-05 13:42:06.657087045 -0400
+++ linux-2.6.8-rc3/include/asm-ia64/resource.h	2004-08-05 13:44:23.847432826 -0400
@@ -46,7 +46,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{         32768,         32768 },		\
+	{   MLOCK_LIMIT,   MLOCK_LIMIT },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.8-rc3/include/linux/resource.h.cleanup	2004-08-05 13:42:06.941002887 -0400
+++ linux-2.6.8-rc3/include/linux/resource.h	2004-08-05 13:48:13.058512450 -0400
@@ -56,6 +56,12 @@ struct rlimit {
 #define _STK_LIM	(8*1024*1024)
 
 /*
+ * GPG wants 32kB of mlocked memory, to make sure pass phrases
+ * and other sensitive information are never written to disk.
+ */
+#define MLOCK_LIMIT	(32*1024)
+
+/*
  * Due to binary compatibility, the actual resource numbers
  * may be different for different linux versions..
  */
--- linux-2.6.8-rc3/include/asm-arm/resource.h.cleanup	2004-08-05 13:42:06.598104528 -0400
+++ linux-2.6.8-rc3/include/asm-arm/resource.h	2004-08-05 13:43:37.951031395 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ 0,             0             },	\
 	{ INR_OPEN,      INR_OPEN      },	\
-	{ 32768,	 32768	       },	\
+	{ MLOCK_LIMIT,	 MLOCK_LIMIT   },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ MAX_SIGPENDING, MAX_SIGPENDING},	\
--- linux-2.6.8-rc3/include/asm-v850/resource.h.cleanup	2004-08-05 13:42:06.904013851 -0400
+++ linux-2.6.8-rc3/include/asm-v850/resource.h	2004-08-05 13:47:20.929960031 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{         32768,         32768 },		\
+	{   MLOCK_LIMIT,   MLOCK_LIMIT },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.8-rc3/include/asm-sparc/resource.h.cleanup	2004-08-05 13:42:06.857027779 -0400
+++ linux-2.6.8-rc3/include/asm-sparc/resource.h	2004-08-05 13:47:05.714468923 -0400
@@ -44,7 +44,7 @@
     {       0, RLIM_INFINITY},		\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {INR_OPEN, INR_OPEN}, {0, 0},	\
-    {32768, 	     32768},	\
+    {MLOCK_LIMIT,   MLOCK_LIMIT},	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {MAX_SIGPENDING, MAX_SIGPENDING},	\
--- linux-2.6.8-rc3/include/asm-alpha/resource.h.cleanup	2004-08-05 13:42:06.537122604 -0400
+++ linux-2.6.8-rc3/include/asm-alpha/resource.h	2004-08-05 13:43:06.538338256 -0400
@@ -41,7 +41,7 @@
     {INR_OPEN, INR_OPEN},			/* RLIMIT_NOFILE */	\
     {LONG_MAX, LONG_MAX},			/* RLIMIT_AS */		\
     {LONG_MAX, LONG_MAX},			/* RLIMIT_NPROC */	\
-    {32768, 	32768	},			/* RLIMIT_MEMLOCK */	\
+    {MLOCK_LIMIT, MLOCK_LIMIT },		/* RLIMIT_MEMLOCK */	\
     {LONG_MAX, LONG_MAX},			/* RLIMIT_LOCKS */	\
     {MAX_SIGPENDING, MAX_SIGPENDING},		/* RLIMIT_SIGPENDING */ \
     {MQ_BYTES_MAX, MQ_BYTES_MAX},		/* RLIMIT_MSGQUEUE */	\
--- linux-2.6.8-rc3/include/asm-i386/resource.h.cleanup	2004-08-05 13:42:06.771053263 -0400
+++ linux-2.6.8-rc3/include/asm-i386/resource.h	2004-08-05 13:44:11.416116138 -0400
@@ -40,7 +40,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{         32768,         32768 },		\
+	{   MLOCK_LIMIT,   MLOCK_LIMIT },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.8-rc3/include/asm-h8300/resource.h.cleanup	2004-08-05 13:42:06.627095934 -0400
+++ linux-2.6.8-rc3/include/asm-h8300/resource.h	2004-08-05 13:44:01.230134142 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{         32768,         32768 },		\
+	{   MLOCK_LIMIT,   MLOCK_LIMIT },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.8-rc3/include/asm-s390/resource.h.cleanup	2004-08-05 13:42:06.796045855 -0400
+++ linux-2.6.8-rc3/include/asm-s390/resource.h	2004-08-05 13:46:16.166151634 -0400
@@ -47,7 +47,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{ INR_OPEN, INR_OPEN },                         \
-	{         32768,         32768 },		\
+	{   MLOCK_LIMIT,   MLOCK_LIMIT },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.8-rc3/include/asm-cris/resource.h.cleanup	2004-08-05 13:42:06.615099490 -0400
+++ linux-2.6.8-rc3/include/asm-cris/resource.h	2004-08-05 13:43:50.955178478 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{         32768,         32768 },               \
+	{   MLOCK_LIMIT,   MLOCK_LIMIT },               \
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.8-rc3/include/asm-sparc64/resource.h.cleanup	2004-08-05 13:42:06.830035780 -0400
+++ linux-2.6.8-rc3/include/asm-sparc64/resource.h	2004-08-05 13:46:46.255235374 -0400
@@ -43,7 +43,7 @@
     {       0, RLIM_INFINITY},		\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {INR_OPEN, INR_OPEN}, {0, 0},	\
-    {32768, 	  32768	          },	\
+    {  MLOCK_LIMIT,   MLOCK_LIMIT},	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {MAX_SIGPENDING, MAX_SIGPENDING},	\
--- linux-2.6.8-rc3/include/asm-arm26/resource.h.cleanup	2004-08-05 13:42:06.552118159 -0400
+++ linux-2.6.8-rc3/include/asm-arm26/resource.h	2004-08-05 13:43:24.978874784 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ 0,             0             },	\
 	{ INR_OPEN,      INR_OPEN      },	\
-	{ 32768,	 32768	       },	\
+	{ MLOCK_LIMIT,	 MLOCK_LIMIT   },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ MAX_SIGPENDING, MAX_SIGPENDING},	\
--- linux-2.6.8-rc3/include/asm-sh/resource.h.cleanup	2004-08-05 13:42:06.825037261 -0400
+++ linux-2.6.8-rc3/include/asm-sh/resource.h	2004-08-05 13:46:27.449807991 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{         32768,         32768 },		\
+	{   MLOCK_LIMIT,   MLOCK_LIMIT },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\

