Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932540AbWGMGWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbWGMGWE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 02:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932559AbWGMGWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 02:22:03 -0400
Received: from host36-195-149-62.serverdedicati.aruba.it ([62.149.195.36]:24045
	"EHLO mx.cpushare.com") by vger.kernel.org with ESMTP
	id S932540AbWGMGWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 02:22:02 -0400
Date: Thu, 13 Jul 2006 08:22:56 +0200
From: andrea@cpushare.com
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: Re: [patch] let CONFIG_SECCOMP default to n
Message-ID: <20060713062256.GB28310@opteron.random>
References: <20060630014050.GI19712@stusta.de> <p73wtain80h.fsf@verdi.suse.de> <20060712210732.GA10182@elte.hu> <200607130006.12705.ak@suse.de> <20060713030402.GC9102@opteron.random> <Pine.LNX.4.64.0607122010060.5623@g5.osdl.org> <20060713044053.GE9102@opteron.random> <Pine.LNX.4.64.0607122208330.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607122208330.5623@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2006 at 10:12:15PM -0700, Linus Torvalds wrote:
> You're just in denial, and don't even listen to what people say. It also 
> has nothing to do with cpufreq, which again is a case of _some_ uses may 
> be patented, but not "_the_ use"

You know "_the_ only use" possible of transmeta.o (see the function
init_transmeta) is in connection with the CMS patented software:

	/* Print CMS and CPU revision */
	max = cpuid_eax(0x80860000);

If you can see a difference between transmeta.o and seccomp.o then I
trust you but personally the only difference I can see is that with
seccomp.o it is possible that it will be used for something else
useful too.

I never cared about transmeta.o being linked into my kernels despite I
never happened to need it so far in my life and despite it's larger
than seccomp. I'm happy to spend those hundred bytes in the transmeta
code just in case I would become a transmeta user in the future.

> I just stated that if other interfaces don't have the problem that
> their only use is patent-protected, then other interfaces are
> clearly better alternatives. IF they have users at all.

Obviously you're free to change the kernel the way you want (feel free
to nuke seccomp as well if you want), but I'm also free not to switch
to ptrace if the only reason you give me is sadly non-technical. If
seccomp is better, it is better regardless if the server side is
patent-pending (not patent-protected) or not. So even trusting you
that transmeta.o is fundamentally different from seccomp.o, and it's
all fair as you imply, it still won't make a difference to me since I
only care about technical arguments for my decisions about CPUShare.
