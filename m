Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264591AbUAAUFM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264588AbUAAUFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:05:05 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.26]:11327 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S264594AbUAAUB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:01:57 -0500
Date: Thu, 1 Jan 2004 21:01:55 +0100
Message-Id: <200401012001.i01K1s11031757@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 352] MVME16x RTC C99
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MVME16x RTC: Use C99 struct initializers

--- linux-2.6.0/arch/m68k/mvme16x/rtc.c	Thu Jan  2 12:53:57 2003
+++ linux-m68k-2.6.0/arch/m68k/mvme16x/rtc.c	Sun Oct  5 12:34:00 2003
@@ -155,9 +155,9 @@
 
 static struct miscdevice rtc_dev=
 {
-	RTC_MINOR,
-	"rtc",
-	&rtc_fops
+	.minor =	RTC_MINOR,
+	.name =		"rtc",
+	.fops =		&rtc_fops
 };
 
 int __init rtc_MK48T08_init(void)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
