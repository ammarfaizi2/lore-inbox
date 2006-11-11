Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946036AbWKKMab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946036AbWKKMab (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 07:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946855AbWKKMab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 07:30:31 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1295 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1946036AbWKKMaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 07:30:30 -0500
Date: Sat, 11 Nov 2006 13:30:33 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc5: where can I select INPUT?
Message-ID: <20061111123033.GZ4729@stusta.de>
References: <200611111325.02749.arvidjaar@mail.ru> <20061111112528.GY4729@stusta.de> <200611111518.42238.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611111518.42238.arvidjaar@mail.ru>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2006 at 03:18:41PM +0300, Andrey Borzenkov wrote:
> 
> On Saturday 11 November 2006 14:25, Adrian Bunk wrote:
> > On Sat, Nov 11, 2006 at 01:24:58PM +0300, Andrey Borzenkov wrote:
> > >
> > > Neither in menuconfig nor in xconfig do I see any place to actually
> > > select INPUT. Help text suggests that it is a) selectable b) it can be
> > > made modules. I do not have either option. Here what I see in menuconfig
> > > if I go into Input device support:
> > >
> > >     --- Generic input layer (needed for keyboard, mouse, ...)
> > >     < >   Support for memoryless force-feedback devices
> > >     ---   Userland interfaces
> > >
> > > as you see there is no check box for INPUT itself.
> > >
> > > I already had similar issue something else (I believe it was something
> > > related to serio). In menuconfig item was no selectable, but I could
> > > directly edit .config to change y to m.
> > >...
> >
> > INPUT can only be unset if you set CONFIG_EMBEDDED=y.
> >
> 
> {pts/1}% grep EMB /boot/config
> CONFIG_EMBEDDED=y
> 
> > The rationale is that it usually doesn't make sense for users to disable
> > INPUT, and allowing it tends to cause some confusion.
> >
> 
> I do not want to disable it. I want to make it module (OK it has the same 
> rationale - if you need it anyway why you do want to make it module etc). 
> This should be possible according to help text. It does not work. Direct 
> editing of .config silently reverts it back to y instead of m.

What you want seems to require some non-trivial changes.

Are you trying this "just because it should work" or is there a strong 
technical reason why you need it?

> TIA
> - -andrey

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

