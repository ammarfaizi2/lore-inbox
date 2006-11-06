Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030352AbWKFHYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030352AbWKFHYR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 02:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030359AbWKFHYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 02:24:17 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:26293 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030352AbWKFHYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 02:24:16 -0500
Date: Mon, 6 Nov 2006 08:23:23 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       arjan <arjan@infradead.org>
Subject: Re: [PATCH] debug workqueue locking sanity
Message-ID: <20061106072323.GC29772@elte.hu>
References: <1162758984.14695.22.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162758984.14695.22.camel@lappy>
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


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> +		if (unlikely(in_atomic()
> +#ifdef CONFIG_LOCKDEP
> +			|| current->lockdep_depth > 0
> +#endif
> +			)) {

i agree with this patch, but shouldnt this #ifdef be hidden via some 
sort of lockdep_depth() inline in lockdep.h that just returns 0 if 
!LOCKDEP?

	Ingo
