Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264121AbTCXGVt>; Mon, 24 Mar 2003 01:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264123AbTCXGVt>; Mon, 24 Mar 2003 01:21:49 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:48059 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S264121AbTCXGVs>;
	Mon, 24 Mar 2003 01:21:48 -0500
Date: Mon, 24 Mar 2003 17:32:52 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH][COMPAT] fix typo in compat_ptr
Message-Id: <20030324173252.09a23c0f.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry about this Linus.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.65-2003032309-32bit.2/include/asm-parisc/compat.h 2.5.65-2003032309-32bit.2a/include/asm-parisc/compat.h
--- 2.5.65-2003032309-32bit.2/include/asm-parisc/compat.h	2003-03-24 14:25:45.000000000 +1100
+++ 2.5.65-2003032309-32bit.2a/include/asm-parisc/compat.h	2003-03-24 17:28:24.000000000 +1100
@@ -112,7 +112,7 @@
  */
 typedef	u32		compat_uptr_t;
 
-static inline void *compat_ptr(compat_ptr_t uptr)
+static inline void *compat_ptr(compat_uptr_t uptr)
 {
 	return (void *)uptr;
 }
diff -ruN 2.5.65-2003032309-32bit.2/include/asm-ppc64/compat.h 2.5.65-2003032309-32bit.2a/include/asm-ppc64/compat.h
--- 2.5.65-2003032309-32bit.2/include/asm-ppc64/compat.h	2003-03-24 14:25:45.000000000 +1100
+++ 2.5.65-2003032309-32bit.2a/include/asm-ppc64/compat.h	2003-03-24 17:28:33.000000000 +1100
@@ -106,7 +106,7 @@
  */
 typedef	u32		compat_uptr_t;
 
-static inline void *compat_ptr(compat_ptr_t uptr)
+static inline void *compat_ptr(compat_uptr_t uptr)
 {
 	return (void *)uptr;
 }
diff -ruN 2.5.65-2003032309-32bit.2/include/asm-s390x/compat.h 2.5.65-2003032309-32bit.2a/include/asm-s390x/compat.h
--- 2.5.65-2003032309-32bit.2/include/asm-s390x/compat.h	2003-03-24 14:25:45.000000000 +1100
+++ 2.5.65-2003032309-32bit.2a/include/asm-s390x/compat.h	2003-03-24 17:28:41.000000000 +1100
@@ -109,7 +109,7 @@
  */
 typedef	u32		compat_uptr_t;
 
-static inline void *compat_ptr(compat_ptr_t uptr)
+static inline void *compat_ptr(compat_uptr_t uptr)
 {
 	return (void *)(uptr & 0x7fffffffUL);
 }
diff -ruN 2.5.65-2003032309-32bit.2/include/asm-sparc64/compat.h 2.5.65-2003032309-32bit.2a/include/asm-sparc64/compat.h
--- 2.5.65-2003032309-32bit.2/include/asm-sparc64/compat.h	2003-03-24 14:25:45.000000000 +1100
+++ 2.5.65-2003032309-32bit.2a/include/asm-sparc64/compat.h	2003-03-24 17:28:48.000000000 +1100
@@ -108,7 +108,7 @@
  */
 typedef	u32		compat_uptr_t;
 
-static inline void *compat_ptr(compat_ptr_t uptr)
+static inline void *compat_ptr(compat_uptr_t uptr)
 {
 	return (void *)uptr;
 }
diff -ruN 2.5.65-2003032309-32bit.2/include/asm-x86_64/compat.h 2.5.65-2003032309-32bit.2a/include/asm-x86_64/compat.h
--- 2.5.65-2003032309-32bit.2/include/asm-x86_64/compat.h	2003-03-24 14:25:45.000000000 +1100
+++ 2.5.65-2003032309-32bit.2a/include/asm-x86_64/compat.h	2003-03-24 17:28:55.000000000 +1100
@@ -115,7 +115,7 @@
  */
 typedef	u32		compat_uptr_t;
 
-static inline void *compat_ptr(compat_ptr_t uptr)
+static inline void *compat_ptr(compat_uptr_t uptr)
 {
 	return (void *)uptr;
 }
