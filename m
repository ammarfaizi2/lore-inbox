Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276424AbRKSSYT>; Mon, 19 Nov 2001 13:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276751AbRKSSYF>; Mon, 19 Nov 2001 13:24:05 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:41117 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S276424AbRKSSXj>; Mon, 19 Nov 2001 13:23:39 -0500
Date: Mon, 19 Nov 2001 11:23:23 -0700
Message-Id: <200111191823.fAJINNb30280@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Andi Kleen <ak@suse.de>
Cc: Mike Kravetz <kravetz@us.ibm.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        lse-tech@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: Real Time Runqueue
In-Reply-To: <20011119173022.A19740@wotan.suse.de>
In-Reply-To: <20011116154701.G1152@w-mikek2.des.beaverton.ibm.com>
	<Pine.LNX.4.40.0111161620050.998-100000@blue1.dev.mcafeelabs.com>
	<20011116163224.H1152@w-mikek2.des.beaverton.ibm.com>
	<20011119173022.A19740@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
> On Fri, Nov 16, 2001 at 04:32:24PM -0800, Mike Kravetz wrote:
> > The reason I ask is that we went through the pains of a separate
> > realtime RQ in our MQ scheduler.  And yes, it does hurt the common
> > case, not to mention the extra/complex code paths.  I was hoping
> > that someone in the know could enlighten us as to how RT semantics
> > apply to SMP systems.  If the semantics I suggest above are required,
> > then it implies support must be added to any possible future
> > scheduler implementations.
> 
> It seems a lot of applications/APIs do not care about global RT
> semantics, but about RT semantics for groups of threads or processes
> (e.g. java or ada applications). Linux currently simulates this only
> for root and with a global runqueue. I don't think it makes too much
> sense to have an global rt queue on a multi processor system, but
> there should be some way to define "scheduling groups" where rt
> semantics are followed inside.  Such a scheduling group could be a
> clone flag or default to CLONE_VM for example for compatibility.  A
> scheduling group would also make it possible to support simple rt
> semantics for thread groups as non root.  Then one could run a rt
> queue per scheduling group, and simulate global rt run queue or per
> cpu rt run queue as needed by appropiate setup.

We have to continue providing global RT semantics. However, a
non-privileged scheduling class which gives RT-like behaviour within a
scheduling group would be *great*! I've wished for such a facility
myself.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
