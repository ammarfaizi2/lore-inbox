Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWJHSpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWJHSpc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 14:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWJHSpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 14:45:31 -0400
Received: from www.osadl.org ([213.239.205.134]:38333 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751328AbWJHSp3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 14:45:29 -0400
Subject: Re: + clocksource-add-generic-sched_clock.patch added to -mm tree
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, johnstul@us.ibm.com, mingo@elte.hu, zippel@linux-m68k.org,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1160328400.3693.100.camel@c-67-180-230-165.hsd1.ca.comcast.net>
References: <200610070153.k971ruEZ020872@shell0.pdx.osdl.net>
	 <1160301340.22911.27.camel@localhost.localdomain>
	 <1160318750.3693.12.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160319112.5686.8.camel@localhost.localdomain>
	 <1160321570.3693.34.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160322376.5686.25.camel@localhost.localdomain>
	 <1160323597.3693.62.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160324354.5686.41.camel@localhost.localdomain>
	 <1160324846.3693.78.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160326451.5686.51.camel@localhost.localdomain>
	 <1160328400.3693.100.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Content-Type: text/plain
Date: Sun, 08 Oct 2006 20:45:27 +0200
Message-Id: <1160333127.5686.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-08 at 10:26 -0700, Daniel Walker wrote:
> On Sun, 2006-10-08 at 18:54 +0200, Thomas Gleixner wrote:
> > On Sun, 2006-10-08 at 09:27 -0700, Daniel Walker wrote:
> > > On Sun, 2006-10-08 at 18:19 +0200, Thomas Gleixner wrote:
> > > 
> > > > Probably. Anyway, can we just keep the stuff in clocksource.c right
> > > > now ?
> > > 
> > > I suppose I can move the sched_clock stuff.
> > 
> > And keep the code you wanted to move into timer.c too. 
> 
> I'm not moving the kernel/timer.c clocksource user back into
> kernel/time/clocksource.c . That code completely belongs with the
> generic time of day changes. The code is directly coupled, and in fact
> it improves the timekeeping clock switching code to have it that way.

I don't see any reason, why it must be added to timer.c. You can achieve
the same result with calling the code outside, except that the compiler
might miss some inline optimization. The switch clock code is not a
hotpath and so it does not matter whether it is called here or there.

> I'd be happy to create kernel/time/timeofday.c though .

Then please get an agreement with John and Roman, so we can move it now.

	tglx


