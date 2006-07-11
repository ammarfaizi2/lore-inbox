Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbWGKJaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbWGKJaJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 05:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbWGKJaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 05:30:09 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:61077 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750847AbWGKJaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 05:30:07 -0400
Date: Tue, 11 Jul 2006 11:29:48 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: john stultz <johnstul@us.ibm.com>, Pavel Machek <pavel@ucw.cz>,
       Mikael Pettersson <mikpe@it.uu.se>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [BUG] APM resume breakage from 2.6.18-rc1 clocksource changes
In-Reply-To: <1152605229.32107.88.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0607111120310.12900@scrub.home>
References: <200607092352.k69NqZuJ029196@harpo.it.uu.se> 
 <1152554328.5320.6.camel@localhost.localdomain>  <20060710180839.GA16503@elf.ucw.cz>
  <Pine.LNX.4.64.0607110035300.17704@scrub.home>  <1152571816.9062.29.camel@localhost.localdomain>
  <Pine.LNX.4.64.0607110054180.12900@scrub.home> <1152605229.32107.88.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 11 Jul 2006, Thomas Gleixner wrote:

> > That's another reason why I think that keeping interrupt handling and 
> > timekeeping separate is illusionary.
> 
> It is not illusionary at all and we have to find a way to handle this.
> 
> Forcing time keeping to be bound on some interrupt handling is the wrong
> design and in the way of tickless systems.

So what is the correct design?
Especially for tickless system it's vital for precise timekeeping that the 
timekeeping code knows what the timer interrupt code does.

> When there is a system where the time source is bound to an interrupt
> event then the handling code for that time source has to cope with the
> problem instead of enforcing this not generally valid scenario on
> everything. We can of course add helpers into the generic part of the
> time keeping code to make this easier.

I'm not sure I'm following, could you please illustrate with an example?

> The majority of machines has stand alone time sources and there is no
> need to enforce artificial interrupt relations on them.

What do you mean with "artificial interrupt relations"?

> Please accept that the "tick" is not the holy grail of Linux. We have
> already way too much historic tick ballast all over the place, so we
> really want to avoid that when we design replacement functionality.

What do you mean with the "holy grail" of "tick"?

bye, Roman
