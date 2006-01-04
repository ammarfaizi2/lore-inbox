Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751650AbWADQ6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbWADQ6h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 11:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751652AbWADQ6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 11:58:37 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:65288 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751604AbWADQ6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 11:58:36 -0500
Date: Wed, 4 Jan 2006 17:58:35 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] i386: enable 4k stacks by default
Message-ID: <20060104165835.GP3831@stusta.de>
References: <20060104145138.GN3831@stusta.de> <9a8748490601040839s58a0a26en454f54459006077c@mail.gmail.com> <20060104164445.GO3831@stusta.de> <9a8748490601040849l5e144f18s381854dd7f5f6e6b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490601040849l5e144f18s381854dd7f5f6e6b@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 05:49:25PM +0100, Jesper Juhl wrote:
> On 1/4/06, Adrian Bunk <bunk@stusta.de> wrote:
> > On Wed, Jan 04, 2006 at 05:39:14PM +0100, Jesper Juhl wrote:
> > > On 1/4/06, Adrian Bunk <bunk@stusta.de> wrote:
> > > > This patch enables 4k stacks by default.
> > > >
> > > > 4k stacks have become a well-tested feature used fore a long time in
> > > > Fedora and even in RHEL 4.
> > > >
> > > > There are no known problems in in-kernel code with 4k stacks still
> > > > present after Neil's patch that went into -mm nearly two months ago.
> > > >
> > > > Defaulting to 4k stacks in -mm kernel will give some more testing
> > > > coverage and should show whether there are really no problems left.
> > > >
> > > > Keeping the option for now should make the people happy who want to use
> > > > the experimental -mm kernel but don't trust the well-tested 4k stacks.
> > > >
> > > >
> > > > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > > >
> > > > --- linux-2.6.15-rc5-mm3-full/arch/i386/Kconfig.debug.old       2006-01-04 11:43:55.000000000 +0100
> > > > +++ linux-2.6.15-rc5-mm3-full/arch/i386/Kconfig.debug   2006-01-04 11:44:14.000000000 +0100
> > > > @@ -53,8 +53,8 @@
> > > >           If in doubt, say "N".
> > > >
> > > >  config 4KSTACKS
> > > > -       bool "Use 4Kb for kernel stacks instead of 8Kb"
> > > > -       depends on DEBUG_KERNEL
> > > > +       bool "Use 4Kb for kernel stacks instead of 8Kb" if DEBUG_KERNEL
> > >
> > > Why "if DEBUG_KERNEL" ?
> >
> > This is simply the same as before with the defaults inverted.
> >
> I just thought that you wanted to get as much testing in -mm as
> possible while still leaving the old stacksize option for those who
> don't yet trust 4K stacks.

That is what my patch does.

> To get maximum testing making 4KSTACKS default Y and removing the "if
> DEBUG_KERNEL" conditional just seems to me to be the obvious choice...

With my version, we are getting the bigger testing coverage - and 
getting a big testing coverage in -mm is what we need if we want to know 
whether we have really already fixed all stack problems or whether 
there are any left.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

