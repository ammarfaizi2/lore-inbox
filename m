Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263380AbTFTRIw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 13:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263493AbTFTRIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 13:08:23 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:8129 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263380AbTFTQ6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 12:58:11 -0400
Date: Fri, 20 Jun 2003 19:12:05 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       trivial@rustcorp.com.au, daniel.ritz@gmx.ch
Subject: Re: [2.5 patch] remove an unused variable from xirc2ps_cs.c
Message-ID: <20030620171205.GL29247@fs.tum.de>
References: <20030620001049.GI29247@fs.tum.de> <20030620050950.38D362C129@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030620050950.38D362C129@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 02:36:01PM +1000, Rusty Russell wrote:
> In message <20030620001049.GI29247@fs.tum.de> you write:
> > The platch below removes an unused variable from 
> > drivers/net/pcmcia/xirc2ps_cs.c .
> 
> Please add __attribute_used__ instead, since the author presumably
> wants the string left in.

I'd agree if the author was still active. All the changes to this 
driver in the near past weren't done by Werner Koch (dd9jn). Since 
the version isn't updated when the driver is updated and this string is 
no longer used in 2.5 (it was displayed in 2.4) I consider it quite 
obsolete.

> Cheers,
> Rusty.
> 
> > --- linux-2.5.72-mm2/drivers/net/pcmcia/xirc2ps_cs.c.old	2003-06-20 02:07:40.000000000 +0200
> > +++ linux-2.5.72-mm2/drivers/net/pcmcia/xirc2ps_cs.c	2003-06-20 02:07:55.000000000 +0200
> > @@ -225,9 +225,7 @@
> >  #else
> >  #define DEBUG(n, args...)
> >  #endif
> > -static char *version =
> > -"xirc2ps_cs.c 1.31 1998/12/09 19:32:55 (dd9jn+kvh)";
> > -	    /* !--- CVS revision */
> > +
> >  #define KDBG_XIRC KERN_DEBUG   "xirc2ps_cs: "
> >  #define KERR_XIRC KERN_ERR     "xirc2ps_cs: "
> >  #define KWRN_XIRC KERN_WARNING "xirc2ps_cs: "
> --
>   Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

