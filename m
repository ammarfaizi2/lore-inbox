Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277207AbRJDTCo>; Thu, 4 Oct 2001 15:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277210AbRJDTCe>; Thu, 4 Oct 2001 15:02:34 -0400
Received: from c290168-a.stcla1.sfba.home.com ([24.250.174.240]:4171 "HELO
	top.worldcontrol.com") by vger.kernel.org with SMTP
	id <S277207AbRJDTCX>; Thu, 4 Oct 2001 15:02:23 -0400
From: brian@worldcontrol.com
Date: Thu, 4 Oct 2001 12:15:26 -0700
To: Craig Kulesa <ckulesa@as.arizona.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-ac3+preempt non-responsive under certain loads
Message-ID: <20011004121526.A7480@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	Craig Kulesa <ckulesa@as.arizona.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0110021924440.25160-100000@loke.as.arizona.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0110021924440.25160-100000@loke.as.arizona.edu>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2001 at 07:32:45PM -0700, Craig Kulesa wrote:
> What would help everyone more is if you provided a URL to the file that
> caused you problems. 

I was unconformtable with sending along the URL because I felt it
might offend the anti-America readers of linux-kernel, and I might
get accused of being a troll.  Imagine a big American flag popping
up on their screen.  (There is a shortage of US flags in the US,
so people are having to make their own)

I couldn't find nor remember the URL where I got it.  I put it up
at http://www.litzinger.com/flag.pdf (230K).

>                    And, since neither Linus nor Alan have accepted the
> preempt patch yet, you should *really* test the issue with, say, stock
> 2.4.10-ac.  If the problem goes away, we know it's in the patch and not
> somewhere in the rest of the kernel tree.

I'll give that a try.  Several have suggested trying 2.4.11pre2.  If
I can find the ext3 patch for it I'll try that too.
 
> It would also be useful to know what the system was doing when it became
> unresponsive.  Was it kswapd?  Consider doing a 'ps aux' before the
> problem, and after the problem, see if any of the kernel daemons took any
> CPU time in the interim.  And if it's VM related, try running
> 'vmstat 1' before opening the file and save the output when it's over.

Rather than include all that in this email.  If anyone wants to look
the before and after 'ps aux'  and vmstat sessions for each program
listed below are in http://www.litzinger.com/stats.tgz (25K).

My website recently moved IPs so if you have trouble try again in
a few hours or use http://216.218.185.198

> It could be that ghostscript had a fit and alloc'd tons of memory.  Does
> xpdf do the same thing, or is it okay?

ghostview: system is immediately very unresponsive. 10 to 20
           seconds pauses for long periods of time.  I get a 
	   little CPU time every 15 seconds or so.  Eventually
	   the flag does display.

xpdf:      system is initially responsive then becomes very unresponsive.
           I believe the OOM handler eventually kills xpdf.

acroread:  system maintains reasonable responsiveness.  Certainly would
           not call it "silky smooth".  Does have the occasional period
	   of 5 seconds of non-responsiveness.  flag does display.

gimp:      runs along reasonably responsive for a good amount of time.
           then exhibits 3 to 5 second pauses, becomes responsive
	   again and then my filesystem runs out of space for the tile
	   cache.

-- 
Brian Litzinger <brian@worldcontrol.com>

    Copyright (c) 2000 By Brian Litzinger, All Rights Reserved
