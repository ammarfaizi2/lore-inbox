Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbWBZRlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWBZRlZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 12:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWBZRlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 12:41:25 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3087 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751365AbWBZRlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 12:41:23 -0500
Date: Sun, 26 Feb 2006 18:41:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Building 100 kernels; we suck at dependencies and drown in warnings
Message-ID: <20060226174123.GJ3674@stusta.de>
References: <200602261721.17373.jesper.juhl@gmail.com> <20060226170038.GF3674@stusta.de> <9a8748490602260929v74fd8358r8bdb2d670508bb0a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490602260929v74fd8358r8bdb2d670508bb0a@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2006 at 06:29:54PM +0100, Jesper Juhl wrote:
> On 2/26/06, Adrian Bunk <bunk@stusta.de> wrote:
>...
> > > >From 100 kernel builds there was a total of 16152 warnings and 645 of those
> > > are unique warnings, the rest are duplicates.
> > >
> > > We are drowning in warnings people. Sure, many of the warnings are due to
> > > gcc getting something wrong and shouldn't really be emitted, but a lot of
> > > them point to actual problems or deficiencies (I obviously haven't looked
> > > at them all in detail yet, so take that with a grain of salt please).
> > >...
> >
> > It's well-known that BROKEN_ON_SMP drivers often spit 50 warnings in one
> > warning. If you remove the dozen worst drivers the numbers should look
> > much better.
> >
> Better yet, let's fix the warnings.

It's never bad if someone converts drivers still using cli/sti.

Unfortunately, this is non-trivial...

> > Not that our current situation was perfect, but the number of warnings
> > in .config's people usually use isn't that bad.
> 
> I agree it's not too bad for most people. The point of my post was
> mostly a "call to arms" trying to get people interrested in fixing all
> the warnings and build errors we have.

I'm agreeing that this is a good idea, I simply disagreed with your
"we suck at..." point, since although we can become better we aren't 
that bad.

> There's a lot of focus on implementing new features - and that's great
> - but there's little emphasis on fixing the problems we have and
> already know about - I'd like to see that change, and my post was
> mainly an attempt at making that happen :)

IMHO, the real problems we already know about are not warnings, they are 
the ones listed at
  http://bugzilla.kernel.org/

And in these cases, the bugs in unmaintained areas of the kernel like 
APM or the floppy driver are the worst ones.

> Jesper Juhl <jesper.juhl@gmail.com>

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

