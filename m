Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269461AbTGJQEh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 12:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269460AbTGJQEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 12:04:37 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:21718
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S269461AbTGJQEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 12:04:33 -0400
Date: Thu, 10 Jul 2003 18:18:59 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Bernardo Innocenti <bernie@develer.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Peter Chubb <peter@chubb.wattle.id.au>, Andrew Morton <akpm@digeo.com>,
       Ian Molton <spyro@f2s.com>
Subject: Re: [PATCH] Fix do_div() for all architectures
Message-ID: <20030710161859.GP16313@dualathlon.random>
References: <200307060133.15312.bernie@develer.com> <200307070626.08215.bernie@develer.com> <200307082027.26233.bernie@develer.com> <20030710154019.GA18697@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030710154019.GA18697@twiddle.net>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 08:40:19AM -0700, Richard Henderson wrote:
> On Tue, Jul 08, 2003 at 08:27:26PM +0200, Bernardo Innocenti wrote:
> > +extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor)
> > __attribute_pure__;
> ...
> > +		__rem = __div64_32(&(n), __base);	\
> 
> The pure declaration is very incorrect.  You're writing to N.

now pure sounds more reasonable, I wondered how could gcc keep track of
the stuff pointed by the parameters (especially if this stuff points to
other stuff etc.. ;). So only the pointer passed as parameter can
change, not the memory pointed by the pointer as in this case.

Andrea
