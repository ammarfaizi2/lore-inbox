Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266247AbUBQQUp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 11:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266267AbUBQQUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 11:20:45 -0500
Received: from mail.tmr.com ([216.238.38.203]:41487 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S266247AbUBQQUn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 11:20:43 -0500
Date: Tue, 17 Feb 2004 11:19:37 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Nick Piggin <piggin@cyberone.com.au>
cc: linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>
Subject: Re: [BENCHMARK] 2.6.3-rc2 v 2.6.3-rc3-mm1 kernbench
In-Reply-To: <40319720.3090709@cyberone.com.au>
Message-ID: <Pine.LNX.3.96.1040217110549.8209A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Feb 2004, Nick Piggin wrote:


> Bill, I have CC'ed your message without modification because Con is
> not subscribed to the list. Even for people who are subscribed, the
> convention on lkml is to reply to all.
> 
> Anyway, the "no SMT" run is with CONFIG_SCHED_SMT turned off, P4 HT
> is still on. This was my fault because I didn't specify clearly that
> I wanted to see a run with hardware HT turned off, although these
> numbers are still interesting.
> 
> Con hasn't tried HT off AFAIK because we couldn't work out how to
> turn it off at boot time! :(

The curse of the brain-dead BIOS :-(

So does CONFIG_SCHED_SMT turned off mean not using more than one sibling
per package, or just going back to using them poorly? Yes, I should go
root through the code.

Clearly it would be good to get one more data point with HT off in BIOS,
but from this data it looks as if the SMT stuff really helps little when
the system is very heavily loaded (Nproc>=Nsibs), and does best when the
load is around Nproc==Ncpu. At least as I read the data. The really
interesting data would be the -j64 load without HT, using both schedulers.

I just got done looking at a mail server with HT, kept the load avg 40-70
for a week. Speaks highly for the stability of RHEL-3.0, but I wouldn't
mind a little more performance for free.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

