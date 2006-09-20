Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWITIz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWITIz6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 04:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWITIz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 04:55:58 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:37338 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750716AbWITIz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 04:55:57 -0400
Date: Wed, 20 Sep 2006 10:47:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] rtc: lockdep fix
Message-ID: <20060920084728.GA17887@elte.hu>
References: <1158695676.28174.21.camel@lappy> <20060920082135.GB12517@elte.hu> <4511008E.5090005@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4511008E.5090005@linux.intel.com>
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


* Arjan van de Ven <arjan@linux.intel.com> wrote:

> >ouch! That is a scenario that could lead to real lockups. Fix looks 
> >good and necessary for v2.6.18 to me.
> 
> btw this entire code path is evil; the rtc_get_rtc_time() function can 
> do really long delays which is unsuitable for being called in 
> interrupt context!

yeah - but i dont think it triggers that often, and a fix for that 
probably isnt for v2.6.18.

	Ingo
