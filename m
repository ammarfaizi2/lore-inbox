Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317916AbSFSP4z>; Wed, 19 Jun 2002 11:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317917AbSFSP4y>; Wed, 19 Jun 2002 11:56:54 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:65499 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317916AbSFSP4x>; Wed, 19 Jun 2002 11:56:53 -0400
Date: Wed, 19 Jun 2002 17:56:49 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Dave Jones <davej@suse.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [-dj patch] fix a tqueue.h compile error in drivers/input/keyboard/ps2serkbd.c
Message-ID: <Pine.NEB.4.44.0206191736180.10290-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

the patch below fixes two tqueue.h compile errors in files that are only
in 2.5.23-dj1 but not in 2.5.23.

cu
Adrian


--- drivers/input/keyboard/ps2serkbd.c.old	Wed Jun 19 17:35:14 2002
+++ drivers/input/keyboard/ps2serkbd.c	Wed Jun 19 17:35:34 2002
@@ -31,6 +31,7 @@
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/serio.h>
+#include <linux/tqueue.h>

 #define ATKBD_CMD_SETLEDS	0x10ed
 #define ATKBD_CMD_GSCANSET	0x11f0


--- drivers/input/keyboard/sunkbd.c.old	Wed Jun 19 17:40:58 2002
+++ drivers/input/keyboard/sunkbd.c	Wed Jun 19 17:42:14 2002
@@ -35,6 +35,7 @@
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/serio.h>
+#include <linux/tqueue.h>

 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Sun keyboard driver");


