Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264745AbTIDGqY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 02:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264750AbTIDGqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 02:46:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:16771 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264745AbTIDGqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 02:46:17 -0400
Date: Wed, 3 Sep 2003 23:44:11 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: perex@suse.cz, akpm <akpm@osdl.org>
Subject: [PATCH] [sound] remove duplicate includes
Message-Id: <20030903234411.04a46050.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
Please apply to 2.6.0-current.

--
~Randy


patch_name:	sound_incdups.patch
patch_version:	2003-09-03.23:31:54
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	remove duplicate #includes in sound/
product:	Linux
product_versions: 2.6.0-test4
maintainer:	perex@suse.cz
diffstat:	=
 sound/core/ioctl32/ioctl32.c |    1 -
 sound/oss/forte.c            |    1 -
 sound/oss/nec_vrc5477.c      |    1 -
 sound/oss/rme96xx.c          |    1 -
 sound/oss/vwsnd.c            |    2 --
 5 files changed, 6 deletions(-)

diff -Naurp ./sound/oss/forte.c~incdups ./sound/oss/forte.c
--- ./sound/oss/forte.c~incdups	2003-09-03 16:33:44.000000000 -0700
+++ ./sound/oss/forte.c	2003-09-03 22:07:40.000000000 -0700
@@ -37,7 +37,6 @@
 
 #include <linux/delay.h>
 #include <linux/poll.h>
-#include <linux/kernel.h>
 
 #include <linux/sound.h>
 #include <linux/ac97_codec.h>
diff -Naurp ./sound/oss/rme96xx.c~incdups ./sound/oss/rme96xx.c
--- ./sound/oss/rme96xx.c~incdups	2003-09-03 16:33:45.000000000 -0700
+++ ./sound/oss/rme96xx.c	2003-09-03 22:08:45.000000000 -0700
@@ -54,7 +54,6 @@ TODO:
 #include <linux/smp_lock.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
-#include <asm/dma.h>
 #include <asm/hardirq.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
diff -Naurp ./sound/oss/vwsnd.c~incdups ./sound/oss/vwsnd.c
--- ./sound/oss/vwsnd.c~incdups	2003-09-03 16:34:08.000000000 -0700
+++ ./sound/oss/vwsnd.c	2003-09-03 22:09:34.000000000 -0700
@@ -158,8 +158,6 @@
 
 #ifdef VWSND_DEBUG
 
-#include <linux/interrupt.h>		/* for in_interrupt() */
-
 static int shut_up = 1;
 
 /*
diff -Naurp ./sound/oss/nec_vrc5477.c~incdups ./sound/oss/nec_vrc5477.c
--- ./sound/oss/nec_vrc5477.c~incdups	2003-09-03 16:34:29.000000000 -0700
+++ ./sound/oss/nec_vrc5477.c	2003-09-03 22:10:34.000000000 -0700
@@ -96,7 +96,6 @@
 #endif
 
 #if defined(VRC5477_AC97_DEBUG)
-#include <linux/kernel.h>
 #define ASSERT(x)  if (!(x)) { \
 	panic("assertion failed at %s:%d: %s\n", __FILE__, __LINE__, #x); }
 #else
diff -Naurp ./sound/core/ioctl32/ioctl32.c~incdups ./sound/core/ioctl32/ioctl32.c
--- ./sound/core/ioctl32/ioctl32.c~incdups	2003-09-03 16:33:23.000000000 -0700
+++ ./sound/core/ioctl32/ioctl32.c	2003-09-03 22:12:53.000000000 -0700
@@ -25,7 +25,6 @@
 #include <linux/time.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
-#include <linux/init.h>
 #include <sound/core.h>
 #include <sound/control.h>
 #include <asm/uaccess.h>
