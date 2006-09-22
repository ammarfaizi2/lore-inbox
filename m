Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWIVTJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWIVTJn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 15:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbWIVTJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 15:09:43 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:37064 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932075AbWIVTJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 15:09:42 -0400
Date: Fri, 22 Sep 2006 21:01:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, John Stultz <johnstul@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.19 -mm merge plans
Message-ID: <20060922190106.GA32638@elte.hu>
References: <20060920135438.d7dd362b.akpm@osdl.org> <20060921131433.GA4182@elte.hu> <20060922130648.GD4055@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060922130648.GD4055@ucw.cz>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4996]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Pavel Machek <pavel@suse.cz> wrote:

> > would be nice to merge the -hrt queue that goes right ontop this 
> > queue. Even if HIGH_RES_TIMERS is "default n" in the beginning. That 
> > gives us high-res timers and dynticks which are both very important 
> > features to certain classes of users/devices.
> 
> dynticks give benefit of 0.3W, or 20minutes (IIRC) from 8hours on 
> thinkpad x60... and they were around for way too long. (When baseline 
> is hz=250, it is 0.5W from hz=1000 baseline). It would be cool to 
> finally merge them.

note that this is a new implementation of dynticks though, not Con's 
older stuff which you probably used, right? But it's fairly low-impact 
(just a few lines ontop of hrtimers, here and there), ontop of the 
long-existing -hrt queue.

	Ingo
