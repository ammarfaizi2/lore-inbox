Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262818AbSI3STR>; Mon, 30 Sep 2002 14:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262819AbSI3STR>; Mon, 30 Sep 2002 14:19:17 -0400
Received: from packet.digeo.com ([12.110.80.53]:52413 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262818AbSI3STQ>;
	Mon, 30 Sep 2002 14:19:16 -0400
Message-ID: <3D9896F6.8E584DC5@digeo.com>
Date: Mon, 30 Sep 2002 11:24:54 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>,
       Anton Blanchard <anton@samba.org>
Subject: Re: 2.5.39-mm1
References: <3D9804E1.76C9D4AE@digeo.com> <766838976.1033378149@[10.10.2.3]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Sep 2002 18:24:35.0658 (UTC) FILETIME=[A11F5AA0:01C268AE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" wrote:
> 
> Which looks about the same to me? Me slightly confused.

I expect that with the node-local allocations you're not getting
a lot of benefit from the lock amortisation.  Anton will.

It's the lack of improvement of cache-niceness which is irksome.
Perhaps the heuristic should be based on recency-of-allocation and
not recency-of-freeing.  I'll play with that.

> Will try
> adding the original hot/cold stuff onto 39-mm1 if you like?

Well, it's all in the noise floor, isn't it?  Better off trying
broader tests.  I had a play with netperf and the chatroom
benchmark.  But the latter varied from 80,000 msgs/sec up
to 350,000 between runs.
