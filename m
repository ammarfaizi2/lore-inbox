Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261835AbSI2Wxc>; Sun, 29 Sep 2002 18:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261836AbSI2Wxc>; Sun, 29 Sep 2002 18:53:32 -0400
Received: from hera.cwi.nl ([192.16.191.8]:21457 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261835AbSI2Wxb>;
	Sun, 29 Sep 2002 18:53:31 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 30 Sep 2002 00:58:43 +0200 (MEST)
Message-Id: <UTC200209292258.g8TMwhH24099.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] net/Config.in
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wanted to compile a kernel with Appletalk and couldn't find it.
Upon examination of the source it turns out that since 2.5.32
Appletalk is hiding behind "ANSI/IEEE 802.2 Data link layer".

This tiny patch will make life easier for others needing IPX
or Appletalk.

Andries

--- /linux/2.5/linux-2.5.39/linux/net/Config.in	Sat Sep 21 11:39:53 2002
+++ /linux/2.5/linux-2.5.39a/linux/net/Config.in	Mon Sep 30 00:52:19 2002
@@ -47,7 +47,7 @@
 fi
 tristate '802.1Q VLAN Support' CONFIG_VLAN_8021Q
 
-tristate 'ANSI/IEEE 802.2 Data link layer protocol' CONFIG_LLC
+tristate 'ANSI/IEEE 802.2 Data link layer protocol (IPX, Appletalk)' CONFIG_LLC
 if [ "$CONFIG_LLC" != "n" ]; then
    tristate '  LLC sockets interface' CONFIG_LLC_UI
 fi
