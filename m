Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbTI1NSb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 09:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbTI1NHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 09:07:42 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:36124 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S262564AbTI1NGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 09:06:10 -0400
Date: Sun, 28 Sep 2003 14:55:28 +0200
Message-Id: <200309281255.h8SCtSTp005564@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 315] Amiga A2091 SCSI is broken
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amiga A2091 SCSI is broken (needs SCSI device list updates and
a2091_bus_reset())

--- linux-2.6.0-test6/drivers/scsi/Kconfig	Tue Sep  9 10:13:04 2003
+++ linux-m68k-2.6.0-test6/drivers/scsi/Kconfig	Thu Sep 18 05:14:16 2003
@@ -1552,7 +1552,7 @@
 
 config A2091_SCSI
 	tristate "A2091/A590 WD33C93A support"
-	depends on ZORRO && SCSI
+	depends on ZORRO && SCSI && BROKEN
 	help
 	  If you have a Commodore A2091 SCSI controller, say Y. Otherwise,
 	  say N. This driver is also available as a module ( = code which can

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
