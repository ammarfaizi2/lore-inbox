Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267237AbTAANpe>; Wed, 1 Jan 2003 08:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267238AbTAANpe>; Wed, 1 Jan 2003 08:45:34 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:62398 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267237AbTAANpd>; Wed, 1 Jan 2003 08:45:33 -0500
Date: Wed, 1 Jan 2003 14:53:57 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] only show Wireless LAN submenu if Wireless LAN is selected
Message-ID: <20030101135357.GG14184@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial: This is a follow-up to your "Gigabit Ethernet submenu" precedent.

Only show the Wireless LAN submenu if the Wireless LAN entry is selected.

-- 
Tomas Szepe <szepe@pinerecords.com>

diff -urN a/drivers/net/Kconfig b/drivers/net/Kconfig
--- a/drivers/net/Kconfig	2003-01-01 14:25:27.000000000 +0100
+++ b/drivers/net/Kconfig	2003-01-01 14:50:59.000000000 +0100
@@ -2141,11 +2141,8 @@
 	  end of the link as well. It's good enough, for example, to run IP
 	  over the async ports of a Camtec JNT Pad. If unsure, say N.
 
-
-menu "Wireless LAN (non-hamradio)"
-	depends on NETDEVICES
-
 config NET_RADIO
+	depends on NETDEVICES
 	bool "Wireless LAN (non-hamradio)"
 	---help---
 	  Support for wireless LANs and everything having to do with radio,
@@ -2168,6 +2165,9 @@
 	  special kernel support are available from
 	  <ftp://shadow.cabi.net/pub/Linux/>.
 
+menu "Wireless LAN (non-hamradio)"
+	depends on NET_RADIO
+
 config STRIP
 	tristate "STRIP (Metricom starmode radio IP)"
 	depends on NET_RADIO && INET
