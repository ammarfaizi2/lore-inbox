Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269726AbUINTlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269726AbUINTlf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 15:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269628AbUINTin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 15:38:43 -0400
Received: from holomorphy.com ([207.189.100.168]:2198 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269726AbUINTfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 15:35:01 -0400
Date: Tue, 14 Sep 2004 12:34:48 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Robert Love <rml@ximian.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
Message-ID: <20040914193448.GF9106@holomorphy.com>
References: <4146EA3E.4010804@yahoo.com.au> <20040914132225.GA9310@elte.hu> <4146F33C.9030504@yahoo.com.au> <20040914140905.GM4180@dualathlon.random> <41470021.1030205@yahoo.com.au> <20040914150316.GN4180@dualathlon.random> <1095185103.23385.1.camel@betsy.boston.ximian.com> <20040914185212.GY9106@holomorphy.com> <1095188569.23385.11.camel@betsy.boston.ximian.com> <20040914192512.GA3365@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914192512.GA3365@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 03:02:49PM -0400, Robert Love wrote:
>> Getting rid of these, or at least better delineating them, will move the
>> BKL closer to being just a very granular lock.
>> cond_resched_bkl() is a step toward that.

On Tue, Sep 14, 2004 at 09:25:13PM +0200, Andrea Arcangeli wrote:
> yes, I don't think it will make thing worse in respect of dropping the
> bkl, if something it should help.
> probably the bkl is still there because removing it won't bring much
> further value to the kernel at runtime, it'd probably only make the
> kernel a bit cleaner and simpler.

I think the real trouble is that the locking being so hard to analyze,
especially  when it's intermixed with normal locking, causes real bugs.


-- wli
