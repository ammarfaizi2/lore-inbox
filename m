Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312320AbSDEGCk>; Fri, 5 Apr 2002 01:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312321AbSDEGCb>; Fri, 5 Apr 2002 01:02:31 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:6923 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S312320AbSDEGCP>; Fri, 5 Apr 2002 01:02:15 -0500
Date: Fri, 5 Apr 2002 08:02:11 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: MartinDalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] Re: Linux-2.5.8-pre1
In-Reply-To: <3CAC2FA4.3040204@evision-ventures.com>
Message-ID: <Pine.LNX.4.33.0204050756280.22684-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here comes the patch for a stupid mistake of mine that crept into 
2.5.8-pre1 but was spotted by Martin Dalecki. 
Please apply (to cover my horrible stupidity).

Thanks,
Tim


--- linux-2.5.8-pre1/arch/cris/drivers/ethernet.c.orig	Fri Apr  5 07:42:20 2002
+++ linux-2.5.8-pre1/arch/cris/drivers/ethernet.c	Fri Apr  5 07:47:11 2002
@@ -1313,7 +1313,7 @@
 static void
 e100_clear_network_leds(unsigned long dummy)
 {
-	if (led_active && jiffies > time_after(jiffies, led_next_time)) {
+	if (led_active && time_after(jiffies, led_next_time)) {
 		e100_set_network_leds(NO_NETWORK_ACTIVITY);
 
 		/* Set the earliest time we may set the LED */

