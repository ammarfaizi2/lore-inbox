Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263154AbUKTTLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263154AbUKTTLN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 14:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263157AbUKTTLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 14:11:13 -0500
Received: from imap.gmx.net ([213.165.64.20]:21916 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263154AbUKTTLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 14:11:07 -0500
X-Authenticated: #4399952
Date: Sat, 20 Nov 2004 20:11:55 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.29-0
Message-ID: <20041120201155.6dc43c39@mango.fruits.de>
In-Reply-To: <1100975745.6879.35.camel@krustophenia.net>
References: <20041111215122.GA5885@elte.hu>
	<20041116125402.GA9258@elte.hu>
	<20041116130946.GA11053@elte.hu>
	<20041116134027.GA13360@elte.hu>
	<20041117124234.GA25956@elte.hu>
	<20041118123521.GA29091@elte.hu>
	<20041118164612.GA17040@elte.hu>
	<1100920963.1424.1.camel@krustophenia.net>
	<20041120125536.GC8091@elte.hu>
	<1100971141.6879.18.camel@krustophenia.net>
	<20041120191403.GA16262@elte.hu>
	<1100975745.6879.35.camel@krustophenia.net>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Nov 2004 13:35:44 -0500
Lee Revell <rlrevell@joe-job.com> wrote:

> On Sat, 2004-11-20 at 20:14 +0100, Ingo Molnar wrote:
> > i only tried the !PREEMPT version though - does that one work for you? 
> 
> Not sure, will test.  My goal was to see if I could get the stability
> and low latency of T3 (this is low enough latency for me!) with the new
> versions.
> 
> > Also, please send me the .config that produces the failing kernel.
> 
> Sent (off-list).

Hi,

29-4 with PREEMPT works very good (jackd at 64 frames: 0 xruns (running for
1h now), soundcard irq unthreaded). Opposed to 29-1 PREEMPT_REALTIME which
showed some very weird jackd behaviour (xruns from 10usec to 50msec [!!!]).
rtc_wakeup was showing no large jitter for that kernel though, nor did the
different traces show anything that might have caused the jackd xruns. And
yes, i configured the irq handlers sanely :)

Will build 29-4 PREEMPT_REALTIME now and see how this one behaves.

flo
