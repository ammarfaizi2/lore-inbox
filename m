Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264639AbUIOCgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbUIOCgg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 22:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266304AbUIOCge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 22:36:34 -0400
Received: from holomorphy.com ([207.189.100.168]:26776 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264639AbUIOCga (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 22:36:30 -0400
Date: Tue, 14 Sep 2004 19:36:11 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Love <rml@ximian.com>,
       Andrea Arcangeli <andrea@novell.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
Message-ID: <20040915023611.GH9106@holomorphy.com>
References: <41470021.1030205@yahoo.com.au> <20040914150316.GN4180@dualathlon.random> <1095185103.23385.1.camel@betsy.boston.ximian.com> <20040914185212.GY9106@holomorphy.com> <1095188569.23385.11.camel@betsy.boston.ximian.com> <20040914192104.GB9106@holomorphy.com> <1095189593.16988.72.camel@localhost.localdomain> <1095207749.2406.36.camel@krustophenia.net> <20040915014610.GG9106@holomorphy.com> <1095213644.2406.90.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095213644.2406.90.camel@krustophenia.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-14 at 21:46, William Lee Irwin III wrote:
>> I've not heard a peep about anyone trying to fix this. It should be
>> killed off along with the rest, of course, but like I said before, it's
>> the messiest, dirtiest, and ugliest code that's left to go through,
>> which is why it's been left for last. e.g. driver ->ioctl() methods.

On Tue, Sep 14, 2004 at 10:00:44PM -0400, Lee Revell wrote:
> Andrew tried to fix this a few times in 2.4 and it broke the FS in
> subtle ways.  Don't have an archive link but the message is
> <20040712163141.31ef1ad6.akpm@osdl.org>.  I asked Hans directly about it
> and he said "balancing makes it hard, the fix is reiser4", see
> <411925FA.2000303@namesys.com>.

I have neither of these locally. I suspect someone needs to care enough
about the code for anything to happen soon. I suppose there are things
that probably weren't tried, e.g. auditing to make sure dependencies on
external synchronization are taken care of, removing implicit sleeping
with the BKL held, then punt a private recursive spinlock in reiser3's
direction. Not sure what went on, or if I want to get involved in this
particular case.


-- wli
