Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318194AbSHMP6N>; Tue, 13 Aug 2002 11:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318192AbSHMP6N>; Tue, 13 Aug 2002 11:58:13 -0400
Received: from mnh-1-01.mv.com ([207.22.10.33]:52996 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S318194AbSHMP6M>;
	Tue, 13 Aug 2002 11:58:12 -0400
Message-Id: <200208131705.MAA02401@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, jdike@karaya.com
Subject: [PATCH] UML - part 1 of 3
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Aug 2002 12:05:47 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When you reverted the stringify changes I sent last time, you missed removing
a comment, which is now grossly wrong.  This patch finishes the job.

				Jeff

diff -Naur orig/include/linux/stringify.h linus/include/linux/stringify.h
--- orig/include/linux/stringify.h	Mon Aug 12 22:29:53 2002
+++ linus/include/linux/stringify.h	Tue Aug 13 11:37:18 2002
@@ -4,10 +4,6 @@
 /* Indirect stringification.  Doing two levels allows the parameter to be a
  * macro itself.  For example, compile with -DFOO=bar, __stringify(FOO)
  * converts to "bar".
- *
- * The "..." is gcc's cpp vararg macro syntax.  It is required because __ALIGN,
- * in linkage.h, contains a comma, which when expanded, causes it to look 
- * like two arguments, which breaks the standard non-vararg stringizer.
  */
 
 #define __stringify_1(x)	#x

