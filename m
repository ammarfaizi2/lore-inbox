Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317576AbSFRT3w>; Tue, 18 Jun 2002 15:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317578AbSFRT3v>; Tue, 18 Jun 2002 15:29:51 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:41977 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317576AbSFRT3r>; Tue, 18 Jun 2002 15:29:47 -0400
Date: Tue, 18 Jun 2002 15:29:49 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken
Message-ID: <20020618152949.B16091@redhat.com>
References: <1024422409.1476.208.camel@sinai> <E17KO4i-0002xn-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17KO4i-0002xn-00@wagner.rustcorp.com.au>; from rusty@rustcorp.com.au on Wed, Jun 19, 2002 at 04:51:31AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2002 at 04:51:31AM +1000, Rusty Russell wrote:
> You could do a loop here, but the real problem is the broken userspace
> interface.  Can you fix this so it takes a single CPU number please?
> 
> ie.
> 	/* -1 = remove affinity */
> 	sys_sched_setaffinity(pid_t pid, int cpu);
> 
> This will work everywhere, and doesn't require userspace to know the
> size of the cpu bitmask etc.

That doesn't work.  Think of SMT CPU pairs (aka HyperThreading) or 
quads that share caches.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
