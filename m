Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbVJUX3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbVJUX3Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 19:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbVJUX3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 19:29:24 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:23170 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751272AbVJUX3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 19:29:23 -0400
Subject: Re: 2.6.14-rc5-rt3 - `IRQ 8'[798] is being piggy
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Knecht <markknecht@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <5bdc1c8b0510211525v62212d33j84491cfc687bd200@mail.gmail.com>
References: <5bdc1c8b0510211003j4e9bf03bhf1ea8e94ffe60153@mail.gmail.com>
	 <5bdc1c8b0510211040s40f3f9bbj7f83e174d7b6d937@mail.gmail.com>
	 <1129920323.17709.2.camel@mindpipe>
	 <5bdc1c8b0510211152m592d95cfte57dc7e9b027f87a@mail.gmail.com>
	 <1129923883.17709.11.camel@mindpipe>
	 <5bdc1c8b0510211525v62212d33j84491cfc687bd200@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 21 Oct 2005 19:28:37 -0400
Message-Id: <1129937318.4724.6.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-21 at 15:25 -0700, Mark Knecht wrote:
> >
> > No I don't think so.  CONFIG_RTC_HISTOGRAM is a hack, designed to work
> > with a specific test program that runs SCHED_FIFO and poll()s on the
> > RTC.  VLC apparently poll()s on the RTC but does not run SCHED_FIFO.  So
> > of course there will be delays.

> Lee,
>    Indeed, you are correct. Apparently under character devices I had
> turned on the RTC histogram feature. With that off I am not only
> getting the maximum latency values we expect.
> 
>    Now I'll have to let it run for hours/days to see if I catch any
> info on these xruns, should I get another rash of them. Yesterday they
> came only after about 14 hours of work. I had none the previous two
> days.

In general you should avoid enabling/disabling random config options
between runs.  If you keep changing the .config it makes it impossible
to hunt bugs or compare one set of results to another.

The easiest way is to do:

zcat /proc/config.gz > .config
make oldconfig

Lee

