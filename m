Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265083AbUAAUOo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264949AbUAAUGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:06:48 -0500
Received: from amsfep15-int.chello.nl ([213.46.243.28]:43063 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S264867AbUAAUCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:02:00 -0500
Date: Thu, 1 Jan 2004 21:01:58 +0100
Message-Id: <200401012001.i01K1wYm031787@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 358] Mac Sonic Ethernet
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mac Sonic Ethernet: Minor updates (from Matthias Urlichs)

--- linux-2.6.0/drivers/net/macsonic.c	Tue Jul 29 18:18:58 2003
+++ linux-m68k-2.6.0/drivers/net/macsonic.c	Mon Oct 20 21:37:23 2003
@@ -630,8 +630,7 @@
 	return macsonic_init(dev);
 }
 
 #ifdef MODULE
-static char namespace[16] = "";
 static struct net_device dev_macsonic;
 
 MODULE_PARM(sonic_debug, "i");
@@ -641,7 +639,6 @@
 int
 init_module(void)
 {
-        dev_macsonic.name = namespace;
         dev_macsonic.init = macsonic_probe;
 
         if (register_netdev(&dev_macsonic) != 0) {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
