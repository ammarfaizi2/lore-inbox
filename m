Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264456AbTFVJdC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 05:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264463AbTFVJdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 05:33:02 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:31722 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264456AbTFVJdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 05:33:00 -0400
Date: Sun, 22 Jun 2003 11:47:01 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@digeo.com>
cc: Samuel.Thibault@ens-lyon.fr,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Permit big console scrolls
In-Reply-To: <20030622023626.60d2a24e.akpm@digeo.com>
Message-ID: <Pine.GSO.4.21.0306221146170.869-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jun 2003, Andrew Morton wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > > -			if (get_user(lines, (char *)arg+1)) {
> >  						    ^^^^^
> >  > +			if (get_user(lines, (s32 *)((char *)arg+4))) {
> >  							    ^^^^^
> >  >  				ret = -EFAULT;
> >  >  			} else {
> >  >  				scrollfront(lines);
> > 
> >  Why was the `arg+1' changed to `arg+4'? Do we really want to skip 12 bytes?
> 
> It skips three bytes?

Oops, you're right. But my first question remains: why skip 3 bytes?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

