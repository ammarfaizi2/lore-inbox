Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263150AbUJ2Ihk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263150AbUJ2Ihk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 04:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263151AbUJ2Ihk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 04:37:40 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:22656 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S263150AbUJ2Ihf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 04:37:35 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] v850: Add definitions for memcpy_fromio and memcpy_toio
Cc: linux-kernel@vger.kernel.org
From: Miles Bader <miles@gnu.org>
Message-Id: <20041029081546.0C21F4D9@mctpc71>
Date: Fri, 29 Oct 2004 17:15:46 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Miles Bader <miles@gnu.org>

 include/asm-v850/io.h |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff -ruN -X../cludes linux-2.6.9-uc0/include/asm-v850/io.h linux-2.6.9-uc0-v850-20041028/include/asm-v850/io.h
--- linux-2.6.9-uc0/include/asm-v850/io.h	2004-02-24 18:22:54 +0900
+++ linux-2.6.9-uc0-v850-20041028/include/asm-v850/io.h	2004-10-28 13:32:47 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/io.h -- Misc I/O operations
  *
- *  Copyright (C) 2001,02,03  NEC Electronics Corporation
- *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03,04  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03,04  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -114,4 +114,7 @@
 #define phys_to_virt(addr)	((void *)__phys_to_virt (addr))
 #define virt_to_phys(addr)	((unsigned long)__virt_to_phys (addr))
 
+#define memcpy_fromio(dst, src, len) memcpy (dst, (void *)src, len)
+#define memcpy_toio(dst, src, len) memcpy ((void *)dst, src, len)
+
 #endif /* __V850_IO_H__ */
