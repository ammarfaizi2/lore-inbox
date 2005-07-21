Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbVGUKWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbVGUKWE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 06:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVGUKV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 06:21:28 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:25052 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261740AbVGUKV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 06:21:26 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] v850: Define L1_CACHE_SHIFT and L1_CACHE_SHIFT_MAX
Cc: linux-kernel@vger.kernel.org
From: Miles Bader <miles@gnu.org>
Message-Id: <20050721102122.0D0563AB@mctpc71>
Date: Thu, 21 Jul 2005 19:21:22 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Miles Bader <miles@gnu.org>

 include/asm-v850/cache.h        |    7 +++++--
 include/asm-v850/v850e2_cache.h |    5 +++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff -ruN -X../cludes linux-2.6.12-uc0/include/asm-v850/cache.h linux-2.6.12-uc0-v850-20050721/include/asm-v850/cache.h
--- linux-2.6.12-uc0/include/asm-v850/cache.h	2002-11-05 11:25:31.839784000 +0900
+++ linux-2.6.12-uc0-v850-20050721/include/asm-v850/cache.h	2005-07-21 15:21:07.336901000 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/cache.h -- Cache operations
  *
- *  Copyright (C) 2001  NEC Corporation
- *  Copyright (C) 2001  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,05  NEC Corporation
+ *  Copyright (C) 2001,05  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -20,6 +20,9 @@
 #ifndef L1_CACHE_BYTES
 /* This processor has no cache, so just choose an arbitrary value.  */
 #define L1_CACHE_BYTES		16
+#define L1_CACHE_SHIFT		4
 #endif
 
+#define L1_CACHE_SHIFT_MAX	L1_CACHE_SHIFT
+
 #endif /* __V850_CACHE_H__ */
diff -ruN -X../cludes linux-2.6.12-uc0/include/asm-v850/v850e2_cache.h linux-2.6.12-uc0-v850-20050721/include/asm-v850/v850e2_cache.h
--- linux-2.6.12-uc0/include/asm-v850/v850e2_cache.h	2003-07-28 10:14:26.472851000 +0900
+++ linux-2.6.12-uc0-v850-20050721/include/asm-v850/v850e2_cache.h	2005-07-21 15:19:05.917798000 +0900
@@ -2,8 +2,8 @@
  * include/asm-v850/v850e2_cache_cache.h -- Cache control for V850E2
  * 	cache memories
  *
- *  Copyright (C) 2003  NEC Electronics Corporation
- *  Copyright (C) 2003  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2003,05  NEC Electronics Corporation
+ *  Copyright (C) 2003,05  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -69,6 +69,7 @@
 
 /* For <asm/cache.h> */
 #define L1_CACHE_BYTES			V850E2_CACHE_LINE_SIZE
+#define L1_CACHE_SHIFT			V850E2_CACHE_LINE_SIZE_BITS
 
 
 #endif /* __V850_V850E2_CACHE_H__ */
