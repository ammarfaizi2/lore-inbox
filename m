Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264788AbTFUOpx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 10:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264797AbTFUOpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 10:45:53 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:11150 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264788AbTFUOpw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 10:45:52 -0400
Date: Sat, 21 Jun 2003 16:59:38 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>, perex@suse.cz,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Isapnp warning
In-Reply-To: <1056198688.25975.25.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.GSO.4.21.0306211658470.869-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Jun 2003, Alan Cox wrote:
> On Sul, 2003-06-15 at 19:36, Geert Uytterhoeven wrote:
> > Isapnp: Kill warning if CONFIG_PCI is not set
> > 
> > --- linux-2.5.x/drivers/pnp/resource.c	Tue May 27 19:03:04 2003
> > +++ linux-m68k-2.5.x/drivers/pnp/resource.c	Sun Jun  8 13:31:20 2003
> > @@ -97,7 +97,9 @@
> >  
> >  int pnp_add_irq_resource(struct pnp_dev *dev, int depnum, struct pnp_irq *data)
> >  {
> > +#ifdef CONFIG_PCI
> >  	int i;
> > +#endif
> 
> This is far uglier than te warning

It depends on your goals. These warnings distract us from the real harmful
warnings. Will we ever have a kernel that compiles with -Werror?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

