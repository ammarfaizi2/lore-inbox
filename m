Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbVIDUmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbVIDUmV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 16:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbVIDUmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 16:42:21 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:9940 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751199AbVIDUmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 16:42:20 -0400
Date: Sun, 4 Sep 2005 13:41:54 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Con Kolivas <kernel@kolivas.org>, vatsa@in.ibm.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050904204154.GB25856@us.ibm.com>
References: <20050831165843.GA4974@in.ibm.com> <200509031801.09069.kernel@kolivas.org> <20050903090650.B26998@flint.arm.linux.org.uk> <200509031814.49666.kernel@kolivas.org> <20050904201054.GA4495@us.ibm.com> <20050904212616.B11265@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050904212616.B11265@flint.arm.linux.org.uk>
X-Operating-System: Linux 2.6.13 (i686)
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.09.2005 [21:26:16 +0100], Russell King wrote:
> On Sun, Sep 04, 2005 at 01:10:54PM -0700, Nishanth Aravamudan wrote:
> > I've got a few ideas that I think might help push Con's patch coalescing
> > efforts in an arch-independent fashion.
> 
> Note that ARM contains cleanups on top of Tony's original work, on
> which the x86 version is based.
> 
> Basically, Tony submitted his ARM version, we discussed it, fixed up
> some locking problems and simplified it (it contained multiple
> structures which weren't necessary, even in multiple timer-based systems).

<snip>

> > First of all, and maybe this is just me, I think it would be good to
> > make the dyn_tick_timer per-interrupt source, as opposed to each arch?
> > Thus, for x86, we would have a dyn_tick_timer structure for the PIT,
> > APIC, ACPI PM-timer and the HPET. These structures could be put in
> > arch-specific timer.c files (there currently is not one for x86, I
> > believe).
> 
> Each timer source should have its own struct dyn_tick_timer.  On x86,
> maybe it makes sense having a pointer in the init_timer_opts or timer_opts
> structures?

Just to be clear, I think we mean the same thing with timer source and
interrupt source. But I believe time sources are distinct (which is why<
I think, John hates the naming (his own) of timer_opts).

Thanks,
Nish
