Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131382AbRCUMzO>; Wed, 21 Mar 2001 07:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131392AbRCUMzF>; Wed, 21 Mar 2001 07:55:05 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:26351 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131382AbRCUMyv>;
	Wed, 21 Mar 2001 07:54:51 -0500
Date: Wed, 21 Mar 2001 07:54:08 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Ingo Molnar <mingo@elte.hu>
cc: Anton Blanchard <anton@linuxcare.com.au>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] pagecache SMP-scalability patch [was: spinlock usage]
In-Reply-To: <Pine.LNX.4.30.0103211301530.5270-100000@elte.hu>
Message-ID: <Pine.GSO.4.21.0103210751521.739-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Mar 2001, Ingo Molnar wrote:

> 
> Anton,
> 
> if you are doing SMP-intensive dbench runs, then check out the SMP
> pagecache-scalability patch (against 2.4.2-ac20):
> 
>   http://people.redhat.com/~mingo/smp-pagecache-patches/pagecache-2.4.2-H1
> 
> this patch splits up the main scalability offender in non-RAM-limited
> dbench runs, which is pagecache_lock. The patch was designed and written
> by David Miller, and is being forward ported / maintained by me. (The new
> pagecache lock design is similar to TCP's hashed spinlocks, which proved
> to scale excellently.)
> 
> (about lstat(): IMO lstat() should not call into the lowlevel FS code.)

a) revalidation on network filesystems
b) just about anything layered would win from ability to replace the
normal stat() behaviour (think of UI/GID replacement, etc.)
							Cheers,
								Al

