Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262181AbVBAXp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbVBAXp7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 18:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbVBAXp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 18:45:58 -0500
Received: from mail.tmr.com ([216.238.38.203]:17672 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262181AbVBAXpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 18:45:30 -0500
Date: Tue, 1 Feb 2005 18:23:26 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Adrian Bunk <bunk@stusta.de>
cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] mark the mcd cdrom driver as BROKEN
In-Reply-To: <20050201223645.GA3258@stusta.de>
Message-ID: <Pine.LNX.3.96.1050201181051.837A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Feb 2005, Adrian Bunk wrote:

> On Tue, Feb 01, 2005 at 10:24:56AM -0500, Bill Davidsen wrote:
> > Adrian Bunk wrote:
> > >On Sat, Jan 29, 2005 at 06:22:55PM +0100, Jean Delvare wrote:
> > >
> > >>Hi Adrian,
> > >>
> > >>
> > >>>The mcd driver drives only very old hardware (some single and double 
> > >>>speed CD drives that were connected either via the soundcard or a 
> > >>>special ISA card), and the mcdx driver offers more functionality for
> > >>>the  same hardware.
> > >>>
> > >>>My plan is to mark MCD as broken in 2.6.11 and if noone complains 
> > >>>completely remove this driver some time later.
> > >>>(...)
> > >>>-	depends on CD_NO_IDESCSI
> > >>>+	depends on CD_NO_IDESCSI && BROKEN
> > >>
> > >>Shouldn't we introduce a DEPRECATED option for use in cases like this
> > >>one?
> > >
> > >
> > >We could.
> > >
> > >We could also list MCD in Documentation/feature-removal-schedule.txt 
> > >first.
> > >
> > >But in this case I doubt it makes any difference.
> > >
> > >This driver is for hardware where I doubt many users exist today, and it 
> > >should have been removed nearly ten years ago when the better mcdx 
> > >driver for the same now-obsolete hardware entered the kernel.
> > 
> > I actually have one (or two) of these, but I agree that in this case it 
> > makes no difference. As a general thing I think DEPRECIATED would be 
> > useful for the case where there is a newer functional driver. The 
> > systems I have are unlikely to ever run a current kernel, so I am not 
> > affected, and I suspect most others who have this old stuff are running 
> > 2.0 or 2.2 kernels, also.
> 
> Are you using the mcd or the mcdx driver?
> 
> At 2.2 times, I also had such a drive.
> But I didn't observe any need for the mcd driver that was already 
> outdated at that time.

Exactly, that one can go for sure.
> 
> The mcd driver should perhaps have been removed 10 years ago when the 
> mcdx driver was introduced. You could start today with deprecating the 
> mcd driver instead of a quick removal of this driver. But why? The 
> question is whether the number of people using one of these drives with 
> a 2.6 kernel is above zero or not - not whether we need one or two 
> drivers for them.

In case my first note wasn't clear, I'm in favor of DEPRECIATED as a
supported feature, the mcd driver can just go away I would think. I
believe I'm using the mcdx driver in my old systems, but whatever is there
is presumably going to stay in the old kernels, and I can't imagine ever
building another kernel for a box that old. They are happily chugging
along, and when they die they will go to the 2nd hand store. If the disks
have anything requiring disposal (I think not), I will drill a few holes
in them before scrapping.

If it wouldn't be a LOT of work, I would think that using a DEPRECIATED
driver could be noted in some way in an oops, like tainted. That's just a
thought, feel free to comment, but don't expect me to defend the idea, I'm
just sharing it.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

