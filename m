Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265094AbSKNRf6>; Thu, 14 Nov 2002 12:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265095AbSKNRf6>; Thu, 14 Nov 2002 12:35:58 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:35085 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S265094AbSKNRfz>;
	Thu, 14 Nov 2002 12:35:55 -0500
Date: Thu, 14 Nov 2002 18:42:47 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Nicolas Pitre <nico@cam.org>, Andreas Steinmetz <ast@domdv.de>,
       Sam Ravnborg <sam@ravnborg.org>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: make distclean and make dep??
Message-ID: <20021114174246.GB10723@mars.ravnborg.org>
Mail-Followup-To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Nicolas Pitre <nico@cam.org>, Andreas Steinmetz <ast@domdv.de>,
	Sam Ravnborg <sam@ravnborg.org>, Bill Davidsen <davidsen@tmr.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0211131628010.16858-100000@xanadu.home> <Pine.LNX.4.44.0211140933150.5313-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211140933150.5313-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 09:35:53AM -0600, Kai Germaschewski wrote:
> I think there's good reasons for both distclean and mrproper, distclean is
> the standard target which most projects use, and mrproper is the
> traditional Linux kernel target. So I would vote for keeping them both
> (and share a common help entry).
> 
> What I don't see is why we would need different semantics, though, 
> anybody?
How about the following:
clean	Delete all intermidiate files, including symlinks and modversions
mrproper	clean + deletes .config and .config.old
distclean	mrproper + all editor backup, patch backup files

In other words a more powerfull clean compared to today.
The difference between clean and mrproper is then _only_ the configuration
files. That easy to explain, and thats easy to understand. Today only
very few people know the difference, and simply save their config,
and do make mrproper.

I have many times seen people do something like:
cp .config xxx
make mrproper
mv xxx .config

No need for that, when make clean deletes enough.

Only caveat is that people are forced to wait for the modversion stuff,
but to my understanding Rusty is making that step obsolete soon.
Did I miss something obvious?

	Sam
