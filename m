Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317282AbSFLAvl>; Tue, 11 Jun 2002 20:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317283AbSFLAvk>; Tue, 11 Jun 2002 20:51:40 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:40082 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S317282AbSFLAvk>; Tue, 11 Jun 2002 20:51:40 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        k-suganuma@mvj.biglobe.ne.jp
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support 
In-Reply-To: Your message of "Tue, 11 Jun 2002 02:27:25 MST."
             <3D05C27D.186DC066@zip.com.au> 
Date: Wed, 12 Jun 2002 10:53:20 +1000
Message-Id: <E17HwO1-0002OW-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3D05C27D.186DC066@zip.com.au> you write:
> Rusty Russell wrote:
> > 
> > ...
> > Let's not perpetuate the myth that everything in the kernel needs to
> > be tuned to the last cycle at all costs, hm?
> 
> I was more concerned about the RAM use, actually.
> 
> This patch is an additional reason for CONFIG_NR_CPUS, but I've rather
> gone cold on that idea because the "proper fix" is to make all those
> huge per-cpu arrays dynamically allocated.   So you can run a 64p kernel
> on 2p without losing hundreds of k of memory and kernel address space.
> 
> But it looks like all those dynamically-allocated structures would
> have to be allocated out to NR_CPUS anyway, to support hotplug, yes?
> 
> In which case, CONFIG_NR_CPUS is the only way to get the memory
> back...

Precisely.  Previously, the assumption was that if you're SMP, memory
is cheap.  To be frank, it's still true, but I don't want to
discourage any sign of a "small is beautiful" mindset 8)

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
