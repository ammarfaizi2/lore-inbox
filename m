Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264349AbUD0VDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264349AbUD0VDz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 17:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264352AbUD0VDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 17:03:55 -0400
Received: from colin2.muc.de ([193.149.48.15]:27140 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264349AbUD0VDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 17:03:53 -0400
Date: 27 Apr 2004 23:03:52 +0200
Date: Tue, 27 Apr 2004 23:03:52 +0200
From: Andi Kleen <ak@muc.de>
To: Darren Hart <dvhltc@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andi Kleen <ak@muc.de>
Subject: Re: sched_domains and Stream benchmark
Message-ID: <20040427210352.GA53718@colin2.muc.de>
References: <1N7xQ-7fh-29@gated-at.bofh.it> <m3r7uitr1r.fsf@averell.firstfloor.org> <1083018633.3070.8.camel@farah> <20040427023327.GB11321@colin2.muc.de> <1083084439.2733.34.camel@farah>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1083084439.2733.34.camel@farah>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2004 at 09:47:19AM -0700, Darren Hart wrote:
> On Mon, 2004-04-26 at 19:33, Andi Kleen wrote:
> > > I noticed your binary ran with N=2000000 which is only sufficient for a
> > > 2 proc 1 MB cache opteron box according to the documentation on the
> > 
> > It does not seem to make any difference. 
> 
> I was under the impression you didn't change the N value (array size)
> and ran the benchmark with someone else's precompiled binaries (the ones
> you sent me).  Did you have two binaries with different array sizes

Correct.  I always used 2000000. But it did not seem to make
any difference in showing the scheduler issues even when going
to 4 CPUs.

(there were some fluctuations, but much less than the 25% you reported)

> > > stream faq.  I also noticed wide variation in results (25% or so) when
> > > running with 4 threads on a 4 proc opteron on linux-2.6.5-mm5.  Can you
> > > provide me with the specs of the system you ran your tests on?
> > 
> > Yes, mm5 is still broken because it has the "tuned to numasaurus" numa
> > scheduler. Run it on a standard (non mm*) kernel or with Ingo's early 
> > load balance patch.
> 
> I ran it on 2.6.5, 2.6.5-mm5, and 2.6.5-mm5-flat-domains trying to
> reproduce the results you found (including the poor performance of
> virgin and mm) so that I can have some context while analyzing the
> sched_domains topology on x86_64 and its effects on performance.  So
> that I can see where the differences lie in our tests, could you please
> provide some of the specs of the system you ran on, such as number of
> procs, cache size, and amount of RAM.

I saw the issue on a wide range of systems, ranging from 2 CPUs to 4 CPUs.
All hard enough per CPU memory to fit the benchmark.

-Andi
