Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261709AbTCaQ2C>; Mon, 31 Mar 2003 11:28:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261708AbTCaQ2C>; Mon, 31 Mar 2003 11:28:02 -0500
Received: from yuzuki.cinet.co.jp ([61.197.228.219]:30336 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261707AbTCaQ17>; Mon, 31 Mar 2003 11:27:59 -0500
Date: Tue, 1 Apr 2003 01:37:55 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2.5.66-ac1] Rest of PC-9800 support (1/9) Kconfig
Message-ID: <20030331163755.GD1148@yuzuki.cinet.co.jp>
References: <20030331163404.GC1148@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030331163404.GC1148@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patch to support NEC PC-9800 subarchitecture
against 2.5.66-ac1. (1/9)

Add selection CONFIG_X86_PC9800.

Regards,
Osamu Tomita

diff -Nru linux-2.5.65-ac3/arch/i386/Kconfig linux98-2.5.65-ac3/arch/i386/Kconfig
--- linux-2.5.65-ac3/arch/i386/Kconfig	2003-03-23 16:59:02.000000000 +0900
+++ linux98-2.5.65-ac3/arch/i386/Kconfig	2003-03-23 17:01:20.000000000 +0900
@@ -104,6 +104,12 @@
 	  A kernel compiled for the Visual Workstation will not run on PCs
 	  and vice versa. See <file:Documentation/sgi-visws.txt> for details.
 
+config X86_PC9800
+	bool "PC-9800 (NEC)"
+	help
+	  To make kernel for NEC PC-9801/PC-9821 sub-architecture, say Y.
+	  If say Y, kernel works -ONLY- on PC-9800 architecture.
+
 endchoice
 
 
@@ -1090,7 +1096,7 @@
 
 config EISA
 	bool "EISA support"
-	depends on ISA
+	depends on ISA && !X86_PC9800
 	---help---
 	  The Extended Industry Standard Architecture (EISA) bus was
 	  developed as an open alternative to the IBM MicroChannel bus.
@@ -1108,7 +1114,7 @@
 
 config MCA
 	bool "MCA support"
-	depends on !(X86_VISWS || X86_VOYAGER)
+	depends on !(X86_VISWS || X86_VOYAGER || X86_PC9800)
 	help
 	  MicroChannel Architecture is found in some IBM PS/2 machines and
 	  laptops.  It is a bus system similar to PCI or ISA. See
