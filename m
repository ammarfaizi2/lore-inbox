Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbUCIXOE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 18:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262408AbUCIXOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 18:14:04 -0500
Received: from alt.aurema.com ([203.217.18.57]:16008 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S262304AbUCIXN6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 18:13:58 -0500
Date: Wed, 10 Mar 2004 10:13:47 +1100
From: Kingsley Cheung <kingsley@aurema.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] For preventing kstat overflow
Message-ID: <20040310101347.B30341@aurema.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040309132338.A30341@aurema.com> <20040308185354.70040c8b.akpm@osdl.org> <20040309165704.L29788@aurema.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040309165704.L29788@aurema.com>; from kingsley@aurema.com on Tue, Mar 09, 2004 at 04:57:04PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2004 at 04:57:04PM +1100, Kingsley Cheung wrote:
> On Mon, Mar 08, 2004 at 06:53:54PM -0800, Andrew Morton wrote:
> > Kingsley Cheung <kingsley@aurema.com> wrote:
> > >
> > > Hi All,
> > > 
> > > What do people think of a patch to change the fields in cpu_usage_stat
> > > from unsigned ints to unsigned long longs?  And the same change for
> > > nr_switches in the runqueue structure too?
> > 
> > Sounds unavoidable.
> > 
> > > Its actually worse for context
> > > switches on a busy system, for we've been seeing an average of ten
> > > switches a tick for some of the statistics we have.
> > 
> > Sounds broken.  What CPU scheduler are you using?
> 
> Um, what do you mean by broken?
> 
> Well, as for the scheduler, its the Entitlement Based Scheduler, but
> it doesn't look like its got anything to do with the scheduler.  Some
> work loads we have been testing just have processes that come and go
> so frequently that the context switch rate is high.  Even when Ingo
> posted his original O(1) patch (see
> http://marc.theaimsgroup.com/?l=linux-kernel&m=101010394225604&w=2) he
> claimed high context switch rates.

Oh, just in case there's some confusion... even though we've been
seeing it for EBS, the patch is for 2.6.3.

-- 
		Kingsley
