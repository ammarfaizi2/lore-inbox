Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbWIUIMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbWIUIMw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 04:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbWIUIMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 04:12:52 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:59871 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750961AbWIUIMv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 04:12:51 -0400
Date: Thu, 21 Sep 2006 10:04:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Deepak Saxena <dsaxena@plexity.net>
Cc: linux-kernel@vger.kernel.org, Daniel Walker <dwalker@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, rmk@arm.linux.org.uk,
       Kevin Hilman <khilman@mvista.com>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: 2.6.18-rt1
Message-ID: <20060921080456.GA32040@elte.hu>
References: <20060920141907.GA30765@elte.hu> <1158774118.29177.13.camel@c-67-180-230-165.hsd1.ca.comcast.net> <20060920182553.GC1292@us.ibm.com> <200609201436.47042.gene.heskett@verizon.net> <20060920194650.GA21037@elte.hu> <20060921080435.GA29636@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060921080435.GA29636@plexity.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4999]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Deepak Saxena <dsaxena@plexity.net> wrote:

> I am seeing an intermittent lock up on the ARM Versatile board during 
> the ALSA driver init that only shows up with (PREEMPT_RT & 
> !HIGH_RES_TIMERS & ARM_EABI) enabled. If HRT is disabled and EABI is 
> enabled, the kernel works every time, and same with !RT & !HRT & EABI.  
> I get no oops, just a complete lock up with no console output.

does enabling LOCKDEP give you any better info? (It might not make a 
difference on the bootup that locks, but maybe you'll get a lockdep clue 
about the problem in one of the successful bootups.)

	Ingo
