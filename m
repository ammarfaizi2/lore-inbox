Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbUB2Qax (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 11:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbUB2Qax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 11:30:53 -0500
Received: from witte.sonytel.be ([80.88.33.193]:59540 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262068AbUB2Qaw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 11:30:52 -0500
Date: Sun, 29 Feb 2004 17:30:41 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.4-rc1
In-Reply-To: <Pine.LNX.4.58.0402271458480.1078@ppc970.osdl.org>
Message-ID: <Pine.GSO.4.58.0402291729180.7483@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0402271458480.1078@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Feb 2004, Linus Torvalds wrote:
> Ok, as usual, there was a lot of stuff for the -rc1, but as seems to be
> more and more true it is mainly in the "periphery".
>
> Andrew Morton:
>   o m68k: Amiga Hydra Ethernet new driver model

This part of the patch seems to have been lost (root_hydra_dev is no more):

--- linux-2.6.4-rc1/drivers/net/hydra.c	2004-02-29 09:32:04.000000000 +0100
+++ linux-m68k-2.6.4-rc1/drivers/net/hydra.c	2004-02-29 09:53:41.000000000 +0100
@@ -142,10 +142,6 @@
     ei_status.reg_offset = hydra_offsets;
     dev->open = &hydra_open;
     dev->stop = &hydra_close;
-#ifdef MODULE
-    ei_status.priv = (unsigned long)root_hydra_dev;
-    root_hydra_dev = dev;
-#endif
     NS8390_init(dev, 0);

     err = register_netdev(dev);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
