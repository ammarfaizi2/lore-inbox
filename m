Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbVJGLOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbVJGLOp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 07:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbVJGLOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 07:14:45 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:10125 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751266AbVJGLOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 07:14:44 -0400
Date: Fri, 7 Oct 2005 13:14:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       linux-kernel@vger.kernel.org, david singleton <dsingleton@mvista.com>
Subject: Re: 2.6.14-rc3-rt2
Message-ID: <20051007111458.GA857@elte.hu>
References: <20051004084405.GA24296@elte.hu> <Pine.LNX.4.58.0510050928440.23350@localhost.localdomain> <Pine.LNX.4.58.0510051023460.23350@localhost.localdomain> <1128527319.13057.139.camel@tglx.tec.linutronix.de> <20051005155836.GA3626@elte.hu> <Pine.LNX.4.58.0510051204170.23350@localhost.localdomain> <Pine.LNX.4.58.0510070538170.6608@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510070538170.6608@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> 
> On Wed, 5 Oct 2005, Steven Rostedt wrote:
> 
> >
> > It seems that the problem comes down to the call to getnstimeofday in
> > do_gettimeofday.
> >
> 
> OK, not sure if anyone looked into this more or not.  But this patch 
> seems to at least fix the symptom if not the cure.  I changed 
> set_normalize_timespec to take a nsec_t type as its last parameter.  
> Since I don't see a problem with overflowing a 64 bit number, this 
> works for now.  But I still don't know the full extent of 
> xtime_last_update not updating during something like hackbench 
> starving the timer softirq.

thanks, applied.

	Ingo
