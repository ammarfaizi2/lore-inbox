Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbVG1Q1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbVG1Q1G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 12:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVG1Q1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 12:27:02 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:58584 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261649AbVG1QZq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 12:25:46 -0400
Date: Fri, 29 Jul 2005 02:21:45 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/6] Clean up struct flock definitions
Message-Id: <20050729022145.5ad904ca.sfr@canb.auug.org.au>
In-Reply-To: <20050729020802.22b7656c.sfr@canb.auug.org.au>
References: <20050729020802.22b7656c.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch just gathers together all the struct flock definitions.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruNp linus-fcntl.4/include/asm-alpha/fcntl.h linus-fcntl.5/include/asm-alpha/fcntl.h
--- linus-fcntl.4/include/asm-alpha/fcntl.h	2005-07-26 16:04:48.000000000 +1000
+++ linus-fcntl.5/include/asm-alpha/fcntl.h	2005-07-28 23:47:52.000000000 +1000
@@ -37,14 +37,6 @@
 
 #define F_INPROGRESS	64
 
-struct flock {
-	short l_type;
-	short l_whence;
-	__kernel_off_t l_start;
-	__kernel_off_t l_len;
-	__kernel_pid_t l_pid;
-};
-
 #include <asm-generic/fcntl.h>
 
 #endif
diff -ruNp linus-fcntl.4/include/asm-arm/fcntl.h linus-fcntl.5/include/asm-arm/fcntl.h
--- linus-fcntl.4/include/asm-arm/fcntl.h	2005-07-26 16:47:14.000000000 +1000
+++ linus-fcntl.5/include/asm-arm/fcntl.h	2005-07-26 17:50:55.000000000 +1000
@@ -10,14 +10,6 @@
 #define F_SETLK64	13
 #define F_SETLKW64	14
 
