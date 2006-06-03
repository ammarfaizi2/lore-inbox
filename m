Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbWFCH5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbWFCH5M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 03:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbWFCH5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 03:57:12 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:29873 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751317AbWFCH5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 03:57:10 -0400
Date: Sat, 3 Jun 2006 09:57:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Andrew Morton'" <akpm@osdl.org>,
       "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "'Chris Mason'" <mason@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] fix smt nice lock contention and optimization
Message-ID: <20060603075734.GC20229@elte.hu>
References: <000701c686e1$71f2f7f0$df34030a@amr.corp.intel.com> <200606031752.59532.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606031752.59532.kernel@kolivas.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5004]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Con Kolivas <kernel@kolivas.org> wrote:

> Could we make this neater with extra braces such as:
> 
>  	for_each_domain(this_cpu, tmp) {
> 		if (tmp->flags & SD_SHARE_CPUPOWER) {
>  			sd = tmp;
> 			break;
> 		}
> 	}
> 
> and same for the other uses of for_each ? I know it's redundant but 
> it's neater IMO when there are multiple lines of code below it.

yep, that's the preferred style when there are multiple lines below a 
loop.

	Ingo
