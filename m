Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbVHaHDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbVHaHDu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 03:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbVHaHDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 03:03:48 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:64662 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S932403AbVHaHD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 03:03:29 -0400
Date: Wed, 31 Aug 2005 17:01:29 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/7] Clean up struct flock64 definitions
Message-Id: <20050831170129.29673e4c.sfr@canb.auug.org.au>
In-Reply-To: <20050831165939.50138ae5.sfr@canb.auug.org.au>
References: <20050831164738.6cee5830.sfr@canb.auug.org.au>
	<20050831165039.3740c832.sfr@canb.auug.org.au>
	<20050831165358.63910cfb.sfr@canb.auug.org.au>
	<20050831165550.7a477884.sfr@canb.auug.org.au>
	<20050831165724.114c4600.sfr@canb.auug.org.au>
	<20050831165939.50138ae5.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch gathers all the struct flock64 definitions (and the
operations), puts them under !CONFIG_64BIT and cleans up the arch files.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 include/asm-arm/fcntl.h     |   12 ------------
 include/asm-arm26/fcntl.h   |   12 ------------
 include/asm-cris/fcntl.h    |   17 -----------------
 include/asm-frv/fcntl.h     |   18 ------------------
 include/asm-generic/fcntl.h |   25 +++++++++++++++++++++++++
 include/asm-h8300/fcntl.h   |   12 ------------
 include/asm-i386/fcntl.h    |   17 -----------------
 include/asm-m32r/fcntl.h    |   17 -----------------
 include/asm-m68k/fcntl.h    |   12 ------------
 include/asm-mips/fcntl.h    |   12 +++---------
 include/asm-parisc/fcntl.h  |    8 --------
 include/asm-ppc/fcntl.h     |   14 --------------
 include/asm-s390/fcntl.h    |   26 --------------------------
 include/asm-sh/fcntl.h      |   18 ------------------
 include/asm-sh64/fcntl.h    |    6 ------
 include/asm-sparc/fcntl.h   |   14 +-------------
 include/asm-v850/fcntl.h    |   12 ------------
 include/asm-xtensa/fcntl.h  |    1 +
 18 files changed, 30 insertions(+), 223 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff --git a/include/asm-arm/fcntl.h b/include/asm-arm/fcntl.h
--- a/include/asm-arm/fcntl.h
+++ b/include/asm-arm/fcntl.h
@@ -6,18 +6,6 @@
 #define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE	0400000
 
-#define F_GETLK64	12	/*  using 'struct flock64' */
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
-struct flock64 {
-	short  l_type;
-	short  l_whence;
-	loff_t l_start;
-	loff_t l_len;
-	pid_t  l_pid;
-};
-
 #include <asm-generic/fcntl.h>
 
 #endif
diff --git a/include/asm-arm26/fcntl.h b/include/asm-arm26/fcntl.h
--- a/include/asm-arm26/fcntl.h
+++ b/include/asm-arm26/fcntl.h
@@ -8,18 +8,6 @@
 #define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE	0400000
 
-#define F_GETLK64	12	/*  using 'struct flock64' */
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
-struct flock64 {
-	short  l_type;
-	short  l_whence;
-	loff_t l_start;
-	loff_t l_len;
-	pid_t  l_pid;
-};
-
 #include <asm-generic/fcntl.h>
 
 #endif
diff --git a/include/asm-cris/fcntl.h b/include/asm-cris/fcntl.h
--- a/include/asm-cris/fcntl.h
+++ b/include/asm-cris/fcntl.h
@@ -1,18 +1 @@
-#ifndef _CRIS_FCNTL_H
-#define _CRIS_FCNTL_H
-
-#define F_GETLK64      12      /*  using 'struct flock64' */
-#define F_SETLK64      13
-#define F_SETLKW64     14
-
-struct flock64 {
-	short  l_type;
-	short  l_whence;
-	loff_t l_start;
-	loff_t l_len;
-	pid_t  l_pid;
-};
-
 #include <asm-generic/fcntl.h>
-
-#endif
diff --git a/include/asm-frv/fcntl.h b/include/asm-frv/fcntl.h
--- a/include/asm-frv/fcntl.h
+++ b/include/asm-frv/fcntl.h
@@ -1,19 +1 @@
-#ifndef _ASM_FCNTL_H
-#define _ASM_FCNTL_H
-
-#define F_GETLK64	12	/*  using 'struct flock64' */
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
-struct flock64 {
-	short  l_type;
-	short  l_whence;
-	loff_t l_start;
-	loff_t l_len;
-	pid_t  l_pid;
-};
-
 #include <asm-generic/fcntl.h>
-
-#endif /* _ASM_FCNTL_H */
-
diff --git a/include/asm-generic/fcntl.h b/include/asm-generic/fcntl.h
--- a/include/asm-generic/fcntl.h
+++ b/include/asm-generic/fcntl.h
@@ -1,6 +1,7 @@
 #ifndef _ASM_GENERIC_FCNTL_H
 #define _ASM_GENERIC_FCNTL_H
 
