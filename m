Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161042AbWGMXKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161042AbWGMXKJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 19:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161041AbWGMXKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 19:10:09 -0400
Received: from host36-195-149-62.serverdedicati.aruba.it ([62.149.195.36]:14479
	"EHLO mx.cpushare.com") by vger.kernel.org with ESMTP
	id S1161042AbWGMXKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 19:10:07 -0400
Date: Fri, 14 Jul 2006 01:11:18 +0200
From: andrea@cpushare.com
To: Pavel Machek <pavel@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       Lee Revell <rlrevell@joe-job.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>,
       bunk@stusta.de, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [2.6 patch] let CONFIG_SECCOMP default to n
Message-ID: <20060713231118.GA1913@opteron.random>
References: <20060629192121.GC19712@stusta.de> <200607102159.11994.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060711041600.GC7192@opteron.random> <200607111619.37607.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060712210545.GB24367@opteron.random> <1152741776.22943.103.camel@localhost.localdomain> <20060712234441.GA9102@opteron.random> <20060713212940.GB4101@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713212940.GB4101@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2006 at 09:29:41PM +0000, Pavel Machek wrote:
> Actually random delays are unlike to help (much). You have just added
> noise, but you can still decode original signal...

You're wrong, the random delays added to every packet will definitely
wipe out any signal.

But regardless of what is the best fix for the network attack I quote
Ingo:

   correct. But when i suggested to do precisely that i got a rant from
   Andrea of how super duper important it was to disable the TSC for
   seccomp ... (which argument is almost total hogwash)

Now if the availability of the nanosecond precision of the TSC is
almost total hogwash, how can the network attack be a real concern?

Either the NOTSC feature is critically important (and I don't think it
is but it's not total hogwash either), or the network attach is an
absolute red-herring.

You can't get it both ways. It can't be the NOTSC isn't needed but the
network attack is a serious concern.

What is currently shocking me is that if you really think the network
attack isn't an absolute red-herring, then it's very weird you're
answering to my email instead of answering to Ingo when he says the
availability of the TSC is almost total hogwash.

And please feel free to demonstrate the network attack, remote seccomp
computations are already possible so if you want to start listening to
a signal you can.
