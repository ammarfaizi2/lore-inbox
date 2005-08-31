Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbVHaHEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbVHaHEY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 03:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbVHaHD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 03:03:56 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:64406 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S932402AbVHaHD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 03:03:28 -0400
Date: Wed, 31 Aug 2005 16:59:39 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/7] Clean up struct flock definitions
Message-Id: <20050831165939.50138ae5.sfr@canb.auug.org.au>
In-Reply-To: <20050831165724.114c4600.sfr@canb.auug.org.au>
References: <20050831164738.6cee5830.sfr@canb.auug.org.au>
	<20050831165039.3740c832.sfr@canb.auug.org.au>
	<20050831165358.63910cfb.sfr@canb.auug.org.au>
	<20050831165550.7a477884.sfr@canb.auug.org.au>
	<20050831165724.114c4600.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch just gathers together all the struct flock definitions except
xtensa into asm-generic/fcntl.h.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 include/asm-alpha/fcntl.h   |    8 --------
 include/asm-arm/fcntl.h     |    8 --------
 include/asm-arm26/fcntl.h   |    8 --------
 include/asm-cris/fcntl.h    |    8 --------
 include/asm-frv/fcntl.h     |    8 --------
 include/asm-generic/fcntl.h |   17 +++++++++++++++++
 include/asm-h8300/fcntl.h   |    8 --------
 include/asm-i386/fcntl.h    |    8 --------
 include/asm-ia64/fcntl.h    |    8 --------
 include/asm-m32r/fcntl.h    |   12 ------------
 include/asm-m68k/fcntl.h    |    8 --------
 include/asm-mips/fcntl.h    |   17 ++++-------------
 include/asm-parisc/fcntl.h  |    8 --------
 include/asm-ppc/fcntl.h     |   10 ----------
 include/asm-s390/fcntl.h    |   10 ----------
 include/asm-sh/fcntl.h      |    8 --------
 include/asm-sparc/fcntl.h   |   11 ++---------
 include/asm-sparc64/fcntl.h |    9 +--------
 include/asm-v850/fcntl.h    |    8 --------
 include/asm-x86_64/fcntl.h  |   13 -------------
 include/asm-xtensa/fcntl.h  |    2 ++
 21 files changed, 26 insertions(+), 171 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff --git a/include/asm-alpha/fcntl.h b/include/asm-alpha/fcntl.h
--- a/include/asm-alpha/fcntl.h
+++ b/include/asm-alpha/fcntl.h
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
diff --git a/include/asm-arm/fcntl.h b/include/asm-arm/fcntl.h
--- a/include/asm-arm/fcntl.h
+++ b/include/asm-arm/fcntl.h
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
diff --git a/include/asm-arm26/fcntl.h b/include/asm-arm26/fcntl.h
--- a/include/asm-arm26/fcntl.h
+++ b/include/asm-arm26/fcntl.h
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
diff --git a/include/asm-cris/fcntl.h b/include/asm-cris/fcntl.h
--- a/include/asm-cris/fcntl.h
+++ b/include/asm-cris/fcntl.h
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
diff --git a/include/asm-frv/fcntl.h b/include/asm-frv/fcntl.h
--- a/include/asm-frv/fcntl.h
+++ b/include/asm-frv/fcntl.h
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
diff --git a/include/asm-generic/fcntl.h b/include/asm-generic/fcntl.h
--- a/include/asm-generic/fcntl.h
+++ b/include/asm-generic/fcntl.h
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
diff --git a/include/asm-h8300/fcntl.h b/include/asm-h8300/fcntl.h
--- a/include/asm-h8300/fcntl.h
+++ b/include/asm-h8300/fcntl.h
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
diff --git a/include/asm-i386/fcntl.h b/include/asm-i386/fcntl.h
--- a/include/asm-i386/fcntl.h
+++ b/include/asm-i386/fcntl.h
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
diff --git a/include/asm-ia64/fcntl.h b/include/asm-ia64/fcntl.h
--- a/include/asm-ia64/fcntl.h
+++ b/include/asm-ia64/fcntl.h
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
diff --git a/include/asm-m32r/fcntl.h b/include/asm-m32r/fcntl.h
--- a/include/asm-m32r/fcntl.h
+++ b/include/asm-m32r/fcntl.h
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
diff --git a/include/asm-m68k/fcntl.h b/include/asm-m68k/fcntl.h
--- a/include/asm-m68k/fcntl.h
+++ b/include/asm-m68k/fcntl.h
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
diff --git a/include/asm-mips/fcntl.h b/include/asm-mips/fcntl.h
--- a/include/asm-mips/fcntl.h
+++ b/include/asm-mips/fcntl.h
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
diff --git a/include/asm-parisc/fcntl.h b/include/asm-parisc/fcntl.h
--- a/include/asm-parisc/fcntl.h
+++ b/include/asm-parisc/fcntl.h
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
diff --git a/include/asm-ppc/fcntl.h b/include/asm-ppc/fcntl.h
--- a/include/asm-ppc/fcntl.h
+++ b/include/asm-ppc/fcntl.h
@@ -10,17 +10,7 @@
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
 
-#ifndef __powerpc64__
 struct flock64 {
 	short  l_type;
 	short  l_whence;
diff --git a/include/asm-s390/fcntl.h b/include/asm-s390/fcntl.h
--- a/include/asm-s390/fcntl.h
+++ b/include/asm-s390/fcntl.h
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
diff --git a/include/asm-sh/fcntl.h b/include/asm-sh/fcntl.h
--- a/include/asm-sh/fcntl.h
+++ b/include/asm-sh/fcntl.h
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
diff --git a/include/asm-sparc/fcntl.h b/include/asm-sparc/fcntl.h
--- a/include/asm-sparc/fcntl.h
+++ b/include/asm-sparc/fcntl.h
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
diff --git a/include/asm-sparc64/fcntl.h b/include/asm-sparc64/fcntl.h
--- a/include/asm-sparc64/fcntl.h
+++ b/include/asm-sparc64/fcntl.h
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
 
diff --git a/include/asm-v850/fcntl.h b/include/asm-v850/fcntl.h
--- a/include/asm-v850/fcntl.h
+++ b/include/asm-v850/fcntl.h
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
diff --git a/include/asm-x86_64/fcntl.h b/include/asm-x86_64/fcntl.h
--- a/include/asm-x86_64/fcntl.h
+++ b/include/asm-x86_64/fcntl.h
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
diff --git a/include/asm-xtensa/fcntl.h b/include/asm-xtensa/fcntl.h
--- a/include/asm-xtensa/fcntl.h
+++ b/include/asm-xtensa/fcntl.h
@@ -53,6 +53,8 @@ struct flock64 {
 	pid_t  l_pid;
 };
 
+#define HAVE_ARCH_STRUCT_FLOCK
+
 #include <asm-generic/fcntl.h>
 
 #endif /* _XTENSA_FCNTL_H */