+#include <linux/config.h>
 #include <linux/types.h>
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
@@ -121,4 +122,28 @@ struct flock {
 };
 #endif
 
+#ifndef CONFIG_64BIT
+
+#ifndef F_GETLK64
+#define F_GETLK64	12	/*  using 'struct flock64' */
+#define F_SETLK64	13
+#define F_SETLKW64	14
+#endif
+
+#ifndef HAVE_ARCH_STRUCT_FLOCK64
+#ifndef __ARCH_FLOCK64_PAD
+#define __ARCH_FLOCK64_PAD
+#endif
+
+struct flock64 {
+	short  l_type;
+	short  l_whence;
+	loff_t l_start;
+	loff_t l_len;
+	pid_t  l_pid;
+	__ARCH_FLOCK64_PAD
+};
+#endif
+#endif /* !CONFIG_64BIT */
+
 #endif /* _ASM_GENERIC_FCNTL_H */
diff --git a/include/asm-h8300/fcntl.h b/include/asm-h8300/fcntl.h
--- a/include/asm-h8300/fcntl.h
+++ b/include/asm-h8300/fcntl.h
@@ -6,18 +6,6 @@
 #define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE	0400000
 
-#define F_GETLK64	12	/*  using 'struct flock64' */
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
-struct flock64 {
-	short  l_type;
-	short  l_whence;
-	loff_t l_start;
-	loff_t l_len;
-	pid_t  l_pid;
-};
-
 #include <asm-generic/fcntl.h>
 
 #endif /* _H8300_FCNTL_H */
diff --git a/include/asm-i386/fcntl.h b/include/asm-i386/fcntl.h
--- a/include/asm-i386/fcntl.h
+++ b/include/asm-i386/fcntl.h
@@ -1,18 +1 @@
-#ifndef _I386_FCNTL_H
-#define _I386_FCNTL_H
-
-#define F_GETLK64	12	/*  using 'struct flock64' */
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
-struct flock64 {
-	short  l_type;
-	short  l_whence;
-	loff_t l_start;
-	loff_t l_len;
-	pid_t  l_pid;
-};
-
 #include <asm-generic/fcntl.h>
-
-#endif
diff --git a/include/asm-m32r/fcntl.h b/include/asm-m32r/fcntl.h
--- a/include/asm-m32r/fcntl.h
+++ b/include/asm-m32r/fcntl.h
@@ -1,18 +1 @@
-#ifndef _ASM_M32R_FCNTL_H
-#define _ASM_M32R_FCNTL_H
-
-#define F_GETLK64	12	/*  using 'struct flock64' */
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
-struct flock64 {
-	short  l_type;
-	short  l_whence;
-	loff_t l_start;
-	loff_t l_len;
-	pid_t  l_pid;
-};
-
 #include <asm-generic/fcntl.h>
-
-#endif  /* _ASM_M32R_FCNTL_H */
diff --git a/include/asm-m68k/fcntl.h b/include/asm-m68k/fcntl.h
--- a/include/asm-m68k/fcntl.h
+++ b/include/asm-m68k/fcntl.h
@@ -6,18 +6,6 @@
 #define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE	0400000
 
-#define F_GETLK64	12	/*  using 'struct flock64' */
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
-struct flock64 {
-	short  l_type;
-	short  l_whence;
-	loff_t l_start;
-	loff_t l_len;
-	pid_t  l_pid;
-};
-
 #include <asm-generic/fcntl.h>
 
 #endif /* _M68K_FCNTL_H */
diff --git a/include/asm-mips/fcntl.h b/include/asm-mips/fcntl.h
--- a/include/asm-mips/fcntl.h
+++ b/include/asm-mips/fcntl.h
@@ -52,15 +52,6 @@ typedef struct flock {
 	long	pad[4];
 };
 
-typedef struct flock64 {
-	short	l_type;
-	short	l_whence;
-	loff_t	l_start;
-	loff_t	l_len;
-	pid_t	l_pid;
-} flock64_t;
-
-
 #define HAVE_ARCH_STRUCT_FLOCK
 
 #endif
