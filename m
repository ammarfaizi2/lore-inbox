Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbWF3Eua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbWF3Eua (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 00:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbWF3Eua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 00:50:30 -0400
Received: from host36-195-149-62.serverdedicati.aruba.it ([62.149.195.36]:3206
	"EHLO mx.cpushare.com") by vger.kernel.org with ESMTP
	id S1750905AbWF3Eu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 00:50:29 -0400
Date: Fri, 30 Jun 2006 06:52:28 +0200
From: Andrea Arcangeli <andrea@cpushare.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, mingo@elte.hu, Alan Cox <alan@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [2.6 patch] let CONFIG_SECCOMP default to n
Message-ID: <20060630045228.GA14677@opteron.random>
References: <20060629192121.GC19712@stusta.de> <1151628246.22380.58.camel@mindpipe> <20060629180706.64a58f95.akpm@osdl.org> <20060630014050.GI19712@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060630014050.GI19712@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Jun 30, 2006 at 03:40:50AM +0200, Adrian Bunk wrote:
> Andrea is proud [..]

I wish I could be proud of it like you suggest, but for now it remains
to be seen if it will be approved and useful, perhaps one day will pay
off and I could be proud of the hard work, but for now I'm being very
cautious.

> [..] so I doubt 
> he would be happy with no longer having the client part defaulting to
> Y... [..]

Correct but this is a purely technical matter, let's not confuse
technical issues with strict bureaucracy.

> It might sound a bit strange that although Alan Cox and Linus Torvalds 
> even wrote an open letter to the President of the European Parliament
> calling "Software patents are also the utmost threat to the development 
> of Linux and other free software products" [2]...

Alan filed too:

	http://appft1.uspto.gov/netacgi/nph-Parser?Sect1=PTO2&Sect2=HITOFF&p=1&u=%2Fnetahtml%2FPTO%2Fsearch-bool.html&r=2&f=G&l=50&co1=AND&d=PG01&s1=%22alan+cox%22&OS="alan+cox"&RS="alan+cox"

Ingo who started this focus on disabling seccomp by default filed too:

	http://appft1.uspto.gov/netacgi/nph-Parser?Sect1=PTO2&Sect2=HITOFF&p=1&u=%2Fnetahtml%2FPTO%2Fsearch-bool.html&r=1&f=G&l=50&co1=AND&d=PG01&s1=molnar&s2=ingo&OS=molnar+AND+ingo&RS=molnar+AND+ingo

FWIW I agree that patents at large are one of the threats to the
development of linux and other free software. But it's not me that
you've to talk with if you want to change the system. I can only agree
with Linus, Alan and you. Like most others here I would be _very_ happy
if all patents would suddently disappear, not just the software patents.

Infact you should inform yourself on the usages of your cpu resources if
you're donating them:

	http://ubuntuforums.org/archive/index.php/t-31418.html"***</t-116861.html

As far as CPUShare is concerned that problem doesn't exist because it's
not a donation, so it's up to you to ask a fair price.

> One bonus point for people arguing in favor of software patents - even 
> Linux actively supports patented services.

Not quite, all open source or proprietary OS out there are free to add
seccomp to their kernels, I will never have any right about the seccomp
idea no matter what.

BTW, I suggested a few weeks ago to the rpm maintainer to use seccomp to
validate the rpm header data because he wasn't convinced that such code
could be trusted. It seems he was looking into it. There are many other
possible usages but nobody ever got intersted to implement them so far.

I think Y is the right setting. If something I can add a secondary
config option for the tsc disable and set that one to N, but the global
CONFIG_SECCOMP should be set to Y beause it generates absolutely zero
overhead, not just pratically but theoretically too.
