Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262868AbVA2HEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbVA2HEd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 02:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262869AbVA2HEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 02:04:33 -0500
Received: from mail.joq.us ([67.65.12.105]:58005 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262868AbVA2HEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 02:04:30 -0500
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
References: <87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu>
	<20050124125814.GA31471@elte.hu> <20050125135613.GA18650@elte.hu>
	<87sm4opxto.fsf@sulphur.joq.us> <20050126070404.GA27280@elte.hu>
	<87fz0neshg.fsf@sulphur.joq.us>
	<1106782165.5158.15.camel@npiggin-nld.site>
	<20050128080802.GA2860@elte.hu> <871xc62bot.fsf@sulphur.joq.us>
	<20050128084049.GA5004@elte.hu> <41FAB9A5.6020105@bigpond.net.au>
From: "Jack O'Quin" <joq@io.com>
Date: Sat, 29 Jan 2005 01:02:49 -0600
In-Reply-To: <41FAB9A5.6020105@bigpond.net.au> (Peter Williams's message of
 "Sat, 29 Jan 2005 09:16:05 +1100")
Message-ID: <878y6cogyu.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams <pwil3058@bigpond.net.au> writes:
>
> If the average usage rate is estimated over longer periods it will be
> lower allowing lower limits to be used.  Also if the task's own usage
> rate estimates are used to test the limits then the limit can be lower.
>
> If the default limits can be made sufficiently small then the
> temptation to use this feature by "ordinary" applications will
> disappear.
>
> I'm not an expert but I imagine that the CPU usage rates of most RT
> tasks taken over reasonably long time intervals is quite low and
> therefore the default limits could also be quite low without adversely
> effecting the programs that this mechanism is meant to help.

True for some, but definitely not for all.  

When a system was purchased specifically to do some realtime job, it
often makes sense to dedicate large chunks of the main processor to
realtime number crunching.  Mass-produced general-purpose processors
have excellent price/performance ratios.  There's no good reason not
to take advantage of that.

People commonly run heavy Fast Fourier Transform or reverb
calculations in realtime threads.  They may use up as much of the CPU
as the user/owner is willing to allocate.  With soft realtime, its
hard to push this reliably beyond about 70-80%.  But, those numbers
are definitely practical.
-- 
  joq
