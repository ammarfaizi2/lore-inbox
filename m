Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264371AbUDSLcy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 07:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264369AbUDSLcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 07:32:53 -0400
Received: from FW-30-241.go.retevision.es ([62.174.241.30]:43944 "EHLO
	mayhem.ghetto") by vger.kernel.org with ESMTP id S264371AbUDSLcu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 07:32:50 -0400
Date: Mon, 19 Apr 2004 13:32:43 +0200
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: CFQ iosched praise: good perfomance and better latency
Message-ID: <20040419113243.GA18042@larroy.com>
Mail-Followup-To: Nick Piggin <nickpiggin@yahoo.com.au>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040419005651.GA7860@larroy.com> <40835F4E.5000308@yahoo.com.au> <20040418225752.56d10695.akpm@osdl.org> <40836DE8.5080303@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40836DE8.5080303@yahoo.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: piotr@larroy.com (Pedro Larroy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2004 at 04:12:56PM +1000, Nick Piggin wrote:
> Andrew Morton wrote:
> >Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> >
> >>Pedro Larroy wrote:
> >>
> >>>Hi
> >>>
> >>>I've been trying CFQ ioscheduler in my software raid5 with nice results,
> >>>I've observed that a latency pattern still exists, just as in the
> >>>anticipatory ioscheduler, but those spikes are now much lower (from
> >>>6ms with AS to 2ms with CFQ as seen in the bottom of
> >>>http://pedro.larroy.com/devel/iolat/analisys/),
> >>>plus apps seems to get a fair amount of io so they don't get starved.
> >>>
> >>>Seems a good choice for io loaded boxes. Thanks Jens Axboe.
> >>>
> >>
> >>Although AS isn't at its best when behind raid devices (it should
> >>probably be in front of them), you could be seeing some problem
> >>with the raid code.
> >>
> >>I'd be interested to see what the graph looks like with elevator=noop
> >
> >
> >This isn't a very surprising result, is it?  AS throws away latency to gain
> >throughput.  Pedro is measuring latency...
> >
> 
> Well I think Pedro actually means *seconds*, not ms. The URL
> shows AS peaks at nearly 10 seconds latency, and CFQ over 2s.

Yes, I meant seconds, my mistake. I will be testing elevator=noop this
evening.

> 
> It really seems like a raid problem though, because latency
> measured at the individual devices is under 250ms for AS.

Probably. But I was surprised to find that bonnie gave similar results
with CFQ and with AS when benchmarking the swraid5.

Regards.

-- 
Pedro Larroy Tovar | Linux & Network consultant |  piotr%member.fsf.org 

Software patents are a threat to innovation in Europe please check: 
	http://www.eurolinux.org/     
