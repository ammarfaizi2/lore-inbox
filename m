Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264582AbTIDDFm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 23:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264552AbTIDDFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 23:05:42 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:21956 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S264512AbTIDDFa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 23:05:30 -0400
From: David Lang <david.lang@digitalinsight.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Larry McVoy <lm@work.bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Brown, Len" <len.brown@intel.com>, Giuliano Pochini <pochini@shiny.it>,
       Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Wed, 3 Sep 2003 20:02:27 -0700 (PDT)
Subject: Re: SSI clusters on NUMA (was Re: Scaling noise)
In-Reply-To: <7710000.1062642829@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0309031957500.17581-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003, Martin J. Bligh wrote:

> > how much of this need could be met with a native linux master and kernels
> > running user-mode kernels? (your resource sharing would obviously not be
> > that clean, but you could develop the tools to work across the kernel
> > images this way)
>
> I talked to Jeff and Andrea about this at KS & OLS this year ... the feeling
> was that UML was too much overhead, but there were various ways to reduce
> that, especially if the underlying OS had UML support (doesn't require it
> right now).
>
> I'd really like to see the performance proved to be better before basing
> a design on UML, though that was my first instinct of how to do it ...

I agree that UML won't be able to show the performance advantages (the
fact that the UML kernel can't control the cache footprint on the CPU's
becouse it gets swapped from one to another at the host OS's convienience
is just one issue here)

however with UML you should be able to develop the tools and features to
start to weld the two different kernels into a single logical image. once
people have a handle on how these tools work you can then try them on some
hardware that has a lower level partitioning setup (i.e. the IBM
mainframes) and do real speed comparisons between one kernel that's given
X CPU's and Y memory and two kernels that are each given X/2 CPU's and Y/2
memory.

the fact that common hardware doesn't nicly support the partitioning
shouldn't stop people from solving the other problems.

David Lang
