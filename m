Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269063AbUICPpC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269063AbUICPpC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 11:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269294AbUICPpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 11:45:01 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:21457 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S269066AbUICPoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 11:44:03 -0400
Date: Fri, 3 Sep 2004 11:48:29 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Matt Mackall <mpm@selenic.com>,
       William Lee Irwin III <wli@holomorphy.com>, Keith Owens <kaos@sgi.com>
Subject: Re: [PATCH][0/8] Arch agnostic completely out of line locks
In-Reply-To: <393510000.1094222920@[10.10.2.4]>
Message-ID: <Pine.LNX.4.58.0409031134560.4481@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0409020905540.4481@montezuma.fsmlabs.com>
 <393510000.1094222920@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Sep 2004, Martin J. Bligh wrote:

> > This patch achieves out of line spinlocks by creating kernel/spinlock.c
> > and using the _raw_* inline locking functions.
> ...
> > Size differences are with CONFIG_PREEMPT enabled since we wanted to
> > determine how much could be saved by moving that lot out of line too.
>
> So does this have no performance impact at all? or has that not been measured?

No performance regression on i386 with a specific benchmark (bonnie++)

http://www.zwane.ca/results/cool-locks-stp

I'm going to be running benchmarks against this version of the patch, but
still collecting which to run.

Thanks,
	Zwane

