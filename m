Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTLDFgp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 00:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbTLDFgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 00:36:45 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:45065 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261754AbTLDFgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 00:36:43 -0500
Date: Thu, 4 Dec 2003 06:33:18 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Clemens Schwaighofer <cs@tequila.co.jp>
Cc: bill davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: XFS for 2.4
Message-ID: <20031204053318.GB16903@alpha.home.local>
References: <20031202002347.GD621@frodo> <Pine.LNX.4.44.0312020919410.13692-100000@logos.cnet> <bqlbuj$j03$1@gatekeeper.tmr.com> <20031203204518.GA11325@alpha.home.local> <3FCE810F.3050100@tequila.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FCE810F.3050100@tequila.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04, 2003 at 09:34:23AM +0900, Clemens Schwaighofer wrote:
 
> Well, I had to try that here. I've got a Celeron 650Mhz with 320MB ram
> and a crappy 14GB HD and yes the finds in the xterms are stopping for
> some time ... BUT X is 100% responsive.  there is no sluggishness, I can
> use mozilla, etc without a problem. so seriously, who makes 10 finds at
> the same time and finds are read from FS (I have XFS) so it might be a
> problem with that.

This exact workload is probably not needed by anybody. But my concern is
that if it fails here, then possibily other realistic workloads will fail
too. But since it's hard to identify, that's why I'm waiting for distros
to ship first releases, and for a few people to tell us about particular
cases where they are annoyed. Ingo, Con, Nick and others obviously cannot
make the greatest scheduler in the world without valuable feedback. And
I have the feeling that all they got was "bad...bad...bad.. STOP!! don't
touch anything, XMMS is now great".

Production workloads are typically different. Perhaps my 10 xterms produce
the same type of load as 10 persons grepping gigs of logs from memory ?
And perhaps my "ls -ltr" produce the same workload as... someone searching
a recent file with "ls -ltr".

> So I don't think the scheduler is bad, I think it is
> great. When I switched to 2.5 the first time on that box it was like
> "WOW", so little swapping and KDE is so smooth ... thats so wow ...

I too think it's great and smoother than 2.4. It obviously makes a difference
if you use X (and I don't use these KDE, etc...). But the smoothness was
also brought to 2.4 by patches such as rmap, preempt, variable-hz. All of
them have been merged into 2.6, so we cannot deny that they helped too.

> But for your problem, it might get better for these kind of things in
> later versions :)

-test10 was NOK. I'll try test11, and when I've time I'll try Nick's
scheduler too.

Cheers,
Willy

