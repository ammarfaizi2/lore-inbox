Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbWDRMsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWDRMsU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 08:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbWDRMsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 08:48:19 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:50575 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750987AbWDRMsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 08:48:17 -0400
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
From: Steven Rostedt <rostedt@goodmis.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>,
       Christoph Lameter <clameter@sgi.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
       Martin Mares <mj@atrey.karlin.mff.cuni.cz>, bjornw@axis.com,
       schwidefsky@de.ibm.com, lethal@linux-sh.org,
       Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@tensilica.com>,
       Joe Taylor <joe@tensilica.com>, rth@twiddle.net, spyro@f2s.com,
       starvik@axis.com, tony.luck@intel.com, linux-ia64@vger.kernel.org,
       ralf@linux-mips.org, linux-mips@linux-mips.org,
       grundler@parisc-linux.org, parisc-linux@parisc-linux.org,
       linuxppc-dev@ozlabs.org, paulus@samba.org, linux390@de.ibm.com,
       davem@davemloft.net
In-Reply-To: <44448A60.4040903@yahoo.com.au>
References: <1145049535.1336.128.camel@localhost.localdomain>
	 <4440855A.7040203@yahoo.com.au>
	 <Pine.LNX.4.64.0604170953390.29732@schroedinger.engr.sgi.com>
	 <20060417220238.GD3945@localhost.localdomain>
	 <Pine.LNX.4.58.0604171936040.24264@gandalf.stny.rr.com>
	 <44448A60.4040903@yahoo.com.au>
Content-Type: text/plain
Date: Tue, 18 Apr 2006 08:47:57 -0400
Message-Id: <1145364477.17085.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Removed from CC davidm@hpl.hp.com and benedict.gaster@superh.com
because I keep getting "unknown user" bounces from them]

On Tue, 2006-04-18 at 16:42 +1000, Nick Piggin wrote:
> Steven Rostedt wrote:
> 
> > Understood, but I'm going to start looking in the way Rusty and Arnd
> > suggested with the vmalloc approach. This would allow for saving of
> > memory and dynamic allocation of module memory making it more robust. And
> > all this without that evil extra indirection!
> 
> Remember that this approach could effectively just move the indirection to
> the TLB / page tables (well, I say "moves" because large kernel mappings
> are effectively free compared with 4K mappings).

Yeah, I thought about the paging latencies when it was first mentioned.
And this is something that's going to be very hard to know the impact,
because it will be different on every system.

> 
> So be careful about coding up a large amount of work before unleashing it:
> I doubt you'll be able to find a solution that doesn't involve tradeoffs
> somewhere (but wohoo if you can).
> 

OK, but as I mentioned that this is now more of a side project, so a
month of work is not really going to be a month of work ;)  I'll first
try to get something that just "works" and then post an RFC PATCH set,
to get more ideas.  Since obviously there's a lot of people out there
that know their systems much better than I do ;)

Thanks,

-- Steve


