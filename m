Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264588AbUAAUFP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264575AbUAAUEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:04:52 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.16]:42270 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S264588AbUAAUBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:01:55 -0500
Date: Thu, 1 Jan 2004 21:01:52 +0100
Message-Id: <200401012001.i01K1q6Z031739@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 349] BVME6000 RTC C99
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BVME6000 RTC: Use C99 struct initializers

--- linux-2.6.0/arch/m68k/bvme6000/rtc.c	Thu Jan  2 12:53:56 2003
+++ linux-m68k-2.6.0/arch/m68k/bvme6000/rtc.c	Sun Oct  5 12:34:20 2003
@@ -164,11 +164,10 @@
 	.release =	rtc_release,
 };
 
-static struct miscdevice rtc_dev=
-{
-	RTC_MINOR,
-	"rtc",
-	&rtc_fops
+static struct miscdevice rtc_dev = {
+	.minor =	RTC_MINOR,
+	.name =		"rtc",
+	.fops =		&rtc_fops
 };
 
 int __init rtc_DP8570A_init(void)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
