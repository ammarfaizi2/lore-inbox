Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbTLUCnC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 21:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTLUCnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 21:43:02 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:18395 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262129AbTLUCm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 21:42:57 -0500
Date: Sun, 21 Dec 2003 03:42:53 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       Rik van Riel <riel@surriel.com>, linux-tr@linuxtr.net,
       jschlst@samba.org, cgoos@syskonnect.de, mid@auk.cx, jochen@scram.de
Subject: [2.6 patch] fix some dependencies for TMS380TR=m
Message-ID: <20031221024252.GW12750@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

similar to the 2.4 patch (originally by Rik) I sent, the trivial 
patch below fixes some dependencies for TMS380TR=m .

Please apply
Adrian

--- linux-2.6.0-test11-mm1-modular-no-smp/drivers/net/tokenring/Kconfig.old	2003-12-21 03:36:12.000000000 +0100
+++ linux-2.6.0-test11-mm1-modular-no-smp/drivers/net/tokenring/Kconfig	2003-12-21 03:37:05.000000000 +0100
@@ -107,7 +107,7 @@
 
 config TMSPCI
 	tristate "Generic TMS380 PCI support"
-	depends on TR && TMS380TR!=n && PCI
+	depends on TR && TMS380TR && PCI
 	---help---
 	  This tms380 module supports generic TMS380-based PCI cards.
 
@@ -122,7 +122,7 @@
 
 config SKISA
 	tristate "SysKonnect TR4/16 ISA support"
-	depends on TR && TMS380TR!=n && ISA
+	depends on TR && TMS380TR && ISA
 	help
 	  This tms380 module supports SysKonnect TR4/16 ISA cards.
 
@@ -134,7 +134,7 @@
 
 config PROTEON
 	tristate "Proteon ISA support"
-	depends on TR && TMS380TR!=n && ISA
+	depends on TR && TMS380TR && ISA
 	help
 	  This tms380 module supports Proteon ISA cards.
 
@@ -147,7 +147,7 @@
 
 config ABYSS
 	tristate "Madge Smart 16/4 PCI Mk2 support"
-	depends on TR && TMS380TR!=n && PCI
+	depends on TR && TMS380TR && PCI
 	help
 	  This tms380 module supports the Madge Smart 16/4 PCI Mk2
 	  cards (51-02).
@@ -157,7 +157,7 @@
 
 config MADGEMC
 	tristate "Madge Smart 16/4 Ringnode MicroChannel"
-	depends on TR && TMS380TR!=n && MCA
+	depends on TR && TMS380TR && MCA
 	help
 	  This tms380 module supports the Madge Smart 16/4 MC16 and MC32
 	  MicroChannel adapters.

