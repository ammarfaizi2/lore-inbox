Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316649AbSE3N4k>; Thu, 30 May 2002 09:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316650AbSE3N4j>; Thu, 30 May 2002 09:56:39 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:21129 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316649AbSE3N4j>; Thu, 30 May 2002 09:56:39 -0400
Subject: Re: [Lse-tech] Re: [RFC] Dynamic percpu data allocator
To: dipankar@beaverton.ibm.com
Cc: BALBIR SINGH <balbir.singh@wipro.com>, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net, lse-tech-admin@lists.sourceforge.net,
        "Paul McKenney" <Paul.McKenney@us.ibm.com>,
        Rusty Russell <rusty@rustcorp.com.au>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF6BEB750B.90A03073-ON85256BC9.0041372C@raleigh.ibm.com>
From: "Mala Anand" <manand@us.ibm.com>
Date: Thu, 30 May 2002 08:56:36 -0500
X-MIMETrack: Serialize by Router on D04NM108/04/M/IBM(Release 5.0.9a |January 7, 2002) at
 05/30/2002 09:56:13 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

                                                                                                                                               
                      dipankar@beaverton.ibm.co                                                                                                
                      m                                To:       BALBIR SINGH <balbir.singh@wipro.com>                                         
                      Sent by:                         cc:       linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>, Paul     
                      lse-tech-admin@lists.sour         McKenney/Beaverton/IBM@IBMUS, lse-tech@lists.sourceforge.net                           
                      ceforge.net                      Subject:  [Lse-tech] Re: [RFC] Dynamic percpu data allocator                            
                                                                                                                                               
                                                                                                                                               
                      05/24/02 01:13 AM                                                                                                        
                      Please respond to                                                                                                        
                      dipankar                                                                                                                 
                                                                                                                                               
                                                                                                                                               








>On Fri, May 24, 2002 at 10:07:59AM +0530, BALBIR SINGH wrote:
>> Hello, Dipankar,
>>
>> I would prefer to use the existing slab allocator for this.
>> I am not sure if I understand your requirements for the per-cpu
>> allocator correctly, please correct me if I do not.
>>
>> What I would like to see
>>
>> 1. Have per-cpu slabs instead of per-cpu cpucache_t. One should
>>    be able to tell for which caches we want per-cpu slabs. This
>>    way we can make even kmalloc per-cpu. Since most of the kernel
>>    would use and dispose memory before they migrate across cpus.
>>    I think this would be useful, but again no data to back it up.

>Allocating cpu-local memory is a different issue altogether.
>Eventually for NUMA support, we will have to do such allocations
>that supports choosing memory closest to a group of CPUs.

>The per-cpu data allocator allocates one copy for *each* CPU.
>It uses the slab allocator underneath. Eventually, when/if we have
>per-cpu/numa-node slab allocation, the per-cpu data allocator
>can allocate every CPU's copy from memory closest to it.

Does this mean that memory allocation will happen in "each" CPU?
Do slab allocator allocate the memory in each cpu? Your per-cpu
data allocator sounds like the hot list skbs that are in the tcpip stack
in the sense it is one level above the slab allocator and the list is
kept per cpu.  If slab allocator is fixed for per cpu, do you still
need this per-cpu data allocator?

_____________________________________________
Regards,
    Mala


   Mala Anand
   E-mail:manand@us.ibm.com
   Linux Technology Center - Performance
   Phone:838-8088; Tie-line:678-8088

