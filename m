Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267253AbTAAP7Q>; Wed, 1 Jan 2003 10:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267252AbTAAP7Q>; Wed, 1 Jan 2003 10:59:16 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:24511 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267253AbTAAP7P>; Wed, 1 Jan 2003 10:59:15 -0500
Date: Wed, 1 Jan 2003 17:07:39 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] only show the PCMCIA/CardBus submenu if "PCMCIA/CardBus support" is selected
Message-ID: <20030101160739.GD15200@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial: This is a follow-up to your "Gigabit Ethernet submenu" precedent.

Only show the PCMCIA/CardBus submenu if the PCMCIA/CardBus entry
is selected.

-- 
Tomas Szepe <szepe@pinerecords.com>

diff -urN a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
--- a/drivers/pcmcia/Kconfig	2002-10-31 02:33:50.000000000 +0100
+++ b/drivers/pcmcia/Kconfig	2003-01-01 17:03:59.000000000 +0100
@@ -5,10 +5,8 @@
 # by the integrated kernel driver.
 #
 
-menu "PCMCIA/CardBus support"
-	depends on HOTPLUG
-
 config PCMCIA
+	depends on HOTPLUG
 	tristate "PCMCIA/CardBus support"
 	---help---
 	  Say Y here if you want to attach PCMCIA- or PC-cards to your Linux
@@ -29,6 +27,9 @@
 	  and ds.o.  If you want to compile it as a module, say M here and
 	  read <file:Documentation/modules.txt>.
 
+menu "PCMCIA/CardBus support config"
+	depends on PCMCIA
+
 config CARDBUS
 	bool "CardBus support"
 	depends on PCMCIA && PCI
