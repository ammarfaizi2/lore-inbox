Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267244AbTAAO2T>; Wed, 1 Jan 2003 09:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267236AbTAAO2T>; Wed, 1 Jan 2003 09:28:19 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:4799 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267244AbTAAO2S>; Wed, 1 Jan 2003 09:28:18 -0500
Date: Wed, 1 Jan 2003 15:36:42 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] only show the WAN submenu if WAN is selected
Message-ID: <20030101143642.GK14184@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial: This is a follow-up to your "Gigabit Ethernet submenu" precedent.

Only show the WAN submenu if the WAN entry is selected.

-- 
Tomas Szepe <szepe@pinerecords.com>

diff -urN a/drivers/net/wan/Kconfig b/drivers/net/wan/Kconfig
--- a/drivers/net/wan/Kconfig	2002-10-31 02:33:49.000000000 +0100
+++ b/drivers/net/wan/Kconfig	2003-01-01 15:33:21.000000000 +0100
@@ -2,10 +2,8 @@
 # wan devices configuration
 #
 
-menu "Wan interfaces"
-	depends on NETDEVICES
-
 config WAN
+	depends on NETDEVICES
 	bool "Wan interfaces support"
 	---help---
 	  Wide Area Networks (WANs), such as X.25, frame relay and leased
@@ -22,6 +20,9 @@
 
 	  If unsure, say N.
 
+menu "Wan interfaces"
+	depends on WAN
+
 # There is no way to detect a comtrol sv11 - force it modular for now.
 config HOSTESS_SV11
 	tristate "Comtrol Hostess SV-11 support"
