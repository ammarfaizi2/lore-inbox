Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbVAOTVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbVAOTVx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 14:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262309AbVAOTVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 14:21:44 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:63142 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262338AbVAOTTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 14:19:53 -0500
Date: Sat, 15 Jan 2005 19:19:52 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Avoiding fragmentation through different allocator
In-Reply-To: <20050115013106.GC3474@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0501151918440.17278@skynet>
References: <Pine.LNX.4.58.0501122101420.13738@skynet> <20050113073146.GB1226@holomorphy.com>
 <20050114214218.GB3336@logos.cnet> <20050115013106.GC3474@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2005, William Lee Irwin III wrote:

> On Wed, Jan 12, 2005 at 11:31:46PM -0800, William Lee Irwin III wrote:
> >> I'd expect to do better with kernel/user discrimination only, having
> >> address-ordering biases in opposite directions for each case.
>
> On Fri, Jan 14, 2005 at 07:42:18PM -0200, Marcelo Tosatti wrote:
> > What you mean with "address-ordering biases in opposite directions
> > for each case" ?
> > You mean to have each case allocate from the top and bottom of the
> > free list, respectively, and in opposite address direction ? What you
> > gain from that?
> > And what that means during a long period of VM stress ?
>
> It's one of the standard anti-fragmentation tactics. The large free
> areas come from the middle, address ordering disposes of holes in the
> used areas, and the areas at opposite ends reflect expected lifetimes.
>
> It's more useful for cases where there is not an upper bound on the
> size of an allocation (or power-of-two blocksizes). On second thought,
> Mel's approach exploits both the bound and the power-of-two restriction
> advantageously.
>

I think so too and I reckon I have the figures to prove it. Patches with
test tools and figures are on the way. Working at the moment at running
the last of the tests and getting the patches in order.

-- 
Mel Gorman
