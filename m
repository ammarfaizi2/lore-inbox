Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWBFAUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWBFAUo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 19:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWBFAUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 19:20:44 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:23459 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750810AbWBFAUn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 19:20:43 -0500
Date: Sun, 5 Feb 2006 16:20:20 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: clameter@engr.sgi.com, steiner@sgi.com, dgc@sgi.com, Simon.Derr@bull.net,
       ak@suse.de, linux-kernel@vger.kernel.org,
       Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH 2/5] cpuset memory spread page cache implementation and
 hooks
Message-Id: <20060205162020.d3f9f722.pj@sgi.com>
In-Reply-To: <20060204221524.1607401e.akpm@osdl.org>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
	<20060204071915.10021.89936.sendpatchset@jackhammer.engr.sgi.com>
	<20060204154953.35a0f63f.akpm@osdl.org>
	<20060204174252.9390ddc6.pj@sgi.com>
	<20060204175411.19ff4ffb.akpm@osdl.org>
	<Pine.LNX.4.62.0602041928140.8874@schroedinger.engr.sgi.com>
	<20060204210653.7bb355a2.akpm@osdl.org>
	<20060204220800.049521df.pj@sgi.com>
	<20060204221524.1607401e.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> Please also have a think about __cache_alloc(), see if we can
> improve it further - that's a real hotspot.

I won't be able to get at __cache_alloc() at least until Pekka Enberg
layers his "slab: consolidate allocation paths" patches on top of this
cpuset memory spread patchset.  Indeed, it might be Pekka who does more
for __cache_alloc() than me ... that has yet to play out.

The entangled, ifdef'd piece of code in mm/slab.c is more convoluted
than I can get my head around on this attempt, except for narrowly
focused changes.  Perhaps Pekka's work and another week will be enough.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
