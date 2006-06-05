Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750792AbWFEXQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWFEXQb (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 19:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWFEXQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 19:16:30 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:16329 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750792AbWFEXQa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 19:16:30 -0400
Subject: Re: [patch-rt 0/2] Initial ARM generic-timeofday support
From: john stultz <johnstul@us.ibm.com>
To: dsaxena@plexity.net
Cc: mingo@elte.hu, tglx@linutronix.de, dwalker@mvista.com,
        james.perkins@windriver.com, linux-kernel@vger.kernel.org,
        rmk@arm.linux.org.uk, khilman@mvista.com
In-Reply-To: <20060605231336.GA11790@plexity.net>
References: <20060605222956.608067000@localhost.localdomain>
	 <1149548790.11470.12.camel@localhost.localdomain>
	 <20060605231336.GA11790@plexity.net>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 16:16:26 -0700
Message-Id: <1149549387.11470.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-05 at 16:13 -0700, Deepak Saxena wrote:
> On Jun 05 2006, at 16:06, john stultz was caught saying:
> > On Mon, 2006-06-05 at 15:29 -0700, dsaxena@plexity.net wrote:
> > > Hi,
> > > 
> > > This patchset (against -rt26, but should apply to newer patch) adds
> > > initial support for generic TOD on ARM. It is fairly simple and
> > > copletely rips out the existing TOD code in ARM, assuming that each
> > > sub-arch will either provide a clocksource or enable CONFIG_IS_TICK_BASED.
> > > Currently only Versatile is supported.
> > 
> > Ah! Looks cool! As a warning, -rt is still running w/ an older version
> > of the TOD code (B20), so some changes will be needed when -rt moves to
> > the current version (C2, right now).
> > 
> > The main change is that the read/sync persistent clock bits got cut, so
> > the clock syncing is still necessary in timer_tick(). There might be a
> > few other differences but most of the changes were arch-generic so it
> > shouldn't be too much of an issue.
> 
> OK, I'll keep my out for that. Actually, maybe I should send you a patch
> for latest TOD code. Are there any plans to just sync the persistent
> time updates with the generic RTC layer? It would require moving stuff
> like the CMOS clock code to drivers/rtc, but it would provide a generic
> solution.

Hmmmm. I like that idea! I've been a bit too busy to look at the RTC
changes in detail, but yes, it sounds like the way to go.

thanks!
-john

