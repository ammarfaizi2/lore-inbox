Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264554AbTCZCI0>; Tue, 25 Mar 2003 21:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264555AbTCZCI0>; Tue, 25 Mar 2003 21:08:26 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:62187 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264554AbTCZCIW>; Tue, 25 Mar 2003 21:08:22 -0500
Date: Tue, 25 Mar 2003 18:09:31 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Larry McVoy <lm@bitmover.com>
cc: Andrew Morton <akpm@digeo.com>, venkatesh.pallipadi@intel.com,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: lmbench results for 2.4 and 2.5 -- updated results
Message-ID: <1424610000.1048644571@flay>
In-Reply-To: <20030326015026.GA25091@work.bitmover.com>
References: <C8C38546F90ABF408A5961FC01FDBF19010485F1@fmsmsx405.fm.intel.com> <20030324200105.GA5522@work.bitmover.com> <543480000.1048540161@flay> <20030324153602.28b44e23.akpm@digeo.com> <20030324220435.GA11421@work.bitmover.com> <133220000.1048616630@[10.10.2.4]> <20030326015026.GA25091@work.bitmover.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In general, LMbench optimizes for fast results over exactness.  You can
> definitely get more accurate results by doing longer runs.  My view
> at the time of writing it was that I was looking for the broad stroke
> results because I was trying to measure differences between various
> operating systems.  There was more than enough to show so the results
> didn't need to be precise, getting people to run the benchmark and
> report results was more important.
> 
> If people are doing release runs to see if there are regressions, I
> think that setting ENOUGH up to something longer is a good idea.
> If there is enough interest, I could spend some time on this and
> try and make a more accurate way to get results.  Let me know.

Well, I'd certainly be interested ... I think it's almost inevitable 
that there's a bit of variations in timing ... the way I normally deal 
with that is to do, say 30 runs, sort the results, throw away the top 
and bottom 10, and take the average of the middle 10. 

Now at the moment, I presume you're presenting back an average of all
the runs you did ... if so, that looses some of the data to calculate
that, so we have to do multiple runs, etc and it all gets a bit slower.
If you can do that kind of stats op inside the lmbench tools, it
might help. Of course, I can do that outside as a wrapper, but then
there's the fork/exec setup time of the program to consider, etc etc.

The other interesting question is *why* there's so much variability
in results in the first place. Indicative of some inner kernel problem?
People have talked about page colouring, etc before, but I've tried
before, and never mananged to generate any data showing a benefit for
std dev of runs or whatever. Incidentally, this means that giving std
dev (of the used subset, and all results) from lmbench would be fun ;-)

The other problem was the "make it long enough to profile" thing ...
I think the ENOUGH trick you showed us is perfectly sufficent to solve
that one ;-)

Thanks,

M.

