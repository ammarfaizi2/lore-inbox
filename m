Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281291AbRKLG70>; Mon, 12 Nov 2001 01:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281292AbRKLG7R>; Mon, 12 Nov 2001 01:59:17 -0500
Received: from [196.28.7.2] ([196.28.7.2]:14770 "HELO netfinity.realnet.co.sz")
	by vger.kernel.org with SMTP id <S281291AbRKLG7G>;
	Mon, 12 Nov 2001 01:59:06 -0500
Date: Mon, 12 Nov 2001 09:08:45 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] trivial patch to support for "ACPI" keys in pc_keyb.c
Message-ID: <Pine.LNX.4.33.0111120858430.1901-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know this should normally be done with setkeycodes but it seems pretty
harmless to have them in pc_keyb.c and doesn't stomp (i think) on any of
the other entries. I have these keys on both my BTC keyboards and some
noname brand keyboards too and they seem to correspond to the proper keys.

Diffed against 2.4.13-ac7 but i think it should apply cleanly to newer
kernels.

Regards,
	Zwane Mwaikambo

--- pc_keyb.c.orig	Sat Nov 10 19:22:08 2001
+++ pc_keyb.c	Sat Nov 10 19:50:29 2001
@@ -207,6 +207,10 @@

 /* BTC */
 #define E0_MACRO   112
+#define E0_PWROFF  113
+#define E0_SLEEP   114
+#define E0_WKUP    115
+
 /* LK450 */
 #define E0_F13     113
 #define E0_F14     114
@@ -241,8 +245,8 @@
   E0_DO, E0_F17, 0, 0, 0, 0, E0_BREAK, E0_HOME,	      /* 0x40-0x47 */
   E0_UP, E0_PGUP, 0, E0_LEFT, E0_OK, E0_RIGHT, E0_KPMINPLUS, E0_END,/* 0x48-0x4f */
   E0_DOWN, E0_PGDN, E0_INS, E0_DEL, 0, 0, 0, 0,	      /* 0x50-0x57 */
-  0, 0, 0, E0_MSLW, E0_MSRW, E0_MSTM, 0, 0,	      /* 0x58-0x5f */
-  0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x60-0x67 */
+  0, 0, 0, E0_MSLW, E0_MSRW, E0_MSTM, E0_PWROFF, E0_SLEEP, /* 0x58-0x5f */
+  0, 0, 0, E0_WKUP, 0, 0, 0, 0,			      /* 0x60-0x67 */
   0, 0, 0, 0, 0, 0, 0, E0_MACRO,		      /* 0x68-0x6f */
   0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x70-0x77 */
   0, 0, 0, 0, 0, 0, 0, 0			      /* 0x78-0x7f */

