Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWHGTWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWHGTWe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 15:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWHGTWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 15:22:34 -0400
Received: from styx.suse.cz ([82.119.242.94]:10161 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1750788AbWHGTWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 15:22:34 -0400
Date: Mon, 7 Aug 2006 21:22:19 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Dmitry Torokhov <dtor@insightbb.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Turn rdmsr, rdtsc into inline functions, clarify names
Message-ID: <20060807192219.GA17521@suse.cz>
References: <200608062243.45129.dtor@insightbb.com> <20060807084850.GA67713@muc.de> <20060807110931.GM27757@suse.cz> <20060807122845.GA85602@muc.de> <20060807124855.GB21003@suse.cz> <20060807125639.GA88155@muc.de> <20060807151957.GA9911@rhlx01.fht-esslingen.de> <20060807155714.GA3075@muc.de> <20060807160432.GA16695@suse.cz> <p73k65kplt8.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73k65kplt8.fsf@verdi.suse.de>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2006 at 06:12:03PM +0200, Andi Kleen wrote:
> Vojtech Pavlik <vojtech@suse.cz> writes:
> 
> > On Mon, Aug 07, 2006 at 05:57:14PM +0200, Andi Kleen wrote:
> > > > That way a driver could use
> > > > 
> > > > 	if (gtod_cpu_cycles_needed <= 500)
> > > > 		gettimeofday();
> > > > 	else
> > > > 		funky_fast_workaround();
> > > 
> > > Sounds like overengineering to me. I prefer something simple.
> > 
> > I could as well benchmark gettimeofday() in the gameport init.
> 
> Except you can't because the only way to benchmark it would
> be to use gettimeofday already and then you don't know
> how much is overhead and what is the real time.
 
I run it for 1/10th of a second in a loop and see how many iterations
I've done.  That's enough to check if its fast enough to use in the
gameport routine. Less than 50k iterations and I can't use it.

-- 
Vojtech Pavlik
Director SuSE Labs
