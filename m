Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265277AbTBTMXn>; Thu, 20 Feb 2003 07:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265275AbTBTMWb>; Thu, 20 Feb 2003 07:22:31 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:22912 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S265305AbTBTMVy>; Thu, 20 Feb 2003 07:21:54 -0500
Date: Thu, 20 Feb 2003 21:30:31 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] PC-9800 additional for 2.5.61-ac1 (9/21) kconfig
Message-ID: <20030220123031.GI1657@yuzuki.cinet.co.jp>
References: <20030220121620.GA1618@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030220121620.GA1618@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is additional patch to support NEC PC-9800 subarchitecture
against 2.5.61-ac1. (9/21)

Add selection CONFIG_X86_PC9800.

diff -Nru linux-2.5.61-ac1/arch/i386/Kconfig linux98-2.5.61/arch/i386/Kconfig
--- linux-2.5.61-ac1/arch/i386/Kconfig	2003-02-18 08:58:20.000000000 +0900
+++ linux98-2.5.61/arch/i386/Kconfig	2003-02-18 12:58:14.000000000 +0900
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
@@ -1197,7 +1203,7 @@
 
 config EISA
 	bool "EISA support"
-	depends on ISA
+	depends on ISA && !X86_PC9800
 	---help---
 	  The Extended Industry Standard Architecture (EISA) bus was
 	  developed as an open alternative to the IBM MicroChannel bus.
@@ -1215,7 +1221,7 @@
 
 config MCA
 	bool "MCA support"
-	depends on !(X86_VISWS || X86_VOYAGER)
+	depends on !(X86_VISWS || X86_VOYAGER || X86_PC9800)
 	help
 	  MicroChannel Architecture is found in some IBM PS/2 machines and
 	  laptops.  It is a bus system similar to PCI or ISA. See
