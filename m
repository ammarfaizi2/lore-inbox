Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267160AbTBLOJV>; Wed, 12 Feb 2003 09:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267162AbTBLOI1>; Wed, 12 Feb 2003 09:08:27 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:47744 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267130AbTBLOHW>; Wed, 12 Feb 2003 09:07:22 -0500
Date: Wed, 12 Feb 2003 23:16:04 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 subarch. support for 2.5.60 (31/34) serial-update
Message-ID: <20030212141604.GF1551@yuzuki.cinet.co.jp>
References: <20030212131737.GA1551@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212131737.GA1551@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.60 (31/34).

Updates include/asm-i386/serial.h in 2.5.50-ac1.

- Osamu Tomita

diff -Nru linux-2.5.50-ac1/include/asm-i386/serial.h linux98-2.5.54/include/asm-i386/serial.h
--- linux-2.5.50-ac1/include/asm-i386/serial.h	2003-01-04 10:47:57.000000000 +0900
+++ linux98-2.5.54/include/asm-i386/serial.h	2003-01-04 13:41:33.000000000 +0900
@@ -50,7 +50,7 @@
 
 #define C_P(card,port) (((card)<<6|(port)<<3) + 1)
 
-#ifndef CONFIG_PC9800
+#ifndef CONFIG_X86_PC9800
 #define STD_SERIAL_PORT_DEFNS			\
 	/* UART CLK   PORT IRQ     FLAGS        */			\
 	{ 0, BASE_BAUD, 0x3F8, 4, STD_COM_FLAGS },	/* ttyS0 */	\
@@ -62,7 +62,7 @@
 	/* UART CLK   PORT IRQ     FLAGS        */			\
 	{ 0, BASE_BAUD, 0x30, 4, STD_COM_FLAGS },	/* ttyS0 */	\
 	{ 0, BASE_BAUD, 0x238, 5, STD_COM_FLAGS },	/* ttyS1 */
-#endif /* CONFIG_PC9800 */
+#endif /* CONFIG_X86_PC9800 */
 
 
 #ifdef CONFIG_SERIAL_MANY_PORTS
