Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315451AbSFCTpc>; Mon, 3 Jun 2002 15:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315443AbSFCTo6>; Mon, 3 Jun 2002 15:44:58 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:12761 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315451AbSFCTog>; Mon, 3 Jun 2002 15:44:36 -0400
Date: Tue, 4 Jun 2002 01:18:06 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Mala Anand <manand@us.ibm.com>
Cc: BALBIR SINGH <balbir.singh@wipro.com>, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net,
        Paul McKenney <Paul.McKenney@us.ibm.com>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Lse-tech] Re: [RFC] Dynamic percpu data allocator
Message-ID: <20020604011806.A10422@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <OF60D095C7.87A83057-ON85256BCD.0068BA3A@raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2002 at 02:12:29PM -0500, Mala Anand wrote:
> I looked at the slab code, per cpu slab is already implemented by Manfred
> Spraul.
> Look at cpu_data[NR_CPUS] in kmem_cache_s structure.
> 

Sorry, I should have been more clear saying what I wanted.
Yes, kmem_cache_alloc() allocates one object from "this" CPU's slabs. What
I want is a kmalloc_percupu() that allocates one copy for every
CPU in the system. Think of this as dynamically allocacting an
array of NR_CPUS objects with objects residing on different cachelines.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
