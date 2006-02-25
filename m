Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932565AbWBYC56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbWBYC56 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 21:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbWBYC56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 21:57:58 -0500
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:25754 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932565AbWBYC56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 21:57:58 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch 2.6.16-rc4-mm1]  Task Throttling V14
Date: Sat, 25 Feb 2006 13:57:23 +1100
User-Agent: KMail/1.9.1
Cc: Peter Williams <pwil3058@bigpond.net.au>, Andrew Morton <akpm@osdl.org>,
       MIke Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, "Chen, Kenneth W" <kenneth.w.chen@intel.com>
References: <1140183903.14128.77.camel@homer> <43FFAFE9.8000206@bigpond.net.au> <43FFC411.8010106@yahoo.com.au>
In-Reply-To: <43FFC411.8010106@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602251357.24665.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 February 2006 13:42, Nick Piggin wrote:
> Peter Williams wrote:
> > Andrew Morton wrote:
> >> MIke Galbraith <efault@gmx.de> wrote:
> >>> Not many comments came back, zero actually.
> >>
> >> That's because everyone's terribly busy chasing down those final bugs
> >> so we
> >> get a really great 2.6.16 release (heh, I kill me).
> >>
> >> I'm a bit reluctant to add changes like this until we get the smpnice
> >> stuff
> >> settled down and validated.  I guess that means once Ken's run all his
> >> performance tests across it.
> >>
> >> Of course, if Ken does his testing with just mainline+smpnice then any
> >> coupling becomes less of a problem.  But I would like to see some
> >> feedback
> >> from the other sched developers first.
> >
> > Personally, I'd rather see PlugSched merged in and this patch be used to
> > create a new scheduler inside PlugSched.  But I'm biased :-)
> >
> > As I see it, the problem that this patch is addressing is caused by the
> > fact that the current scheduler is overly complicated.  This patch just
> > makes it more complicated.  Some of the schedulers in PlugSched already
> > handle this problem adequately and some of them are simpler than the
> > current scheduler -- the intersection of these two sets is not empty.
> >
> > So now that it's been acknowledged that the current scheduler has
> > problems, I think that we should be looking at other solutions in
> > addition to just making the current one more complicated.
>
> I tried this angle years ago and it didn't work :)

Our "2.6 forever" policy is why we're stuck with this approach. We tried 
alternative implementations in -mm for a while but like all alternatives they 
need truckloads more testing to see if they provide a real advantage and 
don't cause any regressions. This made it impossible to seriously consider 
any alternatives.

I hacked on and pushed plugsched in an attempt to make it possible to work on 
an alternative implementation that would make the transition possible in a 
stable series. This was vetoed by Linus and Ingo and yourself for the reason 
it dilutes developer effort on the current scheduler. Which leaves us with 
only continually polishing what is already in place.

None of this is news of course but it helps to set the history for outside 
observers of this thread.

Cheers,
Con
