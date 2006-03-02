Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751610AbWCBUcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbWCBUcr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 15:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751683AbWCBUcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 15:32:46 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:37137 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751610AbWCBUcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 15:32:46 -0500
Date: Thu, 2 Mar 2006 21:32:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, dtor_core@ameritech.net,
       jgeorgas@rogers.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] make UNIX a bool
Message-ID: <20060302203245.GD9295@stusta.de>
References: <20060301175852.GA4708@stusta.de> <E1FEcfG-000486-00@gondolin.me.apana.org.au> <20060302173840.GB9295@stusta.de> <9a8748490603021228k7ad1fb5gd931d9778307ca58@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490603021228k7ad1fb5gd931d9778307ca58@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 09:28:15PM +0100, Jesper Juhl wrote:
> On 3/2/06, Adrian Bunk <bunk@stusta.de> wrote:
> > On Thu, Mar 02, 2006 at 12:31:34PM +1100, Herbert Xu wrote:
> > > Adrian Bunk <bunk@stusta.de> wrote:
> > > >
> > > > It does also matter in the kernel image size case, since you have to put
> > > > enough modules to the other medium for having a effect bigger than the
> > > > kernel image size increase from setting CONFIG_MODULES=y.
> > >
> > > That's not very difficult considering the large number of modules that's
> > > out there that a system may wish to use.
> > >...
> >
> > This might be true for full-blown desktop systems - but these do not
> > tend to be the systems where kernel image size matters that much.
> > Smaller kernel image size might be an issue e.g. for distribution
> > kernels, but in a much less pressing way.
> >
> > The systems where kernel image size really matters are systems with few
> > modules where you know in advance which modules you might need. I played
> > a bit with the ARM defconfigs, and if you consider that you can't build
> > the filesystem for accessing your modules modular I haven't found any
> > where making everything modular would have given a real kernel image
> > size gain compared to the CONFIG_MODULES=n case.
> >
> 
> I believe the basic question is this: What do we win by making
> CONFIG_UNIX a bool?
>...

We do not have to export symbols we don't want to export to modules but 
needed by CONFIG_UNIX.

> Jesper Juhl <jesper.juhl@gmail.com>

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

