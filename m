Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266836AbUIOBrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266836AbUIOBrX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 21:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266663AbUIOBrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 21:47:20 -0400
Received: from holomorphy.com ([207.189.100.168]:8344 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266627AbUIOBqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 21:46:20 -0400
Date: Tue, 14 Sep 2004 18:46:10 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Love <rml@ximian.com>,
       Andrea Arcangeli <andrea@novell.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
Message-ID: <20040915014610.GG9106@holomorphy.com>
References: <4146F33C.9030504@yahoo.com.au> <20040914140905.GM4180@dualathlon.random> <41470021.1030205@yahoo.com.au> <20040914150316.GN4180@dualathlon.random> <1095185103.23385.1.camel@betsy.boston.ximian.com> <20040914185212.GY9106@holomorphy.com> <1095188569.23385.11.camel@betsy.boston.ximian.com> <20040914192104.GB9106@holomorphy.com> <1095189593.16988.72.camel@localhost.localdomain> <1095207749.2406.36.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095207749.2406.36.camel@krustophenia.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-14 at 15:19, Alan Cox wrote:
>> Fix the data structure locking starting at the lowest level is how I've
>> always tackled these messes. When the low level locking is right the
>> rest just works (usually 8)).
>> 	"Lock data not code"

On Tue, Sep 14, 2004 at 08:22:29PM -0400, Lee Revell wrote:
> Although, there is at least one case (reiser3) where we know which data
> structures the BKL is supposed to be protecting, because the code does
> something like reiserfs_write_lock(foo_data_structure) which gets
> define'd away to lock_kernel().  And apparently some of the best and
> brightest on LKML have tried and failed to fix it, and even Hans says
> "it's HARD, the fix is reiser4".
> So, maybe some of the current uses should be tagged as WONTFIX.

I've not heard a peep about anyone trying to fix this. It should be
killed off along with the rest, of course, but like I said before, it's
the messiest, dirtiest, and ugliest code that's left to go through,
which is why it's been left for last. e.g. driver ->ioctl() methods.


-- wli
