Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265945AbUF2Sx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265945AbUF2Sx3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 14:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265932AbUF2Sx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 14:53:29 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:59593 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S265953AbUF2SxG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 14:53:06 -0400
Subject: Re: io apic + tsc = slowdown (bugreport + possible fix)
From: john stultz <johnstul@us.ibm.com>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Frederic Krueger <spamalltheway@bigfoot.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55.0406291358010.31801@jurand.ds.pg.gda.pl>
References: <40DFC853.20803@bigfoot.com>
	 <1088467569.1944.10.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.55.0406291358010.31801@jurand.ds.pg.gda.pl>
Content-Type: text/plain
Message-Id: <1088534977.1388.3.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 29 Jun 2004 11:52:58 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-29 at 05:07, Maciej W. Rozycki wrote:
> On Mon, 28 Jun 2004, john stultz wrote:
> 
> > Looking closer at the proposed workaround by Maciej posted here:
> > http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-04/3174.html
> > 
> > Why exactly are we using cpu_has_tsc to switch this? I'm not sure I'm
> > following how this is TSC dependent. Additionally the comment change
> > looks to be from the 2.4 era. 
> 
>  One of the two users of timer_ack is do_slow_gettimeoffset().  When the
> TSC is selected for use as a high-precision timer do_fast_gettimeoffset()
> is used instead.
> 
>  Please folks do read the sources sometimes -- I've been repeatedly
> clarifying these bits while they are all documented in the sources,
> sigh...

Whoops, sorry, I had the impression the patch was targeted against 2.6,
where there is no do_slow_gettimeoffset() and the only user of timer_ack
is in do_timer_interrupt(). 

So am I incorrect that the TSC bits can be dropped for the 2.6 version
of the patch?

thanks
-john


