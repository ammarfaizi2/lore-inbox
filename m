Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030344AbWFISiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbWFISiI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 14:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbWFISiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 14:38:08 -0400
Received: from mail.gmx.de ([213.165.64.20]:50629 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030344AbWFISiH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 14:38:07 -0400
X-Authenticated: #14349625
Subject: Re: 2.6.17-rc6-rt1
From: Mike Galbraith <efault@gmx.de>
To: Daniel Walker <dwalker@mvista.com>
Cc: tglx@linutronix.de,
       =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       John Stultz <johnstul@us.ibm.com>, Deepak Saxena <dsaxena@plexity.net>
In-Reply-To: <1149868555.3187.25.camel@c-67-180-134-207.hsd1.ca.comcast.net>
References: <20060607211455.GA6132@elte.hu>
	 <1149842550.7585.27.camel@Homer.TheSimpsons.net>
	 <1149847951.3829.26.camel@frecb000686>
	 <1149852951.7421.7.camel@Homer.TheSimpsons.net>
	 <1149853468.3829.33.camel@frecb000686>
	 <1149855638.7413.8.camel@Homer.TheSimpsons.net>
	 <1149857821.3829.42.camel@frecb000686>
	 <1149858713.5257.146.camel@localhost.localdomain>
	 <1149860558.7423.9.camel@Homer.TheSimpsons.net>
	 <1149868555.3187.25.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Content-Type: text/plain; charset=utf-8
Date: Fri, 09 Jun 2006 20:41:06 +0200
Message-Id: <1149878466.7907.5.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 8bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-09 at 08:55 -0700, Daniel Walker wrote:
> On Fri, 2006-06-09 at 15:42 +0200, Mike Galbraith wrote:
> > On Fri, 2006-06-09 at 15:11 +0200, Thomas Gleixner wrote:
> > > On Fri, 2006-06-09 at 14:57 +0200, Sébastien Dugué wrote:
> > > > All the round trips under strace are in the 2ms range.
> > > > 
> > > >   How on earth can it be that stracing the ping gives better
> > > > performance???
> > > 
> > > Was busy fixing a scheduling while atomic bug. I just verified that I
> > > have the same weird behaviour. I'm looking into it.
> > 
> > I downloaded and patched a ping.c to do a user triggered latency trace
> > around recvfrom() of a ping -c 1 127.0.0.1 running SCHED_RR.  We
> > schedule away at 25us, do aaaall kinds of interesting stuff, and come
> > back at 42234us.  If you want the trace, holler.  It's 51k bzipped.
> 
> What priority ?

Bare minimum.  None of the other tasks that were scheduled were rt in
their own right though.

	-Mike

