Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284794AbSBMOLx>; Wed, 13 Feb 2002 09:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284732AbSBMOLl>; Wed, 13 Feb 2002 09:11:41 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:42247 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S284264AbSBMOL3>; Wed, 13 Feb 2002 09:11:29 -0500
Date: Wed, 13 Feb 2002 09:09:57 -0500
Message-Id: <200202131409.JAA10642@gatekeeper.tmr.com>
To: akpm@zip.com.au
Subject: Re: [patch] sys_sync livelock fix
In-Reply-To: <3C69FB14.167B899E@zip.com.au>
In-Reply-To: <3C69EBB7.24EA9C05@zip.com.au> <Pine.LNX.3.96.1020213000859.8487A-100000@gatekeeper.tmr.com>
Organization: TMR Associates, Schenectady NY
Cc: linux-kernel@vger.kernel.org
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3C69FB14.167B899E@zip.com.au> you write:
| Bill Davidsen wrote:
| > 
| > > But we want sync to be useful.
| > 
| >   No one has proposed otherwise. Unless you think that a possible hang is
| > useful, the questions becomes adding all dirty buffers to the elevator,
| > then (a) waiting or (b) returning. Either satisfies SuSv2.
| 
| errr.  Bill.  I wrote the patch.   Please take this as a sign
| that I'm not happy with the current implementation :)

Sorry, I had been sitting at a keyboard for about 16 hours when I typed
that, and didn't look at the sender... Lot's of other typos in there as
well, sign of need for 3-4 hours sleep.

But I think sync(2) as a checkpoint, write out all dirty at the moment
of sync call, is fine and deterministic, and all that.

That serves the shutdown case as well, if there is a process in some
unkillable state, but somehow still writing, at least the system will go
down. I'm not sure any process not killable with kill -9 is able to do
anything, but I won't bet on it.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
