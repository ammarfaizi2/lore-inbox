Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWJHPZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWJHPZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 11:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWJHPZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 11:25:38 -0400
Received: from www.osadl.org ([213.239.205.134]:4283 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751223AbWJHPZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 11:25:35 -0400
Subject: Re: + clocksource-add-generic-sched_clock.patch added to -mm tree
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, johnstul@us.ibm.com, mingo@elte.hu, zippel@linux-m68k.org,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1160318750.3693.12.camel@c-67-180-230-165.hsd1.ca.comcast.net>
References: <200610070153.k971ruEZ020872@shell0.pdx.osdl.net>
	 <1160301340.22911.27.camel@localhost.localdomain>
	 <1160318750.3693.12.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Content-Type: text/plain
Date: Sun, 08 Oct 2006 16:51:52 +0200
Message-Id: <1160319112.5686.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-08 at 07:45 -0700, Daniel Walker wrote:
> On Sun, 2006-10-08 at 11:55 +0200, Thomas Gleixner wrote:
> > On Fri, 2006-10-06 at 18:53 -0700, akpm@osdl.org wrote:
> > > Adds a generic sched_clock, along with a boot time override for the scheduler
> > > clocksource (sched_clocksource).  Hopefully the config option would eventually
> > > be removed.
> > 
> > Again, this belongs into the clocksource code and not into sched.c
> > 
> > Your patch series scatters clock source related code snippets all over
> > the place. This becomes simply a maintenance nightmare.
> 
> It's an API, it's suppose to be used in different places.  

Err. clocksource is an API and it is supposed to be at a place, where
clocksource code is.

sched_clock is a user of the clocksource API and there is absolutely no
reason to put that into sched.c

	tglx


