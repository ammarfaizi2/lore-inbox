Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbVIZSKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbVIZSKr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 14:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbVIZSKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 14:10:47 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:41964 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932453AbVIZSKq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 14:10:46 -0400
Subject: Re: vmalloc_node
From: Dave Hansen <haveblue@us.ibm.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Eric Dumazet <dada1@cosmosbay.com>, Harald Welte <laforge@netfilter.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@davemloft.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0509261046410.3650@schroedinger.engr.sgi.com>
References: <43308324.70403@cosmosbay.com> <200509221454.22923.ak@suse.de>
	 <20050922125849.GA27413@infradead.org> <200509221505.05395.ak@suse.de>
	 <Pine.LNX.4.62.0509220835310.16793@schroedinger.engr.sgi.com>
	 <4332D2D9.7090802@cosmosbay.com>
	 <20050923171120.GO731@sunbeam.de.gnumonks.org>
	 <Pine.LNX.4.62.0509231043270.22308@schroedinger.engr.sgi.com>
	 <1127498679.10664.85.camel@localhost>
	 <Pine.LNX.4.62.0509261046410.3650@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Mon, 26 Sep 2005 11:10:13 -0700
Message-Id: <1127758214.26894.20.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-26 at 10:58 -0700, Christoph Lameter wrote:
> On Fri, 23 Sep 2005, Dave Hansen wrote:
> > Instead of hard-coding all of those -1's for the node to specify a
> > default allocation, and changing all of those callers, why not:
> 
> Done.

That looks much nicer.  Thanks!

> > 	__vmalloc_node(size, gfp_mask, prot, -1);
> > A named macro is probably better than -1, but if it is only used in one
> > place, it is hard to complain.
> 
> -1 is used consistently in the *_node functions to indicate that the node 
> is not specified. Should I replace -1 throughout the kernel with a 
> constant?

I certainly wouldn't mind.  Giving it a name like NODE_ANY or
NODE_UNSPECIFIED would certainly keep anyone from having to go dig into
the allocator functions to decide what it actually does.  

-- Dave

