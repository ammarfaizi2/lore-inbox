Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbTFOS3O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 14:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbTFOS14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 14:27:56 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:15165 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S262584AbTFOS0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 14:26:19 -0400
Date: Sun, 15 Jun 2003 20:36:52 +0200
Message-Id: <200306151836.h5FIaqv2008285@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>, perex@suse.cz
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Isapnp warning
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Isapnp: Kill warning if CONFIG_PCI is not set

--- linux-2.5.x/drivers/pnp/resource.c	Tue May 27 19:03:04 2003
+++ linux-m68k-2.5.x/drivers/pnp/resource.c	Sun Jun  8 13:31:20 2003
@@ -97,7 +97,9 @@
 
 int pnp_add_irq_resource(struct pnp_dev *dev, int depnum, struct pnp_irq *data)
 {
+#ifdef CONFIG_PCI
 	int i;
+#endif
 	struct pnp_resources *res;
 	struct pnp_irq *ptr;
 	res = pnp_find_resources(dev,depnum);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
