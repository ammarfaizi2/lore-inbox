Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266195AbUIOCAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266195AbUIOCAm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 22:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266627AbUIOCAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 22:00:42 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:64687 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266195AbUIOCAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 22:00:40 -0400
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
From: Lee Revell <rlrevell@joe-job.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Love <rml@ximian.com>,
       Andrea Arcangeli <andrea@novell.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040915014610.GG9106@holomorphy.com>
References: <4146F33C.9030504@yahoo.com.au>
	 <20040914140905.GM4180@dualathlon.random> <41470021.1030205@yahoo.com.au>
	 <20040914150316.GN4180@dualathlon.random>
	 <1095185103.23385.1.camel@betsy.boston.ximian.com>
	 <20040914185212.GY9106@holomorphy.com>
	 <1095188569.23385.11.camel@betsy.boston.ximian.com>
	 <20040914192104.GB9106@holomorphy.com>
	 <1095189593.16988.72.camel@localhost.localdomain>
	 <1095207749.2406.36.camel@krustophenia.net>
	 <20040915014610.GG9106@holomorphy.com>
Content-Type: text/plain
Message-Id: <1095213644.2406.90.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 14 Sep 2004 22:00:44 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-14 at 21:46, William Lee Irwin III wrote:
> On Tue, Sep 14, 2004 at 08:22:29PM -0400, Lee Revell wrote:
> > Although, there is at least one case (reiser3) where we know which data
> > structures the BKL is supposed to be protecting, because the code does
> > something like reiserfs_write_lock(foo_data_structure) which gets
> > define'd away to lock_kernel().  And apparently some of the best and
> > brightest on LKML have tried and failed to fix it, and even Hans says
> > "it's HARD, the fix is reiser4".
> > So, maybe some of the current uses should be tagged as WONTFIX.
> 
> I've not heard a peep about anyone trying to fix this. It should be
> killed off along with the rest, of course, but like I said before, it's
> the messiest, dirtiest, and ugliest code that's left to go through,
> which is why it's been left for last. e.g. driver ->ioctl() methods.
> 

Andrew tried to fix this a few times in 2.4 and it broke the FS in
subtle ways.  Don't have an archive link but the message is
<20040712163141.31ef1ad6.akpm@osdl.org>.  I asked Hans directly about it
and he said "balancing makes it hard, the fix is reiser4", see
<411925FA.2000303@namesys.com>.

Lee 

