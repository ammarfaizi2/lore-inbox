Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264188AbTCXNBZ>; Mon, 24 Mar 2003 08:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264189AbTCXNBY>; Mon, 24 Mar 2003 08:01:24 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:18304 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S264188AbTCXNBV>; Mon, 24 Mar 2003 08:01:21 -0500
Date: Mon, 24 Mar 2003 22:11:32 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2.5.65-ac4] Complete support for PC-9800 sub-arch (6/9) kconfig
Message-ID: <20030324131132.GF2508@yuzuki.cinet.co.jp>
References: <20030324130025.GA2465@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030324130025.GA2465@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patch to support NEC PC-9800 subarchitecture
against 2.5.65-ac4. (6/9)

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
