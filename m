Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbVKOUyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbVKOUyN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 15:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbVKOUyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 15:54:13 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:31434 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750737AbVKOUyL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 15:54:11 -0500
Date: Tue, 15 Nov 2005 21:53:55 +0100
From: Ingo Molnar <mingo@elte.hu>
To: john stultz <johnstul@us.ibm.com>
Cc: Frank Sorenson <frank@tuxrocks.com>, lkml <linux-kernel@vger.kernel.org>,
       Darren Hart <dvhltc@us.ibm.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/13] Time: Generic Timeofday Subsystem (v B10)
Message-ID: <20051115205355.GA20885@elte.hu>
References: <20051112044850.8240.91581.sendpatchset@cog.beaverton.ibm.com> <4378FFFF.4010706@tuxrocks.com> <1132004327.4668.30.camel@leatherman> <4379074D.5060308@tuxrocks.com> <1132005736.4668.34.camel@leatherman> <437918A0.8000308@tuxrocks.com> <1132010724.4668.40.camel@leatherman> <43796C76.8070603@tuxrocks.com> <1132084415.2906.12.camel@leatherman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132084415.2906.12.camel@leatherman>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* john stultz <johnstul@us.ibm.com> wrote:

> > idle=poll does seem to fix the major clock drift problem.  There may
> > still be an issue, but it's much smaller:
> > 
> > 2.6.14-mm2-todb10:
> > 14 Nov 21:50:57      offset: -0.025373       drift: -22404.0 ppm
> > 14 Nov 21:51:59      offset: -1.577053       drift: -24985.4603175 ppm
> > 14 Nov 21:53:00      offset: -3.104569       drift: -25012.9032258 ppm
> > 
> > 2.6.14-mm2-todb10 with idle=poll:
> > 14 Nov 21:37:59      offset: 5.9e-05         drift: 63.0 ppm
> > 14 Nov 21:39:00      offset: 0.003207        drift: 51.7903225806 ppm
> 
> Hmm. It seems the c3 compensation is triggering when it shouldn't, or 
> maybe its over compensating.
> 
> I can't reproduce it on my laptop. Do you recall if in previous tests 
> you saw anything like this? I'm trying to narrow down if its just a 
> difference in hardware or if something in the c3 idle code changed.

it's with an earlier queue of yours, but maybe it's related: i have a 
report that HPET causes HRT inaccuracies (e.g. sleeps for 20 msecs last 
21 msecs). If all HPET options are turned off in the .config then 
everything is fine and accurate.

	Ingo
