Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVGKJZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVGKJZG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 05:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVGKJZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 05:25:06 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:28117 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261409AbVGKJZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 05:25:04 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] v850: Update checksum.h to match changed function signatures
Cc: linux-kernel@vger.kernel.org
From: Miles Bader <miles@gnu.org>
Message-Id: <20050711092450.52815625@mctpc71>
Date: Mon, 11 Jul 2005 18:24:50 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Miles Bader <miles@gnu.org>

 arch/v850/lib/checksum.c    |    3 ++-
 include/asm-v850/checksum.h |   11 ++++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff -ruN -X../cludes linux-2.6.11-uc0/arch/v850/lib/checksum.c linux-2.6.11-uc0-v850-20050711/arch/v850/lib/checksum.c
--- linux-2.6.11-uc0/arch/v850/lib/checksum.c	2005-03-04 11:31:28.747099000 +0900
+++ linux-2.6.11-uc0-v850-20050711/arch/v850/lib/checksum.c	2005-07-11 13:05:36.844263000 +0900
@@ -138,7 +138,8 @@
  * Copy from userspace and compute checksum.  If we catch an exception
  * then zero the rest of the buffer.
  */
-unsigned int csum_partial_copy_from_user (const unsigned char *src, unsigned char *dst,
+unsigned int csum_partial_copy_from_user (const unsigned char *src,
+					  unsigned char *dst,
                                           int len, unsigned int sum,
                                           int *err_ptr)
 {
diff -ruN -X../cludes linux-2.6.11-uc0/include/asm-v850/checksum.h linux-2.6.11-uc0-v850-20050711/include/asm-v850/checksum.h
--- linux-2.6.11-uc0/include/asm-v850/checksum.h	2002-11-05 11:25:31.859782000 +0900
+++ linux-2.6.11-uc0-v850-20050711/include/asm-v850/checksum.h	2005-07-11 13:06:31.973753000 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/checksum.h -- Checksum ops
  *
- *  Copyright (C) 2001  NEC Corporation
- *  Copyright (C) 2001  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,2005  NEC Corporation
+ *  Copyright (C) 2001,2005  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -36,8 +36,8 @@
  * here even more important to align src and dst on a 32-bit (or even
  * better 64-bit) boundary
  */
-extern unsigned csum_partial_copy (const char *src, char *dst, int len,
-				   unsigned sum);
+extern unsigned csum_partial_copy (const unsigned char *src,
+				   unsigned char *dst, int len, unsigned sum);
 
 
 /*
@@ -46,7 +46,8 @@
  * here even more important to align src and dst on a 32-bit (or even
  * better 64-bit) boundary
  */
-extern unsigned csum_partial_copy_from_user (const char *src, char *dst,
+extern unsigned csum_partial_copy_from_user (const unsigned char *src,
+					     unsigned char *dst,
 					     int len, unsigned sum,
 					     int *csum_err);
 
