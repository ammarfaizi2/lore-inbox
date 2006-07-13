Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWGML1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWGML1D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 07:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbWGML1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 07:27:02 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:6050 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932491AbWGML1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 07:27:00 -0400
Date: Thu, 13 Jul 2006 07:23:52 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] let CONFIG_SECCOMP default to n
Message-ID: <20060713112352.GA3384@ccure.user-mode-linux.org>
References: <20060630014050.GI19712@stusta.de> <p73wtain80h.fsf@verdi.suse.de> <20060712210732.GA10182@elte.hu> <200607130006.12705.ak@suse.de> <20060712221910.GA12905@elte.hu> <20060713031614.GD9102@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713031614.GD9102@opteron.random>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2006 at 05:16:14AM +0200, Andrea Arcangeli wrote:
> On Thu, Jul 13, 2006 at 12:19:11AM +0200, Ingo Molnar wrote:
> > attacked ptrace, implicitly weakening the security perception of other 
> > syscall filtering based projects like User Mode Linux. Now what we have 
> 
> Note that UML had a security weakness already that allowed to escape
> the jail, see bugtraq. Infact his complexity is huge regardless of
> ptrace, the security hole probably wasn't even ptrace related (I don't
> remember the exact details).

Not hardly.  If you did remember the exact details, you'd remember
that it was in 2000, and someone "discovered" that tt mode didn't
allow kernel memory to be protected from userspace.  It had always
been well documented that tt mode had this problem and you shouldn't
be using it if you needed a secure VM.

See http://www.securityfocus.com/bid/3973/info

Now, there were a couple of ways to legitimately escape from UML, and
they *did* involve ptrace.  Things like single-stepping a system call
instruction or putting a breakpoint on a system call instruction and
single-stepping from the breakpoint.  As far as I know, these were
discovered and fixed by UML developers before there was any outside
awareness of these bugs.

				Jeff
