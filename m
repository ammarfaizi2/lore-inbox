Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264931AbTANVp6>; Tue, 14 Jan 2003 16:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264938AbTANVp6>; Tue, 14 Jan 2003 16:45:58 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:13717 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264939AbTANVpz>; Tue, 14 Jan 2003 16:45:55 -0500
Subject: Re: [Lse-tech] Re: [PATCH 2.5.58] new NUMA scheduler: fix
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: Michael Hohnbaum <hohnbaum@us.ibm.com>
Cc: Erich Focht <efocht@ess.nec.de>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Theurer <habanero@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <1042570956.27149.178.camel@dyn9-47-17-164.beaverton.ibm.com>
References: <52570000.1042156448@flay>
	<200301141655.06660.efocht@ess.nec.de>
	<200301141723.29613.efocht@ess.nec.de> 
	<200301141743.25513.efocht@ess.nec.de> 
	<1042570956.27149.178.camel@dyn9-47-17-164.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Jan 2003 13:56:33 -0800
Message-Id: <1042581395.24747.200.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-14 at 11:02, Michael Hohnbaum wrote:
> On Tue, 2003-01-14 at 08:43, Erich Focht wrote:
> > Aargh, I should have gone home earlier...
> > For those who really care about patch 05, it's attached. It's all
> > untested as I don't have a ia32 NUMA machine running 2.5.58...
> 
> One more minor problem - the first two patches are missing the
> following defines, and result in compile issues:
> 
> #define MAX_INTERNODE_LB 40
> #define MIN_INTERNODE_LB 4
> #define NODE_BALANCE_RATIO 10
> 
> Looking through previous patches, and the 05 patch, I found
> these defines and put them under the #if CONFIG_NUMA in sched.c
> that defines node_nr_running and friends.
> 
> With these three lines added, I have a kernel built and booted
> using the first numa-sched and numa-sched-add patches.
> 
> Test results will follow later in the day.

Trying to apply the 05 patch, I discovered that it was already
in there.  Something is messed up with the combined patches, so
I went back to the tgz file you provided and started over.  I'm
not sure what the kernel is that I built and tested earlier today,
but I suspect it was, for the most part, the complete patchset
(i.e., patches 1-5).  Building a kernel with patches 1-4 from
the tgz file does not need the additional defines mentioned in
my previous email.

Testing is starting from scratch with a known patch base.  The
plan is to test with patches 1-4, then add in 05.  I should have
some numbers for you before the end of my day.  btw, the numbers
looked real good for the runs on whatever kernel it was that I
built this morning.
> 
>              Michael
> 
> > Erich
-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

