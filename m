Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266736AbSLDACx>; Tue, 3 Dec 2002 19:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266746AbSLDACx>; Tue, 3 Dec 2002 19:02:53 -0500
Received: from cda1.e-mind.com ([195.223.140.107]:13184 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S266736AbSLDACw>;
	Tue, 3 Dec 2002 19:02:52 -0500
Date: Wed, 4 Dec 2002 01:09:56 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@digeo.com>, Christoph Hellwig <hch@sgi.com>,
       rml@tech9.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set_cpus_allowed() for 2.4
Message-ID: <20021204000956.GH11730@dualathlon.random>
References: <20021202192652.A25938@sgi.com> <1919608311.1038822649@[10.10.2.3]> <3DEBB4BD.F64B6ADC@digeo.com> <20021202195003.GC28164@dualathlon.random> <3DED18CC.5770EA90@digeo.com> <124510000.1038949781@titus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <124510000.1038949781@titus>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2002 at 01:09:42PM -0800, Martin J. Bligh wrote:
> >>please try with my tree.
> >
> >It is greatly improved.  It is still not as smooth as the standard 2.4
> >scheduler, but I'd characterise it as "a bit jerky" rather than "makes
> >me want to punch a hole in the monitor".
> >
> >The difference is unlikely to be noticed by many.  (But it should be
> >_better_ than stock 2.4)
> 
> ...
> 
> >>can you reproduce with my tree?
> >
> >Again, hugely improved over normal O(1) behaviour, but not as responsive
> >as the stock 2.4 scheduler.
> 
> Andrea, which patches in your tree are the ones that fix this?
> If it's the big-monster one ... any chance you could split out
> the bits actually fix it? I'd love to be able to apply your fixes
> to 2.5 and try them there ....

it's all in these patches:

andrea@dualathlon:~/remote/kernel.org/kernels/v2.4/2.4.20aa1> ls -1 *sched*
00_flush-inode-reschedule-2
00_sched-O1-aa-2.4.19rc3-5.gz
10_sched-o1-bluetooth-1
10_sched-o1-hyperthreading-3
20_apm-o1-sched-1
20_sched-o1-fixes-8
71_xfs-sched-1

I'm fixing the RT case too right now, in a few days a further fix will
be available to avoid deadlocks of some app with RT enabled.

Andrea
