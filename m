Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030295AbVIVM72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030295AbVIVM72 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 08:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbVIVM71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 08:59:27 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:38631 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030295AbVIVM70 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 08:59:26 -0400
Date: Thu, 22 Sep 2005 14:59:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, george@mvista.com, johnstul@us.ibm.com,
       paulmck@us.ibm.com
Subject: Re: [ANNOUNCE] ktimers subsystem
Message-ID: <20050922125950.GA14822@elte.hu>
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de> <Pine.LNX.4.61.0509201247190.3743@scrub.home> <1127342485.24044.600.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127342485.24044.600.camel@tglx.tec.linutronix.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> > > This revealed a reasonable explanation for this behaviour. Both 
> > > networking and disk I/O arm a lot of timeout timers (the maximum number 
> > > of armed timers during the tests observed was ~400000).
> > 
> > This triggers the obvious question: where are these timers coming from? 
> > You don't think that having that much timers in first place is little 
> > insane (especially if these are kernel timers)?
> 
> Quick answer: Networking and disk I/O. Insane load on a 4 way SMP 
> machine. Check yourself. :)

a busy network server can easily have millions of timers pending. I once 
had to increase a server's 16 million tw timer sysctl limit ...

	Ingo