@@ -68,5 +59,8 @@ typedef struct flock64 {
 #include <asm-generic/fcntl.h>
 
 typedef struct flock flock_t;
+#ifndef __mips64
+typedef struct flock64 flock64_t;
+#endif
 
 #endif /* _ASM_FCNTL_H */
diff --git a/include/asm-parisc/fcntl.h b/include/asm-parisc/fcntl.h
--- a/include/asm-parisc/fcntl.h
+++ b/include/asm-parisc/fcntl.h
@@ -33,14 +33,6 @@
 #define F_WRLCK		02
 #define F_UNLCK		03
 
-struct flock64 {
-	short l_type;
-	short l_whence;
-	loff_t l_start;
-	loff_t l_len;
-	pid_t l_pid;
-};
-
 #include <asm-generic/fcntl.h>
 
 #endif
diff --git a/include/asm-ppc/fcntl.h b/include/asm-ppc/fcntl.h
--- a/include/asm-ppc/fcntl.h
+++ b/include/asm-ppc/fcntl.h
@@ -6,20 +6,6 @@
 #define O_LARGEFILE     0200000
 #define O_DIRECT	0400000	/* direct disk access hint */
 
-#ifndef __powerpc64__
-#define F_GETLK64	12	/*  using 'struct flock64' */
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
-struct flock64 {
-	short  l_type;
-	short  l_whence;
-	loff_t l_start;
-	loff_t l_len;
-	pid_t  l_pid;
-};
-#endif
-
 #include <asm-generic/fcntl.h>
 
 #endif /* _PPC_FCNTL_H */
diff --git a/include/asm-s390/fcntl.h b/include/asm-s390/fcntl.h
--- a/include/asm-s390/fcntl.h
+++ b/include/asm-s390/fcntl.h
@@ -1,27 +1 @@
-/*
- *  include/asm-s390/fcntl.h
- *
- *  S390 version
- *
- *  Derived from "include/asm-i386/fcntl.h"
- */
-#ifndef _S390_FCNTL_H
-#define _S390_FCNTL_H
-
-#ifndef __s390x__
-#define F_GETLK64	12	/*  using 'struct flock64' */
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
-struct flock64 {
-	short  l_type;
-	short  l_whence;
-	loff_t l_start;
-	loff_t l_len;
-	pid_t  l_pid;
-};
-#endif
-
 #include <asm-generic/fcntl.h>
-
-#endif
diff --git a/include/asm-sh/fcntl.h b/include/asm-sh/fcntl.h
--- a/include/asm-sh/fcntl.h
+++ b/include/asm-sh/fcntl.h
@@ -1,19 +1 @@
-#ifndef __ASM_SH_FCNTL_H
-#define __ASM_SH_FCNTL_H
-
-#define F_GETLK64	12	/*  using 'struct flock64' */
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
-struct flock64 {
-	short  l_type;
-	short  l_whence;
-	loff_t l_start;
-	loff_t l_len;
-	pid_t  l_pid;
-};
-
 #include <asm-generic/fcntl.h>
-
-#endif /* __ASM_SH_FCNTL_H */
-
diff --git a/include/asm-sh64/fcntl.h b/include/asm-sh64/fcntl.h
--- a/include/asm-sh64/fcntl.h
+++ b/include/asm-sh64/fcntl.h
@@ -1,7 +1 @@
-#ifndef __ASM_SH64_FCNTL_H
-#define __ASM_SH64_FCNTL_H
-
 #include <asm-sh/fcntl.h>
-
-#endif /* __ASM_SH64_FCNTL_H */
-
diff --git a/include/asm-sparc/fcntl.h b/include/asm-sparc/fcntl.h
--- a/include/asm-sparc/fcntl.h
+++ b/include/asm-sparc/fcntl.h
@@ -23,25 +23,13 @@
 #define F_SETLK		8
 #define F_SETLKW	9
 
-#define F_GETLK64	12	/*  using 'struct flock64' */
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
 /* for posix fcntl() and lockf() */
 #define F_RDLCK		1
 #define F_WRLCK		2
 #define F_UNLCK		3
 
-struct flock64 {
-	short l_type;
-	short l_whence;
-	loff_t l_start;
-	loff_t l_len;
-	pid_t l_pid;
-	short __unused;
-};
-
 #define __ARCH_FLOCK_PAD	short __unused;
+#define __ARCH_FLOCK64_PAD	short __unused;
 
 #include <asm-generic/fcntl.h>
 
diff --git a/include/asm-v850/fcntl.h b/include/asm-v850/fcntl.h
--- a/include/asm-v850/fcntl.h
+++ b/include/asm-v850/fcntl.h
@@ -6,18 +6,6 @@
 #define O_DIRECT       0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE    0400000
 
-#define F_GETLK64	12	/*  using 'struct flock64' */
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
-struct flock64 {
-	short  l_type;
-	short  l_whence;
-	loff_t l_start;
-	loff_t l_len;
-	pid_t  l_pid;
-};
-
 #include <asm-generic/fcntl.h>
 
 #endif /* __V850_FCNTL_H__ */
diff --git a/include/asm-xtensa/fcntl.h b/include/asm-xtensa/fcntl.h
--- a/include/asm-xtensa/fcntl.h
+++ b/include/asm-xtensa/fcntl.h
@@ -54,6 +54,7 @@ struct flock64 {
 };
 
 #define HAVE_ARCH_STRUCT_FLOCK
+#define HAVE_ARCH_STRUCT_FLOCK64
 
 #include <asm-generic/fcntl.h>
 
