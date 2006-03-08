Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932497AbWCHLtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbWCHLtz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 06:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWCHLtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 06:49:55 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:21411 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932497AbWCHLtz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 06:49:55 -0500
Date: Wed, 8 Mar 2006 12:48:47 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Takashi Iwai <tiwai@suse.de>
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net,
       cc@ccrma.Stanford.EDU
Subject: Re: [Alsa-devel] Re: 2.6.15-rt18, alsa sequencer, rosegarden -> alsa hangs
Message-ID: <20060308114847.GA20591@elte.hu>
References: <1141769000.5565.21.camel@cmn3.stanford.edu> <20060307220628.GA27536@elte.hu> <1141800836.6150.3.camel@cmn3.stanford.edu> <s5h4q29rwfg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h4q29rwfg.wl%tiwai@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Takashi Iwai <tiwai@suse.de> wrote:

> > > could you get a tasklist-dump? It's either SysRq-T, or:
> > > 
> > > 	echo t > /proc/sysrq-trigger
> > > 
> > > that should dump all tasks and their backtraces - including the hung 
> > > rosegardensequencer task.
> > 
> > I'll try to do that tomorrow. 
> 
> That'll be helpful.  A deadlocked mutex could be easily found by a 
> backtrace.

furthermore, in the -rt kernel (if PREEMPT_RT and DEBUG_DEADLOCKS is 
enabled), all locks will also be printed, and their owners, and the site 
where they got acquired, etc. A deadlocked mutex/semaphore should in 
fact be detected by the kernel, if those options are enabled.

	Ingo
