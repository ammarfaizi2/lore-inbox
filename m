Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbTFOTAJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 15:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbTFOTAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 15:00:01 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.20]:34326 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S262703AbTFOS7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 14:59:53 -0400
Date: Sun, 15 Jun 2003 21:10:32 +0200
Message-Id: <200306151910.h5FJAWqg008598@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, perex@suse.cz
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Isapnp warning
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Isapnp: Kill warning if CONFIG_PCI is not set

--- linux-2.4.x/drivers/pnp/isapnp.c	Sat Aug 17 14:10:39 2002
+++ linux-m68k-2.4.x/drivers/pnp/isapnp.c	Fri Jun  6 12:27:42 2003
@@ -510,7 +510,9 @@
                                                int dependent, int size)
 {
 	unsigned char tmp[3];
+#ifdef CONFIG_PCI
 	int i;
+#endif
 	struct isapnp_irq *irq, *ptr;
 
 	isapnp_peek(tmp, size);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
