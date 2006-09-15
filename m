Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWIOJw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWIOJw7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 05:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWIOJw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 05:52:59 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:3725 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750818AbWIOJw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 05:52:58 -0400
Date: Fri, 15 Sep 2006 11:44:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Lameter <christoph@sgi.com>, Nick Piggin <npiggin@suse.de>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix longstanding load balancing bug in the scheduler V2
Message-ID: <20060915094428.GA31195@elte.hu>
References: <20060908103529.A9121@unix-os.sc.intel.com> <Pine.LNX.4.64.0609081135590.23089@schroedinger.engr.sgi.com> <20060908130028.A9446@unix-os.sc.intel.com> <Pine.LNX.4.64.0609081316580.24016@schroedinger.engr.sgi.com> <20060908170352.C9446@unix-os.sc.intel.com> <Pine.LNX.4.64.0609082222330.25269@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0609091252070.26746@schroedinger.engr.sgi.com> <20060911083734.GA25953@wotan.suse.de> <Pine.LNX.4.64.0609121135590.12100@schroedinger.engr.sgi.com> <20060914172617.fc8aef2b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060914172617.fc8aef2b.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> On Tue, 12 Sep 2006 11:37:55 -0700 (PDT)
> Christoph Lameter <christoph@sgi.com> wrote:
> 
> > Fix longstanding load balancing bug in the scheduler V2.
> > 
> > AFAIK this is an important scheduler bug that needs to go 
> > into 2.6.18 and all stable release since the issue can stall the 
> > scheduler for good.
> 
> The timing is of course problematic.  One approach could be to merge 
> it into 2.6.19-early, backport into 2.6.18.x after a few weeks.  I 
> don't know if that's a lot better, really - it's unlikely that anyone 
> will be running serious performance testing against 2.6.19-rc1 or 
> -rc2.

with that release approach it's:

Acked-by: Ingo Molnar <mingo@elte.hu>

> I'm struggling to understand how serious this really is - if the bug 
> is "longstanding" then very few machines must be encountering it?

yeah.

	Ingo
