Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbTLWWJa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 17:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbTLWWJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 17:09:30 -0500
Received: from c211-28-147-198.thoms1.vic.optusnet.com.au ([211.28.147.198]:38356
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S262327AbTLWWJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 17:09:28 -0500
From: Con Kolivas <kernel@kolivas.org>
To: davidsen@tmr.com (bill davidsen), linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0 batch scheduling, HT aware
Date: Wed, 24 Dec 2003 09:09:18 +1100
User-Agent: KMail/1.5.3
References: <200312231138.21734.kernel@kolivas.org> <3FE7AF24.40600@cyberone.com.au> <bs9o97$dc3$1@gatekeeper.tmr.com>
In-Reply-To: <bs9o97$dc3$1@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312240909.19006.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Dec 2003 02:51, bill davidsen wrote:
> There are two goals here. Not having a batch process on one siling makes
> sense, and I'm going to try Con's patch after I try Nick's latest.
> Actually, if they play nicely I would use both, batch would be very
> useful for nightly report generation on servers.

No hope of them playing nicely, but at some later stage I might resync on top 
of Nick's work if I like the direction it takes (which looks likely!)

> But WRT the whole HT scheduling, it would seem that ideally you want to
> schedule the two (or N) processes which have the lowest aggregate cache
> thrash, if you had a way to determine that. I suspect that a process
> which had a small itterative inner loop with a code+data footprint of
> 2-3k would coexist well with almost anything else. Minimizing the FPU
> contention also would improve performance, no doubt. I don't know that
> there are the tools at the moment to get this information, but it seems
> as though until it's available any scheduling will be working in the
> dark to some extent.

Impossible with current tools. Only userspace would have a chance of 
predicting this and the simple rule we work off is that userspace can't be 
trusted so this does not appear doable in the foreseeable future.

> Feel free to tell me I misread this problem.

> I my experience, on servers it's more important to avoid really bad
> behaviour all of the time than to have perfect behaviour most of the
> time. All of the recent scheduler work from Nick, Con and Ingo has
> avoided "jackpot cases" quite well, for which I thank you and encourage
> you to continue. If server response goes from 20ms to 100ms Saturday
> night, we discuss it at a status meeting Monday morning and make
> suggestions to management. If response goes to 2sec we discuss it with
> management at 2am and they make suggestions :-(
>
> So far 2.6.0 has been quite good at "bend but do not break" under load.
> Great job!

Excellent! I'm sure we'll hear from you when you turn the knob up to 11/10.

Con

