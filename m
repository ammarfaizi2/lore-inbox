Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265597AbSJXS4O>; Thu, 24 Oct 2002 14:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265598AbSJXS4O>; Thu, 24 Oct 2002 14:56:14 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:61338 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265597AbSJXS4M>; Thu, 24 Oct 2002 14:56:12 -0400
Subject: Re: Crunch time -- the musical.  (2.5 merge candidate list 1.5)
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: landley@trommello.org
Cc: linux-kernel@vger.kernel.org, Erich Focht <efocht@ess.nec.de>
In-Reply-To: <200210240750.09751.landley@trommello.org>
References: <200210231626.12903.landley@trommello.org>
	<1035476230.1274.1065.camel@dyn9-47-17-164.beaverton.ibm.com> 
	<200210240750.09751.landley@trommello.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 24 Oct 2002 12:01:01 -0700
Message-Id: <1035486061.9367.1078.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-24 at 05:50, Rob Landley wrote:
> On Thursday 24 October 2002 11:17, Michael Hohnbaum wrote:
> > On Wed, 2002-10-23 at 14:26, Rob Landley wrote:
> > > 26) NUMA aware scheduler extenstions (Erich Focht, Michael Hohnbaum)
> > >
> > > Home page:
> > > http://home.arcor.de/efocht/sched/
> > >
> > > Patch:
> > > http://home.arcor.de/efocht/sched/Nod20_numa_sched-2.5.31.patch
> >
> > The simple NUMA scheduler patch, which is ready for inclusion is a
> > separate project from Erich's NUMA scheduler extensions.  Information
> > on the simple NUMA scheduler is contained in this lkml posting:
> >
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=103351680614980&w=2
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=103480772901235&w=2
> >
> > The most recent version has been split into two patches for 2.5.44:
> >
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=103539626130709&w=2
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=103540481010560&w=2
> 
> Any relation to http://lse.sourceforge.net/numa/ which the 2.5 status list 
> says is "Alpha" state, two steps down from "Ready"?
> 
> Rob

Yes and no.  At one point I was working with Erich moving his NUMA 
scheduler to 2.5 and testing it on our NUMA hardware.  However, it
was not looking like his NUMA scheduler was going to be ready for 
2.5, so I went off on a separate effort to produce a much smaller,
simpler patch to provide rudimentary NUMA support within the scheduler.
This patch does not have all the functionality of Erich's, but does
provide definite performance improvements on NUMA machines with no
degradation on non-NUMA SMP.  It is much smaller and less intrusive,
and has been tested on multiple NUMA architectures (including by 
Erich on the NEC IA64 NUMA box).

The 2.5 status list has not been updated to reflect this separate 
effort, and I believe incorrectly lists this entry as "ready".  There
really are now two NUMA scheduler projects:

* Simple NUMA scheduler (Michael Hohnbaum)  - ready for inclusion
* Node affine NUMA scheduler (Erich Focht)  - Alpha (Beta?)

-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

