Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030262AbWA0C7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbWA0C7N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 21:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbWA0C7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 21:59:13 -0500
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:17641 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1030262AbWA0C7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 21:59:13 -0500
From: Con Kolivas <kernel@kolivas.org>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: smp 'nice' bias support breaks scheduler behavior
Date: Fri, 27 Jan 2006 13:58:52 +1100
User-Agent: KMail/1.9
Cc: Peter Williams <pwil3058@bigpond.net.au>, mingo@elte.hu,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
References: <20060126025220.B8521@unix-os.sc.intel.com> <200601271254.54009.kernel@kolivas.org> <20060126181118.C19789@unix-os.sc.intel.com>
In-Reply-To: <20060126181118.C19789@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601271358.52501.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 January 2006 13:11, Siddha, Suresh B wrote:
> On Fri, Jan 27, 2006 at 12:54:53PM +1100, Con Kolivas wrote:
> > It's not my decision to keep Peter's patch out of mainline. If you can
> > make a strong enough case for it then Linus will merge it up even though
> > it's after rc1.
>
> I don't want to push Peters patch to 2.6.16, as I haven't tested much.
>
> > Otherwise I'll let Ingo decide on whether to pull the current
> > implementation or not - you're saying that with the one thing you
> > described that misbehaves that it is doing more harm than fixing smp nice
> > handling.
>
> Are we sure that it really fixes smp nice handling? Its not just one
> scenario(bouncing processes on a lightly loaded system), I am talking
> about. Imbalance calculations will be wrong even on a completely loaded
> system.. Are you sure that there are no perf regressions with your patch..

It was extensively tested for more than 3 months in the -mm tree. Early on 
there were accounting bugs in the code which I corrected and we saw no 
performance regression after that across a wide range of benchmarks and 
hardware configurations at the time thanks to M Bligh. (see test.kernel.org) 
Some were done on the osdl (STP) test bench showing no regression as well but 
the osdl infrastructure became pretty much unworkable not long after.

> Sorry for commenting on this patch so late.. I was on a very long vacation.
> I think it is safe to back that out for 2.6.16 and do more work and get it
> in 2.6.17.

Well I have no emotional investment in the code, I just want to do what's 
right. In the absence of measurable throughput regressions and improvement in 
smp nice handling I don't believe we should back it out.

Cheers,
Con
