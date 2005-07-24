Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbVGXADj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbVGXADj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 20:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbVGXADj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 20:03:39 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:28592 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S261763AbVGXADh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 20:03:37 -0400
Message-ID: <42E2DAE0.307@m1k.net>
Date: Sat, 23 Jul 2005 20:03:44 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Subject: [-mm PATCH] v4l: hybrid dvb: move #defines to Makefile
References: <42E2DA27.9050402@krufky.com>
In-Reply-To: <42E2DA27.9050402@krufky.com>
Content-Type: multipart/mixed;
 boundary="------------040509050405010404080501"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040509050405010404080501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------040509050405010404080501
Content-Type: text/plain;
 name="v4l-dvb-02-move-defines-to-makefile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l-dvb-02-move-defines-to-makefile.patch"

This patch moves #define from cx88-dvb.c and saa7134-dvb.c into Makefile
as CFLAGS, allowing code compatability with video4linux cvs.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>

 linux/drivers/media/video/cx88/Makefile         |   12 ++++++++++++
 linux/drivers/media/video/cx88/cx88-dvb.c       |    7 ++-----
 linux/drivers/media/video/saa7134/Makefile      |    6 ++++++
 linux/drivers/media/video/saa7134/saa7134-dvb.c |    5 ++---
 4 files changed, 22 insertions(+), 8 deletions(-)

diff -u linux-2.6.13/drivers/media/video/cx88/cx88-dvb.c linux/drivers/media/video/cx88/cx88-dvb.c
--- linux-2.6.13/drivers/media/video/cx88/cx88-dvb.c	2005-07-23 19:19:52.000000000 +0000
+++ linux/drivers/media/video/cx88/cx88-dvb.c	2005-07-23 19:42:45.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-dvb.c,v 1.49 2005/07/20 05:38:09 mkrufky Exp $
+ * $Id: cx88-dvb.c,v 1.50 2005/07/23 10:08:00 mkrufky Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * MPEG Transport Stream (DVB) routines
@@ -29,11 +29,8 @@
 #include <linux/kthread.h>
 #include <linux/file.h>
 #include <linux/suspend.h>
+#include <linux/config.h>
 
-#define CONFIG_DVB_MT352 1
-#define CONFIG_DVB_CX22702 1
-#define CONFIG_DVB_OR51132 1
-#define CONFIG_DVB_LGDT3302 1
 
 #include "cx88.h"
 #include "dvb-pll.h"
diff -u linux-2.6.13/drivers/media/video/saa7134/saa7134-dvb.c linux/drivers/media/video/saa7134/saa7134-dvb.c
--- linux-2.6.13/drivers/media/video/saa7134/saa7134-dvb.c	2005-07-23 19:19:52.000000000 +0000
+++ linux/drivers/media/video/saa7134/saa7134-dvb.c	2005-07-23 19:42:45.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * $Id: saa7134-dvb.c,v 1.18 2005/07/04 16:05:50 mkrufky Exp $
+ * $Id: saa7134-dvb.c,v 1.22 2005/07/23 10:08:00 mkrufky Exp $
  *
  * (c) 2004 Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]
  *
@@ -29,9 +29,8 @@
 #include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/suspend.h>
+#include <linux/config.h>
 
-#define CONFIG_DVB_MT352 1
-#define CONFIG_DVB_TDA1004X 1
 
 #include "saa7134-reg.h"
 #include "saa7134.h"
diff -u linux-2.6.13/drivers/media/video/cx88/Makefile linux/drivers/media/video/cx88/Makefile
--- linux-2.6.13/drivers/media/video/cx88/Makefile	2005-06-17 19:48:29.000000000 +0000
+++ linux/drivers/media/video/cx88/Makefile	2005-07-23 19:42:45.000000000 +0000
@@ -9,3 +9,15 @@
 EXTRA_CFLAGS += -I$(src)/..
 EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/dvb-core
 EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/frontends
+ifneq ($(CONFIG_DVB_CX22702),n)
+ EXTRA_CFLAGS += -DCONFIG_DVB_CX22702=1
+endif
+ifneq ($(CONFIG_DVB_OR51132),n)
+ EXTRA_CFLAGS += -DCONFIG_DVB_OR51132=1
+endif
+ifneq ($(CONFIG_DVB_LGDT3302),n)
+ EXTRA_CFLAGS += -DCONFIG_DVB_LGDT3302=1
+endif
+ifneq ($(CONFIG_DVB_MT352),n)
+ EXTRA_CFLAGS += -DCONFIG_DVB_MT352=1
+endif
diff -u linux-2.6.13/drivers/media/video/saa7134/Makefile linux/drivers/media/video/saa7134/Makefile
--- linux-2.6.13/drivers/media/video/saa7134/Makefile	2005-06-17 19:48:29.000000000 +0000
+++ linux/drivers/media/video/saa7134/Makefile	2005-07-23 19:42:45.000000000 +0000
@@ -9,3 +9,9 @@
 EXTRA_CFLAGS += -I$(src)/..
 EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/dvb-core
 EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/frontends
+ifneq ($(CONFIG_DVB_MT352),n)
+ EXTRA_CFLAGS += -DCONFIG_DVB_MT352=1
+endif
+ifneq ($(CONFIG_DVB_TDA1004X),n)
+ EXTRA_CFLAGS += -DCONFIG_DVB_TDA1004X=1
+endif

--------------040509050405010404080501--
