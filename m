Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318128AbSIORSc>; Sun, 15 Sep 2002 13:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318130AbSIORSc>; Sun, 15 Sep 2002 13:18:32 -0400
Received: from franka.aracnet.com ([216.99.193.44]:30928 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S318128AbSIORSb>; Sun, 15 Sep 2002 13:18:31 -0400
Date: Sun, 15 Sep 2002 10:23:24 -0700 (PDT)
From: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andrew Morton <akpm@digeo.com>, Dave Hansen <haveblue@us.ibm.com>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH] add vmalloc stats to meminfo
In-Reply-To: <20020915071157.GH3530@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0209151021530.3517-100000@shell1.aracnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Sep 2002, William Lee Irwin III wrote:

> Dave Hansen wrote:
> >>  It is often hard to tell
> >> whether this is because the area is too small, or just too fragmented.  This
> LDT's were formerly allocated in vmallocspace. This presented difficulties
> with many simultaneous threaded applications. Also, given that there is
> zero vmallocspace OOM recovery now present in the kernel some method of
> monitoring this aspect of system behavior up until the point of failure is
> useful for detecting further problem areas (LDT's were addressed by using
> non-vmalloc allocations).
>
> Also, dynamic vmalloc allocations may very well be starved by boot-time
> allocations on systems where much vmallocspace is required for IO memory.
> The failure mode of such is effectively deadlock, since they block
> indefinitely waiting for permanent boot-time allocations to be freed up.


Thank you!! How difficult would it be to back-port this to 2.4.18?

--
Take Your Trading to the Next Level!
M. Edward Borasky, Meta-Trading Coach

znmeb@borasky-research.net
http://www.borasky-research.net/Meta-Trading-Coach.htm
http://groups.yahoo.com/group/meta-trading-coach

ransacked: participated in a sack race.

