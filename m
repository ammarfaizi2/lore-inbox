Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbVLFGHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbVLFGHr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 01:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbVLFGHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 01:07:47 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:36625 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750798AbVLFGHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 01:07:47 -0500
Date: Tue, 6 Dec 2005 07:07:34 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Greg KH <greg@kroah.com>
Cc: Tim Bird <tim.bird@am.sony.com>, Dave Airlie <airlied@gmail.com>,
       David Woodhouse <dwmw2@infradead.org>, arjan@infradead.org,
       andrew@walrond.org, linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
Message-ID: <20051206060734.GB7096@alpha.home.local>
References: <21d7e9970512051610n1244467am12adc8373c1a4473@mail.gmail.com> <4394DA1D.3090007@am.sony.com> <20051206040820.GB26602@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051206040820.GB26602@kroah.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 08:08:20PM -0800, Greg KH wrote:
 
> For people to think that the kernel developers are just "too dumb" to
> make a stable kernel api (and yes, I've had people accuse me of this
> many times to my face[1]) shows a total lack of understanding as to
> _why_ we change the in-kernel api all the time.  Please see
> Documentation/stable_api_nonsense.txt for details on this.

It's not about being dumb, but this problem is -I think- what prevents
some companies from releasing drivers for their hardware (when they
don't consider that opening it will give their IP away). I've played
several times with opensource drivers for ADSL modems, LCD modules,
watchdogs, ethernet adapters, IDE drivers, etc... and their problem
was that what worked well in 2.4.21 did not even build in 2.4.22
and became difficult to fix starting with 2.4.23. Most of those
small companies who propose a Linux driver simply start by paying
a student during summer for porting their windows/sco/whatever
driver to linux. They think the job is done when he leaves.
Unfortunately, they receive complaints 3 months later from users
because the driver is broken and does not build. They don't have
the resources to keep a permanent developer on it, and they
quickly understand that Linux is just a "geek OS" and that it's
the last time they release any driver.

Of course, you'll tell me that they can write the driver for
the major stable distros (RHEL, SLES, ...). But when they
don't really understand what Linux is, do you believe it's the
student who will tell them "I should write it for RHEL" ? No.
The student will decide "I will write it for vanilla kernel
and test it on my Debian because I hate proprietary systems".

Anyway, those who write drivers for RHEL have no problem
keeping them closed because their users generally don't
expect to read the sources.

> thanks,
> 
> greg k-h
> 
> [1] My usual response is, "If we are so dumb, why are you using the kernel
>     made by us?", which usually stops the conversation right there.

I've already heard a funny response to this : "Usually I use *BSD, but
right now for an unknown reason, it does not install on this strange
machine, so I was FORCED to install Linux, but I will remove it once
I can fix my BSD" :-) It's the same as people who complain about windows
all the day and use it all the day.

Regards,
Willy

