Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265767AbSKOEOq>; Thu, 14 Nov 2002 23:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265770AbSKOEOq>; Thu, 14 Nov 2002 23:14:46 -0500
Received: from are.twiddle.net ([64.81.246.98]:18821 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S265767AbSKOEOp>;
	Thu, 14 Nov 2002 23:14:45 -0500
Date: Thu, 14 Nov 2002 20:21:36 -0800
From: Richard Henderson <rth@twiddle.net>
To: Andi Kleen <ak@suse.de>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: in-kernel linking issues
Message-ID: <20021114202136.A22473@twiddle.net>
Mail-Followup-To: Andi Kleen <ak@suse.de>, rusty@rustcorp.com.au,
	linux-kernel@vger.kernel.org
References: <20021114143701.A30355@twiddle.net.suse.lists.linux.kernel> <p73wunfv5b0.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <p73wunfv5b0.fsf@oldwotan.suse.de>; from ak@suse.de on Fri, Nov 15, 2002 at 05:13:23AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 05:13:23AM +0100, Andi Kleen wrote:
> Richard Henderson <rth@twiddle.net> writes:
> >  (3) Alpha and MIPS64 absolutely require that the core and init allocations
> >      are "close" (within 2GB).  I don't see how this can be guaranteed with
> >      two different vmalloc calls.
> 
> In x86-64 (and I think sparc64) the modules (both data and code) also need
> to be within 2GB of the main kernel code. This is done to avoid needing
> a GOT for calls between main kernel and modules. In the old module code that
> is done with a custom module_map() function. I have not looked yet on how
> that could be implemented in the new code.

Hmm.  I guess that can be done with the two allocation hooks,
which could allocate from a special pool (as is done with the
module_map function at present).  And, as far as that goes,
could apply to Alpha and MIPS as well, if the same special
allocation is done.

Consider this point refuted, Rusty.


r~
