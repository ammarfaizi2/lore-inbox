Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273693AbRIXFjm>; Mon, 24 Sep 2001 01:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273709AbRIXFj3>; Mon, 24 Sep 2001 01:39:29 -0400
Received: from [63.227.221.253] ([63.227.221.253]:41201 "HELO
	keithp-129.keithp.com") by vger.kernel.org with SMTP
	id <S273693AbRIXFjN>; Mon, 24 Sep 2001 01:39:13 -0400
X-Mailer: exmh version 2.3.1 03/08/2001 with version: MH 6.8.4 #23[UCI]
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Cc: keithp@keithp.com
Subject: aironet4500_card driver uses __devinitdata w/o init.h
From: Keith Packard <keithp@keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 23 Sep 2001 22:39:04 -0700
Message-Id: <20010924053906.2F8D489E98@keithp-129.keithp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was just trying to build drivers/net/aironet4500_card.c.  It failed 
because the driver uses __devinitdata but didn't bother to include <linux/
init.h> where that macro is defined.

I almost feel like saying "First Post", but I doubt that I am...

keithp@keithp.com	 XFree86 Core Team		SuSE, Inc.


diff -u orig/linux/drivers/net/aironet4500_card.c linux/drivers/net/aironet4500_card.c
--- orig/linux/drivers/net/aironet4500_card.c	Mon Sep 17 22:52:35 2001
+++ linux/drivers/net/aironet4500_card.c	Sun Sep 23 22:24:19 2001
@@ -28,6 +28,7 @@
 #include <linux/timer.h>
 #include <linux/interrupt.h>
 #include <linux/in.h>
+#include <linux/init.h>
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/bitops.h>



