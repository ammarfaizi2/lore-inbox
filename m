Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264550AbTCZBjU>; Tue, 25 Mar 2003 20:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264551AbTCZBjU>; Tue, 25 Mar 2003 20:39:20 -0500
Received: from bitmover.com ([192.132.92.2]:29654 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S264550AbTCZBjS>;
	Tue, 25 Mar 2003 20:39:18 -0500
Date: Tue, 25 Mar 2003 17:50:26 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Larry McVoy <lm@bitmover.com>, Andrew Morton <akpm@digeo.com>,
       venkatesh.pallipadi@intel.com, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: lmbench results for 2.4 and 2.5 -- updated results
Message-ID: <20030326015026.GA25091@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Larry McVoy <lm@bitmover.com>, Andrew Morton <akpm@digeo.com>,
	venkatesh.pallipadi@intel.com, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
References: <C8C38546F90ABF408A5961FC01FDBF19010485F1@fmsmsx405.fm.intel.com> <20030324200105.GA5522@work.bitmover.com> <543480000.1048540161@flay> <20030324153602.28b44e23.akpm@digeo.com> <20030324220435.GA11421@work.bitmover.com> <133220000.1048616630@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <133220000.1048616630@[10.10.2.4]>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In general, LMbench optimizes for fast results over exactness.  You can
definitely get more accurate results by doing longer runs.  My view
at the time of writing it was that I was looking for the broad stroke
results because I was trying to measure differences between various
operating systems.  There was more than enough to show so the results
didn't need to be precise, getting people to run the benchmark and
report results was more important.

If people are doing release runs to see if there are regressions, I
think that setting ENOUGH up to something longer is a good idea.
If there is enough interest, I could spend some time on this and
try and make a more accurate way to get results.  Let me know.

On Tue, Mar 25, 2003 at 10:23:50AM -0800, Martin J. Bligh wrote:
> > work ~/LMbench2/bin/i686-pc-linux-gnu ENOUGH=1000000 time bw_pipe
> > Pipe bandwidth: 655.37 MB/sec
> > real    0m23.411s
> > user    0m0.480s
> > sys     0m1.180s
> > 
> > work ~/LMbench2/bin/i686-pc-linux-gnu time bw_pipe
> > Pipe bandwidth: 809.81 MB/sec
> > 
> > real    0m2.821s
> > user    0m0.480s
> > sys     0m1.180s
> 
> OK, is a bit more stable now ... before:
> 
> Process fork+exit: 294.4118 microseconds
> Process fork+exit: 279.1500 microseconds
> Process fork+exit: 280.0000 microseconds
> Process fork+exit: 280.0000 microseconds
> Process fork+exit: 277.2222 microseconds
> Process fork+exit: 286.0000 microseconds
> Process fork+exit: 277.6231 microseconds
> Process fork+exit: 307.1176 microseconds
> Process fork+exit: 295.4706 microseconds
> Process fork+exit: 294.3529 microseconds
> 
> after:
> 
> Process fork+exit: 298.4124 microseconds
> Process fork+exit: 298.6746 microseconds
> Process fork+exit: 297.7784 microseconds
> Process fork+exit: 294.8297 microseconds
> Process fork+exit: 299.6249 microseconds
> Process fork+exit: 297.6771 microseconds
> Process fork+exit: 297.9801 microseconds
> Process fork+exit: 293.1421 microseconds
> Process fork+exit: 281.9868 microseconds
> 
> I can probably butcher that around by taking a few derived medians and
> averages to get pretty consistent numbers out of it (std dev < 1% for 99%
> of the time). Though 10 runs with ENOUGH=1000000 is kinda slow for all
> tests, so I probably won't be able to do this by default for every version.
> If there are any more suggestions on added stability, I'd love to hear them.
> 
> Is cool to have something big enough to profile too ;-)
> 
> Thanks very much,
> 
> M.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
