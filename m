Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269328AbUIYNVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269328AbUIYNVF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 09:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269324AbUIYNVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 09:21:05 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:50848 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S269340AbUIYNTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 09:19:24 -0400
Subject: Re: 2.6.9-rc2-mm1 swsusp bug report.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Kevin Fenzi <kevin@scrye.com>,
       Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040925125606.GN9106@holomorphy.com>
References: <20040924021956.98FB5A315A@voldemort.scrye.com>
	 <20040924143714.GA826@openzaurus.ucw.cz>
	 <20040924210958.A3C5AA2073@voldemort.scrye.com>
	 <1096069216.3591.16.camel@desktop.cunninghams>
	 <20040925014546.200828E71E@voldemort.scrye.com>
	 <1096113235.5937.3.camel@desktop.cunninghams>
	 <415562FE.3080709@yahoo.com.au>  <20040925125606.GN9106@holomorphy.com>
Content-Type: text/plain
Message-Id: <1096118462.6294.0.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 25 Sep 2004 23:21:02 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2004-09-25 at 22:56, William Lee Irwin III wrote:
> Nigel Cunningham wrote:
> >> Normal usage; the pattern of pages being freed and allocated inevitably
> >> leads to fragmentation. The buddy allocator does a good job of
> >> minimising it, but what is really needed is a run-time defragmenter. I
> >> saw mention of this recently, but it's probably not that practical to
> >> implement IMHO.
> > 
> On Sat, Sep 25, 2004 at 10:22:22PM +1000, Nick Piggin wrote:
> > Well, by this stage it looks like memory is already pretty well shrunk
> > as much as it is going to be, which means that even a pretty capable
> > defragmenter won't be able to do anything.
> 
> For however useful defragmentation may be to make speculative use of
> physically or virtually contiguous memory more probable to succeed, it
> can never be made deterministic or even reliable, not even in pageable
> kernels (which Linux is not). Fallback to allocations no larger than
> the kernel's internal allocation unit, potentially in tandem with
> scatter/gather capabilities, is essential.

I fully agree. That's why I do it :>

Regards,

Nigel

