Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318253AbSHMP6Q>; Tue, 13 Aug 2002 11:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318192AbSHMP6Q>; Tue, 13 Aug 2002 11:58:16 -0400
Received: from mnh-1-01.mv.com ([207.22.10.33]:53252 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S318253AbSHMP6P>;
	Tue, 13 Aug 2002 11:58:15 -0400
Message-Id: <200208131705.MAA02410@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, jdike@karaya.com
Subject: [PATCH] UML - part 2 of 3
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Aug 2002 12:05:56 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the remaining unmerged change to generic code that UML 
needs.  It adds boot entries for the UML block device.

				Jeff

diff -Naur orig/init/do_mounts.c linus/init/do_mounts.c
--- orig/init/do_mounts.c	Thu Aug  1 20:41:01 2002
+++ linus/init/do_mounts.c	Fri Aug  2 22:04:47 2002
@@ -156,6 +156,22 @@
 	{ "pf",		0x2f00 },
 	{ "apblock", APBLOCK_MAJOR << 8},
 	{ "ddv", DDV_MAJOR << 8},
+ 	{ "ubd0", UBD_MAJOR << 8 | 0 << 4},
+ 	{ "ubda", UBD_MAJOR << 8 | 0 << 4},
+ 	{ "ubd1", UBD_MAJOR << 8 | 1 << 4},
+ 	{ "ubdb", UBD_MAJOR << 8 | 1 << 4},
+ 	{ "ubd2", UBD_MAJOR << 8 | 2 << 4},
+ 	{ "ubdc", UBD_MAJOR << 8 | 2 << 4},
+ 	{ "ubd3", UBD_MAJOR << 8 | 3 << 4},
+ 	{ "ubdd", UBD_MAJOR << 8 | 3 << 4},
+ 	{ "ubd4", UBD_MAJOR << 8 | 4 << 4},
+ 	{ "ubde", UBD_MAJOR << 8 | 4 << 4},
+ 	{ "ubd5", UBD_MAJOR << 8 | 5 << 4},
+ 	{ "ubdf", UBD_MAJOR << 8 | 5 << 4},
+ 	{ "ubd6", UBD_MAJOR << 8 | 6 << 4},
+ 	{ "ubdg", UBD_MAJOR << 8 | 6 << 4},
+ 	{ "ubd7", UBD_MAJOR << 8 | 7 << 4},
+ 	{ "ubdh", UBD_MAJOR << 8 | 7 << 4},
 	{ "jsfd",    JSFD_MAJOR << 8},
 #if defined(CONFIG_ARCH_S390)
 	{ "dasda", (DASD_MAJOR << MINORBITS) },

