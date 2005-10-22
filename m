Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932581AbVJVDoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581AbVJVDoe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 23:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932582AbVJVDoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 23:44:34 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:33228 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932581AbVJVDod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 23:44:33 -0400
Date: Sat, 22 Oct 2005 05:44:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Mark Knecht <markknecht@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc5-rt3 - `IRQ 8'[798] is being piggy
Message-ID: <20051022034458.GB12751@elte.hu>
References: <5bdc1c8b0510211003j4e9bf03bhf1ea8e94ffe60153@mail.gmail.com> <5bdc1c8b0510211040s40f3f9bbj7f83e174d7b6d937@mail.gmail.com> <1129920323.17709.2.camel@mindpipe> <5bdc1c8b0510211152m592d95cfte57dc7e9b027f87a@mail.gmail.com> <1129923883.17709.11.camel@mindpipe> <5bdc1c8b0510211525v62212d33j84491cfc687bd200@mail.gmail.com> <1129937318.4724.6.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129937318.4724.6.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> On Fri, 2005-10-21 at 15:25 -0700, Mark Knecht wrote:
> > >
> > > No I don't think so.  CONFIG_RTC_HISTOGRAM is a hack, designed to work
> > > with a specific test program that runs SCHED_FIFO and poll()s on the
> > > RTC.  VLC apparently poll()s on the RTC but does not run SCHED_FIFO.  So
> > > of course there will be delays.
> 
> > Lee,
> >    Indeed, you are correct. Apparently under character devices I had
> > turned on the RTC histogram feature. With that off I am not only
> > getting the maximum latency values we expect.
> > 
> >    Now I'll have to let it run for hours/days to see if I catch any
> > info on these xruns, should I get another rash of them. Yesterday they
> > came only after about 14 hours of work. I had none the previous two
> > days.
> 
> In general you should avoid enabling/disabling random config options 
> between runs.  If you keep changing the .config it makes it impossible 
> to hunt bugs or compare one set of results to another.

i think i'll remove the CONFIG_RTC_HISTOGRAM feature altogether from the 
-rt tree - meanwhile we've got more advanced (and less verbose) latency 
histogram features via WAKEUP_LATENCY_HIST, PREEMPT_OFF_HIST and 
INTERRUPT_OFF_HIST.

	Ingo
