Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbTLCUs3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 15:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbTLCUs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 15:48:29 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:39433 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261735AbTLCUs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 15:48:27 -0500
Date: Wed, 3 Dec 2003 21:45:18 +0100
From: Willy Tarreau <willy@w.ods.org>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: XFS for 2.4
Message-ID: <20031203204518.GA11325@alpha.home.local>
References: <20031202002347.GD621@frodo> <Pine.LNX.4.44.0312020919410.13692-100000@logos.cnet> <bqlbuj$j03$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bqlbuj$j03$1@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 07:01:39PM +0000, bill davidsen wrote:
 
> Yes, a development tree is much different than a stable tree, and even
> though the number has gone to 2.6, it's very much a development tree, in
> that it's still being used by the same people, and probably not getting
> a lot of new testing. Stability is unlikely to be production quality
> until fixes go in for problems in mass testing, which won't happen until
> it shows up in a vendor release, which won't happen until the vendors
> test and clean up what they find... In other words, I don't expect it to
> be "really stable" for six months at least, maybe a year.

There even are people using 2.2 on production and/or desktop computers. I
know some of them. Many people jumped from 2.2 to 2.4 because of USB, but
since it was backported into 2.2.18, many people prefered to stick to 2.2.

> As for "much faster," let's say that I don't see that on any apples to
> apples benchmark. If you measure new threading against 2.4 threading
> there is a significant gain, but for anything else the gains just don't
> seem to warrant a "much" and there are some regressions shown in other
> people's data.

I second this. I've already tested several 2.5 and 2.6-test, and I'm
really deceived by the scheduler. It looks a lot more as a hack to
satisfy xmms users than something usable. I'm doing 'ls -ltr' all the
day in directories filled with 2000 files, and it takes ages to complete.
I'm even at the point to which I add a "|tail" to make things go faster.

For instance, time typically reports 0.03u, 0.03s, 2.8 real. It seems as
each line sent to xterm consumes one full clock tick doing nothing. I
never reported it yet because I don't have time to investigate, and it
seems more important that people don't hear skips in xmms while compiling
their kernel with "make -j 256" on a 16 MB machine. Second test : launch
10 times : xterm -e "find /" & and look how some windows freeze for up
to 10 seconds... I don't think this is a problem right now. We've seen
lots of work in the scheduler area, many people proposing theirs, and
this will stabilize once 2.6 is out and people start to describe what
they really do with it and what they feel.

Don't take me wrong, I don't want to whine nor offend anyone here. I
think that Ingo and other people like Con have done a very great job
at optimizing this scheduler. I just wish we could choose one depending
on what we want to do with it.

Just my 2 cents,
Willy

