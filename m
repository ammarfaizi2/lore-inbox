Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267410AbUJBRCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267410AbUJBRCm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 13:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267400AbUJBRAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 13:00:48 -0400
Received: from amsfep18-int.chello.nl ([213.46.243.13]:16972 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S267404AbUJBRA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 13:00:26 -0400
Date: Sat, 2 Oct 2004 19:00:23 +0200
Message-Id: <200410021700.i92H0Nb0021162@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 488] Atari ACSI dependencies
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atari ACSI: Correct a small problem in the dependencies of ATARI_BIONET and
ATARI_PAMSNET (e.g. ATARI_ACSI=m shouldn't allow ATARI_BIONET=y).

Signed-off-by: Adrian Bunk <bunk@fs.tum.de>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.9-rc3/drivers/net/Kconfig.old	2004-08-12 13:02:11.000000000 +0200
+++ linux-m68k-2.6.9-rc3/drivers/net/Kconfig	2004-08-12 13:02:21.000000000 +0200
@@ -391,7 +391,7 @@
 
 config ATARI_BIONET
 	tristate "BioNet-100 support"
-	depends on NETDEVICES && ATARI && ATARI_ACSI!=n && BROKEN
+	depends on NETDEVICES && ATARI && ATARI_ACSI && BROKEN
 	help
 	  Say Y to include support for BioData's BioNet-100 Ethernet adapter
 	  for the ACSI port. The driver works (has to work...) with a polled
@@ -399,7 +399,7 @@
 
 config ATARI_PAMSNET
 	tristate "PAMsNet support"
-	depends on NETDEVICES && ATARI && ATARI_ACSI!=n && BROKEN
+	depends on NETDEVICES && ATARI && ATARI_ACSI && BROKEN
 	help
 	  Say Y to include support for the PAMsNet Ethernet adapter for the
 	  ACSI port ("ACSI node"). The driver works (has to work...) with a

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
