Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262325AbSJ2VYD>; Tue, 29 Oct 2002 16:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262328AbSJ2VYD>; Tue, 29 Oct 2002 16:24:03 -0500
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:9463 "EHLO
	falcon.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S262325AbSJ2VYC>; Tue, 29 Oct 2002 16:24:02 -0500
Date: Tue, 29 Oct 2002 14:23:34 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Christoph Hellwig <hch@infradead.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [BK updates] fbdev changes updates.
In-Reply-To: <20021029211800.A2806@infradead.org>
Message-ID: <Pine.LNX.4.33.0210291416220.1363-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > On Tue, Oct 29, 2002 at 12:46:16PM -0800, James Simmons wrote:
> > > >
> > > > OOps. Forgot the link.
> > > >
> > > > bk://fbdev.bkbits.net/fbdev-2.5
> > >
> > > Does it still contain the random file movearounds?
> >
> > The reason I did this was to prevent adding another chuck of agp code. The
> > current work around for AGP fbdev drivers to have there OWN AGP code. So
> > we can leave the agp drivers where they are at or the framebuffer layer
> > can have its own AGP code for itself. Which way do you think it should be
> > done?
> >
> > 1) Fbdev layer has it own AGP layer
> >
> > 2) Use already existing AGP layer code.
>
> Well, I'd be very happy if you could separate different things abit.
> Everyone wants the console fixes in, but code placement is a bit more of a
> policy issue and wants more discussion..  Even when they are in different
> directories the drm drivers can always call into the fbdev drivers as "base
> modules", like sis currently does.

Fair enough. I'm moving agp and dri back to drivers/char. I would
like to discuss a solution to how to initialize the AGP code quicker :-)

