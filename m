Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266464AbSLJBnJ>; Mon, 9 Dec 2002 20:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266473AbSLJBnJ>; Mon, 9 Dec 2002 20:43:09 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:19942 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266464AbSLJBnI>; Mon, 9 Dec 2002 20:43:08 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4.21-BK] Eliminate warning in drivers/usb/hc_sl811.c
Date: Tue, 10 Dec 2002 02:48:28 +0100
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_SORV18KJ0C2UQJL1LE0O"
Message-Id: <200212100248.28309.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_SORV18KJ0C2UQJL1LE0O
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Marcelo,

compile warning is:
 #warning linux/malloc.h is deprecated, use linux/slab.h instead.

attached patch uses linux/slab.h instead, as adviced by above ;)

ciao, Marc
--------------Boundary-00=_SORV18KJ0C2UQJL1LE0O
Content-Type: text/x-diff;
  charset="us-ascii";
  name="malloc-deprecated-slab-instead.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="malloc-deprecated-slab-instead.patch"

--- linux-old/drivers/usb/hc_sl811.c	2002-12-05 18:54:27.000000000 +0100
+++ linux-wolk/drivers/usb/hc_sl811.c	2002-12-10 02:43:44.000000000 +0100
@@ -28,7 +28,7 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/sched.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/smp_lock.h>

--------------Boundary-00=_SORV18KJ0C2UQJL1LE0O--

