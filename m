Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932614AbVISTmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614AbVISTmU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 15:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932618AbVISTmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 15:42:20 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:58759 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932614AbVISTmT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 15:42:19 -0400
Subject: Re: [PATCH] x86-64: Fix bad assumption that dualcore cpus have
	synced TSCs
From: john stultz <johnstul@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       discuss@x86-64.org
In-Reply-To: <20050919193105.GA12810@verdi.suse.de>
References: <1127157404.3455.209.camel@cog.beaverton.ibm.com>
	 <20050919193105.GA12810@verdi.suse.de>
Content-Type: text/plain
Date: Mon, 19 Sep 2005 12:42:16 -0700
Message-Id: <1127158937.3455.214.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-19 at 21:31 +0200, Andi Kleen wrote:
> On Mon, Sep 19, 2005 at 12:16:43PM -0700, john stultz wrote:
> > 	This patch should resolve the issue seen in bugme bug #5105, where it
> > is assumed that dualcore x86_64 systems have synced TSCs. This is not
> > the case, and alternate timesources should be used instead.
> 
> 
> I asked AMD some time ago and they told me it was synchronized.
> The TSC on K8 is C state invariant, but not P state invariant,
> but P states always happen synchronized on dual cores.
> 
> So I'm not quite convinced of your explanation yet.

Would a litter userspace test checking the TSC synchronization maybe
shed additional light on the issue?

thanks
-john



