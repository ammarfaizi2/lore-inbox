Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbVBHQLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVBHQLx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 11:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbVBHQLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 11:11:53 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:37599 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261557AbVBHQLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 11:11:45 -0500
Date: Tue, 8 Feb 2005 08:11:40 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andrew Morton <akpm@osdl.org>
cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: prezeroing V6 [2/3]: ScrubD
In-Reply-To: <20050207173559.68ce30e3.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0502080807410.3169@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0501211228430.26068@schroedinger.engr.sgi.com>
 <1106828124.19262.45.camel@hades.cambridge.redhat.com> <20050202153256.GA19615@logos.cnet>
 <Pine.LNX.4.58.0502071127470.27951@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0502071131260.27951@schroedinger.engr.sgi.com>
 <20050207163035.7596e4dd.akpm@osdl.org> <Pine.LNX.4.58.0502071646170.29971@schroedinger.engr.sgi.com>
 <20050207170947.239f8696.akpm@osdl.org> <Pine.LNX.4.58.0502071710580.30068@schroedinger.engr.sgi.com>
 <20050207173559.68ce30e3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Feb 2005, Andrew Morton wrote:

> > No its a page fault benchmark. Dave Miller has done some kernel compiles
> > and I have some benchmarks here that I never posted because they do not
> > show any material change as far as I can see. I will be posting that soon
> > when this is complete (also need to do the same for the atomic page fault
> > ops and the prefaulting patch).
>
> OK, thanks.  That's important work.  After all, this patch is a performance
> optimisation.

Well its a bit complicated due to the various configuration. UP, and then
more and more processors. Plus the NUMA stuff and the standard benchmarks
that are basically not suited for SMP tests make this a bit difficult.

> > memory node is bound to a set of cpus. This may be controlled by the
> > NUMA node configuration. F.e. for nodes without cpus.
>
> kthread_bind() should be able to do this.  From a quick read it appears to
> have shortcomings in this department (it expects to be bound to a single
> CPU).

Sorry but I still do not get what the problem is? kscrubd does exactly
what kswapd does and can be handled in the same way. It works fine here
on various multi node configurations and correctly gets CPUs assigned.

