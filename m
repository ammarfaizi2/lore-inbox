Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315871AbSEGTVT>; Tue, 7 May 2002 15:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315949AbSEGTVS>; Tue, 7 May 2002 15:21:18 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:26051 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S315871AbSEGTVR>; Tue, 7 May 2002 15:21:17 -0400
Date: Tue, 7 May 2002 13:21:10 -0600
Message-Id: <200205071921.g47JLAV00682@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Patrick Mochel <mochel@osdl.org>
Cc: <benh@kernel.crashing.org>, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <Pine.LNX.4.33.0205071141230.6307-100000@segfault.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel writes:
> 
> On Tue, 7 May 2002, Richard Gooch wrote:
> 
> > Patrick Mochel writes:
> > > Oh, and it's with a modern, clean filesystem, 1/5 the size of devfs. 
> > 
> > The size argument is not an issue. I've already said that devfs will
> > shrink a lot once I move tree management from my own code to the VFS.
> 
> I agree 100%. However, I think that move will be very painful. I
> tried to do it a couple of months ago, and there were so many
> interdependencies and oddities that I gave up after about 6 hours.

Oh, it's certainly more that 6 hours of work. But it *will* get done.

> > At that point devfs will mostly be:
> > - an API
> > - a way fo supporting the devfsd protocol.
> 
> I argue that you shouldn't need a separate daemon. We already have
> the /sbin/hotplug interface. It's simple and sweet. We shouldn't
> need to rely on an entirely separate daemon.

The devfsd protocol is more lightweight. Plus it doesn't require
fork(2)+execve(2) overheads. And more importantly, you can capture
lookup() events.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
