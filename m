Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbUKUUOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbUKUUOW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 15:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbUKUUOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 15:14:22 -0500
Received: from mail.dif.dk ([193.138.115.101]:38859 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261776AbUKUUOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 15:14:16 -0500
Date: Sun, 21 Nov 2004 21:23:41 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, Blaisorblade <blaisorblade_spam@yahoo.it>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Why INSTALL_PATH is not /boot by default?
In-Reply-To: <41A09305.7030908@domdv.de>
Message-ID: <Pine.LNX.4.61.0411212122570.3419@dragon.hygekrogen.localhost>
References: <200411160127.15471.blaisorblade_spam@yahoo.it>
 <20041121094308.GA7911@mars.ravnborg.org> <41A06FF0.7090808@domdv.de>
 <Pine.LNX.4.61.0411211400530.3418@dragon.hygekrogen.localhost>
 <41A09305.7030908@domdv.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Nov 2004, Andreas Steinmetz wrote:

> Jesper Juhl wrote:
> > On Sun, 21 Nov 2004, Andreas Steinmetz wrote:
> > 
> > 
> > > Sam Ravnborg wrote:
> > > 
> > > > On Tue, Nov 16, 2004 at 01:27:15AM +0100, Blaisorblade wrote:
> > > > 
> > > > 
> > > > > This line, in the main Makefile, is commented:
> > > > > 
> > > > > export  INSTALL_PATH=/boot
> > > > > 
> > > > > Why? It seems pointless, since almost everything has been for ages
> > > > > requiring this settings, and distros' versions of installkernel have
> > > > > been
> > > > > taking an empty INSTALL_PATH as meaning /boot for ages (for instance
> > > > > Mandrake). It's maybe even mandated by the FHS (dunno).
> > > > > 
> > > > > Is there any reason I'm missing?
> > > > 
> > > > 
> > > > Changing this may have impact on default behaviour of some versions of
> > > > installkernel.
> > > > If /boot is ok for other than just i386 we can give it a try.
> > > > 
> > > 
> > > Please note that there are cases where you build a kernel for machine x on
> > > machine y. Which means: don't unconditionally uncomment this line.
> > > 
> > 
> > Huh, in that case wouldn't you just copy the kernel image from the source
> > dir on machine y to whereever it needs to liveon machine x by hand? At least
> > that's what I do, the Makefile and its INSTALL_PATH never comes into play
> > then.
> 
> Not if you build different kernels for quite some machines on a build system.
> It is neat then to use INSTALL_PATH and INSTALL_MOD_PATH to get the build
> output into target machine related directories for further automated
> processing.
> What I just want to say is that, yes, set INSTALL_PATH (and INSTALL_MOD_PATH)
> whereever you want to point it to - as long as it is not already set.

Fair enough, I see your point.

--
Jesper Juhl


