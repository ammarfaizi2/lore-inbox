Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262497AbSIZMOE>; Thu, 26 Sep 2002 08:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262505AbSIZMOE>; Thu, 26 Sep 2002 08:14:04 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:24481 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262497AbSIZMOE>;
	Thu, 26 Sep 2002 08:14:04 -0400
Date: Thu, 26 Sep 2002 17:54:45 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.38-mm3
Message-ID: <20020926175445.B18906@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <3D92BE07.B6CDFE54@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D92BE07.B6CDFE54@digeo.com>; from akpm@digeo.com on Thu, Sep 26, 2002 at 07:59:21AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 07:59:21AM +0000, Andrew Morton wrote:
> url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.38/2.5.38-mm3/
> 
> Includes a SARD update from Rick.  The SARD disk accounting is
> pretty much final now.
> 
> read_barrier_depends.patch
>   extended barrier primitives
> 
> rcu_ltimer.patch
>   RCU core
> 
> dcache_rcu.patch
>   Use RCU for dcache
> 

Hi Andrew,

Updated 2.5.38 RCU core and dcache_rcu patches are now available
at http://sourceforge.net/project/showfiles.php?group_id=8875&release_id=112473

The differences since earlier versions are -

rcu_ltimer - call_rcu() fixed for preemption and the earlier fix I had sent
             to you.
read_barrier_depends - fixes list_for_each_rcu macro compilation error.
dcache_rcu - uses list_add_rcu in d_rehash and list_for_each_rcu in d_lookup
             making the read_barrier_depends() fix I had sent to you
             earlier unnecessary.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
