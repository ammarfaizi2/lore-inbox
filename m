Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263246AbUDRR6l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 13:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263552AbUDRR4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 13:56:48 -0400
Received: from witte.sonytel.be ([80.88.33.193]:2552 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263360AbUDRR4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 13:56:19 -0400
Date: Sun, 18 Apr 2004 19:55:35 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH 437] Amiga eth%d
In-Reply-To: <Pine.GSO.4.58.0404181952050.17347@waterleaf.sonytel.be>
Message-ID: <Pine.GSO.4.58.0404181954540.17347@waterleaf.sonytel.be>
References: <200404130838.i3D8cI26018497@callisto.of.borg> <407C164F.1090501@pobox.com>
 <Pine.GSO.4.58.0404181952050.17347@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Apr 2004, Geert Uytterhoeven wrote:
> On Tue, 13 Apr 2004, Jeff Garzik wrote:
> > As a further change, can you please add KERN_xxx prefixes to those printk's?
>
> Do these look OK?
>
> To: akpm, linus, jeff
> Cc: lkml
> Subject: [PATCH] Amiga A2065 Ethernet KERN_*
>
> Amiga A2065 Ethernet: Add KERN_* prefixes to printk() messages

Oops, forgot you have to apply this one first:

To: akpm, linus, jeff
Cc: lkml
Subject: [PATCH] Amiga A2065 Ethernet debug

Amiga A2065 Ethernet: Add missing variable in debug code

--- linux-2.6.6-rc1/drivers/net/a2065.c	11 Apr 2004 11:49:17 -0000	1.14
+++ linux-m68k-2.6.6-rc1/drivers/net/a2065.c	16 Apr 2004 11:36:50 -0000
@@ -274,6 +274,7 @@
 	struct sk_buff *skb = 0;	/* XXX shut up gcc warnings */

 #ifdef TEST_HITS
+	int i;
 	printk ("[");
 	for (i = 0; i < RX_RING_SIZE; i++) {
 		if (i == lp->rx_new)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
