Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbSLONKN>; Sun, 15 Dec 2002 08:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266520AbSLONKM>; Sun, 15 Dec 2002 08:10:12 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:49729 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261463AbSLONKL>; Sun, 15 Dec 2002 08:10:11 -0500
Message-ID: <3DFC807C.B16C519B@cinet.co.jp>
Date: Sun, 15 Dec 2002 22:15:40 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.50-ac1-pc98smp i686)
X-Accept-Language: ja
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 addtional for 2.5.50-ac1 (20/21)
References: <3DFC50E9.656B96D0@cinet.co.jp>
Content-Type: multipart/mixed;
 boundary="------------7CF68C32861A7E03E00723F1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------7CF68C32861A7E03E00723F1
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

NEC PC-9800 subarchitecture support patch for 2.5.50-ac1 (20/21)
This patch support on-board modem of PC98.

diffstat:
 drivers/serial/8250_pnp.c |    5 +++++
 1 files changed, 5 insertions(+)

Regards,
Osamu Tomita
--------------7CF68C32861A7E03E00723F1
Content-Type: text/plain; charset=iso-2022-jp;
 name="serial-pnp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="serial-pnp.patch"

diff -urN linux/drivers/serial/8250_pnp.c linux98/drivers/serial/8250_pnp.c
--- linux/drivers/serial/8250_pnp.c	2002-12-11 13:10:07.000000000 +0900
+++ linux98/drivers/serial/8250_pnp.c	2002-12-11 13:16:51.000000000 +0900
@@ -188,6 +188,8 @@
 	{	"MVX00A1",		0	},
 	/* PC Rider K56 Phone System PnP */
 	{	"MVX00F2",		0	},
+	/* NEC 98NOTE SPEAKER PHONE FAX MODEM(33600bps) */
+	{	"nEC8241",		0	},
 	/* Pace 56 Voice Internal Plug & Play Modem */
 	{	"PMC2430",		0	},
 	/* Generic */
@@ -373,6 +375,9 @@
 			    ((port->min == 0x2f8) ||
 			     (port->min == 0x3f8) ||
 			     (port->min == 0x2e8) ||
+#ifdef CONFIG_PC9800
+			     (port->min == 0x8b0) ||
+#endif
 			     (port->min == 0x3e8)))
 				return 0;
 	}

--------------7CF68C32861A7E03E00723F1--

