Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315753AbSEJBpY>; Thu, 9 May 2002 21:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315754AbSEJBpX>; Thu, 9 May 2002 21:45:23 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:64753
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S315753AbSEJBpW>; Thu, 9 May 2002 21:45:22 -0400
Date: Thu, 9 May 2002 18:45:11 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: benh@kernel.crashing.org
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
Message-ID: <20020510014511.GO2392@matchmail.com>
Mail-Followup-To: benh@kernel.crashing.org,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Padraig Brady <padraig@antefacto.com>,
	Anton Altaparmakov <aia21@cantab.net>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0205071021290.2509-100000@home.transmeta.com> <20020507173034.14013@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2002 at 07:30:34PM +0200, benh@kernel.crashing.org wrote:
> >
> >
> >On Tue, 7 May 2002 benh@kernel.crashing.org wrote:
> >>
> >> One interesting thing here would be to have some optional link between
> >> the bus-oriented device tree and the function-oriented tree (ie. devfs
> >> or simply /dev).
> >
> >There isn't any 1:1 thing - the device/bus-oriented one should _not_ show
> >virtual things like partitions etc that have no relevance for a driver,
> >while /dev (and thus devfs) obviously think that that is the important
> >part, much more important than how we actually got to the device.
> >
> >I think we need to have some way of getting a mapping from /dev ->
> >devicefs, but I don't think that has to be a filesystem thing (it might
> >even be as simple as just one ioctl or new system call: 'get the "path" of
> >this device').
> >
> >There aren't that many people who actually care, I suspect.
> 
> Sure, It's obviously not 1:1, what I had in mind was for the controller
> to show what devices it exports in the sense of raw devices, but I agree
> the other way makes a lot more sense. My problem was how to be devfs
> agnostic, but you answered with "ioctl or syscall" and that would indeed
> be ok. The ioctl things make it appliable to network interfaces as well,
> which is good.

Yes, when will we get something that associates the physical device with
network ethX name?
