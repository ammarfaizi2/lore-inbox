Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136534AbRD3WnV>; Mon, 30 Apr 2001 18:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136538AbRD3WnM>; Mon, 30 Apr 2001 18:43:12 -0400
Received: from pille1.addcom.de ([62.96.128.35]:54535 "HELO pille1.addcom.de")
	by vger.kernel.org with SMTP id <S136534AbRD3WnF>;
	Mon, 30 Apr 2001 18:43:05 -0400
Date: Tue, 1 May 2001 00:43:25 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] compilation warning fixes
Message-ID: <Pine.LNX.4.33.0104302329370.24511-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Newer gcc's (particularly the RH 7.0/7.1 2.96 versions) complain about
implicit declaration of the function abs, and AFAICS they're right.

What do people think about the appended patch to fix this?
(There's more users than just isdn_audio.c, that's why I added a common
header file).

--Kai

Index: linux_2_4/drivers/isdn/isdn_audio.c
diff -u linux_2_4/drivers/isdn/isdn_audio.c:1.1.1.1 linux_2_4/drivers/isdn/isdn_audio.c:1.1.1.1.26.1
--- linux_2_4/drivers/isdn/isdn_audio.c:1.1.1.1	Tue Apr 24 00:13:47 2001
+++ linux_2_4/drivers/isdn/isdn_audio.c	Mon Apr 30 21:42:11 2001
@@ -25,6 +25,7 @@
 #define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/isdn.h>
+#include <linux/stdlib.h>
 #include "isdn_audio.h"
 #include "isdn_common.h"

Index: linux_2_4/include/linux/stdlib.h
diff -u /dev/null linux_2_4/include/linux/stdlib.h:1.1.4.3
--- /dev/null	Mon Apr 30 23:28:11 2001
+++ linux_2_4/include/linux/stdlib.h	Mon Apr 30 23:27:46 2001
@@ -0,0 +1,6 @@
+#ifndef __STDLIB_H__
+#define __STDLIB_H__
+
+extern int abs (int i);
+
+#endif



