Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVGTIii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVGTIii (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 04:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVGTIii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 04:38:38 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:8912 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261417AbVGTIif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 04:38:35 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] v850: const-qualify first parameter of find_next_zero_bit
Cc: linux-kernel@vger.kernel.org
From: Miles Bader <miles@gnu.org>
Message-Id: <20050720083830.5941F43F@mctpc71>
Date: Wed, 20 Jul 2005 17:38:30 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Miles Bader <miles@gnu.org>

 include/asm-v850/bitops.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -ruN -X../cludes linux-2.6.12-uc0/include/asm-v850/bitops.h linux-2.6.12-uc0-v850-20050720/include/asm-v850/bitops.h
--- linux-2.6.12-uc0/include/asm-v850/bitops.h	2004-08-16 14:48:15.606748000 +0900
+++ linux-2.6.12-uc0-v850-20050720/include/asm-v850/bitops.h	2005-07-20 17:08:31.442593000 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/bitops.h -- Bit operations
  *
- *  Copyright (C) 2001,02,03,04  NEC Electronics Corporation
- *  Copyright (C) 2001,02,03,04  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03,04,05  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03,04,05  Miles Bader <miles@gnu.org>
  *  Copyright (C) 1992  Linus Torvalds.
  *
  * This file is subject to the terms and conditions of the GNU General
@@ -157,7 +157,7 @@
 #define find_first_zero_bit(addr, size) \
   find_next_zero_bit ((addr), (size), 0)
 
-extern __inline__ int find_next_zero_bit (void *addr, int size, int offset)
+extern __inline__ int find_next_zero_bit(const void *addr, int size, int offset)
 {
 	unsigned long *p = ((unsigned long *) addr) + (offset >> 5);
 	unsigned long result = offset & ~31UL;
