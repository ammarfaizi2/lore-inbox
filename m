Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267256AbTAAPsp>; Wed, 1 Jan 2003 10:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267257AbTAAPsp>; Wed, 1 Jan 2003 10:48:45 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:22207 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267256AbTAAPso>; Wed, 1 Jan 2003 10:48:44 -0500
Date: Wed, 1 Jan 2003 16:57:07 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] make CONFIG_ACPI a parent option for the ACPI submenu
Message-ID: <20030101155707.GC15200@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial: make CONFIG_ACPI a parent option for the ACPI submenu.  The submenu
will only be shown when ACPI support is enabled.

-- 
Tomas Szepe <szepe@pinerecords.com>

diff -urN a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
--- a/drivers/acpi/Kconfig	2002-12-16 07:01:47.000000000 +0100
+++ b/drivers/acpi/Kconfig	2003-01-01 16:53:48.000000000 +0100
@@ -2,8 +2,6 @@
 # ACPI Configuration
 #
 
-menu "ACPI Support"
-
 config ACPI
 	bool "ACPI Support" if X86
 	default y if IA64 && (!IA64_HP_SIM || IA64_SGI_SN)
@@ -35,6 +33,9 @@
 	  available at:
 	  <http://www.acpi.info>
 
+menu "ACPI Support configuration"
+	depends on ACPI
+
 config ACPI_HT_ONLY
 	bool "CPU Enumeration Only"
 	depends on X86 && ACPI && X86_LOCAL_APIC
