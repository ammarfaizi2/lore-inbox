Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbWH1TGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWH1TGZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 15:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWH1TGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 15:06:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14743 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751347AbWH1TGX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 15:06:23 -0400
Date: Mon, 28 Aug 2006 12:06:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: dipankar@in.ibm.com
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Paul E McKenney <paulmck@us.ibm.com>
Subject: Re: [PATCH 0/4] RCU: various merge candidates
Message-Id: <20060828120611.afad8b0f.akpm@osdl.org>
In-Reply-To: <20060828160845.GB3325@in.ibm.com>
References: <20060828160845.GB3325@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2006 21:38:45 +0530
Dipankar Sarma <dipankar@in.ibm.com> wrote:

> This patchset consists of various merge candidates that would
> do well to have some testing in -mm. This patchset breaks
> out RCU implementation from its APIs to allow multiple
> implementations, gives RCU its own softirq and finally
> lines up preemptible RCU from -rt tree as a configurable
> RCU implementation for mainline.
> 
> All comments and testing is welcome. RFC at the moment, but
> I can later submit patches against -mm, Andrew, if you want.
> They have been tested lightly using dbench, kernbench and ltp
> (both CONFIG_CLASSIC_RCU=y and n) on x86 and ppc64.

ouch.

akpm:/usr/src/25> grep rcu series
radix-tree-rcu-lockless-readside.patch
adix-tree-rcu-lockless-readside-update.patch
radix-tree-rcu-lockless-readside-semicolon.patch
adix-tree-rcu-lockless-readside-update-tidy.patch
adix-tree-rcu-lockless-readside-fix-2.patch
adix-tree-rcu-lockless-readside-fix-3.patch
rcu-add-lock-annotations-to-rcu_bh_torture_read_lockunlock.patch
srcu-3-rcu-variant-permitting-read-side-blocking.patch
srcu-3-rcu-variant-permitting-read-side-blocking-fix.patch
srcu-3-rcu-variant-permitting-read-side-blocking-srcu-add-lock-annotations.patch
srcu-3-add-srcu-operations-to-rcutorture.patch
srcu-3-add-srcu-operations-to-rcutorture-fix.patch
add-srcu-based-notifier-chains.patch
add-srcu-based-notifier-chains-cleanup.patch
srcu-report-out-of-memory-errors.patch
srcu-report-out-of-memory-errors-fixlet.patch
cpufreq-make-the-transition_notifier-chain-use-srcu.patch
rcu-add-module_author-to-rcutorture-module.patch
rcu-fix-incorrect-description-of-default-for-rcutorture.patch
rcu-mention-rcu_bh-in-description-of-rcutortures.patch
rcu-avoid-kthread_stop-on-invalid-pointer-if-rcutorture.patch
rcu-fix-sign-bug-making-rcu_random-always-return-the-same.patch
rcu-add-fake-writers-to-rcutorture.patch
rcu-add-fake-writers-to-rcutorture-tidy.patch

Now what?
