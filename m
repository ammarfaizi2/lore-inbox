Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266473AbUGPAjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266473AbUGPAjb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 20:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266474AbUGPAjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 20:39:31 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:3324 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266473AbUGPAj3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 20:39:29 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [PATCH] reduce inter-node balancing frequency
Date: Thu, 15 Jul 2004 20:38:32 -0400
User-Agent: KMail/1.6.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, John Hawkes <hawkes@sgi.com>
References: <200407151829.20069.jbarnes@engr.sgi.com> <46970000.1089936880@flay>
In-Reply-To: <46970000.1089936880@flay>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407152038.32755.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 15, 2004 8:14 pm, Martin J. Bligh wrote:
> > Nick, we've had this patch floating around for awhile now and I'm
> > wondering what you think.  It's needed to boot systems with lots (e.g.
> > 256) nodes, but could probably be done another way.  Do you think we
> > should create a scheduler domain for every 64 nodes or something?
>
> I think that'd make a lot of sense ...

Yeah, though a smaller number of nodes would probably make more sense :)

> > Any other NUMA folks have thoughts about these values?
>
> Yeah, change them in arch specific code, not in the global stuff ;-)

What, you mean we're the only ones with 256 nodes?

> But seeing as they're dependant (for you) on machine size, as well as
> arch type, you probably need to do something cleverer in
> arch_init_sched_domain

Ok, I'll check that out.

> But the big bugaboo is arch-specific vs general ... we need to break
> opteron vs i386 vs ia64 out from each other ... they all need different
> coefficients.
>
> If you were going to be really fancy, we could do it in common code off
> the topology stuff ... but for now, I think it's easier to just set 'em
> per arch ...

We may have enough information to do that already... I'll look.

Thanks,
Jesse
