Return-Path: <linux-kernel-owner+w=401wt.eu-S1422995AbWLUSEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422995AbWLUSEf (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 13:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422996AbWLUSEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 13:04:35 -0500
Received: from rsm.demon.co.uk ([80.177.111.50]:60263 "EHLO mail.marples.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422995AbWLUSEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 13:04:35 -0500
X-Greylist: delayed 1209 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Dec 2006 13:04:34 EST
Date: Thu, 21 Dec 2006 17:44:17 +0000
From: Roy Marples <roy@marples.name>
To: linux-kernel@vger.kernel.org
Cc: vapier@gentoo.org
Subject: [PATCH 2.6.19] asm/types.h: Allow C99 to use __u64
Message-ID: <20061221174417.5e7478db@uberlaptop.development.ltl>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

C99 standard allows the use of the long long data type, both signed and
unsigned. We should allow this to be used if defined.

Signed-off-by: Roy Marples <uberlord@gentoo.org>


--- a/include/asm-arm/types.h	2006-11-29 21:57:37.000000000 +0000
+++ b/include/asm-arm/types.h	2006-12-21 17:21:43.000000000 +0000
@@ -19,7 +19,7 @@
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
+#if (defined(__GNUC__) && !defined(__STRICT_ANSI__)) || defined(__USE_ISOC99)
 typedef __signed__ long long __s64;
 typedef unsigned long long __u64;
 #endif
--- a/include/asm-arm26/types.h	2006-11-29 21:57:37.000000000 +0000
+++ b/include/asm-arm26/types.h	2006-12-21 17:22:06.000000000 +0000
@@ -19,7 +19,7 @@
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
+#if (defined(__GNUC__) && !defined(__STRICT_ANSI__)) || defined(__USE_ISOC99)
 typedef __signed__ long long __s64;
 typedef unsigned long long __u64;
 #endif
--- a/include/asm-avr32/types.h	2006-11-29 21:57:37.000000000 +0000
+++ b/include/asm-avr32/types.h	2006-12-21 17:22:28.000000000 +0000
@@ -25,7 +25,7 @@
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
+#if (defined(__GNUC__) && !defined(__STRICT_ANSI__)) || defined(__USE_ISOC99)
 typedef __signed__ long long __s64;
 typedef unsigned long long __u64;
 #endif
--- a/include/asm-cris/types.h	2006-11-29 21:57:37.000000000 +0000
+++ b/include/asm-cris/types.h	2006-12-21 17:23:00.000000000 +0000
@@ -19,7 +19,7 @@
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
+#if (defined(__GNUC__) && !defined(__STRICT_ANSI__)) || defined(__USE_ISOC99)
 typedef __signed__ long long __s64;
 typedef unsigned long long __u64;
 #endif
--- a/include/asm-frv/types.h	2006-11-29 21:57:37.000000000 +0000
+++ b/include/asm-frv/types.h	2006-12-21 17:23:23.000000000 +0000
@@ -30,7 +30,7 @@
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
+#if (defined(__GNUC__) && !defined(__STRICT_ANSI__)) || defined(__USE_ISOC99)
 typedef __signed__ long long __s64;
 typedef unsigned long long __u64;
 #endif
--- a/include/asm-h8300/types.h	2006-11-29 21:57:37.000000000 +0000
+++ b/include/asm-h8300/types.h	2006-12-21 17:23:57.000000000 +0000
@@ -27,7 +27,7 @@
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
+#if (defined(__GNUC__) && !defined(__STRICT_ANSI__)) || defined(__USE_ISOC99)
 typedef __signed__ long long __s64;
 typedef unsigned long long __u64;
 #endif
diff -ur a/include/asm-i386/types.h b/include/asm-i386/types.h
--- a/include/asm-i386/types.h	2006-11-29 21:57:37.000000000 +0000
+++ b/include/asm-i386/types.h	2006-12-21 17:20:37.000000000 +0000
@@ -19,7 +19,7 @@
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
+#if (defined(__GNUC__) && !defined(__STRICT_ANSI__)) || defined(__USE_ISOC99)
 typedef __signed__ long long __s64;
 typedef unsigned long long __u64;
 #endif
--- a/include/asm-m68k/types.h	2006-11-29 21:57:37.000000000 +0000
+++ b/include/asm-m68k/types.h	2006-12-21 17:24:23.000000000 +0000
@@ -27,7 +27,7 @@
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
+#if (defined(__GNUC__) && !defined(__STRICT_ANSI__)) || defined(__USE_ISOC99)
 typedef __signed__ long long __s64;
 typedef unsigned long long __u64;
 #endif
--- a/include/asm-mips/types.h	2006-11-29 21:57:37.000000000 +0000
+++ b/include/asm-mips/types.h	2006-12-21 17:24:56.000000000 +0000
@@ -34,7 +34,7 @@
 
 #else
 
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
+#if (defined(__GNUC__) && !defined(__STRICT_ANSI__)) || defined(__USE_ISOC99)
 typedef __signed__ long long __s64;
 typedef unsigned long long __u64;
 #endif
--- a/include/asm-parisc/types.h	2006-11-29 21:57:37.000000000 +0000
+++ b/include/asm-parisc/types.h	2006-12-21 17:25:20.000000000 +0000
@@ -19,7 +19,7 @@
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
+#if (defined(__GNUC__) && !defined(__STRICT_ANSI__)) || defined(__USE_ISOC99)
 typedef __signed__ long long __s64;
 typedef unsigned long long __u64;
 #endif
--- a/include/asm-powerpc/types.h	2006-11-29 21:57:37.000000000 +0000
+++ b/include/asm-powerpc/types.h	2006-12-21 17:25:44.000000000 +0000
@@ -40,7 +40,7 @@
 typedef __signed__ long __s64;
 typedef unsigned long __u64;
 #else
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
+#if (defined(__GNUC__) && !defined(__STRICT_ANSI__)) || defined(__USE_ISOC99)
 typedef __signed__ long long __s64;
 typedef unsigned long long __u64;
 #endif
--- a/include/asm-s390/types.h	2006-11-29 21:57:37.000000000 +0000
+++ b/include/asm-s390/types.h	2006-12-21 17:26:34.000000000 +0000
@@ -28,7 +28,7 @@
 typedef unsigned int __u32;
 
 #ifndef __s390x__
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
+#if (defined(__GNUC__) && !defined(__STRICT_ANSI__)) || defined(__USE_ISOC99)
 typedef __signed__ long long __s64;
 typedef unsigned long long __u64;
 #endif
--- a/include/asm-sh/types.h	2006-11-29 21:57:37.000000000 +0000
+++ b/include/asm-sh/types.h	2006-12-21 17:26:57.000000000 +0000
@@ -19,7 +19,7 @@
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
+#if (defined(__GNUC__) && !defined(__STRICT_ANSI__)) || defined(__USE_ISOC99)
 typedef __signed__ long long __s64;
 typedef unsigned long long __u64;
 #endif
--- a/include/asm-sh64/types.h	2006-11-29 21:57:37.000000000 +0000
+++ b/include/asm-sh64/types.h	2006-12-21 17:27:20.000000000 +0000
@@ -30,7 +30,7 @@
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
+#if (defined(__GNUC__) && !defined(__STRICT_ANSI__)) || defined(__USE_ISOC99)
 typedef __signed__ long long __s64;
 typedef unsigned long long __u64;
 #endif
--- a/include/asm-v850/types.h	2006-11-29 21:57:37.000000000 +0000
+++ b/include/asm-v850/types.h	2006-12-21 17:28:16.000000000 +0000
@@ -27,7 +27,7 @@
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
+#if (defined(__GNUC__) && !defined(__STRICT_ANSI__)) || defined(__USE_ISOC99)
 typedef __signed__ long long __s64;
 typedef unsigned long long __u64;
 #endif
--- a/include/asm-xtensa/types.h	2006-11-29 21:57:37.000000000 +0000
+++ b/include/asm-xtensa/types.h	2006-12-21 17:28:50.000000000 +0000
@@ -29,7 +29,7 @@
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
+#if (defined(__GNUC__) && !defined(__STRICT_ANSI__)) || defined(__USE_ISOC99)
 typedef __signed__ long long __s64;
 typedef unsigned long long __u64;
 #endif
