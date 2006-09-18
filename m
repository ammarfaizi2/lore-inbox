Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751510AbWIRL2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbWIRL2G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 07:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbWIRL2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 07:28:05 -0400
Received: from mx1.suse.de ([195.135.220.2]:30859 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751490AbWIRL2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 07:28:02 -0400
To: "Vladimir B. Savkin" <master@sectorb.msk.ru>
Cc: Jesper Dangaard Brouer <hawk@diku.dk>,
       Harry Edmon <harry@atmos.washington.edu>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
References: <4492D5D3.4000303@atmos.washington.edu>
	<44948EF6.1060201@atmos.washington.edu>
	<Pine.LNX.4.61.0606191638550.23553@ask.diku.dk>
	<200606191724.31305.ak@suse.de>
	<20060916120845.GA18912@tentacle.sectorb.msk.ru>
	<p73k6414lnp.fsf@verdi.suse.de>
	<20060918090330.GA9850@tentacle.sectorb.msk.ru>
	<p73eju94htu.fsf@verdi.suse.de>
	<20060918102918.GA23261@tentacle.sectorb.msk.ru>
From: Andi Kleen <ak@suse.de>
Date: 18 Sep 2006 13:27:57 +0200
In-Reply-To: <20060918102918.GA23261@tentacle.sectorb.msk.ru>
Message-ID: <p73ac4x4doi.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Vladimir B. Savkin" <master@sectorb.msk.ru> writes:

[you seem to send your emails in a strange way that doesn't keep me in cc.
Please stop doing that.]

> On Mon, Sep 18, 2006 at 11:58:21AM +0200, Andi Kleen wrote:
> > > > The x86-64 timer subsystems currently doesn't have clocksources
> > > > at all, but it supports TSC and some other timers.
> > > 
> > 
> > > until I hacked arch/i386/kernel/tsc.c
> > 
> > Then you don't use x86-64. 
> > 
> Oh. I mean I made arch/i386/kernel/tsc.c compile on x86-64
> by hacking some Makefiles and headers. 

The codebase for timing (and lots of other things) is quite different
between 32bit and 64bit. You're really surprised it doesn't work if you do such things?

> But the question is, why stock 2.6.18-rc7 could not use TSC on its own?

x86-64 doesn't use the TSC when it deems it to not be reliable, which
is the case on your system.
 
> > > > > I've also had experience of unsychronized TSC on dual-core Athlon,
> > > > > but it was cured by idle=poll.
> > > > 
> > > > You can use that, but it will make your system run quite hot 
> > > > and cost you a lot of powe^wmoney.
> > > 
> > > Here in Russia electric power is cheap compared with hardware upgrade.
> > 
> > It's not just electrical power - the hardware is more stressed and will
> > likely fail earlier too.  As a rule of thumb the hotter your hardware runs
> > the earlier it will fail.
> 
> What hardware exactly. Doesn't it affect only CPU? And they are not
> know to fail before any other components.

All hardware. It's basic physics.

-Andi
