Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbTI2Ii7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 04:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262887AbTI2IiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 04:38:02 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.20]:38229 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S262893AbTI2Ihw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 04:37:52 -0400
Date: Mon, 29 Sep 2003 10:39:09 +0200
Message-Id: <200309290839.h8T8d90s003682@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 318] Atari Pamsnet Ethernet is broken
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atari Pamsnet Ethernet is broken (needs netif updates and broken ACSI)

--- linux-2.6.0-test6/drivers/net/Kconfig	Tue Sep  9 10:12:56 2003
+++ linux-m68k-2.6.0-test6/drivers/net/Kconfig	Thu Sep 18 04:46:36 2003
@@ -434,7 +434,7 @@
 
 config ATARI_PAMSNET
 	tristate "PAMsNet support"
-	depends on NETDEVICES && ATARI && ATARI_ACSI!=n
+	depends on NETDEVICES && ATARI && ATARI_ACSI!=n && BROKEN
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
