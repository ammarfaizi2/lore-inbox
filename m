Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268206AbUIGQJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268206AbUIGQJd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 12:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268191AbUIGQI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 12:08:57 -0400
Received: from mx2.elte.hu ([157.181.151.9]:6625 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268279AbUIGPCo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 11:02:44 -0400
Date: Tue, 7 Sep 2004 17:04:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R8
Message-ID: <20040907150406.GA29468@elte.hu>
References: <20040903120957.00665413@mango.fruits.de> <20040905140249.GA23502@elte.hu> <20040906110626.GA32320@elte.hu> <200409061348.41324.rjw@sisk.pl> <1094473527.13114.4.camel@boxen> <20040906122954.GA7720@elte.hu> <20040907092659.GA17677@elte.hu> <20040907115722.GA10373@elte.hu> <1094568658.670.11.camel@boxen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094568658.670.11.camel@boxen>
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


* Alexander Nyberg <alexn@dsv.su.se> wrote:

> Looks fine over here on 2-CPU, debian 64-bit user-space with both
> preempt & voluntary preempt turned on. Init seems to explode (gets
> killed over and over, not sure how this happens) on
> CONFIG_LATENCY_TRACE, I'll take a look at that later today unless you
> have any offender you're aware of.

> +#ifdef CONFIG_LATENCY_TRACE
> +EXPORT_SYMBOL(mcount);
> +#endif

thanks, i've added this to latency.c. You can find my current snapshot
at:

  http://redhat.com/~mingo/private/voluntary-preempt-2.6.9-rc1-bk12-R9-A6

there are alot of changes - perhaps one of them fixes your LATENCY_TRACE
problem - but the likelyhood is low, for me LATENCY_TRACE worked fine on
amd64 even with -R8.

	Ingo
