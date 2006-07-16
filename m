Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946058AbWGPAup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946058AbWGPAup (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 20:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbWGPAup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 20:50:45 -0400
Received: from host36-195-149-62.serverdedicati.aruba.it ([62.149.195.36]:8582
	"EHLO mx.cpushare.com") by vger.kernel.org with ESMTP
	id S964820AbWGPAuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 20:50:44 -0400
Date: Sun, 16 Jul 2006 02:51:08 +0200
From: andrea@cpushare.com
To: Valdis.Kletnieks@vt.edu
Cc: Pavel Machek <pavel@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       Lee Revell <rlrevell@joe-job.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>,
       bunk@stusta.de, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [2.6 patch] let CONFIG_SECCOMP default to n
Message-ID: <20060716005108.GK18774@opteron.random>
References: <20060629192121.GC19712@stusta.de> <200607102159.11994.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060711041600.GC7192@opteron.random> <200607111619.37607.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060712210545.GB24367@opteron.random> <1152741776.22943.103.camel@localhost.localdomain> <20060712234441.GA9102@opteron.random> <20060713212940.GB4101@ucw.cz> <20060713231118.GA1913@opteron.random> <200607150255.k6F2tS2R008742@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607150255.k6F2tS2R008742@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2006 at 10:55:28PM -0400, Valdis.Kletnieks@vt.edu wrote:
> In fact, the best you can do here is to reduce the effective bandwidth
> the signal can have, as Shannon showed quite clearly.

Yes.

> And even 20 years ago, the guys who did the original DoD Orange Book
> requirements understood this - they didn't make a requirement that covert
> channels (both timing and other) be totally closed down, they only made
> a requirement that for higher security configurations the bandwidth of
> the channel be reduced below a specified level...

Why I think it's trivial to guarantee the closure of the seccomp side
channel timing attack even on a very fast internet by simply
introducing the random delay, is that below a certain sampling
frequency you won't be able to extract data from the latencies of the
cache. The max length of the random noise has to be >= of what it
takes to refill the whole cache. Then you won't know if it was a cache
miss or a random introduced delay that generated the slowdown, problem
solved.

As you and Pavel correctly pointed out, you can still communicate
whatever you want over the wire (between the two points) by using a
low enough frequency, but I don't think that has security relevance in
this context.

Thanks.
