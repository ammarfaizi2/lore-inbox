Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277068AbRJHSga>; Mon, 8 Oct 2001 14:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277082AbRJHSgW>; Mon, 8 Oct 2001 14:36:22 -0400
Received: from zok.SGI.COM ([204.94.215.101]:30090 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S277068AbRJHSgF>;
	Mon, 8 Oct 2001 14:36:05 -0400
Date: Mon, 8 Oct 2001 11:35:22 -0700
From: Jesse Barnes <jbarnes@sgi.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Whining about NUMA. :)  [Was whining about 2.5...]
In-Reply-To: <1812679136.1002540059@mbligh.des.sequent.com>
Message-ID: <Pine.SGI.4.21.0110081128560.1003752-100000@spamtin.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2001, Martin J. Bligh wrote:

> The worst possible case I can conceive (in the future architectures 
> that I know of)  is 4 different levels. I don't think the number of access
> speed levels is ever related to the number of processors ?
> (users of other NUMA architectures feel free to slap me at this point).

So you're saying that at most any given node is 4 hops away from any
other for your arch?
 
> So I *think* the worst possible case is still linear (to number of nodes) 
> in terms of how many classzone type things we'd need? And the number 
> of classzone type things any given access would have to search through 
> for an access is constant? The number of zones searched would be
> (worst case) linear to number of nodes?

That's how we have our stuff coded at the moment, but with classzones you
might be able to get that down even further.  For instance, you could have
classzones that correspond to the number of hops a set of nodes is from a
given node.  Having such classzones might make finding nearby memory
easier.

Jesse

