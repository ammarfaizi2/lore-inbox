Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268108AbTBWJm1>; Sun, 23 Feb 2003 04:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268107AbTBWJlG>; Sun, 23 Feb 2003 04:41:06 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:48256 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S268105AbTBWJkZ>; Sun, 23 Feb 2003 04:40:25 -0500
Date: Sun, 23 Feb 2003 18:47:27 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] PC-9800 subarch. support for 2.5.62-AC1 (9/21) kconfig
Message-ID: <20030223094727.GJ1324@yuzuki.cinet.co.jp>
References: <20030223092116.GA1324@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030223092116.GA1324@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is additional patch to support NEC PC-9800 subarchitecture
against 2.5.62-ac1. (9/21)

Add selection CONFIG_X86_PC9800.

Regards,
Osamu Tomita

diff -Nru linux-2.5.61-ac1/arch/i386/Kconfig linux98-2.5.61/arch/i386/Kconfig
--- linux-2.5.61-ac1/arch/i386/Kconfig	2003-02-21 10:00:45.000000000 +0900
+++ linux98-2.5.61/arch/i386/Kconfig	2003-02-21 11:05:35.000000000 +0900
@@ -75,6 +75,12 @@
 
 	  If you don't have one of these computers, you should say N here.
 
+config X86_PC9800
+	bool "PC-9800 (NEC)"
+	help
+	  To make kernel for NEC PC-9801/PC-9821 sub-architecture, say Y.
+	  If say Y, kernel works -ONLY- on PC-9800 architecture.
+
 config X86_BIGSMP
 	bool "Support for other sub-arch SMP systems with more than 8 CPUs"
 	help
@@ -1207,7 +1213,7 @@
 
 config EISA
 	bool "EISA support"
-	depends on ISA
+	depends on ISA && !X86_PC9800
 	---help---
 	  The Extended Industry Standard Architecture (EISA) bus was
 	  developed as an open alternative to the IBM MicroChannel bus.
@@ -1225,7 +1231,7 @@
 
 config MCA
 	bool "MCA support"
-	depends on !(X86_VISWS || X86_VOYAGER)
+	depends on !(X86_VISWS || X86_VOYAGER || X86_PC9800)
 	help
 	  MicroChannel Architecture is found in some IBM PS/2 machines and
 	  laptops.  It is a bus system similar to PCI or ISA. See
