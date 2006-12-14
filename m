Return-Path: <linux-kernel-owner+w=401wt.eu-S1751882AbWLNAhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbWLNAhX (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 19:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbWLNAhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 19:37:23 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:48398 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751883AbWLNAhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 19:37:21 -0500
Date: Thu, 14 Dec 2006 01:34:56 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: nickpiggin@yahoo.com.au, vatsa@in.ibm.com, clameter@sgi.com,
       tglx@linutronix.de, arjan@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Patch: dynticks: idle load balancing
Message-ID: <20061214003456.GA2064@elte.hu>
References: <20061211155304.A31760@unix-os.sc.intel.com> <20061213224317.GA2986@elte.hu> <20061213231316.GA13849@elte.hu> <20061213150314.B12795@unix-os.sc.intel.com> <20061213233157.GA20470@elte.hu> <20061213151926.C12795@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061213151926.C12795@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:

> > the other problem is load_balance(): there this_rq is locked and you 
> > call resched_cpu() unconditionally.
> 
> But here resched_cpu() was called after double_rq_unlock().

yeah, you are right - the schedule() one is/was the only problem.

	Ingo
