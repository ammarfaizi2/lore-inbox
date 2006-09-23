Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbWIWU2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWIWU2R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 16:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbWIWU2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 16:28:17 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:36840 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751539AbWIWU2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 16:28:16 -0400
Date: Sat, 23 Sep 2006 22:20:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Voluspa <lista1@comhem.se>
Cc: Daniel Walker <dwalker@mvista.com>, brugolsky@telemetry-investments.com,
       pavel@suse.cz, akpm@osdl.org, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: hires timer patchset [was Re: 2.6.19 -mm merge plans]
Message-ID: <20060923202027.GA8350@elte.hu>
References: <20060923041746.2b9b7e1f@loke.fish.not> <1159034967.21405.22.camel@c-67-180-230-165.hsd1.ca.comcast.net> <20060923215832.03b1dac5@loke.fish.not>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060923215832.03b1dac5@loke.fish.not>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Voluspa <lista1@comhem.se> wrote:

> WARNING: "monotonic_clock" [drivers/char/hangcheck-timer.ko] undefined!

turn off the CONFIG_HANGCHECK_TIMER option.

> WARNING: "hrtimer_stop_sched_tick" [drivers/acpi/processor.ko] undefined!
> WARNING: "hrtimer_restart_sched_tick" [drivers/acpi/processor.ko] undefined!

add these two lins to the end of kernel/hrtimer.c:

EXPORT_SYMBOL_GPL(hrtimer_stop_sched_tick);
EXPORT_SYMBOL_GPL(hrtimer_restart_sched_tick);

	Ingo
