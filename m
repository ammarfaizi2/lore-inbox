Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265228AbSKNU43>; Thu, 14 Nov 2002 15:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265230AbSKNU43>; Thu, 14 Nov 2002 15:56:29 -0500
Received: from cpe-66-1-218-52.fl.sprintbbd.net ([66.1.218.52]:24841 "EHLO
	daytona.compro.net") by vger.kernel.org with ESMTP
	id <S265228AbSKNU42>; Thu, 14 Nov 2002 15:56:28 -0500
Message-ID: <3DD40F77.F4217D4A@compro.net>
Date: Thu, 14 Nov 2002 16:02:47 -0500
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-lcrs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Nicolas Pitre <nico@cam.org>, Andreas Steinmetz <ast@domdv.de>,
       Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: make distclean and make dep??
References: <Pine.LNX.4.44.0211131628010.16858-100000@xanadu.home> <Pine.LNX.4.44.0211140933150.5313-100000@chaos.physics.uiowa.edu> <20021114174246.GB10723@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> 
> On Thu, Nov 14, 2002 at 09:35:53AM -0600, Kai Germaschewski wrote:
> > I think there's good reasons for both distclean and mrproper, distclean is
> > the standard target which most projects use, and mrproper is the
> > traditional Linux kernel target. So I would vote for keeping them both
> > (and share a common help entry).
> >
> > What I don't see is why we would need different semantics, though,
> > anybody?
> How about the following:
> clean   Delete all intermidiate files, including symlinks and modversions
> mrproper        clean + deletes .config and .config.old
> distclean       mrproper + all editor backup, patch backup files
> 
> In other words a more powerfull clean compared to today.
> The difference between clean and mrproper is then _only_ the configuration
> files. That easy to explain, and thats easy to understand. Today only
> very few people know the difference, and simply save their config,
> and do make mrproper.
> 
> I have many times seen people do something like:
> cp .config xxx
> make mrproper
> mv xxx .config
> 
> No need for that, when make clean deletes enough.

I thought make mrproper cleaned whatever make dep did also. Make clean certainly
does not.
I never need a make dep after a clean. Only after a make mrproper???

Mark
