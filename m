Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263250AbTDVRMO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 13:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263263AbTDVRMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 13:12:14 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:61780 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263250AbTDVRMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 13:12:13 -0400
Date: Tue, 22 Apr 2003 13:24:00 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
       <mingo@elte.hu>, <hugh@veritas.com>, <dmccr@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: Re: objrmap and vmtruncate
In-Reply-To: <182180000.1051028196@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0304221308530.24424-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 Apr 2003, Martin J. Bligh wrote:

> If that was the only tradeoff, I'd be happy to make it too. But it's not
> 0.4% / 1.2% under any kind of heavy sharing (eg shared libs), it can be
> something like 25% vs 75% ... the difference between the system living
> or dying. If we had shared pagetables, and shlibs aligned on 2Mb
> boundaries so they could be used, I'd be much less stressed about it, I
> guess.

sorry, but this is just games with numbers. _Sure_, you can find workload
as a demonstration against _any_ resource increase, by allocating that
resource enough times so that lots of stuff is allocated. "Look, we
increased the kernel stack size from 4K to 8K, and now this makes this
[add random heavily threaded workload] thing go from 40% RAM utilization
to 60% RAM utilization"

fact is that 'typical' pagetable usage is in the <1% range on typical
systems. Sure, you can increase it - like you can increase RAM allocation
for just about any resource if you want. The answer: if you want to do
that then add more RAM or dont do it.

so the real question is whether the size increase justifies the
advantages. It's a border case i agree.

	Ingo

