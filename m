Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262415AbTAIJiF>; Thu, 9 Jan 2003 04:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262414AbTAIJiF>; Thu, 9 Jan 2003 04:38:05 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:40324 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S262394AbTAIJiE>; Thu, 9 Jan 2003 04:38:04 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]  Include <asm/posix_types.h> in the v850's asm/stat.h
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030109094642.82859374B@mcspd15.ucom.lsi.nec.co.jp>
Date: Thu,  9 Jan 2003 18:46:42 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is needed by some includers of <asm/stat.h>.

diff -ruN -X../cludes linux-2.5.55-moo.orig/include/asm-v850/stat.h linux-2.5.55-moo/include/asm-v850/stat.h
--- linux-2.5.55-moo.orig/include/asm-v850/stat.h	2002-11-28 10:25:08.000000000 +0900
+++ linux-2.5.55-moo/include/asm-v850/stat.h	2003-01-09 14:07:36.000000000 +0900
@@ -1,6 +1,21 @@
+/*
+ * include/asm-v850/stat.h -- v850 stat structure
+ *
+ *  Copyright (C) 2001,02,03  NEC Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of this
+ * archive for more details.
+ *
+ * Written by Miles Bader <miles@gnu.org>
+ */
+
 #ifndef __V850_STAT_H__
 #define __V850_STAT_H__
 
+#include <asm/posix_types.h>
+
 struct stat {
 	__kernel_dev_t	st_dev;
 	__kernel_ino_t	st_ino;
