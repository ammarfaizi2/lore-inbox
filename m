Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267469AbSLMDNH>; Thu, 12 Dec 2002 22:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267494AbSLMDNH>; Thu, 12 Dec 2002 22:13:07 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:58251 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S267469AbSLMDNG>; Thu, 12 Dec 2002 22:13:06 -0500
Message-ID: <F2DBA543B89AD51184B600508B68D40010F1CE57@fmsmsx103.fm.intel.com>
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>,
       James Cleverdon <jamesclv@us.ibm.com>
Cc: Martin Bligh <mbligh@us.ibm.com>, John Stultz <johnstul@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][2.5][RFC] Using xAPIC apic address space on !Summit
Date: Thu, 12 Dec 2002 19:20:48 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The clustering mode we are talking about is part of xAPIC functionality, not
a NUMA (or Multi-Quad) thing. Even a non-NUMA system, it's available if it
has xAPICs. 

Jun

> -----Original Message-----
> From: Zwane Mwaikambo [mailto:zwane@holomorphy.com]
> Sent: Thursday, December 12, 2002 7:11 PM
> To: James Cleverdon
> Cc: Martin Bligh; John Stultz; Linux Kernel
> Subject: Re: [PATCH][2.5][RFC] Using xAPIC apic address space on !Summit
> 
> On Thu, 12 Dec 2002, James Cleverdon wrote:
> 
> > Sure you can physically address them, if you assign IDs using Intel's
> official
> > xAPIC numbering scheme (which must be clustered for more than 7 CPUs).
> But,
> > you still don't have enough destination address bits to go around.  In
> flat
> > mode, the kernel assumes you have one bit per CPU and phys IDs will be <
> 0xF.
> >
> > Bill tells me that you may be doing this for an emulator.  Why not
> emulate
> > clusered APIC mode, like the real hardware uses?
> >
> > I know the name x86_summit doesn't really fit.  The summit patch should
> work
> > for any xAPIC box that uses the system bus for interrupt delivery and
> has
> > multiple APIC clusters.  Is that what you're working towards?
> 
> Hmm although i could then skip the logical destination mode and stick to
> physical destination mode. This would greatly simplify my code paths since
> i could almost use the same code for both normal SMP and this larger sim.
> Debugging would then be somewhat simpler. My target doesn't have multiple
> APIC clusters and all are addressable via a 0xff broadcast.
> 
> Thanks,
> 	Zwane
> --
> function.linuxpower.ca
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
