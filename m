Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbUKMXku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbUKMXku (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 18:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbUKMXiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 18:38:52 -0500
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:27038
	"EHLO zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261205AbUKMX1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 18:27:19 -0500
Message-ID: <41969843.50407@ppp0.net>
Date: Sun, 14 Nov 2004 00:26:59 +0100
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040926 Thunderbird/0.8 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
CC: linux-parport@lists.infradead.org
Subject: [PATCH] parport module_param conversion
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

module_param conversion for newly introduced MODULE_PARM
in parport_pc.
Also convert some consts which aren't const

Signed-off-by: Jan Dittmer <jdittmer@ppp0.net>

diff -Nru a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
--- a/drivers/parport/parport_pc.c	2004-11-14 00:21:38 +01:00
+++ b/drivers/parport/parport_pc.c	2004-11-14 00:21:38 +01:00
@@ -3172,9 +3172,9 @@
 }

 #ifdef MODULE
-static const char *irq[PARPORT_PC_MAX_PORTS];
-static const char *dma[PARPORT_PC_MAX_PORTS];
-static const char *init_mode;
+static char *irq[PARPORT_PC_MAX_PORTS];
+static char *dma[PARPORT_PC_MAX_PORTS];
+static char *init_mode;

 MODULE_PARM_DESC(io, "Base I/O address (SPP regs)");
 module_param_array(io, int, NULL, 0);
@@ -3190,7 +3190,7 @@
 module_param(verbose_probing, int, 0644);
 #endif
 MODULE_PARM_DESC(init_mode, "Initialise mode for VIA VT8231 port (spp, ps2, epp, ecp or ecpepp)");
-MODULE_PARM(init_mode, "s");
+module_param(init_mode, charp, 0);

 static int __init parse_parport_params(void)
 {
