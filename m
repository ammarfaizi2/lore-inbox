Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbWIHUTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWIHUTp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 16:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWIHUTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 16:19:45 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:20119 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751184AbWIHUTo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 16:19:44 -0400
Date: Fri, 8 Sep 2006 13:19:28 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, npiggin@suse.de,
       mingo@elte.hu
Subject: Re: [PATCH] Fix longstanding load balancing bug in the scheduler.
In-Reply-To: <20060908130028.A9446@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0609081316580.24016@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0609061634240.13322@schroedinger.engr.sgi.com>
 <20060908103529.A9121@unix-os.sc.intel.com>
 <Pine.LNX.4.64.0609081135590.23089@schroedinger.engr.sgi.com>
 <20060908130028.A9446@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sep 2006, Siddha, Suresh B wrote:

> On Fri, Sep 08, 2006 at 11:40:51AM -0700, Christoph Lameter wrote:
> > The balancing operation is not that frequent and having to treat a special 
> > case in the callers would make code more complicated and likely offset the
> > gains in this function.
> 
> This solution as such is not accurate and clean :) and my suggestion is
> not making it any more ugly.
> 
> With increase in NR_CPUS, cost of cpumask operations will increase and 
> we shouldn't penalize the other logical threads or cores sharing the caches by
> bringing in unnecessary cache lines.

One cacheline sized 128bytes will support all 1024 cpus that IA64 allows. 
cacheline align the cpumask?

