Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWJHPZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWJHPZh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 11:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWJHPZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 11:25:37 -0400
Received: from www.osadl.org ([213.239.205.134]:3771 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751222AbWJHPZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 11:25:35 -0400
Subject: Re: + clocksource-update-kernel-parameters.patch added to -mm tree
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, johnstul@us.ibm.com, mingo@elte.hu, zippel@linux-m68k.org,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1160318845.3693.15.camel@c-67-180-230-165.hsd1.ca.comcast.net>
References: <200610070153.k971rw7S020875@shell0.pdx.osdl.net>
	 <1160301551.22911.32.camel@localhost.localdomain>
	 <1160318845.3693.15.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Content-Type: text/plain
Date: Sun, 08 Oct 2006 16:50:15 +0200
Message-Id: <1160319015.5686.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-08 at 07:47 -0700, Daniel Walker wrote:
> On Sun, 2006-10-08 at 11:59 +0200, Thomas Gleixner wrote:
> > On Fri, 2006-10-06 at 18:53 -0700, akpm@osdl.org wrote:
> > > Documents two new kernel parameters,
> > > 
> > > timeofday_clocksource
> > > sched_clocksource
> > >
> > > Removed old ones,
> > > 
> > > clocksource
> > > clock
> > 
> > NAK.
> > 
> > clocksource has just replaced clock. This hit mainline in 2.6.18.
> > 
> > 1. we can not remove "clock" without a grace perdiod
> > 2. we can not change the just created new parameter clocksource again.
> 
> True, I've been thinking about this.. I was think I could deprecate
> "clocksource" and "clock" but keep them around like John originally had.

We really do not need another set of those. clocksource and
sched_clocksource is perfectly fine

	tglx


