Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315937AbSEGSs5>; Tue, 7 May 2002 14:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315938AbSEGSs4>; Tue, 7 May 2002 14:48:56 -0400
Received: from air-2.osdl.org ([65.201.151.6]:15759 "EHLO segfault.osdl.org")
	by vger.kernel.org with ESMTP id <S315937AbSEGSsz>;
	Tue, 7 May 2002 14:48:55 -0400
Date: Tue, 7 May 2002 11:44:38 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: <benh@kernel.crashing.org>, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <200205071844.g47IiFR32553@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.33.0205071141230.6307-100000@segfault.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 7 May 2002, Richard Gooch wrote:

> Patrick Mochel writes:
> > Oh, and it's with a modern, clean filesystem, 1/5 the size of devfs. 
> 
> The size argument is not an issue. I've already said that devfs will
> shrink a lot once I move tree management from my own code to the VFS.

I agree 100%. However, I think that move will be very painful. I tried to 
do it a couple of months ago, and there were so many interdependencies and 
oddities that I gave up after about 6 hours.

> At that point devfs will mostly be:
> - an API
> - a way fo supporting the devfsd protocol.

I argue that you shouldn't need a separate daemon. We already have the 
/sbin/hotplug interface. It's simple and sweet. We shouldn't need to rely 
on an entirely separate daemon. 

	-pat

