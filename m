Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932541AbVKWVeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbVKWVeH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 16:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbVKWVeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 16:34:06 -0500
Received: from fmr22.intel.com ([143.183.121.14]:38825 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932541AbVKWVeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 16:34:04 -0500
Subject: Re: [PATCH]: Free pages from local pcp lists under tight memory
	conditions
From: Rohit Seth <rohit.seth@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: clameter@engr.sgi.com, torvalds@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051123132647.257710b9.akpm@osdl.org>
References: <20051122161000.A22430@unix-os.sc.intel.com>
	 <Pine.LNX.4.62.0511231128090.22710@schroedinger.engr.sgi.com>
	 <1132775194.25086.54.camel@akash.sc.intel.com>
	 <20051123115545.69087adf.akpm@osdl.org>
	 <1132779605.25086.69.camel@akash.sc.intel.com>
	 <20051123132647.257710b9.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel 
Date: Wed, 23 Nov 2005 13:40:48 -0800
Message-Id: <1132782048.25086.76.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Nov 2005 21:33:50.0172 (UTC) FILETIME=[97FD31C0:01C5F075]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-23 at 13:26 -0800, Andrew Morton wrote:
> Rohit Seth <rohit.seth@intel.com> wrote:
> >
> > > I don't think Martin was able to demonstrate much benefit from the lock
> > > contention reduction on 16-way NUMAQ either.
> > > 
> > > So I dithered for months and it was a marginal merge, so it's appropriate
> > > to justify the continued presence of the code.
> > > 
> > 
> > May be the limits on the number of pages hanging on the per_cpu_pagelist
> > was (or even now is) too small (for them to give any meaningful gain).
> > May be we should have more physical contiguity in each of these pcps to
> > give better cache spread.  
> 
> Could be.  The initial settings were pretty arbitrary - I assumed that
> someone would get in and tune them up, but nothing much happened.  Perhaps
> we should expose the thresholds in /proc/sys/vm so they're easier to play
> with.

Most certainly.  If I had a patch ready...I would have given you one
right away :-)  Though I will work on it...

It surely is unfortunate that we have not digged deeper into this area
(in terms of optimizations)....  

-rohit

