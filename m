Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265963AbUF2TLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265963AbUF2TLw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 15:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265959AbUF2TLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 15:11:52 -0400
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:19435 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S265970AbUF2TLu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 15:11:50 -0400
Date: Tue, 29 Jun 2004 21:11:48 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: john stultz <johnstul@us.ibm.com>
Cc: Frederic Krueger <spamalltheway@bigfoot.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: io apic + tsc = slowdown (bugreport + possible fix)
In-Reply-To: <1088534977.1388.3.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.55.0406292107570.31801@jurand.ds.pg.gda.pl>
References: <40DFC853.20803@bigfoot.com>  <1088467569.1944.10.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.55.0406291358010.31801@jurand.ds.pg.gda.pl>
 <1088534977.1388.3.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jun 2004, john stultz wrote:

> >  Please folks do read the sources sometimes -- I've been repeatedly
> > clarifying these bits while they are all documented in the sources,
> > sigh...
> 
> Whoops, sorry, I had the impression the patch was targeted against 2.6,

 It works the same way for both series.

> where there is no do_slow_gettimeoffset() and the only user of timer_ack
> is in do_timer_interrupt(). 

 A quick search reveals the bits were moved to do_timer_overflow() in
include/asm-i386/mach-default/do_timer.h which is used by
arch/i386/kernel/timers/timer_pit.c -- I suppose the comment in 
arch/i386/kernel/time.c needs an update then.

> So am I incorrect that the TSC bits can be dropped for the 2.6 version
> of the patch?

 You are, sorry.

  Maciej
