Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265463AbUBCLdV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 06:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265980AbUBCLdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 06:33:21 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:6543
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265463AbUBCLdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 06:33:20 -0500
Date: Tue, 3 Feb 2004 06:34:49 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ulrich Drepper <drepper@redhat.com>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
Message-ID: <20040203053449.GW26076@dualathlon.random>
References: <1075344395.1592.87.camel@cog.beaverton.ibm.com> <401894DA.7000609@redhat.com> <20040201012803.GN26076@dualathlon.random> <401F251C.2090300@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401F251C.2090300@redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 02, 2004 at 08:35:40PM -0800, Ulrich Drepper wrote:
> Andrea Arcangeli wrote:
> > I definitely call it a great success,
> 
> You got to be kidding.  Some object fixed in the address space which can
> perform system calls.  Nothing is more welcome to somebody trying to
> exploit some bugs.
> 
> The vdso must be randomized.  This is completely impossible with this
> stupid fixed address scheme and it must be changed as soon as possible.

sorry, no idea what you're talking about. I can't see any valid single
reason to randomize the addresses. (the only effect is that it will hurt
performance)

Whatever problem you found, feel free to post an exploit so I will
certainly be able to understand your problem, if you can't to me it
means there's no problem.

the closer thing that your statements reminds me, is the discussion
about the reentrancy of the gettimeofday, basically to allow
virtualization, if that's what you meant that can be addressed just fine
with a modification to the ptes with a syscall, no valid reason to
slowdown the production fast path with an inefficient API just for the
re-virtualization of the vsyscalls.
