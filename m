Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbVFLAGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbVFLAGd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 20:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVFLAGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 20:06:33 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:9912
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261857AbVFLAG0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 20:06:26 -0400
Subject: Re: [PATCH] local_irq_disable removal
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Sven-Thorsten Dietrich <sdietrich@mvista.com>
Cc: Daniel Walker <dwalker@mvista.com>, Esben Nielsen <simlo@phys.au.dk>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1118515236.9519.92.camel@sdietrich-xp.vilm.net>
References: <Pine.LNX.4.10.10506110930050.27294-100000@godzilla.mvista.com>
	 <1118510817.13312.88.camel@tglx.tec.linutronix.de>
	 <1118515236.9519.92.camel@sdietrich-xp.vilm.net>
Content-Type: text/plain
Organization: linutronix
Date: Sun, 12 Jun 2005 02:07:22 +0200
Message-Id: <1118534842.13312.111.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-06-11 at 11:40 -0700, Sven-Thorsten Dietrich wrote:
> > Performance on RT systems is more than IRQ latencies. 
> > 
> > The wide spread misbelief that 
> >   "Realtime == As fast as possible" 
> > 
> > seems to be still stuck in peoples mind.
> > 
> >   "Realtime == As fast as specified"
> > is the correct equation.
> > 
> 
> I think Daniel was referring to the deviations, but it is always good to
> point that out.


I hope, we can agree on this premise for further discussions


> > There is always a tradeoff between interrupt latencies and other
> > performance values, as you have to invent new mechanisms to protect
> > critical sections. In the end, they can be less effective than the gain
> > on irq latencies.
> > 
> 
> Basically you are investing effort to maintain predictability. 
> 
> In order to do that, you somethimes have to put a stitch in before the
> deadline ("in time..."), the effort increases the work = overhead. 
> 
> But if you look at overall time the tasks are waiting you can implement
> optimal scheduling, and maximize throughput.
> 
> This is too complex to argue about here.

Whats too complex? Are you asserting that other people e.g. me, are too
dumb to understand that ?

> For every example I can find you a corner case.

There is everywhere a corner case. Thats nothing new.

> It depends on the application, and you need to decide how to configure
> our kernel if it really matters to what you are doing with Linux.

I completely agree, but your statement just confirms Ebsen's request for
keeping those tweaks as configurable options rather than built in
defaults.

For any RT application the application dictates the constraints and
therefor requires a maximum of configurability.

> We are merely working to provide alternatives that improve performance.

We all do just with a different set of constraints, right ?


tglx


