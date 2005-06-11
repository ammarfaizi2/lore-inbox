Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVFKUNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVFKUNn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 16:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbVFKUNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 16:13:43 -0400
Received: from dvhart.com ([64.146.134.43]:43945 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261255AbVFKUNk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 16:13:40 -0400
Date: Sat, 11 Jun 2005 13:13:42 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <clameter@engr.sgi.com>,
       Nick Piggin <piggin@cyberone.com.au>
Subject: Re: 2.6.12-rc6-mm1
Message-ID: <672740000.1118520822@[10.10.2.4]>
In-Reply-To: <200506111522.30765.kernel@kolivas.org>
References: <20050607170853.3f81007a.akpm@osdl.org> <1155200000.1118447440@flay> <656430000.1118463292@[10.10.2.4]> <200506111522.30765.kernel@kolivas.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Con Kolivas <kernel@kolivas.org> wrote (on Saturday, June 11, 2005 15:22:30 +1000):

> On Sat, 11 Jun 2005 14:14, Martin J. Bligh wrote:
>> --"Martin J. Bligh" <mbligh@mbligh.org> wrote (on Friday, June 10, 2005 > > 
> OK, I backed out those 4, and the degredation mostly went away.
>> > See
>> > http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/perf/kernbench.
>> > moe.png
>> > 
>> > and more specifically, see the +p5150 near the right hand side.
>> > I don't think it's quite as good as mainline, but much closer.
>> > I did this run with HZ=1000, and the the one with no scheduler
>> > patches at all with HZ=250, so I'll try to do a run that's more
>> > directly comparable as well
>> 
>> OK, that makes it look much more like mainline. Looks like you were still
>> revising the details of your patch Con ... once you're ready, drop me a
>> URL for it, and I'll make the system whack on that too.
> 
> Great thanks. Here are rolled up all the reconsidered changes that apply 
> directly to 2.6.12-rc6-mm1 -purely for testing purposes-. I'd be very 
> grateful to see how this performed; it has been boot and stress tested at 
> this end. If it shows detriment I'll have to make the smp nice changes more 
> complex.

It's much better ... but still a degredation - see point p5181 on:

http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/perf/kernbench.moe.png

Only really seems to hurt the NUMA box (the x440 one ... elm3b67 ... is 
still trying to find it's ass with both hands). I'm not necessarily saying
it's a problem ... not sure what the benefits of the patch are, but it's a 
data point, at least ?

M.

