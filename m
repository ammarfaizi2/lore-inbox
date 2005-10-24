Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbVJXRGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbVJXRGF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 13:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbVJXRGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 13:06:05 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:48362 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751168AbVJXRGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 13:06:04 -0400
Subject: Re: 2.6.14-rc5-rt5 - softirq-timer/0/3[CPU#0]: BUG in ktime_get at
	kernel/ktimers.c:103
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Knecht <markknecht@gmail.com>
Cc: john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <5bdc1c8b0510240907mc90490eoe111188ee874c8a5@mail.gmail.com>
References: <5bdc1c8b0510240907mc90490eoe111188ee874c8a5@mail.gmail.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 24 Oct 2005 13:05:52 -0400
Message-Id: <1130173552.7377.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-24 at 09:07 -0700, Mark Knecht wrote:

> Time: tsc clocksource has been installed.
> WARNING: non-monotonic time!
> ... time warped from 151976744 to 147973105.
> softirq-timer/0/3[CPU#0]: BUG in ktime_get at kernel/ktimers.c:103

Hi Mark,

Yeah, I saw this too, and it went through to Thomas Gleixner and then to
John Stultz, where he said that he may have fixed this in his latest
version.  So we are now waiting on Thomas to pull John's work into the
ktimers code, and then onto Ingo's RT base.

So, until then, you may just ignore the messages.  It should only happen
when the tsc clocksource changes.

Unless, of course -rt5 already has this (I just got back from Germany,
so I've been out of the loop).

Thomas, this hasn't been done yet, has it?

-- Steve


