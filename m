Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVALMoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVALMoK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 07:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVALMoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 07:44:10 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:48709 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261172AbVALMoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 07:44:02 -0500
Date: Wed, 12 Jan 2005 12:43:10 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, <clameter@sgi.com>,
       <torvalds@osdl.org>, <ak@muc.de>, <linux-mm@kvack.org>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <benh@kernel.crashing.org>
Subject: Re: page table lock patch V15 [0/7]: overview
In-Reply-To: <20050112014235.7095dcf4.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0501121217580.6133-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2005, Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> >
> > Christoph Lameter wrote:
> >  > Changes from V14->V15 of this patch:
> > 
> >  I wonder what everyone thinks about moving forward with these patches?
> 
> I was waiting for them to settle down before paying more attention.

They seem to have settled down, without advancing to anything satisfactory.
7/7 is particularly amusing at the moment (added complexity with no payoff).

> My general take is that these patches address a single workload on
> exceedingly rare and expensive machines.

Well put.  Christoph's patches stubbornly remain a _good_ hack for one
very specific initial workload (multi-parallel faulting of anon memory)
on one architecture (ia64, perhaps a few more) important to SGI.
I don't see why the mainline kernel should want them.

> If they adversely affect common
> and cheap machines via code complexity, memory footprint or via runtime
> impact then it would be pretty hard to justify their inclusion.

Aside from 7/7 (and some good asm primitives within headers),
the code itself is not complex; but it is more complex to think about,
and so less obviously correct.

> Do we have measurements of the negative and/or positive impact on smaller
> machines?

I don't think so.  But my main worry remains the detriment to other
architectures, which still remains unaddressed.

Nick's patches (I've not seen for some while) are a different case:
on the minus side, considerably more complex; on the plus side,
more general and more aware of the range of architectures.

I'll write at greater length to support these accusations later on.

Hugh

