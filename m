Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267238AbTAAOyP>; Wed, 1 Jan 2003 09:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267241AbTAAOyP>; Wed, 1 Jan 2003 09:54:15 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:10943 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267238AbTAAOyO>; Wed, 1 Jan 2003 09:54:14 -0500
Date: Wed, 1 Jan 2003 16:02:38 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] only show the NET_PCMCIA submenu if NET_PCMCIA is selected
Message-ID: <20030101150237.GM14184@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial: This is a follow-up to your "Gigabit Ethernet submenu" precedent.

Only show the NET_PCMCIA submenu if the NET_PCMCIA entry is selected.

-- 
Tomas Szepe <szepe@pinerecords.com>

diff -urN a/drivers/net/pcmcia/Kconfig b/drivers/net/pcmcia/Kconfig
--- a/drivers/net/pcmcia/Kconfig	2002-10-31 02:33:49.000000000 +0100
+++ b/drivers/net/pcmcia/Kconfig	2003-01-01 15:59:44.000000000 +0100
@@ -2,10 +2,8 @@
 # PCMCIA Network device configuration
 #
 
-menu "PCMCIA network device support"
-	depends on NETDEVICES && HOTPLUG && PCMCIA!=n
-
 config NET_PCMCIA
+	depends on NETDEVICES && HOTPLUG && PCMCIA!=n
 	bool "PCMCIA network device support"
 	---help---
 	  Say Y if you would like to include support for any PCMCIA or CardBus
@@ -21,6 +19,9 @@
 
 	  If unsure, say N.
 
+menu "PCMCIA network device support"
+	depends on NET_PCMCIA
+
 config PCMCIA_3C589
 	tristate "3Com 3c589 PCMCIA support"
 	depends on NET_PCMCIA && PCMCIA
