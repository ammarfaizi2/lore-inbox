Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263531AbSITUTa>; Fri, 20 Sep 2002 16:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263546AbSITUT3>; Fri, 20 Sep 2002 16:19:29 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:62455 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263531AbSITUT3>;
	Fri, 20 Sep 2002 16:19:29 -0400
Date: Sat, 21 Sep 2002 01:58:58 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: maneesh@in.ibm.com, William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       viro@math.psu.edu, Hanna Linder <hannal@us.ibm.com>
Subject: Re: 2.5.36-mm1 dbench 512 profiles
Message-ID: <20020921015858.C4357@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20020919223007.GP28202@holomorphy.com> <68630000.1032477517@w-hlinder> <3D8A5FE6.4C5DE189@digeo.com> <20020920000815.GC3530@holomorphy.com> <200209200747.g8K7la9B174532@northrelay01.pok.ibm.com> <3D8B31F8.40900@us.ibm.com> <20020920231020.A4357@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020920231020.A4357@in.ibm.com>; from dipankar@in.ibm.com on Fri, Sep 20, 2002 at 11:10:20PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2002 at 11:10:20PM +0530, Dipankar Sarma wrote:
> > 
> > In any case, we all know often acquired global locks are a bad idea on 
> > a 32-way, and should be avoided like the plague.  I just wish we had a 
> > dcache solution that didn't even need locks as much... :)
> 
> You have one - dcache_rcu. It reduces the dcache_lock acquisition
> by about 65% over fastwalk.

I should clarify, this was with a webserver benchmark.

For those who want to use them, Maneesh's dcache_rcu-12 patch and my
RCU "performance" infrastructure patches are in -

http://sourceforge.net/project/showfiles.php?group_id=8875&release_id=111743

The latest release is 2.5.36-mm1.
rcu_ltimer and read_barrier_depends are pre-requisites for dcache_rcu.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
