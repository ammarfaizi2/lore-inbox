Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423712AbWKFKMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423712AbWKFKMU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 05:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423710AbWKFKMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 05:12:20 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:60886 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1423712AbWKFKMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 05:12:19 -0500
Date: Mon, 6 Nov 2006 11:11:17 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mike Galbraith <efault@gmx.de>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org, Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: Re: realtime-preempt patch-2.6.18-rt7 oops
Message-ID: <20061106101117.GA20616@elte.hu>
References: <454BC8D1.1020001@rncbc.org> <454BF608.20803@rncbc.org> <454C714B.8030403@rncbc.org> <454E0976.8030303@rncbc.org> <454E15B0.2050008@rncbc.org> <1162742535.2750.23.camel@localhost.localdomain> <454E2FC1.4040700@rncbc.org> <1162797896.6126.5.camel@Homer.simpson.net> <20061106093815.GB14388@elte.hu> <1162807371.13579.4.camel@Homer.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162807371.13579.4.camel@Homer.simpson.net>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mike Galbraith <efault@gmx.de> wrote:

> > could you try the patch below, does it help? (a quick review seems 
> > to suggest that all codepaths protected by kretprobe_lock are 
> > atomic)
> 
> Ah, so I did do the right thing.  Besides the oops, I was getting a 
> pretty frequent non-deadly...

yeah ...

> ...so turned it back into a non-sleeping lock.
> 
> You forgot kprobes.h

so the patch solves this problem for you?

	Ingo
