Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266136AbUBCTXX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 14:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266129AbUBCTXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 14:23:23 -0500
Received: from mail.shareable.org ([81.29.64.88]:27342 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266051AbUBCSXs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 13:23:48 -0500
Date: Tue, 3 Feb 2004 18:23:10 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ulrich Drepper <drepper@redhat.com>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
Message-ID: <20040203182310.GA18326@mail.shareable.org>
References: <1075344395.1592.87.camel@cog.beaverton.ibm.com> <401894DA.7000609@redhat.com> <20040201012803.GN26076@dualathlon.random> <401F251C.2090300@redhat.com> <20040203085224.GA15738@mail.shareable.org> <20040203162515.GY26076@dualathlon.random> <20040203173716.GC17895@mail.shareable.org> <20040203181001.GA26076@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040203181001.GA26076@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> vsyscalls will never execute anything like execve. They can at most
> modify userspace memory a fixed address, so if the userspace isn't
> fixed, then nothing can be done with a vsyscall.

Are we talking about the same x86_64?

I see this in arch/x86_64/vsyscall.S:

__kernel_vsyscall:
.LSTART_vsyscall:
	push	%ebp
.Lpush_ebp:
	movl	%ecx, %ebp
	syscall

Is that page not mapped into userspace?

If the answer is no, then btw we were talking about i386 until you joined in. :)
The "sysenter" instruction is definitely mapped into userspace there.

-- Jamie

