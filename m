Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267228AbTAANiy>; Wed, 1 Jan 2003 08:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267229AbTAANiy>; Wed, 1 Jan 2003 08:38:54 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:59582 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267228AbTAANix>; Wed, 1 Jan 2003 08:38:53 -0500
Date: Wed, 1 Jan 2003 14:47:17 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] only show arcnet submenu if arcnet is selected
Message-ID: <20030101134717.GE14184@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial: This is a follow-up to your "Gigabit Ethernet submenu" precedent.

Only show the arcnet submenu if the arcnet entry is selected.

-- 
Tomas Szepe <szepe@pinerecords.com>

diff -urN a/drivers/net/arcnet/Kconfig b/drivers/net/arcnet/Kconfig
--- a/drivers/net/arcnet/Kconfig	2002-10-31 02:33:49.000000000 +0100
+++ b/drivers/net/arcnet/Kconfig	2003-01-01 14:43:32.000000000 +0100
@@ -2,10 +2,8 @@
 # Arcnet configuration
 #
 
-menu "ARCnet devices"
-	depends on NETDEVICES
-
 config ARCNET
+	depends on NETDEVICES
 	tristate "ARCnet support"
 	---help---
 	  If you have a network card of this type, say Y and check out the
@@ -27,6 +25,9 @@
 	  module, say M here and read <file:Documentation/modules.txt> as well
 	  as <file:Documentation/networking/net-modules.txt>.
 
+menu "ARCnet devices"
+	depends on ARCNET
+
 config ARCNET_1201
 	tristate "Enable standard ARCNet packet format (RFC 1201)"
 	depends on ARCNET
