Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262846AbTCWGg6>; Sun, 23 Mar 2003 01:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262854AbTCWGg6>; Sun, 23 Mar 2003 01:36:58 -0500
Received: from yuzuki.cinet.co.jp ([61.197.228.219]:35200 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S262846AbTCWGgz>; Sun, 23 Mar 2003 01:36:55 -0500
Date: Sun, 23 Mar 2003 15:47:05 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.65-ac3] Updates for PC-9800 related (4/5) NIC
Message-ID: <20030323064705.GD2851@yuzuki.cinet.co.jp>
References: <20030323063207.GA2803@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030323063207.GA2803@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the update patch for NEC PC-9800 subarchitecture related files
against 2.5.65-ac3. (4/5)

Update network card patch.
Remove duplicated C-bus cards entry from Kconfig.

Regards,
Osamu Tomita

diff -Nru linux-2.5.65-ac3/drivers/net/Kconfig linux98-2.5.65-ac3/drivers/net/Kconfig
--- linux-2.5.65-ac3/drivers/net/Kconfig	2003-03-23 11:47:15.000000000 +0900
+++ linux98-2.5.65-ac3/drivers/net/Kconfig	2003-03-23 11:56:18.000000000 +0900
@@ -1225,55 +1225,6 @@
 	bool "NEC PC-9801-108 Support"
 	depends on NE2K_CBUS
 
-config NET_CBUS
-	bool "NEC PC-9800 C-bus cards"
-	depends on NET_ETHERNET && ISA && X86_PC9800
-	---help---
-	  If your network (Ethernet) card hasn't been mentioned yet and its
-	  bus system (that's the way the cards talks to the other components
-	  of your computer) is NEC PC-9800 C-Bus, say Y.
-
-config NE2K_CBUS
-	tristate "Most NE2000-based Ethernet support"
-	depends on NET_CBUS
-
-config NE2K_CBUS_EGY98
-	bool "Melco EGY-98 support"
-	depends on NE2K_CBUS
-
-config NE2K_CBUS_LGY98
-	bool "Melco LGY-98 support"
-	depends on NE2K_CBUS
-
-config NE2K_CBUS_ICM
-	bool "ICM IF-27xxET support"
-	depends on NE2K_CBUS
-
-config NE2K_CBUS_IOLA98
-	bool "I-O DATA LA-98 support"
-	depends on NE2K_CBUS
-
-config NE2K_CBUS_CNET98EL
-	bool "Contec C-NET(98)E/L support"
-	depends on NE2K_CBUS
-
-config NE2K_CBUS_CNET98EL_IO_BASE
-	hex "C-NET(98)E/L I/O base address (0xaaed or 0x55ed)"
-	depends on NE2K_CBUS_CNET98EL
-	default "0xaaed"
-
-config NE2K_CBUS_ATLA98
-	bool "Allied Telesis LA-98 Support"
-	depends on NE2K_CBUS
-
-config NE2K_CBUS_BDN
-	bool "ELECOM Laneed LD-BDN[123]A Support"
-	depends on NE2K_CBUS
-
-config NE2K_CBUS_NEC108
-	bool "NEC PC-9801-108 Support"
-	depends on NE2K_CBUS
-
 config SKMC
 	tristate "SKnet MCA support"
 	depends on NET_ETHERNET && MCA
