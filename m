Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289331AbSBEBCZ>; Mon, 4 Feb 2002 20:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289324AbSBEBCE>; Mon, 4 Feb 2002 20:02:04 -0500
Received: from bs1.dnx.de ([213.252.143.130]:50089 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S289320AbSBEBB5>;
	Mon, 4 Feb 2002 20:01:57 -0500
Date: Tue, 5 Feb 2002 02:01:18 +0100 (CET)
From: Robert Schwebel <robert@schwebel.de>
X-X-Sender: <robert@callisto.local>
Reply-To: <robert@schwebel.de>
To: <marcelo@conectiva.com.br>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Elan bugfixes
Message-ID: <Pine.LNX.4.33.0202050155330.18686-100000@callisto.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

here are two quick bugfix chunks from the AMD Elan patch against
2.4.18-pre8. Please apply - thanks.

Robert

----------8<----------

diff -urN -X kernel-patches/dontdiff linux-2.4.18-pre7/arch/i386/config.in linux-2.4.18-pre7-elan/arch/i386/config.in
--- linux-2.4.18-pre7/arch/i386/config.in	Thu Jan 24 07:36:14 2002
+++ linux-2.4.18-pre7-elan/arch/i386/config.in	Tue Feb  5 01:07:31 2002
@@ -182,6 +182,10 @@
    define_bool CONFIG_X86_PAE y
 fi

+if [ "$CONFIG_MELAN" = "y" ]; then
+   define_bool CONFIG_MATH_EMULATION y
+fi
+
 bool 'Math emulation' CONFIG_MATH_EMULATION
 bool 'MTRR (Memory Type Range Register) support' CONFIG_MTRR
 bool 'Symmetric multi-processing support' CONFIG_SMP
diff -urN -X kernel-patches/dontdiff linux-2.4.18-pre7/arch/i386/kernel/setup.c linux-2.4.18-pre7-elan/arch/i386/kernel/setup.c
--- linux-2.4.18-pre7/arch/i386/kernel/setup.c	Thu Jan 24 07:36:14 2002
+++ linux-2.4.18-pre7-elan/arch/i386/kernel/setup.c	Thu Jan 24 08:51:01 2002
@@ -329,7 +329,7 @@
 	{ "dma2", 0xc0, 0xdf, IORESOURCE_BUSY },
 	{ "fpu", 0xf0, 0xff, IORESOURCE_BUSY }
 };
-#ifdef CONFIG_ELAN
+#ifdef CONFIG_MELAN
 standard_io_resources[1] = { "pic1", 0x20, 0x21, IORESOURCE_BUSY };
 standard_io_resources[5] = { "pic2", 0xa0, 0xa1, IORESOURCE_BUSY };
 #endif

----------8<----------
--
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+

