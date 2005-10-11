Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbVJKTw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbVJKTw3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 15:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbVJKTw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 15:52:29 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:59781 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750957AbVJKTw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 15:52:29 -0400
Date: Tue, 11 Oct 2005 21:53:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.13-rt12: irqs hard off for 657 usecs
Message-ID: <20051011195301.GA29042@elte.hu>
References: <1128724690.17981.57.camel@mindpipe> <20051011112043.GB15995@elte.hu> <1129048106.12702.21.camel@mindpipe> <1129056268.4718.1.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129056268.4718.1.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> > The max latency is close to the period of the timer IRQ.  So either it's
> > an instrumentation bug or something really disables IRQs for up to 1/HZ
> > seconds.
> 
> I can no longer reproduce this with 2.6.14-rc4-rt1.  It seems to have 
> been a real IRQs disabled bug (not an instrumentation bug) as I was 
> also getting xruns with 2.6.13-rt12.

ok, please re-report if it occurs again. I havent fixed any preemption 
bug since -rt12, but maybe as a side-effect of other things? Some false 
positive latencies were fixed in the latency tracer, but since you also 
got xruns, they must have been real latencies. (albeit saving a long 
false-positive latency trace can cause a latency by itself!)

	Ingo
