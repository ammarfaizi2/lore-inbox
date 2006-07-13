Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030405AbWGMVaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030405AbWGMVaJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 17:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030406AbWGMVaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 17:30:09 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:17670 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1030405AbWGMVaH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 17:30:07 -0400
Date: Thu, 13 Jul 2006 21:29:41 +0000
From: Pavel Machek <pavel@suse.cz>
To: andrea@cpushare.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       Lee Revell <rlrevell@joe-job.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>,
       bunk@stusta.de, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [2.6 patch] let CONFIG_SECCOMP default to n
Message-ID: <20060713212940.GB4101@ucw.cz>
References: <20060629192121.GC19712@stusta.de> <200607102159.11994.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060711041600.GC7192@opteron.random> <200607111619.37607.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060712210545.GB24367@opteron.random> <1152741776.22943.103.camel@localhost.localdomain> <20060712234441.GA9102@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060712234441.GA9102@opteron.random>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Actually measuring time through the network is extremely doable given
> > enough samples as is communication through delay perturbation. A good
> > viterbi encoder/decoder will fish a signal out of very high noise. Yes
> > you pay a lot in data rate at that point but it works.
> 
> Currently the bandwidth is free, I'll charge for the transaction
> associated bandwidth only if I'm forced to (which would happen quickly
> if people starts doing the above ;).
> 
> The way the current transactions are running as we speak, is not like
> in a full peer to peer system. It's half peer to peer, a trusted node
> always sits in between buyer and seller. I need this for a multitude
> of reasons (I could offload the middle node in a p3p system that is
> reliable as long as only 1 of the 3 is malicious but it's certainly
> more secure if the node in the middle is fully trusted so I'll try to
> avoid that). So if you are right, my trusted node will simply add
> /dev/urandom delay as needed before forwarding any packet, to prevent
> any meaningful measurement. Any network side channel can be solved in
> a few liner patch and very quickly.

Actually random delays are unlike to help (much). You have just added
noise, but you can still decode original signal...

-- 
Thanks for all the (sleeping) penguins.
