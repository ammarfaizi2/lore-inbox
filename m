Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbTKKEdY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 23:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264195AbTKKEdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 23:33:24 -0500
Received: from nat-68-172-17-106.ne.rr.com ([68.172.17.106]:40182 "EHLO
	trip.jpj.net") by vger.kernel.org with ESMTP id S263340AbTKKEdX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 23:33:23 -0500
Subject: Re: I/O issues, iowait problems, 2.4 v 2.6
From: Paul Venezia <pvenezia@jpj.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031110202819.7e7433a8.akpm@osdl.org>
References: <1068519213.22809.81.camel@soul.jpj.net>
	 <20031110195433.4331b75e.akpm@osdl.org>
	 <1068523328.25805.97.camel@soul.jpj.net>
	 <20031110202819.7e7433a8.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1068524553.22809.108.camel@soul.jpj.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 Nov 2003 23:22:33 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Well that's nice and simple.  Could you please run `vmstat 1' during that
> big `dd'?  Wait for everything to achieve steady state, send us twenty
> lines of the vmstat trace?

I'd pulled this before, here's the output.

> > 
> >  I'd done bonnie++ i/o tests already, and except for an apparent NPTL issue on the per char,
> >  the block i/o numbers were fine; no abnormal results whatsoever. In fact, block r/w
> >  numbers were improved compared to 2.4.22. Now that I'm looking for it, however, I 
> >  do note extremely elevated iowait numbers during a bonnie++ run. Something in the MPT
> >  modules?
> 
> Greater than 90% I/O wait is to be expected in these tests.  What is of
> interest is the overall bandwidth.2.5 megabytes per second is very broken.

Definitely. I should have noted that the 2.4.22 tests on that dd came
back in 23.607s, the 2.6.0 tests hadn't returned for over 4 minutes.

> 2.5 megabytes per second is very
> broken.  I have a 53c1030 box here which uses the MPT fusion driver and it
> happily does 50MB/sec to a single disk, but I guess that's a different
> setup.

This is a 53C1030 with a RAID1 mirror. Now that I think about it, I did
the >2GB bonnie tests on a single disk, no mirror. I'll rerun the i/o
tests with this setup and then remove the mirror and see what happens.

-Paul

