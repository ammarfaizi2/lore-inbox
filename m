Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266656AbUBFHy4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 02:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266660AbUBFHyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 02:54:55 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:16270 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S266656AbUBFHyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 02:54:53 -0500
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH][v850]  Define ARCH_HAS_*_EXTABLE macros for v850
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20040206075447.97417446@mcspd15>
Date: Fri,  6 Feb 2004 16:54:47 +0900 (JST)
From: miles@mcspd15.ucom.lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes linux-2.6.2-uc0/include/asm-v850/module.h linux-2.6.2-uc0-v850-20040206/include/asm-v850/module.h
--- linux-2.6.2-uc0/include/asm-v850/module.h	2003-01-14 10:27:07.000000000 +0900
+++ linux-2.6.2-uc0-v850-20040206/include/asm-v850/module.h	2004-02-06 14:38:36.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/module.h -- Architecture-specific module hooks
  *
- *  Copyright (C) 2001,02,03  NEC Corporation
- *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03,04  NEC Corporation
+ *  Copyright (C) 2001,02,03,04  Miles Bader <miles@gnu.org>
  *  Copyright (C) 2001,03  Rusty Russell
  *
  * This file is subject to the terms and conditions of the GNU General
@@ -50,5 +50,13 @@
 {
 	return 0;
 }
+#define ARCH_HAS_SEARCH_EXTABLE
+static inline void
+sort_extable(struct exception_table_entry *start,
+	     struct exception_table_entry *finish)
+{
+	/* nada */
+}
+#define ARCH_HAS_SORT_EXTABLE
 
 #endif /* __V850_MODULE_H__ */
