Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136035AbRD0Nx3>; Fri, 27 Apr 2001 09:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136036AbRD0NxU>; Fri, 27 Apr 2001 09:53:20 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:22128 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S136035AbRD0NxN>; Fri, 27 Apr 2001 09:53:13 -0400
Date: Fri, 27 Apr 2001 15:52:46 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Magnus Naeslund(f)" <mag@fbab.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Alpha compile problem solved by Andrea (pte_alloc)
Message-ID: <20010427155246.O16020@athlon.random>
In-Reply-To: <052901c0ceca$e6a543c0$020a0a0a@totalmef>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <052901c0ceca$e6a543c0$020a0a0a@totalmef>; from mag@fbab.net on Fri, Apr 27, 2001 at 05:34:01AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2001 at 05:34:01AM +0200, Magnus Naeslund(f) wrote:
> Hello yesterday i installed redhat6.2 on our little alpha server over here.
> It's an Ruffian EV56 system, and a hand upgraded redhat to be able to cope
> with 2.4.
> 
> I got an compile error that told me that pte_alloc was declared wrong in
> some files..
> Then in the back of my mind i figured that Andrea does a lot of alpha work,
> so i grepped after pte_alloc in his patches.
> 
> I found:
> ftp://ftp.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.3/alpha
> -numa-2
> 
> Now my kernel compiled, and it works great. (Thanks Andrea :))
> Just a little gotcha if anyone gets this problem (now it's in the mail
> archives, where i didnt find it).
> 
> Andrea:
> Is that patch harmless, or is it experimental?

The patch is ready for production. I just submitted it two times to
Linus but no luck so far. However alternate patches are been merged in
Linus's tree recently and they fix the compile problems at least.

> Is there any other patches you recommend me to apply to my kernel?

specifically for the alpha (but of course ok for x86 kernels too) in
order against pre7:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.4pre7aa1/00_alpha-numa-6
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.4pre7aa1/00_numa-sched-5
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.4pre7aa1/00_alpha-tlb-page-sym-1
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.4pre7aa1/00_softirq-SMP-fixes-2
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.4pre7aa1/00_rwsem-10

Andrea
