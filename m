Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbTJXHtc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 03:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbTJXHtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 03:49:32 -0400
Received: from gprs146-220.eurotel.cz ([160.218.146.220]:37505 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262063AbTJXHt0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 03:49:26 -0400
Date: Fri, 24 Oct 2003 09:49:08 +0200
From: Pavel Machek <pavel@suse.cz>
To: john stultz <johnstul@us.ibm.com>
Cc: george anzinger <george@mvista.com>, Pavel Machek <pavel@suse.cz>,
       Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] fix time after suspend-to-*
Message-ID: <20031024074907.GB1519@elf.ucw.cz>
References: <20031022233306.GA6461@elf.ucw.cz> <1066866741.1114.71.camel@cog.beaverton.ibm.com> <20031023081750.GB854@openzaurus.ucw.cz> <3F9838B4.5010401@mvista.com> <1066942532.1119.98.camel@cog.beaverton.ibm.com> <3F985FB0.1070901@mvista.com> <1066955396.1122.133.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066955396.1122.133.camel@cog.beaverton.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Uh, not moving jiffies?  What does this say about any timers that may be 
> > pending?  Say for cron or some such?  Like I said, I picked up this thread a bit 
> > late, but, seems to me that if time is passing, it should pass on both the 
> > jiffies AND the wall clocks.
> 
> My understanding is that we are suspending the box (ie: putting your
> laptop to sleep/hybernate), so for all practical purposes the box is off
> waiting until it is woken up. During that time I don't believe we
> receive timer interrupts. When we are woken up, we should update the
> system time and continue, but as the box wasn't running during the
> interim we shouldn't be increasing the notion of monotonic time. 

No timer interrupts, definitely. Machine is powered off.

> Pavel: You new patch looks ok wrt the locking issue. I'm still pretty
> suspicious of the clock_cmos_diff but I'll trust you that it does the
> right thing (this has been tested, right? :)

It worked in apm, it should work now, and yes I did some tests.

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
