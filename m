Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbVBALDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbVBALDv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 06:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbVBALDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 06:03:51 -0500
Received: from gprs214-15.eurotel.cz ([160.218.214.15]:1920 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261985AbVBALDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 06:03:49 -0500
Date: Tue, 1 Feb 2005 12:00:06 +0100
From: Pavel Machek <pavel@suse.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick, version 050127-1
Message-ID: <20050201110006.GA1338@elf.ucw.cz>
References: <20050127212902.GF15274@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127212902.GF15274@atomide.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Thanks for all the comments, here's an updated version of the dynamic
> tick patch.
> 
> I've fixed couple of things:
> 
> - Dyn-tick now supports local APIC timer. This allows longer sleep time
>   inbetween ticks, over 1000 ticks compared to 54 ticks with PIT timer.
>   It seems to stop timers on SMP too, but I've only briefly played with
>   it on SMP.

I used your config advices from second mail, still it does not work as
expected: system gets "too sleepy". Like it takes a nap during boot
after "dyn-tick: Maximum ticks to skip limited to 1339", and key is
needed to make it continue boot. Then cursor stops blinking and
machine is hung at random intervals during use, key is enough to awake
it.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
