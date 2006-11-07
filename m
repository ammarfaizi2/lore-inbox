Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754092AbWKGHdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754092AbWKGHdn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 02:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754091AbWKGHdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 02:33:43 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:47795 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1754090AbWKGHdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 02:33:42 -0500
Date: Tue, 7 Nov 2006 08:32:48 +0100
From: Ingo Molnar <mingo@elte.hu>
To: akpm@osdl.org
Cc: mm-commits@vger.kernel.org, clameter@sgi.com, nickpiggin@yahoo.com.au,
       suresh.b.siddha@intel.com, linux-kernel@vger.kernel.org
Subject: Re: + sched-use-tasklet-to-call-balancing.patch added to -mm tree
Message-ID: <20061107073248.GB5148@elte.hu>
References: <200611032205.kA3M5wmJ003178@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611032205.kA3M5wmJ003178@shell0.pdx.osdl.net>
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


* akpm@osdl.org <akpm@osdl.org> wrote:

> +DECLARE_TASKLET(rebalance, &rebalance_domains, 0L);

i'm not sure i get the point of this whole do-rebalance-in-tasklet idea. 
A tasklet is global to the system. The rebalance tick was per-CPU. This 
is not an equivalent change at all. What am i missing?

	Ingo
