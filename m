Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288327AbSAMXzQ>; Sun, 13 Jan 2002 18:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288331AbSAMXzI>; Sun, 13 Jan 2002 18:55:08 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:28433 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S288327AbSAMXy7>;
	Sun, 13 Jan 2002 18:54:59 -0500
Date: Sun, 13 Jan 2002 16:52:07 -0700
From: yodaiken@fsmlabs.com
To: Robert Love <rml@tech9.net>
Cc: jogi@planetzork.ping.de, Andrew Morton <akpm@zip.com.au>,
        Ed Sweetman <ed.sweetman@wmich.edu>, Andrea Arcangeli <andrea@suse.de>,
        yodaiken@fsmlabs.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        nigel@nrg.org, Rob Landley <landley@trommello.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020113165207.A17878@hq.fsmlabs.com>
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy> <20020112121315.B1482@inspiron.school.suse.de> <20020112160714.A10847@planetzork.spacenet> <20020112095209.A5735@hq.fsmlabs.com> <20020112180016.T1482@inspiron.school.suse.de> <005301c19b9b$6acc61e0$0501a8c0@psuedogod> <3C409B2D.DB95D659@zip.com.au> <20020113184249.A15955@planetzork.spacenet> <1010946178.11848.14.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <1010946178.11848.14.camel@phantasy>; from rml@tech9.net on Sun, Jan 13, 2002 at 01:22:57PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well to start with:
	1) Maybe I should be more precise: The latency measures I've seen
	posted all favor Morton and not preempt. Since the claimed purpose
	of both patches is improving latency isn't that more interesting
	than measuremts of kernel compile?
	
	2) In these measurements
	the tree is different each time so the measurement doesn't
	seem very stable. It's not exactly a secret that file layout 
	can have an affect on performance.

	3) There is no measure of preempt without Ingo's scheduler

	4) this is what I want to see:
		Run the periodic SCHED_FIFO task I've posted multiple times
		Let's see worst case error
		Let's see effect on the background kernel compile

	All the rest is just so much talk about "interactive feel". I saw
	exactly the same claims from the people who wanted kernel graphics.




On Sun, Jan 13, 2002 at 01:22:57PM -0500, Robert Love wrote:
> On Sun, 2002-01-13 at 12:42, jogi@planetzork.ping.de wrote:
> 
> >         13-pre5aa1      18-pre2aa2      18-pre3         18-pre3s        18-pre3sp       18-pre3minill  
> > j100:   6:59.79  78%    7:07.62  76%        *           6:39.55  81%    6:24.79  83%        *
> > j100:   7:03.39  77%    8:10.04  66%        *           8:07.13  66%    6:21.23  83%        *
> > j100:   6:40.40  81%    7:43.15  70%        *           6:37.46  81%    6:03.68  87%        *
> > j100:   7:45.12  70%    7:11.59  75%        *           7:14.46  74%    6:06.98  87%        *
> > j100:   6:56.71  79%    7:36.12  71%        *           6:26.59  83%    6:11.30  86%        *
> > 		                                                                                          
> > j75:    6:22.33  85%    6:42.50  81%    6:48.83  80%    6:01.61  89%    5:42.66  93%    7:07.56  77%
> > j75:    6:41.47  81%    7:19.79  74%    6:49.43  79%    5:59.82  89%    6:00.83  88%    7:17.15  74%
> > j75:    6:10.32  88%    6:44.98  80%    7:01.01  77%    6:02.99  88%    5:48.00  91%    6:47.48  80%
> > j75:    6:28.55  84%    6:44.21  80%    9:33.78  57%    6:19.83  85%    5:49.07  91%    6:34.02  83%
> > j75:    6:17.15  86%    6:46.58  80%    7:24.52  73%    6:23.50  84%    5:58.06  88%    7:01.39  77%
> 
> Again, preempt seems to reign supreme.  Where is all the information
> correlating preempt is inferior?  To be fair, however, we should bench a
> mini-ll+s test.
> 
> But I stand by my original point that none of this matters all too
> much.  A preemptive kernel will allow for future latency reduction
> _without_ using explicit scheduling points everywhere there is a
> problem.  This means we can tackle the problem and not provide a million
> bandaids.
> 
> 	Robert Love

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

