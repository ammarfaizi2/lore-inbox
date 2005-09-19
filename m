Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932596AbVISTtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596AbVISTtg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 15:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbVISTtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 15:49:36 -0400
Received: from cantor.suse.de ([195.135.220.2]:36017 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932596AbVISTtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 15:49:36 -0400
Date: Mon, 19 Sep 2005 21:49:34 +0200
From: Andi Kleen <ak@suse.de>
To: john stultz <johnstul@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, discuss@x86-64.org
Subject: Re: [discuss] Re: [PATCH] x86-64: Fix bad assumption that dualcore cpus have synced TSCs
Message-ID: <20050919194934.GC12810@verdi.suse.de>
References: <1127157404.3455.209.camel@cog.beaverton.ibm.com> <20050919193105.GA12810@verdi.suse.de> <1127158937.3455.214.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127158937.3455.214.camel@cog.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2005 at 12:42:16PM -0700, john stultz wrote:
> On Mon, 2005-09-19 at 21:31 +0200, Andi Kleen wrote:
> > On Mon, Sep 19, 2005 at 12:16:43PM -0700, john stultz wrote:
> > > 	This patch should resolve the issue seen in bugme bug #5105, where it
> > > is assumed that dualcore x86_64 systems have synced TSCs. This is not
> > > the case, and alternate timesources should be used instead.
> > 
> > 
> > I asked AMD some time ago and they told me it was synchronized.
> > The TSC on K8 is C state invariant, but not P state invariant,
> > but P states always happen synchronized on dual cores.
> > 
> > So I'm not quite convinced of your explanation yet.
> 
> Would a litter userspace test checking the TSC synchronization maybe
> shed additional light on the issue?

Sure you can try it.

-Andi
