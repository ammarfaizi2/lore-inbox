Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVBFNqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVBFNqs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 08:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbVBFNqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 08:46:48 -0500
Received: from ns.suse.de ([195.135.220.2]:50618 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261229AbVBFNql (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 08:46:41 -0500
Date: Sun, 6 Feb 2005 14:46:40 +0100
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, drepper@redhat.com
Subject: Re: [PROPOSAL/PATCH] Remove PT_GNU_STACK support before 2.6.11
Message-ID: <20050206134640.GB30476@wotan.suse.de>
References: <20050206113635.GA30109@wotan.suse.de> <20050206114758.GA8437@infradead.org> <20050206120244.GA28061@elte.hu> <20050206124523.GA762@elte.hu> <20050206125002.GF30109@wotan.suse.de> <1107694800.22680.90.camel@laptopd505.fenrus.org> <20050206130152.GH30109@wotan.suse.de> <20050206130650.GA32015@infradead.org> <20050206131130.GJ30109@wotan.suse.de> <20050206133239.GA4483@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206133239.GA4483@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> fortunately there's this 'NX-emulation' thing called exec-shield which
> is part of Fedora (and has been part of it for almost 2 years) and did
> all the testing for you on all x86 hardware, on thousands of packages
> and on over a ten thousand binaries, well in advance of this going
> upstream. It wasnt a bump-free ride, but it was worth it.

But apparently a completely different patch was tested
with quite different semantics. 

> 
> (the Mono bug was found this way, the Grub one wasnt, due to it being

But not fixed in mainline mono.

And also as far as I can figure out there was no effort 
to warn user land people about this intrusive change,
and tell them what they need to do when they recompile.

> RWE. But if it triggers it shows up immediately so it's not like you
> have no sign that something wrong is going on. Only grub-install
> triggers it and no boot/install kernel i know of defaults to
> PAE-enabled, that's what caused grub-install being used in an NX
> scenario so infrequently.)
> 
> anyway, this particular flamewar might have made more sense last Summer.

Last summer nobody did change the 32bit ABI on x86-64.

I only started it because the bug reports are appearing now 
and it's clear now that we have a problem. 

-Andi
