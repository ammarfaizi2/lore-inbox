Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269114AbUICHAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269114AbUICHAX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 03:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269261AbUICHAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 03:00:23 -0400
Received: from mx1.elte.hu ([157.181.1.137]:31944 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269114AbUICHAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 03:00:14 -0400
Date: Fri, 3 Sep 2004 09:01:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Eric St-Laurent <ericstl34@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R0
Message-ID: <20040903070136.GA13100@elte.hu>
References: <20040902065549.GA18860@elte.hu> <20040902111003.GA4256@elte.hu> <20040902215728.GA28571@elte.hu> <1094162812.1347.54.camel@krustophenia.net> <20040902221402.GA29434@elte.hu> <1094171082.19760.7.camel@krustophenia.net> <1094181447.4815.6.camel@orbiter> <1094192788.19760.47.camel@krustophenia.net> <20040903063658.GA11801@elte.hu> <1094194157.19760.71.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094194157.19760.71.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> > vanilla kernel 2.6.8.1 would be quite interesting to get a few charts of
> > - especially if your measurement methodology has changed.
> 
> OK, I will give this a shot.  Now that the VP patches are stabilizing
> I will be doing more profiling.  I also want to try the -mm kernel,
> this has some interesting differences from the stock kernel.  For
> example I measured about a 10% improvement with the old method, which
> implies a big performance gain.

the -mm kernel used to have additional *-latency-fix patches that were
done based on the initial preemption-timing patch in -mm and partly
based on early VP discussions and findings. I recently reviewed and
merged the 2-3 missing ones into VP. Andrew has dropped these patches
meanwhile and i expect to submit the cleaner and more complete solution
that is in VP.

So i'd expect -mm to still perform better than vanilla (it usually
does), but if that big 10% difference in latencies doesnt show up
anymore i'd attribute it to the shuffling around of latency related
patches, not some genuine deficiency in -mm.

	Ingo
