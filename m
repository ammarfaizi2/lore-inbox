Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbUB2UC4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 15:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbUB2UC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 15:02:56 -0500
Received: from mx2.ngi.de ([213.191.74.84]:18644 "EHLO mx2.ngi.de")
	by vger.kernel.org with ESMTP id S262125AbUB2UCy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 15:02:54 -0500
Date: Sun, 29 Feb 2004 20:23:20 +0100
From: Richard Zidlicky <rz@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Worrisome IDE PIO transfers...
Message-ID: <20040229192320.GA20299@linux-m68k.org>
References: <4041232C.7030305@pobox.com> <200402290121.30498.bzolnier@elka.pw.edu.pl> <40413927.6010408@pobox.com> <200402290405.19067.bzolnier@elka.pw.edu.pl> <Pine.GSO.4.58.0402290950590.7483@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0402290950590.7483@waterleaf.sonytel.be>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 29, 2004 at 09:52:08AM +0100, Geert Uytterhoeven wrote:
> On Sun, 29 Feb 2004, Bartlomiej Zolnierkiewicz wrote:
> > On Sunday 29 of February 2004 01:58, Jeff Garzik wrote:
> > > > I like Alan's idea to use loopback instead of "bswap".
> > >
> > > Neat but no more zerocopy that way.  I much prefer a swap-as-you-go...
> >
> > Okay, better solution:
> >
> > - on Atari/Q40:
> >   if drive->bswap use insw/outsw instead of swapping variants
> 
> Yep, that sounds the most logical. Richard?

looks good. 

However it appears to fix only part of the problem -  we need some
logic to ensure only disk data is swapped.
Bswapping WIN_DOWNLOAD_MICROCODE data would not be very
clever I guess.

Richard
