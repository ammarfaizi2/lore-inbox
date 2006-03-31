Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWCaGwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWCaGwD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 01:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWCaGwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 01:52:03 -0500
Received: from ns1.siteground.net ([207.218.208.2]:25237 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751160AbWCaGwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 01:52:01 -0500
Date: Thu, 30 Mar 2006 22:52:50 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, clameter@engr.sgi.com, shai@scalex86.org,
       alok.kataria@calsoftinc.com, penberg@cs.Helsinki.FI
Subject: Re: [patch] slab: add statistics for alien cache overflows
Message-ID: <20060331065250.GC4334@localhost.localdomain>
References: <20060331055648.GB4334@localhost.localdomain> <20060330220135.767663d7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330220135.767663d7.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 10:01:35PM -0800, Andrew Morton wrote:
> Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> >
> > Add a statistics counter which is incremented everytime the alien
> >  cache overflows.  alien_cache limit is hardcoded to 12 right now.
> >  We can use this statistics to tune alien cache if needed in the future.
> 
> Does it break slabtop, and whatever else reads /proc/slabinfo?

These stats get compiled in only with DEBUG_SLAB.  Even with DEBUG_SLAB
compiled in, slabtop does not break.  I guess slabtop is not wired to read
these extra stats.  Is there anything else that reads slabinfo apart from
slabtop?  I could find only slabtop to be relevant with the procps package.

Thanks,
Kiran

