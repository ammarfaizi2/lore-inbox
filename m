Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932763AbVITO1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932763AbVITO1J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 10:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932764AbVITO1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 10:27:09 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:18893 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932763AbVITO1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 10:27:07 -0400
Date: Tue, 20 Sep 2005 16:27:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH linux-2.6.13-rt14] Priority inversion bug
Message-ID: <20050920142753.GA6132@elte.hu>
References: <1127162309.5097.15.camel@localhost.localdomain> <20050920133706.GA4855@elte.hu> <Pine.LNX.4.58.0509201013040.5489@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509201013040.5489@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 20 Sep 2005, Ingo Molnar wrote:
> > thanks - added it to my tree. I'm wondering why it never showed up in
> > practice?
> 
> How do we know if it hasn't?  It wouldn't bug, you may just have a 
> longer latency on the higher priority process than what should be. It 
> did happen on my kernel, and the way I found that it did, was that I 
> had a test in the passing of ownership to make sure that the one that 
> got the lock is indeed the highest priority process. Without this 
> check, we probably would never know.

'showed up' as in 'clearly incorrect scheduling shown in latency trace'.  
It's probably the complex locking scenario that never made it trigger in 
the simpler tests that e.g. rtc_wakeup or other latency testers do.

	Ingo
