Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261321AbSI0Ihc>; Fri, 27 Sep 2002 04:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261326AbSI0Ihc>; Fri, 27 Sep 2002 04:37:32 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:42673 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S261321AbSI0Ihb>;
	Fri, 27 Sep 2002 04:37:31 -0400
Date: Fri, 27 Sep 2002 10:41:33 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] {read,write}s{b,w,l} or iobarrier_*()
In-Reply-To: <3D93348D.3060304@pobox.com>
Message-ID: <Pine.GSO.4.21.0209271041080.25590-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Sep 2002, Jeff Garzik wrote:
> Benjamin Herrenschmidt wrote:
> > So we have 2 solutions here (one of which I prefer, but I
> > still want the debate open here):
> > 
> >  - Have all archs provide {read,write}s{b,w,l} functions.
> > Those will hide all of the details of bytewapping & barriers
> > from the drivers and can be used as-is for things like IDE
> > MMIO iops.
> 
> I prefer this solution...
> 
> 
> >  - Have all archs provide iobarrier_* functions. Here, drivers
> > would still have to re-implement the transfer loops with
> > raw_{read,write}{b,w,l} and do proper use of iobarrier_*.
> 
> I have a tulip patch from Peter de Shivjer (sp?) that adds 

Peter De Schrijver, I assume.

> iobarrier_rw() and I think it looks ugly as sin.  I would much prefer 
> the first solution...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

