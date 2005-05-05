Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262065AbVEEMD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbVEEMD1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 08:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbVEEMD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 08:03:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:56557 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262065AbVEEMDV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 08:03:21 -0400
Date: Thu, 5 May 2005 14:03:11 +0200
From: Andi Kleen <ak@suse.de>
To: Len Brown <len.brown@intel.com>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, mingo@elte.hu,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Shah, Rajesh" <rajesh.shah@intel.com>,
       John Stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Asit K Mallick <asit.k.mallick@intel.com>
Subject: Re: [RFC][PATCH] i386 x86-64 Eliminate Local APIC timer interrupt
Message-ID: <20050505120311.GM28441@wotan.suse.de>
References: <88056F38E9E48644A0F562A38C64FB60049EE972@scsmsx403.amr.corp.intel.com> <1115266581.7644.52.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115266581.7644.52.camel@d845pe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2005 at 12:16:21AM -0400, Brown, Len wrote:
> On Fri, 2005-04-29 at 22:43, Pallipadi, Venkatesh wrote:
> 
> > The patch as it is should handle 8259 case using the regular APIC
> > timer.  It only adds broadcast when IOAPIC is used for timer
> > interrupt.
> 
> While they don't need the broadcast capability of this patch,
> uniprocessors do need the change to stop using LAPIC timer
> if they support C3 (as virtually all laptops do).
> It was a mistake to allow using the LOC on a uniprocessor
> in the first place -- as the UP system runs perfectly fine
> with timers coming in on IRQ0 and doesn't need another interrupt.

Yes I agree. It does not make much sense to run two timers
on a CPU. I already changed that in my x86-64 tree. i386 will
hopefully follow at some point.

-Andi
