Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266081AbSKOKWm>; Fri, 15 Nov 2002 05:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266091AbSKOKWc>; Fri, 15 Nov 2002 05:22:32 -0500
Received: from ns.suse.de ([213.95.15.193]:41230 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S266081AbSKOKWV>;
	Fri, 15 Nov 2002 05:22:21 -0500
Date: Fri, 15 Nov 2002 11:29:15 +0100
From: Andi Kleen <ak@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@suse.de>, Richard Henderson <rth@twiddle.net>,
       linux-kernel@vger.kernel.org, davidm@hpl.hp.com
Subject: Re: in-kernel linking issues
Message-ID: <20021115112915.B26474@wotan.suse.de>
References: <p73wunfv5b0.fsf@oldwotan.suse.de> <20021115084757.A640A2C145@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021115084757.A640A2C145@lists.samba.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2) Use a magic allocator a-la Sparc64.

That is what is currently done.

> 
> 3) Best-effort: allocate both at alloc-core time (store init ptr in
>    mod_arch_specific) and if they're too far apart, throw that away
>    and fall back to one big alloc.
> 
> 4) Implement jump stubs between the two sections.

Does not work, I need data references in the same range to.
Also frankly I would refuse to cripple my modules just to accomodate the new
code - it should be the other way around.


-Andi

