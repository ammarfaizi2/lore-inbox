Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbWGMDPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbWGMDPX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 23:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbWGMDPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 23:15:23 -0400
Received: from ns2.suse.de ([195.135.220.15]:62858 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932489AbWGMDPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 23:15:22 -0400
Date: Thu, 13 Jul 2006 05:16:14 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] let CONFIG_SECCOMP default to n
Message-ID: <20060713031614.GD9102@opteron.random>
References: <20060630014050.GI19712@stusta.de> <p73wtain80h.fsf@verdi.suse.de> <20060712210732.GA10182@elte.hu> <200607130006.12705.ak@suse.de> <20060712221910.GA12905@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060712221910.GA12905@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2006 at 12:19:11AM +0200, Ingo Molnar wrote:
> attacked ptrace, implicitly weakening the security perception of other 
> syscall filtering based projects like User Mode Linux. Now what we have 

Note that UML had a security weakness already that allowed to escape
the jail, see bugtraq. Infact his complexity is huge regardless of
ptrace, the security hole probably wasn't even ptrace related (I don't
remember the exact details).

I'm a big fun of UML and other userland virtualization project, my own
ex prof is working on a few of them. That doesn't mean I would use UML
as a jail myself for CPUShare.

In the last two years of existence of seccomp, there has never been a
single bug that could allow to escape the jail, infact there has never
been one that I know if you backtest seccomp. And this track record
will continue.

Even the kernel itself as a whole is less secure than the seccomp
jail, that doesn't mean I want to weaken the perception of anything.
It's a pure matter of probability, the higher the complexity and the
bigger is the size of the project in kernel space, the more likely
there can be bug that can lead to an exploit.
