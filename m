Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263274AbSITSlt>; Fri, 20 Sep 2002 14:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263280AbSITSlt>; Fri, 20 Sep 2002 14:41:49 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:63662 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263274AbSITSlr>; Fri, 20 Sep 2002 14:41:47 -0400
Date: Fri, 20 Sep 2002 11:51:13 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Maneesh Soni <maneesh@in.ibm.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, viro@math.psu.edu
cc: Hanna Linder <hannal@us.ibm.com>
Subject: Re: 2.5.36-mm1 dbench 512 profiles
Message-ID: <61200000.1032547873@w-hlinder>
In-Reply-To: <20020920120358.GV28202@holomorphy.com>
References: <20020919223007.GP28202@holomorphy.com> <68630000.1032477517@w-hlinder> <3D8A5FE6.4C5DE189@digeo.com> <20020920000815.GC3530@holomorphy.com> <200209200747.g8K7la9B174532@northrelay01.pok.ibm.com> <20020920080628.GK3530@holomorphy.com> <20020920120358.GV28202@holomorphy.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Friday, September 20, 2002 05:03:58 -0700 William Lee Irwin III <wli@holomorphy.com> wrote:

> On Fri, Sep 20, 2002 at 01:29:28PM +0530, Maneesh Soni wrote:
>>> For a 32-way system fastwalk will perform badly from dcache_lock
>>> point of view, basically due to increased lock hold time.
>>> dcache_rcu-12 should reduce dcache_lock contention and hold time. The
>>> patch uses RCU infrastructer patch and read_barrier_depends patch.
>>> The patches are available in Read-Copy-Update section on lse site at
>>> http://sourceforge.net/projects/lse
> 
> On Fri, Sep 20, 2002 at 01:06:28AM -0700, William Lee Irwin III wrote:
>> ISTR Hubertus mentioning this at OLS, and it sounded like a problem to
>> me. I'm doing some runs with this to see if it fixes the problem.

	I mentioned it at OLS too. It was the point of my talk. Next
	time I will request a non 10am time slot!

> take its place. Ugly. OTOH the qualitative difference is striking. The
> interactive responsiveness of the machine, even when entirely unloaded,
> is drastically improved, along with such nice things as init scripts
> and kernel compiles also markedly faster. I suspect this is just the
> wrong benchmark to show throughput benefits with.
> 
> Also notable is that the system time was significantly reduced though
> I didn't log it. Essentially a long period of 100% system time is
> entered after a certain point in the benchmark, during which there are
> few (around 60 or 70) context switches in a second, and the duration
> of this period was shortened.

	Bill, you are saying that replacing dcache_rcu significantly
	improved system response time among other things? 

	Perhaps it is time to reconsider replacing fastwalk with dcache_rcu. 

	Viro? What are your objections?

Thanks.

Hanna

