Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263721AbTCUSdt>; Fri, 21 Mar 2003 13:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263729AbTCUScx>; Fri, 21 Mar 2003 13:32:53 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:900
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263721AbTCUSc3>; Fri, 21 Mar 2003 13:32:29 -0500
Date: Fri, 21 Mar 2003 19:47:37 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211947.h2LJlbig025971@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: PC9800 has a slight funny on 8250_pnp
Cc: rmk@arm.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/serial/8250_pnp.c linux-2.5.65-ac2/drivers/serial/8250_pnp.c
--- linux-2.5.65/drivers/serial/8250_pnp.c	2003-03-03 19:20:12.000000000 +0000
+++ linux-2.5.65-ac2/drivers/serial/8250_pnp.c	2003-03-14 01:07:59.000000000 +0000
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
+#ifdef CONFIG_X86_PC9800
+			     (port->min == 0x8b0) ||
+#endif
 			     (port->min == 0x3e8)))
 				return 0;
 	}
