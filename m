Return-Path: <linux-kernel-owner+w=401wt.eu-S965181AbWLUJqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965181AbWLUJqu (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 04:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965183AbWLUJqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 04:46:50 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:57158 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965181AbWLUJqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 04:46:49 -0500
Date: Thu, 21 Dec 2006 10:43:41 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
       David Brownell <dbrownell@users.sourceforge.net>, dwalker@mvista.com,
       khilman@mvista.com
Subject: Re: [PATCH -rt 0/4] ARM: OMAP: Add clocksource and clockevent driver for OMAP
Message-ID: <20061221094341.GA9203@elte.hu>
References: <458A471C.3090402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <458A471C.3090402@gmail.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Dirk Behme <dirk.behme@googlemail.com> wrote:

> Hi,
> 
> the following patches for CONFIG PREEMPT RT add clocksource and 
> clockevent driver for ARM based TI OMAP devices.
> 
> They are against linux-2.6.19 + patch-2.6.20-rc1 + 
> patch-2.6.20-rc1-rt1. The clocksource patch went through several 
> review cycles on OMAP list.

thanks. I've added them to the -rt tree and it should be in the next 
release (2.6.20-rt2).

(a couple of small suggestions for future submissions: if you send them 
as attachments (which is fine to me), please name patches canonically, 
i.e. "arm-no-hz.patch", not "arm-no-hz-patch.txt" and include the patch 
description in the patch file too - or just send it all as plaintext. 
Plus please Cc: everyone who's involved with the patch(es) so that they 
can see feedback too - in this case that would be Daniel Walker, Kevin 
Hilman and David Brownell.)

> Btw: What's about
> 
> [PATCH -rt][RESEND] fix preempt hardirqs on OMAP
> http://www.ussg.iu.edu/hypermail/linux/kernel/0612.1/0642.html

that patch has problems because it breaks non-OMAP platforms. There was 
a brief discussion about it but no updated patch AFAICS.

	Ingo
