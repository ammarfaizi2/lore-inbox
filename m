Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316080AbSE3BdW>; Wed, 29 May 2002 21:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316089AbSE3BdU>; Wed, 29 May 2002 21:33:20 -0400
Received: from holomorphy.com ([66.224.33.161]:35732 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316080AbSE3BdE>;
	Wed, 29 May 2002 21:33:04 -0400
Date: Wed, 29 May 2002 18:32:00 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre9aa1
Message-ID: <20020530013200.GB14918@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20020530010125.GA1383@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2002 at 03:01:25AM +0200, Andrea Arcangeli wrote:
> NOTE: this release is highly experimental, while it worked solid so far
> it's not well tested yet, so please don't use in production
> environments! (yet :)
> The o1 scheduler integration will take a few weeks to settle and to
> compile on all archs. I would suggest the big-iron folks to give this
> kernel a spin, in particular for o1, shm-rmid fix, p4/pmd fix,
> inode-leak fix. The only rejected feature is been the node-affine
> allocations of per-cpu data structures in the numa-sched (matters only
> for numa, but o1 is more sensible optimization for numa anyways).
> Currently only x86 and alpha compiles and runs as expected. x86-64,
> ia64, ppc, s390*, sparc64 doesn't compile yet. uml worst of all compiles
> but it doesn't run correctly :), however it runs pretty well too, simply
> it hangs sometime and you've to press a key in the terminal and then it
> resumes as if nothing has happened.

I noticed what looked like missed wakeups in tty code in early 2.4.x
ports of the O(1) scheduler, though I saw a somewhat different failure
mode, that is, the terminal echo would remain one character behind
forever (and if it happened again, more than one). I never got a real
answer to this, unfortunately, as it appeared to go away after a certain
revision of the scheduler. The failure mode you describe is slightly
different, but perhaps related.

And thanks for looking into shm, I understand that area is a bit
painful to work around, but fixes are certainly needed there.


Cheers,
Bill
