Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264015AbTFUXWc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 19:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbTFUXWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 19:22:32 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:52968 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264015AbTFUXWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 19:22:30 -0400
Date: Sun, 22 Jun 2003 01:36:30 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: frible@teaser.fr, linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, jgarzik@pobox.com
Subject: Re: [2.5 patch] yam.c: return IRQ_NONE in error case
Message-ID: <20030621233630.GG23337@fs.tum.de>
References: <20030620000137.GG29247@fs.tum.de> <20030620050950.1A9A82C09A@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030620050950.1A9A82C09A@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 02:34:42PM +1000, Rusty Russell wrote:
> In message <20030620000137.GG29247@fs.tum.de> you write:
> > Please check whether the following patch to return IRQ_NONE in case of
> > errors is correct:
> > 
> > --- linux-2.5.72-mm2/drivers/net/hamradio/yam.c.old	2003-06-20 01:57:02.000000000 +0200
> > +++ linux-2.5.72-mm2/drivers/net/hamradio/yam.c	2003-06-20 01:57:41.000000000 +0200
> > @@ -742,7 +742,7 @@
> >  
> >  			if (--counter <= 0) {
> >  				printk(KERN_ERR "%s: too many irq iir=%d\n", dev->name, iir);
> > -				return;
> > +				return IRQ_NONE;
> >  			}
> 
> IRQ_HANDLED, I think: it did handle them, but decided it was
> livelocked and exited.

akpm already sent a better fix to Linus.

> Cheers,
> Rusty.

Thanks
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

