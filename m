Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVASBFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVASBFN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 20:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVASBFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 20:05:13 -0500
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:10421 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261519AbVASBFE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 20:05:04 -0500
Date: Tue, 18 Jan 2005 17:04:37 -0800
From: Tony Lindgren <tony@atomide.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Pavel Machek <pavel@ucw.cz>, George Anzinger <george@mvista.com>,
       john stultz <johnstul@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic tick patch
Message-ID: <20050119010437.GC4860@atomide.com>
References: <20050119000556.GB14749@atomide.com> <1106094130.30792.12.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106094130.30792.12.camel@krustophenia.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Revell <rlrevell@joe-job.com> [050118 16:22]:
> On Tue, 2005-01-18 at 16:05 -0800, Tony Lindgren wrote:
> > Currently supported timers are TSC and ACPI PM timer. Other
> > timers should be easy to add. Both TSC and ACPI PM timer
> > rely on the PIT timer for interrupts, so the maximum skip
> > inbetween ticks is only few seconds at most.
> > 
> 
> An interesting hack if your sound cards interval timer is supported and
> can interrupt at high enough resolution (currently ymfpci, emu10k1 and
> some ISA cards) would be to use it as the system timer.  Who knows, it
> might even be useful for games, music and AV stuff that clocks off the
> sound card anyway.  It would probably be easy, ALSA has a very clean
> timer API.

Hmmm, that never occured to me, but sounds interesting. I wonder if
the patch already removes some latencies, as the sound card interrupt
triggers the timer interrupt as well?

Tony
