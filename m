Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266050AbUALC3V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 21:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266052AbUALC3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 21:29:21 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:61652 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266050AbUALC3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 21:29:16 -0500
Date: Mon, 12 Jan 2004 03:29:13 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: David Hinds <dahinds@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] simplify PARPORT_PC_PCMCIA dependencies
Message-ID: <20040112022913.GH9677@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

after looking at the 2.4 PARPORT_PC_PCMCIA dependencies, it seems the 
intention for 2.6 are what my patch below does.

Is this patch correct, or did I miss some trick in the dependencies?

cu
Adrian

--- linux-2.6.1-mm2/drivers/parport/Kconfig.old	2004-01-12 03:11:33.000000000 +0100
+++ linux-2.6.1-mm2/drivers/parport/Kconfig	2004-01-12 03:17:26.000000000 +0100
@@ -83,7 +83,7 @@
 
 config PARPORT_PC_PCMCIA
 	tristate "Support for PCMCIA management for PC-style ports"
-	depends on PARPORT!=n && HOTPLUG && (PCMCIA!=n && PARPORT_PC=m && PARPORT_PC || PARPORT_PC=y && PCMCIA)
+	depends on HOTPLUG && PCMCIA && PARPORT_PC
 	help
 	  Say Y here if you need PCMCIA support for your PC-style parallel
 	  ports. If unsure, say N.
