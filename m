Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968295AbWLEPdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968295AbWLEPdp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 10:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968307AbWLEPdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 10:33:45 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:59554 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968295AbWLEPdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 10:33:44 -0500
Date: Tue, 5 Dec 2006 16:32:24 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "'Andrew Morton'" <akpm@osdl.org>,
       "'Christoph Lameter'" <clameter@sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [-mm patch] sched remove lb_stopbalance counter
Message-ID: <20061205153224.GA3204@elte.hu>
References: <000001c71881$1ad82850$a884030a@amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001c71881$1ad82850$a884030a@amr.corp.intel.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0003]
	1.4 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:

> in -mm tree: I would like to revert the change on adding 
> lb_stopbalance counter.  This count can be calculated by: lb_balanced 
> - lb_nobusyg - lb_nobusyq.  There is no need to create gazillion 
> counters while we can derive the value.  I'm more of against changing 
> sched-stat format unless it is absolutely necessary as all user land 
> tool parsing /proc/schedstat needs to be updated and it's a real pain 
> trying to keep multiple versions of it.
> 
> Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

Acked-by: Ingo Molnar <mingo@elte.hu>

but, please:

> -#define SCHEDSTAT_VERSION 13
> +#define SCHEDSTAT_VERSION 12

change this to 14 instead. Versions should only go upwards, even if we 
revert to an earlier output format.

	Ingo
