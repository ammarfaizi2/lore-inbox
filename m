Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbUDSX7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbUDSX7p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 19:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbUDSX7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 19:59:45 -0400
Received: from FW-30-241.go.retevision.es ([62.174.241.30]:49585 "EHLO
	mayhem.ghetto") by vger.kernel.org with ESMTP id S261296AbUDSX7n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 19:59:43 -0400
Date: Tue, 20 Apr 2004 01:59:41 +0200
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: CFQ iosched praise: good perfomance and better latency
Message-ID: <20040419235941.GA1112@larroy.com>
Mail-Followup-To: Nick Piggin <nickpiggin@yahoo.com.au>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040419005651.GA7860@larroy.com> <40835F4E.5000308@yahoo.com.au> <20040418225752.56d10695.akpm@osdl.org> <40836DE8.5080303@yahoo.com.au> <20040419113243.GA18042@larroy.com> <4083BDBB.2050904@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4083BDBB.2050904@yahoo.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: piotr@larroy.com (Pedro Larroy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2004 at 09:53:31PM +1000, Nick Piggin wrote:
> Pedro Larroy wrote:
> >On Mon, Apr 19, 2004 at 04:12:56PM +1000, Nick Piggin wrote:
> 
> >>Well I think Pedro actually means *seconds*, not ms. The URL
> >>shows AS peaks at nearly 10 seconds latency, and CFQ over 2s.
> >
> >
> >Yes, I meant seconds, my mistake. I will be testing elevator=noop this
> >evening.
> >
> 
> That would be interesting.
> 
> >
> >>It really seems like a raid problem though, because latency
> >>measured at the individual devices is under 250ms for AS.
> >
> >
> >Probably. But I was surprised to find that bonnie gave similar results
> >with CFQ and with AS when benchmarking the swraid5.
> 
> I haven't used bonnie, but I think it is single threaded, isn't
> it? If that is the case, then the IO scheduler will make little
> or no difference, so your result is not surprising.

Seems your suspicions were correct, the delay patterns are pretty
similar with all the schedulers, and the big delays aren't caused by the
ioscheduler aparently. I've updated the graphs. In 2.6.5-mm3
at least, all the ioschedulers give alike latencies. I wonder now how did I
get previous measures around 6000ms. I think I blamed a previous
misbehaving kernel version on the ioscheduler. My apologies.

Is there any interest to hack in md code? IIRC the plans are to use dm
in the near future.

Regards.
-- 
Pedro Larroy Tovar | Linux & Network consultant |  piotr%member.fsf.org 

Software patents are a threat to innovation in Europe please check: 
	http://www.eurolinux.org/     
