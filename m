Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbVKILXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbVKILXP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 06:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbVKILXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 06:23:15 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:59337 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751371AbVKILXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 06:23:14 -0500
Date: Wed, 9 Nov 2005 12:22:47 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Mark Knecht <markknecht@gmail.com>, john stultz <johnstul@us.ibm.com>,
       Florian Schmidt <mista.tapas@gmx.net>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: 2.6.14-rt1 (now rt6)
Message-ID: <20051109112247.GA31536@elte.hu>
References: <20051017160536.GA2107@elte.hu> <20051020195432.GA21903@elte.hu> <20051030133316.GA11225@elte.hu> <1131158124.4834.24.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131158124.4834.24.camel@cmn3.stanford.edu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> I've been running 2.6.14-rt6 fine in my smp system the whole day and 
> suddenly, just a moment ago, I suddenly started getting key repeats 
> and screensaver bliiiinks [not my typo]. No HIGH_RES_TIMERS, with 
> PREEMPT_RT. No messages in the logs or dmesg.
> 
> Doing a loop with "sleep 10" bbracketed by calls to date gives me 
> sporadic results:
> 
> --- Fri Nov  4 18:30:25 PST 2005
> 10
> ---
> --- Fri Nov  4 19:43:53 PST 2005
> 10
> ---
> --- Fri Nov  4 19:44:03 PST 2005
> 3

hm ... could you try the -rt9 kernel, does it still produce these short 
timeouts? If yes, then could you strace the 'sleep 10' processes and 
send me the strace output of such a short sleep? (does it still return 
-516, aka -ERESTART_RESTARTBLOCK?)

	Ingo
