Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWH1TQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWH1TQh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 15:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWH1TQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 15:16:37 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:60394 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750717AbWH1TQg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 15:16:36 -0400
Date: Tue, 29 Aug 2006 00:46:42 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Paul E McKenney <paulmck@us.ibm.com>
Subject: Re: [PATCH 0/4] RCU: various merge candidates
Message-ID: <20060828191642.GA32697@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060828160845.GB3325@in.ibm.com> <20060828120611.afad8b0f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060828120611.afad8b0f.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2006 at 12:06:11PM -0700, Andrew Morton wrote:
> On Mon, 28 Aug 2006 21:38:45 +0530
> Dipankar Sarma <dipankar@in.ibm.com> wrote:
> 
> > This patchset consists of various merge candidates that would
> > do well to have some testing in -mm. This patchset breaks
> > out RCU implementation from its APIs to allow multiple
> > implementations, gives RCU its own softirq and finally
> > lines up preemptible RCU from -rt tree as a configurable
> > RCU implementation for mainline.
> > 
> > All comments and testing is welcome. RFC at the moment, but
> > I can later submit patches against -mm, Andrew, if you want.
> > They have been tested lightly using dbench, kernbench and ltp
> > (both CONFIG_CLASSIC_RCU=y and n) on x86 and ppc64.
> 
> ouch.
> 
> akpm:/usr/src/25> grep rcu series
> radix-tree-rcu-lockless-readside.patch
> adix-tree-rcu-lockless-readside-update.patch
> radix-tree-rcu-lockless-readside-semicolon.patch
> adix-tree-rcu-lockless-readside-update-tidy.patch
> adix-tree-rcu-lockless-readside-fix-2.patch
> adix-tree-rcu-lockless-readside-fix-3.patch

Not related to RCU implementation.

> rcu-add-lock-annotations-to-rcu_bh_torture_read_lockunlock.patch

rcutorture (test module) patch independent of the implementation changes.

> srcu-3-rcu-variant-permitting-read-side-blocking.patch
> srcu-3-rcu-variant-permitting-read-side-blocking-fix.patch
> srcu-3-rcu-variant-permitting-read-side-blocking-srcu-add-lock-annotations.patch
> srcu-3-add-srcu-operations-to-rcutorture.patch
> srcu-3-add-srcu-operations-to-rcutorture-fix.patch
> add-srcu-based-notifier-chains.patch
> add-srcu-based-notifier-chains-cleanup.patch
> srcu-report-out-of-memory-errors.patch
> srcu-report-out-of-memory-errors-fixlet.patch
> cpufreq-make-the-transition_notifier-chain-use-srcu.patch

srcu (sleepable rcu) patches independent of the core RCU implementation
changes in the patchset. You can queue these up either before
or after srcu.


> rcu-add-module_author-to-rcutorture-module.patch
> rcu-fix-incorrect-description-of-default-for-rcutorture.patch
> rcu-mention-rcu_bh-in-description-of-rcutortures.patch
> rcu-avoid-kthread_stop-on-invalid-pointer-if-rcutorture.patch
> rcu-fix-sign-bug-making-rcu_random-always-return-the-same.patch
> rcu-add-fake-writers-to-rcutorture.patch
> rcu-add-fake-writers-to-rcutorture-tidy.patch

rcutorture fix patches independent of rcu implementation changes
in this patchset.

> 
> Now what?

Heh. I can always re-submit against -mm after I wait for a day or two
for comments :) Or I can wait. I think rcutorture patches are
fairly safe to merge and should go in soon. srcu and the patchset
I mailed today should probably get more testing in -mm before
going in.

Thanks
Dipankar

Thanks
Dipankar
