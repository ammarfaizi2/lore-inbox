Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267245AbTAAPZW>; Wed, 1 Jan 2003 10:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267246AbTAAPZW>; Wed, 1 Jan 2003 10:25:22 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:19391 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267245AbTAAPZV>; Wed, 1 Jan 2003 10:25:21 -0500
Date: Wed, 1 Jan 2003 16:33:45 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] only show the ATM drivers submenu if "ATM drivers" is selected
Message-ID: <20030101153345.GB15200@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial: This is a follow-up to your "Gigabit Ethernet submenu" precedent.

Only show the ATM drivers submenu if the ATM drivers entry is selected.

-- 
Tomas Szepe <szepe@pinerecords.com>

diff -urN a/drivers/atm/Kconfig b/drivers/atm/Kconfig
--- a/drivers/atm/Kconfig	2002-10-31 02:33:41.000000000 +0100
+++ b/drivers/atm/Kconfig	2003-01-01 16:28:07.000000000 +0100
@@ -2,8 +2,12 @@
 # ATM device configuration
 #
 
-menu "ATM drivers"
+config ATM_DRIVERS
 	depends on NETDEVICES && ATM
+	bool "ATM drivers (depends on ATM=y)"
+
+menu "ATM drivers"
+	depends on ATM_DRIVERS
 
 config ATM_TCP
 	tristate "ATM over TCP"
