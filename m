Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWBFHvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWBFHvK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 02:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWBFHvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 02:51:10 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:139 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750705AbWBFHvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 02:51:09 -0500
Date: Mon, 6 Feb 2006 09:51:07 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Paul Jackson <pj@sgi.com>
cc: Andrew Morton <akpm@osdl.org>, clameter@engr.sgi.com, steiner@sgi.com,
       dgc@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: [PATCH 2/5] cpuset memory spread page cache implementation and
 hooks
In-Reply-To: <Pine.LNX.4.58.0602060937160.21215@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.58.0602060948560.21447@sbz-30.cs.Helsinki.FI>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
 <20060204071915.10021.89936.sendpatchset@jackhammer.engr.sgi.com>
 <20060204154953.35a0f63f.akpm@osdl.org> <20060204174252.9390ddc6.pj@sgi.com>
 <20060204175411.19ff4ffb.akpm@osdl.org> <Pine.LNX.4.62.0602041928140.8874@schroedinger.engr.sgi.com>
 <20060204210653.7bb355a2.akpm@osdl.org> <20060204220800.049521df.pj@sgi.com>
 <20060204221524.1607401e.akpm@osdl.org> <20060205215152.27800776.pj@sgi.com>
 <Pine.LNX.4.58.0602060912100.20153@sbz-30.cs.Helsinki.FI>
 <Pine.LNX.4.58.0602060937160.21215@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2006, Pekka J Enberg wrote:
> Actually, the above patch isn't probably any good as it moves 
> cache_alloc_cpucache() out-of-line which should be the common case for 
> NUMA too (it's hurting kmem_cache_alloc and kmalloc). The following should 
> be better.

Hmm. Strike that. It's wrong as it no longer respects mempolicy.

		Pekka
