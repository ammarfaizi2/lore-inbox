Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965368AbWKHKVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965368AbWKHKVp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 05:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965472AbWKHKVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 05:21:44 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:23459 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965368AbWKHKVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 05:21:42 -0500
Date: Wed, 8 Nov 2006 02:21:36 -0800
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Avoid allocating during interleave from almost full nodes
Message-Id: <20061108022136.3b9b0748.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0611060854000.25351@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0611031256190.15870@schroedinger.engr.sgi.com>
	<20061103134633.a815c7b3.akpm@osdl.org>
	<Pine.LNX.4.64.0611031353570.16486@schroedinger.engr.sgi.com>
	<20061103143145.85a9c63f.akpm@osdl.org>
	<20061103172605.e646352a.pj@sgi.com>
	<20061103174206.53f2c49e.akpm@osdl.org>
	<20061104025128.ca3c9859.pj@sgi.com>
	<Pine.LNX.4.64.0611060854000.25351@schroedinger.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph wrote:
> On Sat, 4 Nov 2006, Paul Jackson wrote:
> 
> >   Do you know of any existing counters that we could use like this?
> > 
> > Adding a system wide count of pages allocated or scanned, just for
> > these fullnode hint caches, bothers me.
> 
> There are already such counters. PGALLOC_* and PGSCAN_*. See 
> include/linux/vmstat.h


  Andrew,

    I'm willing to take a shot at replacing the wall clock time
    base with one of these vm counters, in my patch in *-mm:

	memory-page_alloc-zonelist-caching-speedup.patch

    But it will be a few weeks before I can get to it.

    I really need to do some other stuff first.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
