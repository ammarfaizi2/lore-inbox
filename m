Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261857AbSJQHzt>; Thu, 17 Oct 2002 03:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261859AbSJQHzt>; Thu, 17 Oct 2002 03:55:49 -0400
Received: from packet.digeo.com ([12.110.80.53]:46746 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261857AbSJQHzs>;
	Thu, 17 Oct 2002 03:55:48 -0400
Message-ID: <3DAE6E63.EFAF0F80@digeo.com>
Date: Thu, 17 Oct 2002 01:01:39 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.43-mm2 with contest
References: <1034840438.3dae6976a93fb@kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Oct 2002 08:01:40.0268 (UTC) FILETIME=[6CAD2EC0:01C275B3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> Here are the updated benchmarks with contest v0.51 (http://contest.kolivas.net)
> showing the change from -mm1 to -mm2. Other results removed for clarity.
> 
> noload:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.18 [3]              71.8    93      0       0       1.01
> 2.5.43 [2]              74.6    92      0       0       1.04
> 2.5.43-mm1 [4]          74.9    93      0       0       1.05
> 2.5.43-mm2 [2]          73.4    93      0       0       1.03

Would be interesting to run

	blockdev --setra 1024 /dev/hdXX

here.  We're getting more idle time with 2.5 and that can only
be due to disk wait - the IO scheduler changes.  This might make a
small difference.

> ...
> Removal of per-cpu pages patch does not seem to have been detrimental to contest
> benchmarks at least - perhaps this is responsible for the noload being better now?

Well that code is still there.  I'd expect a very small benefit from it
in this testing.
