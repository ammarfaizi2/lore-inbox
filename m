Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbVASAXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVASAXL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 19:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVASAXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 19:23:10 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:31384 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261507AbVASAWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 19:22:16 -0500
Subject: Re: [PATCH] dynamic tick patch
From: Lee Revell <rlrevell@joe-job.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, George Anzinger <george@mvista.com>,
       john stultz <johnstul@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050119000556.GB14749@atomide.com>
References: <20050119000556.GB14749@atomide.com>
Content-Type: text/plain
Date: Tue, 18 Jan 2005 19:22:10 -0500
Message-Id: <1106094130.30792.12.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-18 at 16:05 -0800, Tony Lindgren wrote:
> Currently supported timers are TSC and ACPI PM timer. Other
> timers should be easy to add. Both TSC and ACPI PM timer
> rely on the PIT timer for interrupts, so the maximum skip
> inbetween ticks is only few seconds at most.
> 

An interesting hack if your sound cards interval timer is supported and
can interrupt at high enough resolution (currently ymfpci, emu10k1 and
some ISA cards) would be to use it as the system timer.  Who knows, it
might even be useful for games, music and AV stuff that clocks off the
sound card anyway.  It would probably be easy, ALSA has a very clean
timer API.

Lee

