Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750774AbWFEXKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWFEXKu (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 19:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWFEXKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 19:10:50 -0400
Received: from rwcrmhc15.comcast.net ([216.148.227.155]:27321 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S1750774AbWFEXKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 19:10:49 -0400
Date: Mon, 5 Jun 2006 16:13:36 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: john stultz <johnstul@us.ibm.com>
Cc: mingo@elte.hu, tglx@linutronix.de, dwalker@mvista.com,
        james.perkins@windriver.com, linux-kernel@vger.kernel.org,
        rmk@arm.linux.org.uk, khilman@mvista.com
Subject: Re: [patch-rt 0/2] Initial ARM generic-timeofday support
Message-ID: <20060605231336.GA11790@plexity.net>
Reply-To: dsaxena@plexity.net
References: <20060605222956.608067000@localhost.localdomain> <1149548790.11470.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149548790.11470.12.camel@localhost.localdomain>
Organization: Plexity Networks
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 05 2006, at 16:06, john stultz was caught saying:
> On Mon, 2006-06-05 at 15:29 -0700, dsaxena@plexity.net wrote:
> > Hi,
> > 
> > This patchset (against -rt26, but should apply to newer patch) adds
> > initial support for generic TOD on ARM. It is fairly simple and
> > copletely rips out the existing TOD code in ARM, assuming that each
> > sub-arch will either provide a clocksource or enable CONFIG_IS_TICK_BASED.
> > Currently only Versatile is supported.
> 
> Ah! Looks cool! As a warning, -rt is still running w/ an older version
> of the TOD code (B20), so some changes will be needed when -rt moves to
> the current version (C2, right now).
> 
> The main change is that the read/sync persistent clock bits got cut, so
> the clock syncing is still necessary in timer_tick(). There might be a
> few other differences but most of the changes were arch-generic so it
> shouldn't be too much of an issue.

OK, I'll keep my out for that. Actually, maybe I should send you a patch
for latest TOD code. Are there any plans to just sync the persistent
time updates with the generic RTC layer? It would require moving stuff
like the CMOS clock code to drivers/rtc, but it would provide a generic
solution.

Tnx,
~Deepak

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

In the end, they will not say, "those were dark times,"  they will ask
"why were their poets silent?" - Bertold Brecht
