Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbUCaS7o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 13:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbUCaS7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 13:59:44 -0500
Received: from mail01.hpce.nec.com ([193.141.139.228]:63393 "EHLO
	mail01.hpce.nec.com") by vger.kernel.org with ESMTP id S262345AbUCaS7j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 13:59:39 -0500
From: Erich Focht <efocht@hpce.nec.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
Date: Wed, 31 Mar 2004 20:59:23 +0200
User-Agent: KMail/1.5.4
Cc: nickpiggin@yahoo.com.au, mbligh@aracnet.com, mingo@elte.hu, ak@suse.de,
       jun.nakajima@intel.com, ricklind@us.ibm.com,
       linux-kernel@vger.kernel.org, kernel@kolivas.org, rusty@rustcorp.com.au,
       anton@samba.org, lse-tech@lists.sourceforge.net
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com> <200403301204.14303.efocht@hpce.nec.com> <20040330030242.56221bcf.akpm@osdl.org>
In-Reply-To: <20040330030242.56221bcf.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403312059.23287.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 March 2004 13:02, Andrew Morton wrote:
> Erich Focht <efocht@hpce.nec.com> wrote:
> >  > And finally, HPC
> >  > applications are the very ones that should be using CPU
> >  > affinities because they are usually tuned quite tightly to the
> >  > specific architecture.
> >
> >  There are companies mainly selling NUMA machines for HPC (SGI?), so
> >  this is not a niche market.
>
> It is niche in terms of number of machines and in terms of affected users.
> And the people who provide these machines have the resources to patch the
> scheduler if needs be.

Uhm, depends on the CPUs you think of. I bet much more than half of
the Opterons and Itanium2 CPUs sold last year went into HPC. Certainly
not so many IA64s went into NUMA machines. But almost all Opterons ;-)
IBM's NUMA machines with Power CPUs are mainly sold with AIX into the
HPC market, I don't recall to have seen big HPC installations with HP
Superdome under Linux, not yet...? IBM sells x86-NUMA more into the
commercial market, the only big visible Linux-NUMA in HPC is SGI's
Altix. Most of the other NUMA machines go into HPC with other OSes and
we don't care about them (yet?). So you're probably right about the
number of Linux-NUMA-HPC users, but this actually shows that
Linux-NUMA is currently not the ideal choice. We're working on it,
right?

> Correct me if I'm wrong, but what we have here is a situation where if we
> design the scheduler around the HPC requirement, it will work poorly in a
> significant number of other applications.  And we don't see a way of fixing
> this without either a /proc/i-am-doing-hpc, or a config option, or
> requiring someone to carry an external patch, yes?
>
> If so then all of those seem reasonable options to me.  We should optimise
> the scheduler for the common case, and that ain't HPC.

Yes! A per process flag would be enough to have the choice.

> If we agree that architecturally sched-domains _can_ satisfy the HPC
> requirement then I think that's good enough for now.  I'd prefer that Ingo
> and Nick not have to bust a gut trying to get optimum HPC performance
> before the code is even merged up.

Sure. On the other hand the benchmark brought into discussion by Andi
is very easy to understand, much easier than any Java monster. If the
scheduler doesn't have a screw for running this optimally, it's
disappointing.

> Do you agree that sched-domains is architected appropriately?

My current impression is: YES. My testing experience with it is
still very limited...

Regards,
Erich


