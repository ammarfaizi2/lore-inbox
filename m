Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263211AbUDMIkj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 04:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263219AbUDMIi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 04:38:58 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.24]:38955 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S263226AbUDMIiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 04:38:10 -0400
Date: Tue, 13 Apr 2004 10:38:07 +0200
Message-Id: <200404130838.i3D8c75A018448@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 428] MVME16x RTC const
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MVME16x RTC: Make days_in_mo[] const

--- linux-2.6.5-rc2/arch/m68k/mvme16x/rtc.c	2004-01-21 22:03:13.000000000 +0100
+++ linux-m68k-2.6.5-rc2/arch/m68k/mvme16x/rtc.c	2004-03-28 11:58:40.000000000 +0200
@@ -33,7 +33,7 @@
 #define BCD2BIN(val) (((val)&15) + ((val)>>4)*10)
 #define BIN2BCD(val) ((((val)/10)<<4) + (val)%10)
 
-static unsigned char days_in_mo[] =
+static const unsigned char days_in_mo[] =
 {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
 
 static atomic_t rtc_ready = ATOMIC_INIT(1);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
