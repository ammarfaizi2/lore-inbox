Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbVLGKs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbVLGKs6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 05:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbVLGKs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 05:48:57 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:23212 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750821AbVLGKs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 05:48:56 -0500
Date: Wed, 7 Dec 2005 11:49:00 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, zippel@linux-m68k.org,
       linux-kernel@vger.kernel.org, rostedt@goodmis.org, johnstul@us.ibm.com
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
Message-ID: <20051207104900.GA26877@elte.hu>
References: <20051206000126.589223000@tglx.tec.linutronix.de> <Pine.LNX.4.61.0512061628050.1610@scrub.home> <1133908082.16302.93.camel@tglx.tec.linutronix.de> <20051207013122.3f514718.akpm@osdl.org> <20051207101137.GA25796@elte.hu> <4396B81E.4030605@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4396B81E.4030605@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Ingo Molnar wrote:
> 
> >so i believe that:
> >
> >	- 'struct ktimer', 'struct ktimeout'
> >
> >is in theory superior naming, compared to:
> >
> >	- 'struct ptimer', 'struct timer_list'
> >
> 
> Just curious -- why the "k" thing?

yeah. 'struct timer' and 'struct timeout' is even better. I tried it on 
real code and sometimes it looked a bit funny: often we have a 'timeout' 
parameter somewhere that is a scalar or a timeval/timespec. So at least 
for variable names it was useful to have it in this form:

	struct timeout *ktimeout;

	struct timer *ktimer;

otherwise it looked OK. This is also in line with most other 'object 
names' we have in the kernel: struct inode, struct dentry.

	Ingo
