Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268256AbTALHl0>; Sun, 12 Jan 2003 02:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268257AbTALHl0>; Sun, 12 Jan 2003 02:41:26 -0500
Received: from mark.mielke.cc ([216.209.85.42]:54028 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S268256AbTALHlZ>;
	Sun, 12 Jan 2003 02:41:25 -0500
Date: Sun, 12 Jan 2003 02:58:44 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: David Schwartz <davids@webmaster.com>
Cc: linux-kernel@vger.kernel.org
Subject: inefficient RT vs efficient non-RT
Message-ID: <20030112075844.GA16050@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2003 at 11:09:13PM -0800, David Schwartz wrote:
> 	No, I've never used vxWorks, I just understand the difference 
> between an RTOS and a non-RTOS and how to choose the right tool for 
> the job. If an application can run on an OS that is not an RTOS, it 
> almost always does. RTOSes are usually used where you *must* *have* 
> guarantees.

The parts that you are not considering are:

   1) Many RT applications only need a small portion of RT.

   2) VxWorks adds a much more significant hit to performance that many
      consider to be reasonable. In fact, the hit is such that given the
      *SAME* capacity requirements, there is evidence that non-RT Linux
      can be sufficiently faster than RT VxWorks that 99.999+% can be
      'guaranteed' and still have time to spare.

I'm talking actual experiments by actual RT application designers. The
product in question, I believe, is a CDMA cellular telephone switch.

You are talking theory from a text book. I'm talking practice from people
who are frustrated with VxWorks on a daily basis.

Don't assume that because it has 'RT' on the label, that it makes it
beyond comparison with a non-RT operating system. Any operating system
can be poorly written, and that includes RT systems that successfully
guarantee system calls to require a fixed amount of time to
complete. The fixed amount of time to complete may be fixed, but it
may also be unreasonable high.

Think about it logically -- if I can process 5X as much data as you can on
the same hardware, but I can't guarantee that *at* 5X no data will be lost,
but then, I only run at 1X (the same speed as you), how many packets have
a chance of being lost?

In theory, a few, perhaps more. In practice, it's really hard to say,
and I trust experimental data from my peers over theory from
you. Sorry. :-)

When you've run your software on VxWorks, and then run your software on
Linux, and you have numbers (experience + numbers vs theory) then I'll
take your word over theirs.

Until then, I don't plan to touch VxWorks. I much prefer encouraging
Linux+RT to out-perform VxWorks, and be able to prove it. (For all I know,
they may have done this already -- from what I have heard about VxWorks,
it can't be that hard...)

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

