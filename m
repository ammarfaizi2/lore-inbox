Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263774AbUDFLcC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 07:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263779AbUDFLbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 07:31:35 -0400
Received: from witte.sonytel.be ([80.88.33.193]:18819 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263774AbUDFLai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 07:30:38 -0400
Date: Tue, 6 Apr 2004 13:29:59 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@osdl.org>, Phil Blundell <Philip.Blundell@pobox.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-parport@torque.net
Subject: [PATCH] parport dependency
Message-ID: <Pine.GSO.4.58.0404061329090.4158@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


PCI multi-IO card support depends on PCI

--- linux-2.6.5/drivers/parport/Kconfig.orig	2004-02-29 09:32:22.000000000 +0100
+++ linux-2.6.5/drivers/parport/Kconfig	2004-04-01 14:47:40.000000000 +0200
@@ -54,7 +54,7 @@

 config PARPORT_SERIAL
 	tristate "Multi-IO cards (parallel and serial)"
-	depends on SERIAL_8250!=n && PARPORT_PC_CML1
+	depends on SERIAL_8250!=n && PARPORT_PC_CML1 && PCI
 	help
 	  This adds support for multi-IO PCI cards that have parallel and
 	  serial ports.  You should say Y or M here.  If you say M, the module

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
