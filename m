Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262150AbVBAWoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbVBAWoZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 17:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbVBAWoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 17:44:24 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:37647 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262150AbVBAWgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 17:36:47 -0500
Date: Tue, 1 Feb 2005 23:36:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] mark the mcd cdrom driver as BROKEN
Message-ID: <20050201223645.GA3258@stusta.de>
References: <20050129191430.GF28047@stusta.de> <41FF9F48.60008@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FF9F48.60008@tmr.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2005 at 10:24:56AM -0500, Bill Davidsen wrote:
> Adrian Bunk wrote:
> >On Sat, Jan 29, 2005 at 06:22:55PM +0100, Jean Delvare wrote:
> >
> >>Hi Adrian,
> >>
> >>
> >>>The mcd driver drives only very old hardware (some single and double 
> >>>speed CD drives that were connected either via the soundcard or a 
> >>>special ISA card), and the mcdx driver offers more functionality for
> >>>the  same hardware.
> >>>
> >>>My plan is to mark MCD as broken in 2.6.11 and if noone complains 
> >>>completely remove this driver some time later.
> >>>(...)
> >>>-	depends on CD_NO_IDESCSI
> >>>+	depends on CD_NO_IDESCSI && BROKEN
> >>
> >>Shouldn't we introduce a DEPRECATED option for use in cases like this
> >>one?
> >
> >
> >We could.
> >
> >We could also list MCD in Documentation/feature-removal-schedule.txt 
> >first.
> >
> >But in this case I doubt it makes any difference.
> >
> >This driver is for hardware where I doubt many users exist today, and it 
> >should have been removed nearly ten years ago when the better mcdx 
> >driver for the same now-obsolete hardware entered the kernel.
> 
> I actually have one (or two) of these, but I agree that in this case it 
> makes no difference. As a general thing I think DEPRECIATED would be 
> useful for the case where there is a newer functional driver. The 
> systems I have are unlikely to ever run a current kernel, so I am not 
> affected, and I suspect most others who have this old stuff are running 
> 2.0 or 2.2 kernels, also.

Are you using the mcd or the mcdx driver?

At 2.2 times, I also had such a drive.
But I didn't observe any need for the mcd driver that was already 
outdated at that time.

The mcd driver should perhaps have been removed 10 years ago when the 
mcdx driver was introduced. You could start today with deprecating the 
mcd driver instead of a quick removal of this driver. But why? The 
question is whether the number of people using one of these drives with 
a 2.6 kernel is above zero or not - not whether we need one or two 
drivers for them.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

