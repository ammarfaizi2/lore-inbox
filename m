Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbTI1NSc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 09:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262553AbTI1NHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 09:07:36 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:17722 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S262566AbTI1NGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 09:06:12 -0400
Date: Sun, 28 Sep 2003 14:55:29 +0200
Message-Id: <200309281255.h8SCtTje005576@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 317] Atari Bionet Ethernet is broken
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atari Bionet Ethernet is broken (needs netif updates and broken ACSI)

--- linux-2.6.0-test6/drivers/net/Kconfig	Tue Sep  9 10:12:56 2003
+++ linux-m68k-2.6.0-test6/drivers/net/Kconfig	Thu Sep 18 04:46:36 2003
@@ -426,7 +426,7 @@
 
 config ATARI_BIONET
 	tristate "BioNet-100 support"
-	depends on NETDEVICES && ATARI && ATARI_ACSI!=n
+	depends on NETDEVICES && ATARI && ATARI_ACSI!=n && BROKEN
 	help
 	  Say Y to include support for BioData's BioNet-100 Ethernet adapter
 	  for the ACSI port. The driver works (has to work...) with a polled

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
