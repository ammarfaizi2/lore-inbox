Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315536AbSEZCJV>; Sat, 25 May 2002 22:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315539AbSEZCJU>; Sat, 25 May 2002 22:09:20 -0400
Received: from stm.lbl.gov ([131.243.16.51]:4356 "EHLO stm.lbl.gov")
	by vger.kernel.org with ESMTP id <S315536AbSEZCJU>;
	Sat, 25 May 2002 22:09:20 -0400
Date: Sat, 25 May 2002 19:09:13 -0700
From: David Schleef <ds@schleef.org>
To: Karim Yaghmour <karim@opersys.com>, Larry McVoy <lm@bitmover.com>,
        Wolfgang Denk <wd@denx.de>, linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020525190913.A6869@stm.lbl.gov>
Reply-To: David Schleef <ds@schleef.org>
In-Reply-To: <20020525110208.A15969@work.bitmover.com> <20020525182617.D627E11972@denx.denx.de> <20020525114426.B15969@work.bitmover.com> <3CEFEB73.5BB2C14C@opersys.com> <20020525133637.B17573@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2002 at 01:36:37PM -0700, Larry McVoy wrote:
> A couple of points.  If you are going to rewrite, then you should rewrite.
> I'm told, and I've seen, that there substantial parts of RT/Linux in the
> RTAI source base.

I was told this too.  Being familiar with both RTAI internals and
(in the past) RTLinux internals, I found this statement to be
rather questonable.  However, since I hadn't gone over _every line_
of the code, I couldn't be sure.

So I wrote a perl script that compares two entire source trees, and
looks to see which source lines are similar, ignoring whitespace,
punctuation, etc.  It turned out to be surprisingly good at its
task -- I checked RTAI against other projects that I work on,
and it showed me all the segments of code that I copied between the
projects.  I checked RTAI against itself, and it showed me that all
the examples are very similar.  I checked RTAI against the kernel,
and it picked up matches between the patch files in the RTAI source
and the files that the patches patch in the kernel source.

I checked RTAI vs. RTLinux, and it turned up 2 things: an example
written by Jerry Epplin, and the implementation of rt_printk(),
which was written by me.  Neither of these were "originally" in
RTLinux, they were both "originally" posted to the RTLinux mailing
list.

There was one more match that was publicly claimed as copying by
the maintainer of RTLinux -- a few fields in the scheduler structure.
The script caught those, too, once I set the threshhold down to 3
lines, which also picked up hundreds of mismatches.  But strangely, I
found the same lines in an OS textbook dated 1987.  I wonder who
copied whom.

[By the way, if someone reminds me, I'll make the script available
for download.  It's quite useful.]

> Isn't it true that RTAI used to be called "my-rtai"
> and the guy who did that work freely admitted that it was a fork of the 
> RT/Linux source base?

No, it was never a fork.  RTAI, in its DOS form, existed before
RTLinux.

> Second, that's what patents are all about, it's about protecting your
> investment.

Then why doesn't USENIX or New Mexico Tech own it?  They were the
ones that paid for the development of RTLinux.



dave...

