Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261348AbSITHnp>; Fri, 20 Sep 2002 03:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261395AbSITHnp>; Fri, 20 Sep 2002 03:43:45 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:34015 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261348AbSITHnn>;
	Fri, 20 Sep 2002 03:43:43 -0400
Message-Id: <200209200747.g8K7la9B174532@northrelay01.pok.ibm.com>
User-Agent: Pan/0.11.2 (Unix)
From: "Maneesh Soni" <maneesh@in.ibm.com>
To: "William Lee Irwin III" <wli@holomorphy.com>,
       Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       viro@math.psu.edu
Subject: Re: 2.5.36-mm1 dbench 512 profiles
Date: Fri, 20 Sep 2002 13:29:28 +0530
References: <20020919223007.GP28202@holomorphy.com> <68630000.1032477517@w-hlinder> <3D8A5FE6.4C5DE189@digeo.com> <20020920000815.GC3530@holomorphy.com>
Reply-To: maneesh@in.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2002 05:48:38 +0530, William Lee Irwin III wrote:

> Hanna Linder wrote:
>>> Looks like fastwalk might not behave so well on this 32 cpu numa
>>> system...
> 
> On Thu, Sep 19, 2002 at 04:38:14PM -0700, Andrew Morton wrote:
>> I've rather lost the plot.  Have any of the dcache speedup patches been
>> merged into 2.5?
> 
> As far as the dcache goes, I'll stick to observing and reporting. I'll
> rerun with dcache patches applied, though.
> 
..
> Thanks,
> Bill
> -

For a 32-way system fastwalk will perform badly from dcache_lock point of 
view, basically due to increased lock hold time. dcache_rcu-12 should reduce
dcache_lock contention and hold time. The patch uses RCU infrastructer patch and
read_barrier_depends patch. The patches are available in Read-Copy-Update
section on lse site at

http://sourceforge.net/projects/lse

Regards
Maneesh

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
