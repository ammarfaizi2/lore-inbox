Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbUB2IxB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 03:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbUB2IxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 03:53:01 -0500
Received: from witte.sonytel.be ([80.88.33.193]:39328 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262019AbUB2Iw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 03:52:56 -0500
Date: Sun, 29 Feb 2004 09:52:08 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Richard Zidlicky <rz@linux-m68k.org>
cc: Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Worrisome IDE PIO transfers...
In-Reply-To: <200402290405.19067.bzolnier@elka.pw.edu.pl>
Message-ID: <Pine.GSO.4.58.0402290950590.7483@waterleaf.sonytel.be>
References: <4041232C.7030305@pobox.com> <200402290121.30498.bzolnier@elka.pw.edu.pl>
 <40413927.6010408@pobox.com> <200402290405.19067.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Feb 2004, Bartlomiej Zolnierkiewicz wrote:
> On Sunday 29 of February 2004 01:58, Jeff Garzik wrote:
> > > I like Alan's idea to use loopback instead of "bswap".
> >
> > Neat but no more zerocopy that way.  I much prefer a swap-as-you-go...
>
> Okay, better solution:
>
> - on Atari/Q40:
>   if drive->bswap use insw/outsw instead of swapping variants

Yep, that sounds the most logical. Richard?

> - on others:
>   use device mapper as suggested by Matt Mackall
>   (no extra copying and you can use DMA to read disk from TiVo!)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
