Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317283AbSFLAwX>; Tue, 11 Jun 2002 20:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317287AbSFLAwW>; Tue, 11 Jun 2002 20:52:22 -0400
Received: from dsl093-058-082.blt1.dsl.speakeasy.net ([66.93.58.82]:35570 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S317283AbSFLAwS>; Tue, 11 Jun 2002 20:52:18 -0400
Date: Tue, 11 Jun 2002 15:27:42 -0400 (EDT)
From: Donald Becker <becker@scyld.com>
X-X-Sender: <becker@presario>
To: Matti Aarnio <matti.aarnio@zmailer.org>
cc: Robert PipCA <robertpipca@yahoo.com>, <vortex@scyld.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [vortex] Re: MTU discovery
In-Reply-To: <20020610110513.I18899@mea-ext.zmailer.org>
Message-ID: <Pine.LNX.4.33.0206111523050.1688-100000@presario>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2002, Matti Aarnio wrote:

> Date: Mon, 10 Jun 2002 11:05:13 +0300
> From: Matti Aarnio <matti.aarnio@zmailer.org>
> To: Robert PipCA <robertpipca@yahoo.com>
> Cc: vortex@scyld.com, linux-kernel@vger.kernel.org
> Subject: [vortex] Re: MTU discovery
>
> On Mon, Jun 10, 2002 at 12:45:07AM -0700, Robert PipCA wrote:
> >   Hi,
> >   I'm working on a project that require knowing the max MTU size
> > supported by the 3Com PCI 3c905C (Boomerang).
> > The datasheet provided by 3Com does not mention it, and I already
> > did the usual google search, but didn't find it neither.
> > Does anyone knows a "generic way" of knowing this (or chip-specific)?
..
>   Some devices do, however, support reception (and transmit) of what
>   is called "jumbograms".  With boomerang you can set a register
>   to contain the limit value.

A 16 bit register.. 64KB packets.  There are various issues with using
large packet sizes.  There is no driver that has been verified with
jumbo frames.  I have been throwing driver versions at Rishi Srivatsavai
<rishis at CLEMSON.EDU> trying to sort out the issues.  You might notice
the changes in 0.99W, although they don't handle the FIFO limit issues.

>  Alternatively with boomerang, and
>   its predecessors, you can set a bit to accept extra-large frames.
>
>   I recall the ultimate limit is in order of 4kB.

More precisely, FDDI frame size minus the FDDI-specific bits, about
4.5KB.

-- 
Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

