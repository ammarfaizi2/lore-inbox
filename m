Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965913AbWKHPUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965913AbWKHPUP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 10:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965917AbWKHPUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 10:20:15 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:8201 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S965913AbWKHPUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 10:20:13 -0500
Subject: Re: Avoid allocating during interleave from almost full nodes
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Paul Jackson <pj@sgi.com>
Cc: Christoph Lameter <clameter@sgi.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061108022136.3b9b0748.pj@sgi.com>
References: <Pine.LNX.4.64.0611031256190.15870@schroedinger.engr.sgi.com>
	 <20061103134633.a815c7b3.akpm@osdl.org>
	 <Pine.LNX.4.64.0611031353570.16486@schroedinger.engr.sgi.com>
	 <20061103143145.85a9c63f.akpm@osdl.org>
	 <20061103172605.e646352a.pj@sgi.com>
	 <20061103174206.53f2c49e.akpm@osdl.org>
	 <20061104025128.ca3c9859.pj@sgi.com>
	 <Pine.LNX.4.64.0611060854000.25351@schroedinger.engr.sgi.com>
	 <20061108022136.3b9b0748.pj@sgi.com>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 16:18:05 +0100
Message-Id: <1162999085.14238.17.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-08 at 02:21 -0800, Paul Jackson wrote:
> Christoph wrote:
> > On Sat, 4 Nov 2006, Paul Jackson wrote:
> > 
> > >   Do you know of any existing counters that we could use like this?
> > > 
> > > Adding a system wide count of pages allocated or scanned, just for
> > > these fullnode hint caches, bothers me.
> > 
> > There are already such counters. PGALLOC_* and PGSCAN_*. See 
> > include/linux/vmstat.h
> 
> 
>   Andrew,
> 
>     I'm willing to take a shot at replacing the wall clock time
>     base with one of these vm counters, in my patch in *-mm:
> 
> 	memory-page_alloc-zonelist-caching-speedup.patch
> 
>     But it will be a few weeks before I can get to it.
> 
>     I really need to do some other stuff first.

The swap token code in -mm (which I still have to review) has a global
fault counter to measure 'time'. Perhaps we can generalise that.


