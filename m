Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbWI1VTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWI1VTw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 17:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbWI1VTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 17:19:52 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:41698 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751009AbWI1VTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 17:19:51 -0400
Date: Thu, 28 Sep 2006 23:11:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] exponential update_wall_time
Message-ID: <20060928211150.GA32393@elte.hu>
References: <1159385734.29040.9.camel@localhost> <Pine.LNX.4.64.0609280031550.6761@scrub.home> <1159398793.7297.9.camel@localhost> <Pine.LNX.4.64.0609280128330.6761@scrub.home> <1159403333.7297.24.camel@localhost> <Pine.LNX.4.64.0609282254450.6761@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609282254450.6761@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> > > add up to 1 second. Right now we slice it into HZ steps, but this 
> > > can be rather easily changed now.
> > 
> > Right off, it seems it would then make sense to make the ntp "ticks" 
> > one second in length. And set the interval values accordingly.
> > 
> > However, there might be clocksources that are incapable of running 
> > freely for a full second w/o overflowing. In that case we would need 
> > to set the interval values and the ntp tick length accordingly. It 
> > seems we need some sort of interface to ntp to define that base tick 
> > length. Would that be ok by you?
> 
> I don't see how you want to do this without some rather complex 
> calculations. I doubt this will make anything easier.

lets figure out a way to solve this in some manner - the loop of 
thousands of function calls on dynticks didnt look too well. Millions of 
kids will be grateful for it :-)

	Ingo
