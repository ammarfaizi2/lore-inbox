Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314911AbSDVXGX>; Mon, 22 Apr 2002 19:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314912AbSDVXGV>; Mon, 22 Apr 2002 19:06:21 -0400
Received: from thorgal.et.tudelft.nl ([130.161.40.91]:20604 "EHLO
	thorgal.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S314911AbSDVXGR>; Mon, 22 Apr 2002 19:06:17 -0400
Mime-Version: 1.0
Message-Id: <a05100307b8ea44c17d90@[130.161.115.44]>
In-Reply-To: <3CC4861C.F21859A6@mvista.com>
Date: Tue, 23 Apr 2002 01:06:42 +0200
To: george anzinger <george@mvista.com>
From: "J.D. Bakker" <bakker@thorgal.et.tudelft.nl>
Subject: Re: Why HZ on i386 is 100 ?
Cc: linux-kernel@vger.kernel.org, John Alvord <jalvo@mbay.net>,
        Pavel Machek <pavel@suse.cz>, davidm@hpl.hp.com
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 14:52 -0700 22-04-2002, george anzinger wrote:
>John Alvord wrote:
>  > On Sun, 21 Apr 2002, Pavel Machek wrote:
>  > > And think what it does with old 386sx.. Maybe time for those 
>"tick on demand"
>>  > patches?
>>
>  > Doesn't IBM have a tickless patch.. useful when demonstrating 10,000
>>  virtual linux machines on a single system.
>
>Please folks.  When can we put the "tick on demand" thing to bed?  If in
>doubt, get the patch from the high-res-timers sourceforge site (see
>signature for the URL) and try it.  Overhead becomes higher with system
>load passing the ticked system at relatively light loads.  Just what we
>want, very low overhead idle systems!

During idle, the current monitors on our StrongARM-based low power 
testbed show a distinct 100Hz beat. A significant portion of idle 
power consumption can be attributed to the timer interrupt. IIRC the 
IBM LinuxWatch people came to a similar conclusion.

In some cases we definitely do want very low overhead idle systems. 
And of course on ARM systems context switches are relatively 
expensive anyway, due to the need to flush the (virtually 
indexed/tagged) caches.

JDB
[not that I'm proposing to inflict this on the mainline kernel]
-- 
LART. 250 MIPS under one Watt. Free hardware design files.
http://www.lart.tudelft.nl/
