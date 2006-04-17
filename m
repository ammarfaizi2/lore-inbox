Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbWDQWBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWDQWBo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 18:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWDQWBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 18:01:44 -0400
Received: from ns1.siteground.net ([207.218.208.2]:4302 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751274AbWDQWBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 18:01:43 -0400
Date: Mon, 17 Apr 2006 15:02:38 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Steven Rostedt <rostedt@goodmis.org>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
       Martin Mares <mj@atrey.karlin.mff.cuni.cz>, bjornw@axis.com,
       schwidefsky@de.ibm.com, benedict.gaster@superh.com, lethal@linux-sh.org,
       Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@tensilica.com>,
       Joe Taylor <joe@tensilica.com>,
       David Mosberger-Tang <davidm@hpl.hp.com>, rth@twiddle.net,
       spyro@f2s.com, starvik@axis.com, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, ralf@linux-mips.org,
       linux-mips@linux-mips.org, grundler@parisc-linux.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       paulus@samba.org, linux390@de.ibm.com, davem@davemloft.net
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
Message-ID: <20060417220238.GD3945@localhost.localdomain>
References: <1145049535.1336.128.camel@localhost.localdomain> <4440855A.7040203@yahoo.com.au> <Pine.LNX.4.64.0604170953390.29732@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604170953390.29732@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2006 at 09:55:02AM -0700, Christoph Lameter wrote:
> On Sat, 15 Apr 2006, Nick Piggin wrote:
> 
> > If I'm following you correctly, this adds another dependent load
> > to a per-CPU data access, and from memory that isn't node-affine.
> 
> I am also concerned about that. Kiran has a patch to avoid allocpercpu
> having to go through one level of indirection that I guess would no 
> longer work with this scheme.

The alloc_percpu reimplementation would work regardless of changes to
static per-cpu areas.  But, any extra indirection as was proposed initially
is bad IMHO. 

>  
> > If so, I think people with SMP and NUMA kernels would care more
> > about performance and scalability than the few k of memory this
> > saves.
> 
> Right.

Me too :)

Kiran
