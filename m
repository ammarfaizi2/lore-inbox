Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263770AbTCUSmE>; Fri, 21 Mar 2003 13:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263763AbTCUSks>; Fri, 21 Mar 2003 13:40:48 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:13444
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263757AbTCUSjo>; Fri, 21 Mar 2003 13:39:44 -0500
Date: Fri, 21 Mar 2003 19:54:59 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211954.h2LJsxfq026121@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: Alpha folks said my change was wrong, revert it and note the funny
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/include/asm-alpha/core_cia.h linux-2.5.65-ac2/include/asm-alpha/core_cia.h
--- linux-2.5.65/include/asm-alpha/core_cia.h	2003-03-18 16:46:52.000000000 +0000
+++ linux-2.5.65-ac2/include/asm-alpha/core_cia.h	2003-03-18 17:09:27.000000000 +0000
@@ -293,7 +293,8 @@
 #ifdef __KERNEL__
 
 #ifndef __EXTERN_INLINE
-#define __EXTERN_INLINE static inline
+/* Do not touch, this should *NOT* be static inline */
+#define __EXTERN_INLINE extern inline
 #define __IO_EXTERN_INLINE
 #endif
 
