Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbULEXTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbULEXTX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 18:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbULEXTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 18:19:23 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:26812 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261246AbULEXTI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 18:19:08 -0500
Date: Mon, 6 Dec 2004 00:14:24 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.32-0
In-Reply-To: <20041203205807.GA25578@elte.hu>
Message-Id: <Pine.OSF.4.05.10412052342380.12234-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Dec 2004, Ingo Molnar wrote:

> 
> [...] 
> on low RT load (the common case) 

In the system I deal with on my day job, 50% of the CPU load is from
RT tasks!

In fact, I think that is quite normal for industrial applications. Those
tend to be PLC-like: You run your scan every 10 ms. First you read your
input, then you do your calculations then you set your output. You do
the same thing every time. You can thus safely tick around at a CPU
load close to 100%!!

This is quite opposit to how telecom real-time systems works: Those are
usually event based. I.e. they process things when they occur. The load
can vary a lot depending on how much traffic has to go through the device.

Esben

