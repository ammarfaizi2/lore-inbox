Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263524AbSITUpE>; Fri, 20 Sep 2002 16:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263527AbSITUpE>; Fri, 20 Sep 2002 16:45:04 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:60363 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263524AbSITUpD>; Fri, 20 Sep 2002 16:45:03 -0400
Date: Sat, 21 Sep 2002 02:24:23 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Maneesh Soni <maneesh@in.ibm.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: 2.5.36-mm1 dbench 512 profiles
Message-ID: <20020921022423.B5267@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20020919223007.GP28202@holomorphy.com> <68630000.1032477517@w-hlinder> <3D8A5FE6.4C5DE189@digeo.com> <20020920000815.GC3530@holomorphy.com> <200209200747.g8K7la9B174532@northrelay01.pok.ibm.com> <20020920080628.GK3530@holomorphy.com> <20020920120358.GV28202@holomorphy.com> <61200000.1032547873@w-hlinder> <69960000.1032553974@w-hlinder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <69960000.1032553974@w-hlinder>; from hannal@us.ibm.com on Fri, Sep 20, 2002 at 08:32:48PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2002 at 08:32:48PM +0000, Hanna Linder wrote:
> --On Friday, September 20, 2002 11:51:13 -0700 Hanna Linder <hannal@us.ibm.com> wrote:
> 
> > 
> > 	Perhaps it is time to reconsider replacing fastwalk with dcache_rcu. 
> 
> These patches were written by Maneesh Soni. Since the Read-Copy Update
> infrastructure has not been accepted into the mainline kernel yet (although
> there were murmurings of it being acceptable) you will need to apply
> those first. Here they are, apply in this order. Too big to post
> inline text though. These are provided against 2.5.36-mm1.
> 
> 
> http://prdownloads.sourceforge.net/lse/rcu_ltimer-2.5.36-mm1
> 
> http://prdownloads.sourceforge.net/lse/read_barrier_depends-2.5.36-mm1
> 
> http://prdownloads.sourceforge.net/lse/dcache_rcu-12-2.5.36-mm1
> 
> There has been quite a bit of testing done on this and it has proven
> quite stable. If anyone wants to do any additional testing that would
> be great.

Thanks for the vote of confidence :)

Now for some results (out of date, but also has results with backported code 
from 2.5) see http://lse.sf.net/locking/dcache/dcache.html.

Preliminary profiling of webserver benchmarks in 2.5.3X show similar potential
for dcache_rcu. I will have actual results published when we can
get formal runs done.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
