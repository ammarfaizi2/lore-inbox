Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263991AbTAANYl>; Wed, 1 Jan 2003 08:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267223AbTAANYl>; Wed, 1 Jan 2003 08:24:41 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:55486 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S263991AbTAANYk>; Wed, 1 Jan 2003 08:24:40 -0500
Date: Wed, 1 Jan 2003 14:33:04 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5: make gigabit ethernet into a real submenu
Message-ID: <20030101133304.GC14184@louise.pinerecords.com>
References: <20021231080146.GQ21097@louise.pinerecords.com> <Pine.LNX.4.44.0212311107480.2697-100000@home.transmeta.com> <20030101131925.GA14184@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030101131925.GA14184@louise.pinerecords.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial: This is a follow-up to your "Gigabit Ethernet submenu" precedent.

Only show the 10/100 Mbit Ethernet submenu if the "10/100 Mbit Ethernet"
entry is selected.

-- 
Tomas Szepe <szepe@pinerecords.com>

diff -urN a/drivers/net/Kconfig b/drivers/net/Kconfig
--- a/drivers/net/Kconfig	2003-01-01 14:10:09.000000000 +0100
+++ b/drivers/net/Kconfig	2003-01-01 14:25:27.000000000 +0100
@@ -148,10 +148,8 @@
 #	Ethernet
 #
 
-menu "Ethernet (10 or 100Mbit)"
-	depends on NETDEVICES
-
 config NET_ETHERNET
+	depends on NETDEVICES
 	bool "Ethernet (10 or 100Mbit)"
 	---help---
 	  Ethernet (also called IEEE 802.3 or ISO 8802-2) is the most common
@@ -177,6 +175,9 @@
 	  kernel: saying N will just cause the configurator to skip all
 	  the questions about Ethernet network cards. If unsure, say N.
 
+menu "Ethernet (10 or 100Mbit)"
+	depends on NET_ETHERNET
+
 config ARM_AM79C961A
 	bool "ARM EBSA110 AM79C961A support"
 	depends on NET_ETHERNET && ARM && ARCH_EBSA110
