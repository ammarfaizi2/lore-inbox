Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262103AbTCIENx>; Sat, 8 Mar 2003 23:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262333AbTCIENx>; Sat, 8 Mar 2003 23:13:53 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:43904 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S262103AbTCIENu>; Sat, 8 Mar 2003 23:13:50 -0500
Date: Sun, 9 Mar 2003 13:23:57 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] PC-9800 subarch. support for 2.5.64-ac3 (10/20) kconfig
Message-ID: <20030309042357.GK1231@yuzuki.cinet.co.jp>
References: <20030309035245.GA1231@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030309035245.GA1231@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patch to support NEC PC-9800 subarchitecture
against 2.5.64-ac3. (10/20)

Add selection CONFIG_X86_PC9800.

Regards,
Osamu Tomita

diff -Nru linux-2.5.64/arch/i386/Kconfig linux98-2.5.64/arch/i386/Kconfig
--- linux-2.5.64/arch/i386/Kconfig	2003-03-05 11:22:25.000000000 +0900
+++ linux98-2.5.64/arch/i386/Kconfig	2003-03-05 11:43:32.000000000 +0900
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
 
 
@@ -1073,7 +1079,7 @@
 
 config EISA
 	bool "EISA support"
-	depends on ISA
+	depends on ISA && !X86_PC9800
 	---help---
 	  The Extended Industry Standard Architecture (EISA) bus was
 	  developed as an open alternative to the IBM MicroChannel bus.
@@ -1091,7 +1097,7 @@
 
 config MCA
 	bool "MCA support"
-	depends on !(X86_VISWS || X86_VOYAGER)
+	depends on !(X86_VISWS || X86_VOYAGER || X86_PC9800)
 	help
 	  MicroChannel Architecture is found in some IBM PS/2 machines and
 	  laptops.  It is a bus system similar to PCI or ISA. See
