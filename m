Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265543AbUFONwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265543AbUFONwJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 09:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265544AbUFONwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 09:52:09 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:42074 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265543AbUFONwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 09:52:04 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andi Kleen <ak@muc.de>
Subject: Re: NUMA API observations
Date: Tue, 15 Jun 2004 09:50:41 -0400
User-Agent: KMail/1.6.2
Cc: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
       lse-tech@projects.sourceforge.net
References: <20040614153638.GB25389@krispykreme> <20040614214003.GE25389@krispykreme> <20040614234958.GC90963@colin2.muc.de>
In-Reply-To: <20040614234958.GC90963@colin2.muc.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406150950.41129.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > My kernel is compiled with NR_CPUS=128, the setaffinity syscall must
> > > > be called with a bitmap at least as big as the kernels cpumask_t. I
> > > > will submit a patch for this shortly.
> > >
> > > Umm, what a misfeature. We size the buffer up to the biggest
> > > running CPU. That should be enough.
> > >
> > > IMHO that's just a kernel bug. How should a user space
> > > application sanely discover the cpumask_t size needed by the kernel?
> > > Whoever designed that was on crack.
> >
> > glibc now uses a select style interface. Unfortunately the interface has
> > changed about three times by now.
>
> I have no plans to track the glibc interface of the week for this
> and numactl must run with older glibc anyways, that is why I always
> used an own stub to this. I am not sure they even solved the problem
> completely. With the upcomming numactl version it should work.
>
> What I wonder is why IA64 worked though. We tested on it previously,
> but somehow didn't run into this. The regression test suite
> needs to check this better.

Yeah, I tested it with a kernel compiled for 512p, and didn't have any 
problems.  But that was awhile ago--I may have fixed the code and lost the 
diff when I sent you the other patches...

Jesse