-struct flock {
-	short l_type;
-	short l_whence;
-	off_t l_start;
-	off_t l_len;
-	pid_t l_pid;
-};
-
 struct flock64 {
 	short  l_type;
 	short  l_whence;
diff -ruNp linus-fcntl.4/include/asm-arm26/fcntl.h linus-fcntl.5/include/asm-arm26/fcntl.h
--- linus-fcntl.4/include/asm-arm26/fcntl.h	2005-07-26 16:47:44.000000000 +1000
+++ linus-fcntl.5/include/asm-arm26/fcntl.h	2005-07-26 17:51:05.000000000 +1000
@@ -12,14 +12,6 @@
 #define F_SETLK64	13
 #define F_SETLKW64	14
 
-struct flock {
-	short l_type;
-	short l_whence;
-	off_t l_start;
-	off_t l_len;
-	pid_t l_pid;
-};
-
 struct flock64 {
 	short  l_type;
 	short  l_whence;
diff -ruNp linus-fcntl.4/include/asm-cris/fcntl.h linus-fcntl.5/include/asm-cris/fcntl.h
--- linus-fcntl.4/include/asm-cris/fcntl.h	2005-07-26 16:48:19.000000000 +1000
+++ linus-fcntl.5/include/asm-cris/fcntl.h	2005-07-26 17:51:14.000000000 +1000
@@ -5,14 +5,6 @@
 #define F_SETLK64      13
 #define F_SETLKW64     14
 
-struct flock {
-	short l_type;
-	short l_whence;
-	off_t l_start;
-	off_t l_len;
-	pid_t l_pid;
-};
-
 struct flock64 {
 	short  l_type;
 	short  l_whence;
diff -ruNp linus-fcntl.4/include/asm-frv/fcntl.h linus-fcntl.5/include/asm-frv/fcntl.h
--- linus-fcntl.4/include/asm-frv/fcntl.h	2005-07-26 16:48:50.000000000 +1000
+++ linus-fcntl.5/include/asm-frv/fcntl.h	2005-07-26 17:51:25.000000000 +1000
@@ -5,14 +5,6 @@
 #define F_SETLK64	13
 #define F_SETLKW64	14
 
-struct flock {
-	short l_type;
-	short l_whence;
-	off_t l_start;
-	off_t l_len;
-	pid_t l_pid;
-};
-
 struct flock64 {
 	short  l_type;
 	short  l_whence;
diff -ruNp linus-fcntl.4/include/asm-generic/fcntl.h linus-fcntl.5/include/asm-generic/fcntl.h
--- linus-fcntl.4/include/asm-generic/fcntl.h	2005-07-26 17:02:11.000000000 +1000
+++ linus-fcntl.5/include/asm-generic/fcntl.h	2005-07-26 18:33:48.000000000 +1000
@@ -1,6 +1,8 @@
 #ifndef _ASM_GENERIC_FCNTL_H
 #define _ASM_GENERIC_FCNTL_H
 
+#include <linux/types.h>
+
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
 #define O_ACCMODE	00000003
@@ -104,4 +106,19 @@
 
 #define F_LINUX_SPECIFIC_BASE	1024
 
+#ifndef HAVE_ARCH_STRUCT_FLOCK
+#ifndef __ARCH_FLOCK_PAD
+#define __ARCH_FLOCK_PAD
+#endif
+
+struct flock {
+	short	l_type;
+	short	l_whence;
+	off_t	l_start;
+	off_t	l_len;
+	pid_t	l_pid;
+	__ARCH_FLOCK_PAD
+};
+#endif
+
 #endif /* _ASM_GENERIC_FCNTL_H */
diff -ruNp linus-fcntl.4/include/asm-h8300/fcntl.h linus-fcntl.5/include/asm-h8300/fcntl.h
--- linus-fcntl.4/include/asm-h8300/fcntl.h	2005-07-26 16:49:30.000000000 +1000
+++ linus-fcntl.5/include/asm-h8300/fcntl.h	2005-07-26 17:51:38.000000000 +1000
@@ -10,14 +10,6 @@
 #define F_SETLK64	13
 #define F_SETLKW64	14
 
-struct flock {
-	short l_type;
-	short l_whence;
-	off_t l_start;
-	off_t l_len;
-	pid_t l_pid;
-};
-
 struct flock64 {
 	short  l_type;
 	short  l_whence;
diff -ruNp linus-fcntl.4/include/asm-i386/fcntl.h linus-fcntl.5/include/asm-i386/fcntl.h
--- linus-fcntl.4/include/asm-i386/fcntl.h	2005-07-26 16:50:00.000000000 +1000
+++ linus-fcntl.5/include/asm-i386/fcntl.h	2005-07-26 17:48:37.000000000 +1000
@@ -5,14 +5,6 @@
 #define F_SETLK64	13
 #define F_SETLKW64	14
 
-struct flock {
-	short l_type;
-	short l_whence;
-	off_t l_start;
-	off_t l_len;
-	pid_t l_pid;
-};
-
 struct flock64 {
 	short  l_type;
 	short  l_whence;
diff -ruNp linus-fcntl.4/include/asm-ia64/fcntl.h linus-fcntl.5/include/asm-ia64/fcntl.h
--- linus-fcntl.4/include/asm-ia64/fcntl.h	2005-07-26 16:50:15.000000000 +1000
+++ linus-fcntl.5/include/asm-ia64/fcntl.h	2005-07-26 17:52:00.000000000 +1000
@@ -5,14 +5,6 @@
  *	David Mosberger-Tang <davidm@hpl.hp.com>, Hewlett-Packard Co.
  */
 
-struct flock {
-	short l_type;
-	short l_whence;
-	off_t l_start;
-	off_t l_len;
-	pid_t l_pid;
-};
-
 #define force_o_largefile() ( ! (current->personality & PER_LINUX32) )
 
 #include <asm-generic/fcntl.h>
diff -ruNp linus-fcntl.4/include/asm-m32r/fcntl.h linus-fcntl.5/include/asm-m32r/fcntl.h
--- linus-fcntl.4/include/asm-m32r/fcntl.h	2005-07-26 16:50:39.000000000 +1000
+++ linus-fcntl.5/include/asm-m32r/fcntl.h	2005-07-26 17:52:22.000000000 +1000
@@ -1,22 +1,10 @@
 #ifndef _ASM_M32R_FCNTL_H
 #define _ASM_M32R_FCNTL_H
 
-/* $Id$ */
-
-/* orig : i386 2.4.18 */
-
 #define F_GETLK64	12	/*  using 'struct flock64' */
 #define F_SETLK64	13
 #define F_SETLKW64	14
 
-struct flock {
-	short l_type;
-	short l_whence;
-	off_t l_start;
-	off_t l_len;
-	pid_t l_pid;
-};
-
 struct flock64 {
 	short  l_type;
 	short  l_whence;
diff -ruNp linus-fcntl.4/include/asm-m68k/fcntl.h linus-fcntl.5/include/asm-m68k/fcntl.h
--- linus-fcntl.4/include/asm-m68k/fcntl.h	2005-07-26 16:51:08.000000000 +1000
+++ linus-fcntl.5/include/asm-m68k/fcntl.h	2005-07-26 17:52:32.000000000 +1000
@@ -10,14 +10,6 @@
 #define F_SETLK64	13
 #define F_SETLKW64	14
 
-struct flock {
-	short l_type;
-	short l_whence;
-	off_t l_start;
-	off_t l_len;
-	pid_t l_pid;
-};
-
 struct flock64 {
 	short  l_type;
 	short  l_whence;
diff -ruNp linus-fcntl.4/include/asm-mips/fcntl.h linus-fcntl.5/include/asm-mips/fcntl.h
--- linus-fcntl.4/include/asm-mips/fcntl.h	2005-07-26 16:52:09.000000000 +1000
+++ linus-fcntl.5/include/asm-mips/fcntl.h	2005-07-29 01:05:09.000000000 +1000
@@ -50,7 +50,7 @@ typedef struct flock {
 	long	l_sysid;
 	__kernel_pid_t l_pid;
 	long	pad[4];
-} flock_t;
+};
 
 typedef struct flock64 {
 	short	l_type;
@@ -60,22 +60,13 @@ typedef struct flock64 {
 	pid_t	l_pid;
 } flock64_t;
 
-#else /* 64-bit definitions */
 
-typedef struct flock {
-	short	l_type;
-	short	l_whence;
-	__kernel_off_t l_start;
-	__kernel_off_t l_len;
-	__kernel_pid_t l_pid;
-} flock_t;
-
-#ifdef __KERNEL__
-#define flock64		flock
-#endif
+#define HAVE_ARCH_STRUCT_FLOCK
 
 #endif
 
 #include <asm-generic/fcntl.h>
 
+typedef struct flock flock_t;
+
 #endif /* _ASM_FCNTL_H */
diff -ruNp linus-fcntl.4/include/asm-parisc/fcntl.h linus-fcntl.5/include/asm-parisc/fcntl.h
--- linus-fcntl.4/include/asm-parisc/fcntl.h	2005-07-26 16:53:18.000000000 +1000
+++ linus-fcntl.5/include/asm-parisc/fcntl.h	2005-07-26 17:53:10.000000000 +1000
@@ -33,14 +33,6 @@
 #define F_WRLCK		02
 #define F_UNLCK		03
 
-struct flock {
-	short l_type;
-	short l_whence;
-	off_t l_start;
-	off_t l_len;
-	pid_t l_pid;
-};
-
 struct flock64 {
 	short l_type;
 	short l_whence;
diff -ruNp linus-fcntl.4/include/asm-ppc/fcntl.h linus-fcntl.5/include/asm-ppc/fcntl.h
--- linus-fcntl.4/include/asm-ppc/fcntl.h	2005-07-26 16:53:47.000000000 +1000
+++ linus-fcntl.5/include/asm-ppc/fcntl.h	2005-07-26 17:53:25.000000000 +1000
@@ -12,17 +12,7 @@
 #define F_GETLK64	12	/*  using 'struct flock64' */
 #define F_SETLK64	13
 #define F_SETLKW64	14
-#endif
-
-struct flock {
-	short l_type;
-	short l_whence;
-	off_t l_start;
-	off_t l_len;
-	pid_t l_pid;
-};
 
-#ifndef CONFIG_64BIT
 struct flock64 {
 	short  l_type;
 	short  l_whence;
diff -ruNp linus-fcntl.4/include/asm-s390/fcntl.h linus-fcntl.5/include/asm-s390/fcntl.h
--- linus-fcntl.4/include/asm-s390/fcntl.h	2005-07-26 16:54:10.000000000 +1000
+++ linus-fcntl.5/include/asm-s390/fcntl.h	2005-07-26 17:53:43.000000000 +1000
@@ -12,17 +12,7 @@
 #define F_GETLK64	12	/*  using 'struct flock64' */
 #define F_SETLK64	13
 #define F_SETLKW64	14
-#endif /* ! __s390x__ */
 
-struct flock {
-	short l_type;
-	short l_whence;
-	off_t l_start;
-	off_t l_len;
-	pid_t l_pid;
-};
-
-#ifndef __s390x__
 struct flock64 {
 	short  l_type;
 	short  l_whence;
diff -ruNp linus-fcntl.4/include/asm-sh/fcntl.h linus-fcntl.5/include/asm-sh/fcntl.h
--- linus-fcntl.4/include/asm-sh/fcntl.h	2005-07-26 16:54:41.000000000 +1000
+++ linus-fcntl.5/include/asm-sh/fcntl.h	2005-07-26 17:53:51.000000000 +1000
@@ -5,14 +5,6 @@
 #define F_SETLK64	13
 #define F_SETLKW64	14
 
-struct flock {
-	short l_type;
-	short l_whence;
-	off_t l_start;
-	off_t l_len;
-	pid_t l_pid;
-};
-
 struct flock64 {
 	short  l_type;
 	short  l_whence;
diff -ruNp linus-fcntl.4/include/asm-sparc/fcntl.h linus-fcntl.5/include/asm-sparc/fcntl.h
--- linus-fcntl.4/include/asm-sparc/fcntl.h	2005-07-26 16:55:19.000000000 +1000
+++ linus-fcntl.5/include/asm-sparc/fcntl.h	2005-07-26 18:31:34.000000000 +1000
@@ -32,15 +32,6 @@
 #define F_WRLCK		2
 #define F_UNLCK		3
 
-struct flock {
-	short l_type;
-	short l_whence;
-	off_t l_start;
-	off_t l_len;
-	pid_t l_pid;
-	short __unused;
-};
-
 struct flock64 {
 	short l_type;
 	short l_whence;
@@ -50,6 +41,8 @@ struct flock64 {
 	short __unused;
 };
 
+#define __ARCH_FLOCK_PAD	short __unused;
+
 #include <asm-generic/fcntl.h>
 
 #endif
diff -ruNp linus-fcntl.4/include/asm-sparc64/fcntl.h linus-fcntl.5/include/asm-sparc64/fcntl.h
--- linus-fcntl.4/include/asm-sparc64/fcntl.h	2005-07-26 16:55:34.000000000 +1000
+++ linus-fcntl.5/include/asm-sparc64/fcntl.h	2005-07-26 18:32:06.000000000 +1000
@@ -29,14 +29,7 @@
 #define F_WRLCK		2
 #define F_UNLCK		3
 
-struct flock {
-	short l_type;
-	short l_whence;
-	off_t l_start;
-	off_t l_len;
-	pid_t l_pid;
-	short __unused;
-};
+#define __ARCH_FLOCK_PAD	short __unused;
 
 #include <asm-generic/fcntl.h>
 
diff -ruNp linus-fcntl.4/include/asm-v850/fcntl.h linus-fcntl.5/include/asm-v850/fcntl.h
--- linus-fcntl.4/include/asm-v850/fcntl.h	2005-07-26 16:55:58.000000000 +1000
+++ linus-fcntl.5/include/asm-v850/fcntl.h	2005-07-26 17:54:51.000000000 +1000
@@ -10,14 +10,6 @@
 #define F_SETLK64	13
 #define F_SETLKW64	14
 
-struct flock {
-	short l_type;
-	short l_whence;
-	off_t l_start;
-	off_t l_len;
-	pid_t l_pid;
-};
-
 struct flock64 {
 	short  l_type;
 	short  l_whence;
diff -ruNp linus-fcntl.4/include/asm-x86_64/fcntl.h linus-fcntl.5/include/asm-x86_64/fcntl.h
--- linus-fcntl.4/include/asm-x86_64/fcntl.h	2005-07-26 16:56:26.000000000 +1000
+++ linus-fcntl.5/include/asm-x86_64/fcntl.h	2005-07-26 17:55:13.000000000 +1000
@@ -1,14 +1 @@
-#ifndef _X86_64_FCNTL_H
-#define _X86_64_FCNTL_H
-
-struct flock {
-	short  l_type;
-	short  l_whence;
-	off_t l_start;
-	off_t l_len;
-	pid_t  l_pid;
-};
-
 #include <asm-generic/fcntl.h>
-
-#endif /* !_X86_64_FCNTL_H */
diff -ruNp linus-fcntl.4/include/asm-xtensa/fcntl.h linus-fcntl.5/include/asm-xtensa/fcntl.h
--- linus-fcntl.4/include/asm-xtensa/fcntl.h	2005-07-26 16:57:07.000000000 +1000
+++ linus-fcntl.5/include/asm-xtensa/fcntl.h	2005-07-26 17:56:18.000000000 +1000
@@ -53,6 +53,8 @@ struct flock64 {
 	pid_t  l_pid;
 };
 
+#define HAVE_ARCH_STRUCT_FLOCK
+
 #include <asm-generic/fcntl.h>
 
 #endif /* _XTENSA_FCNTL_H */
