Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264197AbUD0Qs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264197AbUD0Qs6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 12:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264199AbUD0Qs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 12:48:58 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:64659 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264197AbUD0Qry (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 12:47:54 -0400
Subject: Re: sched_domains and Stream benchmark
From: Darren Hart <dvhltc@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@muc.de>
In-Reply-To: <20040427023327.GB11321@colin2.muc.de>
References: <1N7xQ-7fh-29@gated-at.bofh.it>
	 <m3r7uitr1r.fsf@averell.firstfloor.org> <1083018633.3070.8.camel@farah>
	 <20040427023327.GB11321@colin2.muc.de>
Content-Type: text/plain
Message-Id: <1083084439.2733.34.camel@farah>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 27 Apr 2004 09:47:19 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-04-26 at 19:33, Andi Kleen wrote:
> > I noticed your binary ran with N=2000000 which is only sufficient for a
> > 2 proc 1 MB cache opteron box according to the documentation on the
> 
> It does not seem to make any difference. 

I was under the impression you didn't change the N value (array size)
and ran the benchmark with someone else's precompiled binaries (the ones
you sent me).  Did you have two binaries with different array sizes
compiled in, or did I miss some way of configuring that?  The
documentation was admittedly sparse.

> > stream faq.  I also noticed wide variation in results (25% or so) when
> > running with 4 threads on a 4 proc opteron on linux-2.6.5-mm5.  Can you
> > provide me with the specs of the system you ran your tests on?
> 
> Yes, mm5 is still broken because it has the "tuned to numasaurus" numa
> scheduler. Run it on a standard (non mm*) kernel or with Ingo's early 
> load balance patch.

I ran it on 2.6.5, 2.6.5-mm5, and 2.6.5-mm5-flat-domains trying to
reproduce the results you found (including the poor performance of
virgin and mm) so that I can have some context while analyzing the
sched_domains topology on x86_64 and its effects on performance.  So
that I can see where the differences lie in our tests, could you please
provide some of the specs of the system you ran on, such as number of
procs, cache size, and amount of RAM.

Thanks,

--Darren

