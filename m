Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268999AbUHZOdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268999AbUHZOdU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 10:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268961AbUHZO3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 10:29:55 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:13753 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S268976AbUHZOZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 10:25:53 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: 2.6.9-rc1-mm1
Date: Thu, 26 Aug 2004 16:36:06 +0200
User-Agent: KMail/1.5
References: <20040826014745.225d7a2c.akpm@osdl.org> <412DC47B.4000704@kolivas.org>
In-Reply-To: <412DC47B.4000704@kolivas.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408261636.06857.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 of August 2004 13:07, Con Kolivas wrote:
> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2
> >.6.9-rc1-mm1/
> >
> >
> > - nicksched is still here.  There has been very little feedback, except
> > that it seems to slow some workloads on NUMA.
>
> That's because most people aren't interested in a new cpu scheduler for
> 2.6.

I am, but I have no benchmarks that give any useful numbers.

> The current one works well enough in most situations and people
> aren't trying -mm to fix their interactive problems since they are few
> and far between.

Actually, with the current scheduler, updatedb really sucks.  It's supposed to 
be a background task, but it hogs IO resources and memory like crazy 
(disclaimer: it's my personal subjective observation).

> The only reports about adverse behaviour with 2.6 we
> track down to "It behaves differently to what I expect" or applications
> with no (b)locking between threads suck under load. Personally I think
> the latter is a good thing as it encourages better coding, and the
> former is something we'll have with any alternate design.
>
> The only feedback we got on staircase was that it helped NUMA somewhat
> and Nick and Ingo made some criticisms (not counting any benchmarks I
> had to offer). The only feedback on nickshed was that it hurt NUMA
> somewhat, SMT interactivity was broken (an easy enough oversight), and I
> did not comment to avoid giving biased criticism.

Frankly, if I had any useful benchmark, I would have readily run it and posted 
the results.  The problem is that I don't know what kind of results you are 
interested in.  Please let me know what _exactly_ you want to measure.  
Please propose some benchmarks or post a HOWTO, or what.  "Help me help you".

> If you're after subjective performance feedback you're less likely to
> get it now than ever since you've made a strong stance against
> subjective reports, due to placebo effect. LKML is scary enough for the
> average user already. We have a situation now that if one brave single
> user reports good or bad behaviour everyone runs off that one user's
> report. Ouch!
>
> There isn't going to be a 2.7 any time soon and there are people that
> are using alternate schedulers already in production; which is obviously
> why you're giving them a test run in -mm. Clearly the lack of a formal
> (2.7) development branch makes this even harder. Your attempt at
> preventing "good stuff' from rotting in alternate trees when mainline
> should be benefitting is admirable. While it's fun to rewrite the
> scheduler and gives us something to play with, the current level of
> feedback is hardly the testbase off which to replace it unless there's
> something strikingly better about a new cpu scheduler.
>
> It will be interesting to see if this spawns any further discussion or
> whether Peter's scheduler's performance will also be lost in a low
> signal to noise ratio when it gets a run in -mm.

I think the problem is that relatively not so many people run -mm, and even 
less people try to use them for a longer time.  Also, there sometimes are 
some issues with -mm that must be sorted out first, but then there's not much 
time left for testing the scheduler before the next -mm.

Regards,
RJW

-- 
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
