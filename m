Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267359AbTA1Q2G>; Tue, 28 Jan 2003 11:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267361AbTA1Q2G>; Tue, 28 Jan 2003 11:28:06 -0500
Received: from ns.suse.de ([213.95.15.193]:39186 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267359AbTA1Q2F>;
	Tue, 28 Jan 2003 11:28:05 -0500
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: jasonp@boo.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] page coloring for 2.5.59 kernel, version 1
References: <3.0.6.32.20030127224726.00806c20@boo.net.suse.lists.linux.kernel> <884740000.1043737132@titus.suse.lists.linux.kernel> <20030128071313.GH780@holomorphy.com.suse.lists.linux.kernel> <1466000000.1043770007@titus.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 28 Jan 2003 17:37:25 +0100
In-Reply-To: "Martin J. Bligh"'s message of "28 Jan 2003 17:09:52 +0100"
Message-ID: <p73k7gpz0vu.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:

> > I think this one really needs to be done with the userspace cache
> > thrashing microbenchmarks. 
> 
> If a benefit cannot be show on some sort of semi-realistic workload,
> it's probably not worth it, IMHO.

The main advantage of cache coloring normally is that benchmarks 
should get stable results. Without it a benchmark result can vary based on 
random memory allocation patterns.

Just having stable benchmarks may be worth it.

I suspect the benefit will vary a lot based on the CPU. Your caches may
have good enough associativity. On other CPUs it may make much more difference.

-Andi
