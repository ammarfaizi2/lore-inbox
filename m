Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264973AbUHHCdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264973AbUHHCdY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 22:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264980AbUHHCdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 22:33:24 -0400
Received: from holomorphy.com ([207.189.100.168]:28119 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264973AbUHHCdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 22:33:13 -0400
Date: Sat, 7 Aug 2004 19:33:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] preempt-timing-on-2.6.8-rc2-O2
Message-ID: <20040808023306.GP17188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1091403477.862.4.camel@mindpipe> <1091407585.862.40.camel@mindpipe> <20040802073938.GA8332@elte.hu> <1091435237.3024.9.camel@mindpipe> <20040802092855.GA15894@elte.hu> <20040802100815.GA18349@elte.hu> <20040802101840.GB2334@holomorphy.com> <20040802103516.GA20584@elte.hu> <20040802105100.GA22855@elte.hu> <1091932214.1150.3.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091932214.1150.3.camel@mindpipe>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-02 at 06:51, Ingo Molnar wrote:
>> Newest patch at:
>>  http://redhat.com/~mingo/voluntary-preempt/preempt-timing-on-2.6.8-rc2-O2

On Sat, Aug 07, 2004 at 10:31:06PM -0400, Lee Revell wrote:
> I get a *lot* of these:
> (swapper/0): 996us non-preemptible critical section violated 100 us
> preempt threshold starting at schedule+0x55/0x5a0 and ending at
> do_IRQ+0x110/0x180
>  [<c0106717>] dump_stack+0x17/0x20
>  [<c0113eec>] dec_preempt_count+0x3c/0x50
>  [<c0107a20>] do_IRQ+0x110/0x180
>  [<c01062d8>] common_interrupt+0x18/0x20
>  [<c0104222>] cpu_idle+0x32/0x50
>  [<c030a782>] start_kernel+0x1a2/0x1f0
>  [<c010019f>] 0xc010019f
> This has to be a false positive, because if there were really ~1ms
> non-preemptible critical sections all over the place I would be getting
> xruns.

This seems to be 996us spent in do_IRQ() when it interrupts idle tasks.

-- wli
