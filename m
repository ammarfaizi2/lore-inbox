Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWAFAIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWAFAIO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752315AbWAFAIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:08:13 -0500
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:9860 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1752313AbWAFAIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:08:10 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [PATCH] sched: Fix adverse effects of NFS client   on interactive response
Date: Fri, 6 Jan 2006 11:08:26 +1100
User-Agent: KMail/1.8.2
Cc: Mike Galbraith <efault@gmx.de>, Helge Hafting <helgehaf@aitel.hist.no>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <5.2.1.1.2.20060105070601.026b21f0@pop.gmx.net> <200601061033.10001.kernel@kolivas.org> <43BDB37D.1030601@bigpond.net.au>
In-Reply-To: <43BDB37D.1030601@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601061108.26561.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2006 11:02 am, Peter Williams wrote:
> Con Kolivas wrote:
> > On Fri, 6 Jan 2006 10:13 am, Peter Williams wrote:
> >>If the plugsched patches were included in -mm we could get wider testing
> >>of alternative scheduling mechanisms.  But I think it will take a lot of
> >>testing of the new schedulers to allay fears that they may introduce new
> >>problems of their own.
> >
> > When I first generated plugsched and posted it to lkml for inclusion in
> > -mm it was blocked as having no chance of being included by both Ingo and
> > Linus and I doubt they've changed their position since then. As you're
> > well aware this is why I gave up working on it and let you maintain it
> > since then. Obviously I thought it was a useful feature or I wouldn't
> > have worked on it.
>
> I've put a lot of effort into reducing code duplication and reducing the
> size of the interface and making it completely orthogonal to load
> balancing so I'm hopeful (perhaps mistakenly) that this makes it more
> acceptable (at least in -mm).

The objection was to dilution of developer effort towards one cpu scheduler to 
rule them all. Linus' objection was against specialisation - he preferred one 
cpu scheduler that could do everything rather than unique cpu schedulers for 
NUMA, SMP, UP, embedded... Each approach has its own arguments and there 
isn't much point bringing them up again. We shall use Linux as the 
"steamroller to crack a nut" no matter what that nut is.

> My testing shows that there's no observable difference in performance
> between a stock kernel and plugsched with ingosched selected at the
> total system level (although micro benchmarking may show slight
> increases in individual operations).

I could find no difference either, but IA64 which does not cope with 
indirection well would probably suffer a demonstrable performance hit I have 
been told. I do not have access to such hardware.

> Anyway, I'll just keep plugging away,

Nice pun.

Cheers,
Con
