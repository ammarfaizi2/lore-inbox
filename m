Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262896AbTI2Ilc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 04:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262894AbTI2Ij1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 04:39:27 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.28]:47381 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S262896AbTI2Ihx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 04:37:53 -0400
Date: Mon, 29 Sep 2003 10:39:10 +0200
Message-Id: <200309290839.h8T8dAjI003688@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 327] Macintosh SMC 9194 Ethernet is broken
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Macintosh SMC 9194 Ethernet is broken (needs NuBus I/O abstractions)

--- linux-2.6.0-test6/drivers/net/Kconfig	Fri Sep 19 15:28:22 2003
+++ linux-m68k-2.6.0-test6/drivers/net/Kconfig	Fri Sep 19 15:30:10 2003
@@ -808,7 +808,7 @@
 
 config SMC9194
 	tristate "SMC 9194 support"
-	depends on NET_VENDOR_SMC && (ISA || MAC)
+	depends on NET_VENDOR_SMC && (ISA || MAC && BROKEN)
 	select CRC32
 	---help---
 	  This is support for the SMC9xxx based Ethernet cards. Choose this

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
