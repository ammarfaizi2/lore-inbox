Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261600AbSLAKmM>; Sun, 1 Dec 2002 05:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261609AbSLAKmM>; Sun, 1 Dec 2002 05:42:12 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:56221 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261600AbSLAKmL>;
	Sun, 1 Dec 2002 05:42:11 -0500
Date: Sun, 1 Dec 2002 11:49:07 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4 double PCI unregistration with pcigame
Message-ID: <20021201114907.A14691@ucw.cz>
References: <20021201044019.GA965@gondor.apana.org.au> <20021201110808.B14392@ucw.cz> <20021201104502.GA19773@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021201104502.GA19773@gondor.apana.org.au>; from herbert@gondor.apana.org.au on Sun, Dec 01, 2002 at 09:45:02PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 01, 2002 at 09:45:02PM +1100, Herbert Xu wrote:

> On Sun, Dec 01, 2002 at 11:08:08AM +0100, Vojtech Pavlik wrote:
> >
> > I think the proper solution would be:
> 
> This wouldn't work since trident.o requires pcigame.o to work even
> though the latter may not discover any devices on its own.  That's
> why that comment is there.

Ok, I agree. Fortunately this mess isn't in 2.5 ...

> > diff -u -r1.1.1.7 pcigame.c
> > --- drivers/char/joystick/pcigame.c   28 Nov 2002 23:53:12 -0000 1.1.1.7
> > +++ drivers/char/joystick/pcigame.c   1 Dec 2002 02:32:08 -0000
> > 
> > @@ -195,7 +195,7 @@
> > 
> >  int __init pcigame_init(void)
> >  {
> > -     pci_module_init(&pcigame_driver);
> > -     /* Needed by other modules */
> > -     return 0;
> > +     return pci_module_init(&pcigame_driver);
> >  }
> -- 
> Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
> Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

-- 
Vojtech Pavlik
SuSE Labs
