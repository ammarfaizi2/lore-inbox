Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbWJHQGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWJHQGk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 12:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWJHQGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 12:06:40 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:50608 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751156AbWJHQGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 12:06:39 -0400
Subject: Re: + clocksource-add-generic-sched_clock.patch added to -mm tree
From: Daniel Walker <dwalker@mvista.com>
To: tglx@linutronix.de
Cc: akpm@osdl.org, johnstul@us.ibm.com, mingo@elte.hu, zippel@linux-m68k.org,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1160322376.5686.25.camel@localhost.localdomain>
References: <200610070153.k971ruEZ020872@shell0.pdx.osdl.net>
	 <1160301340.22911.27.camel@localhost.localdomain>
	 <1160318750.3693.12.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160319112.5686.8.camel@localhost.localdomain>
	 <1160321570.3693.34.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160322376.5686.25.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 08 Oct 2006 09:06:37 -0700
Message-Id: <1160323597.3693.62.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-08 at 17:46 +0200, Thomas Gleixner wrote:
> On Sun, 2006-10-08 at 08:32 -0700, Daniel Walker wrote:
> > > sched_clock is a user of the clocksource API and there is absolutely no
> > > reason to put that into sched.c
> > 
> > We could do something like kernel/time/sched_clock.c ? I really don't
> > like the idea of stuff sched_clock() , and timekeeping back into
> > clocksource.
> 
> Do we really want 3 files which each has 50 lines of code ? Although
> it's better than pushing that stuff into sched.c and timer.c. timer.c is
> enough mess and we really do not want to add more.

I think John's plan, and my plan, is to move the generic time bits, plus
the timekeeping specific clocksource stuff, into a different file.
kernel/timer.c shouldn't have that stuff anyway. That's about 250 lines,
the part of that which is due to the clocksource is about 100 lines.

Are you thinking that this interface is only likely to have one or two
users?

Daniel

