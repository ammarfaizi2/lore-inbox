Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268077AbUIAVJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268077AbUIAVJk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 17:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267903AbUIAVJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:09:14 -0400
Received: from baikonur.stro.at ([213.239.196.228]:62180 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267893AbUIAUz4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:55:56 -0400
Subject: [patch 03/25]  drivers/char/esp.c MIN/MAX removal
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:55:55 +0200
Message-ID: <E1C2c95-0007HJ-CE@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patch (against 2.6.7) removes unnecessary min/max macros and changes
calls to use kernel.h macros instead.

Feedback is always welcome
Michael

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/drivers/char/esp.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff -puN drivers/char/esp.c~min-max-char_esp drivers/char/esp.c
--- linux-2.6.9-rc1-bk7/drivers/char/esp.c~min-max-char_esp	2004-09-01 19:33:32.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/char/esp.c	2004-09-01 19:33:32.000000000 +0200
@@ -19,7 +19,7 @@
  *
  *  rs_set_termios fixed to look also for changes of the input
  *      flags INPCK, BRKINT, PARMRK, IGNPAR and IGNBRK.
- *                                            Bernd Anhäupl 05/17/96.
+ *                                            Bernd Anhï¿½pl 05/17/96.
  *
  * --- End of notices from serial.c ---
  *
@@ -141,7 +141,7 @@ static struct esp_struct *ports;
 
 static void change_speed(struct esp_struct *info);
 static void rs_wait_until_sent(struct tty_struct *, int);
-	
+
 /*
  * The ESP card has a clock rate of 14.7456 MHz (that is, 2**ESPC_SCALE
  * times the normal 1.8432 Mhz clock of most serial boards).
@@ -151,10 +151,6 @@ static void rs_wait_until_sent(struct tt
 /* Standard COM flags (except for COM4, because of the 8514 problem) */
 #define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
 
-#ifndef MIN
-#define MIN(a,b)	((a) < (b) ? (a) : (b))
-#endif
-
 /*
  * tmp_buf is used as a temporary buffer by serial_write.  We need to
  * lock it in case the memcpy_fromfs blocks while swapping in a page,

_
