Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317653AbSHCSV1>; Sat, 3 Aug 2002 14:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317639AbSHCSOE>; Sat, 3 Aug 2002 14:14:04 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11024 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317649AbSHCSMz>; Sat, 3 Aug 2002 14:12:55 -0400
To: Linus Torvalds <torvalds@transmeta.com>
CC: <linux-kernel@vger.kernel.org>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] 10: 2.5.29-wdt977
Message-Id: <E17b3Rq-0006wh-00@flint.arm.linux.org.uk>
Date: Sat, 03 Aug 2002 19:16:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has been verified to apply cleanly to 2.5.30

Bitops are used with on the timer_alive variable.  Therefore, timer_alive
needs to be "unsigned long" not "int".

 drivers/char/wdt977.c |    2 +-
 1 files changed, 1 insertion, 1 deletion

diff -urN orig/drivers/char/wdt977.c linux/drivers/char/wdt977.c
--- orig/drivers/char/wdt977.c	Sat May 25 23:13:25 2002
+++ linux/drivers/char/wdt977.c	Wed Jun 12 14:13:47 2002
@@ -39,7 +39,7 @@
 
 static	int timeout = DEFAULT_TIMEOUT*60;	/* TO in seconds from user */
 static	int timeoutM = DEFAULT_TIMEOUT;		/* timeout in minutes */
-static	int timer_alive;
+static	unsigned long timer_alive;
 static	int testmode;
 
 MODULE_PARM(timeout, "i");

