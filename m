Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315917AbSEGRn6>; Tue, 7 May 2002 13:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315918AbSEGRn5>; Tue, 7 May 2002 13:43:57 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:3779 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S315917AbSEGRn5>; Tue, 7 May 2002 13:43:57 -0400
Date: Tue, 7 May 2002 11:43:35 -0600
Message-Id: <200205071743.g47HhZd30932@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: benh@kernel.crashing.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <Pine.LNX.4.44.0205071021290.2509-100000@home.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
> On Tue, 7 May 2002 benh@kernel.crashing.org wrote:
> >
> > One interesting thing here would be to have some optional link between
> > the bus-oriented device tree and the function-oriented tree (ie. devfs
> > or simply /dev).
> 
> There isn't any 1:1 thing - the device/bus-oriented one should _not_
> show virtual things like partitions etc that have no relevance for a
> driver, while /dev (and thus devfs) obviously think that that is the
> important part, much more important than how we actually got to the
> device.

Actually, I've always said that I think devfs should care about both
views. And that's why I think putting the driver tree (ala driverfs)
in devfs, and making the device-oriented part of the tree be symlinks
into the bus-oriented tree, is a good idea.

> I think we need to have some way of getting a mapping from /dev ->
> devicefs, but I don't think that has to be a filesystem thing (it
> might even be as simple as just one ioctl or new system call: 'get
> the "path" of this device').

Fugly. What's wrong with readlink(2) as this "magic syscall"?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
