Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262492AbVD3C4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262492AbVD3C4S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 22:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbVD3C4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 22:56:18 -0400
Received: from fmr16.intel.com ([192.55.52.70]:2237 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S262492AbVD3C4K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 22:56:10 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC][PATCH] i386 x86-64 Eliminate Local APIC timer interrupt
Date: Fri, 29 Apr 2005 19:55:53 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB60049EE97A@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC][PATCH] i386 x86-64 Eliminate Local APIC timer interrupt
Thread-Index: AcVNLP0YhPPO24RTTHKoqEJXB13yVAAAdb0g
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <torvalds@osdl.org>, <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       "Shah, Rajesh" <rajesh.shah@intel.com>, <johnstul@us.ibm.com>,
       <ak@suse.de>, "Mallick, Asit K" <asit.k.mallick@intel.com>
X-OriginalArrivalTime: 30 Apr 2005 02:55:54.0768 (UTC) FILETIME=[206C8900:01C54D30]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: Andrew Morton [mailto:akpm@osdl.org] 
>Sent: Friday, April 29, 2005 7:33 PM
>To: Pallipadi, Venkatesh
>Cc: torvalds@osdl.org; mingo@elte.hu; 
>linux-kernel@vger.kernel.org; Shah, Rajesh; 
>johnstul@us.ibm.com; ak@suse.de; Mallick, Asit K
>Subject: Re: [RFC][PATCH] i386 x86-64 Eliminate Local APIC 
>timer interrupt
>
>The patch (at least, as I merged it) goes into a ghastly death 
>spiral early
>in boot.
>
>Serial console says:
>
>
>Initializing CPU#1
>Calibrating delay using timer specific routine.. 5615.95 
>BogoMIPS (lpj=2807978)
>CPU: Trace cache: 12K uops, L1 D cache: 8K
>CPU: L2 cache: 512K
>CPU: Physical Processor ID: 0
>CPU1: Intel Pentium 4 (Northwood) stepping 07
>Total of 2 processors activated (11238.26 BogoMIPS).
>ENABLING IO-APIC IRQs
>..TIMER: vector=0x31 pin1=2 pin2=-1
>checking TSC synchronization across 2 CPUs: passed.
>Brought up 2 CPUs
>Unable to handle kernel NULL pointer dereference
>
>which isn't very helpful.
>
>tty output is at 
>http://www.zip.com.au/~akpm/linux/patches/stuff/dsc02506.jpg
>
>which is also less that totally useful.
>
>There's waaaaaaaaay too much low-level x86 stuff happening at 
>present.  We
>need to settle it down, go more slowly, take more care and test things
>better, please.  Next -mm has already been delayed by two days 
>due to my
>having to chase down all the bugs people have been sending me.
>

I did test this patch on variety of systems and didn't see any failures.

Probably some other change in mm conflicting with this patch? 
Is there way to get the all the patches in mm, so that I can try same
Kernel and reproduce this failure?

I agree though that this patch is very risky and needs some discussion 
and lot of testing before it goes into base.

Thanks,
Venki
