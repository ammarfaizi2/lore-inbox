Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264692AbTGBIYF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 04:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264812AbTGBIYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 04:24:05 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:23948
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264692AbTGBIYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 04:24:03 -0400
Date: Wed, 2 Jul 2003 10:38:01 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Bernardo Innocenti <bernie@develer.com>
Cc: Peter Chubb <peter@chubb.wattle.id.au>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Kill div64.h dupes, parenthesize do_div() macro params
Message-ID: <20030702083801.GU3040@dualathlon.random>
References: <200307020232.20726.bernie@develer.com> <200307020852.17782.bernie@develer.com> <20030702071919.GP3040@dualathlon.random> <200307020928.38830.bernie@develer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307020928.38830.bernie@develer.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 09:28:38AM +0200, Bernardo Innocenti wrote:
> On Wednesday 02 July 2003 09:19, you wrote:
>  > On Wed, Jul 02, 2003 at 08:52:17AM +0200, Bernardo Innocenti wrote:
>  > > + *	static inline uint32_t do_div(uint64_t &n, uint32_t base)
>  >
>  > c++ ;)
> 
>  Oops! Shall I send a new patch? ;-)

I guess no ;).

> 
>  > > +# error do_div() does not yet support the C64
>  >
>  > ;)
>  >
>  > this new version looks good to me since it will fix bugs and it's not
>  > only a cleanup avoiding code duplication. thanks.
> 
>  The previous patch was not just a cleanup: it actually added parenthes
> that were missing around parameters in many do_div() variants. Guess
> what happened when shrink_slab() did this (pages = 0):
> 
>    do_div(delta, pages + 1); /* Ouch! */

I see.

Andrea
