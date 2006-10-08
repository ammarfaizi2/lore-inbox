Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbWJHR0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbWJHR0n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 13:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWJHR0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 13:26:43 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:30392 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1750997AbWJHR0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 13:26:42 -0400
Subject: Re: + clocksource-add-generic-sched_clock.patch added to -mm tree
From: Daniel Walker <dwalker@mvista.com>
To: tglx@linutronix.de
Cc: akpm@osdl.org, johnstul@us.ibm.com, mingo@elte.hu, zippel@linux-m68k.org,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1160326451.5686.51.camel@localhost.localdomain>
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
Content-Type: text/plain
Date: Sun, 08 Oct 2006 10:26:40 -0700
Message-Id: <1160328400.3693.100.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-08 at 18:54 +0200, Thomas Gleixner wrote:
> On Sun, 2006-10-08 at 09:27 -0700, Daniel Walker wrote:
> > On Sun, 2006-10-08 at 18:19 +0200, Thomas Gleixner wrote:
> > 
> > > Probably. Anyway, can we just keep the stuff in clocksource.c right
> > > now ?
> > 
> > I suppose I can move the sched_clock stuff.
> 
> And keep the code you wanted to move into timer.c too. 

I'm not moving the kernel/timer.c clocksource user back into
kernel/time/clocksource.c . That code completely belongs with the
generic time of day changes. The code is directly coupled, and in fact
it improves the timekeeping clock switching code to have it that way.

I'd be happy to create kernel/time/timeofday.c though .

Daniel

