Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311922AbSCTSTH>; Wed, 20 Mar 2002 13:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311921AbSCTSS6>; Wed, 20 Mar 2002 13:18:58 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:54284 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S311912AbSCTSSw>; Wed, 20 Mar 2002 13:18:52 -0500
Date: Wed, 20 Mar 2002 13:15:54 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: aa-030-writeout_scheduling
In-Reply-To: <Pine.LNX.4.44L.0203201039510.2181-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.3.96.1020320131135.7804B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2002, Rik van Riel wrote:

> Indeed, I suspect you'll want to either fix this or remove
> the code before submitting the patch.  Including dead code
> right from the start seems kind of pointless.

  Fix it is obviously the right way to go, assuming it is really broken
rather than some problem in the breakup.
 
> Note that if you have the ndirty thing functional, the
> nfract_stop_bdflush tunable isn't doing anything, since
> kswapd would stop after ndirty pages ...

That's not the intent... one is "don't do too much at one time" and the
other is "stop when you've done enough." I think both are good things to
be able to adjust, along with the usual frequency of check and age to
flush. Better that all of these should WORK, of course.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

