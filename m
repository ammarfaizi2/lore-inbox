Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315437AbSFCTMl>; Mon, 3 Jun 2002 15:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317460AbSFCTMj>; Mon, 3 Jun 2002 15:12:39 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:43987 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315437AbSFCTMc>; Mon, 3 Jun 2002 15:12:32 -0400
Subject: Re: [Lse-tech] Re: [RFC] Dynamic percpu data allocator
To: dipankar@beaverton.ibm.com
Cc: BALBIR SINGH <balbir.singh@wipro.com>, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net, lse-tech-admin@lists.sourceforge.net,
        Paul McKenney <Paul.McKenney@us.ibm.com>,
        Rusty Russell <rusty@rustcorp.com.au>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF60D095C7.87A83057-ON85256BCD.0068BA3A@raleigh.ibm.com>
From: "Mala Anand" <manand@us.ibm.com>
Date: Mon, 3 Jun 2002 14:12:29 -0500
X-MIMETrack: Serialize by Router on D04NM108/04/M/IBM(Release 5.0.9a |January 7, 2002) at
 06/03/2002 03:12:02 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2002 at 08:56:36AM -0500, Mala Anand wrote:
>>

>>                       dipankar@beaverton.ibm.co

>>                       m                                To:       BALBIR
SINGH <balbir.singh@wipro.com>
>>
>>The per-cpu data allocator allocates one copy for *each* CPU.
>> >It uses the slab allocator underneath. Eventually, when/if we have
>> >per-cpu/numa-node slab allocation, the per-cpu data allocator
>> >can allocate every CPU's copy from memory closest to it.
>>
>> Does this mean that memory allocation will happen in "each" CPU?
>> Do slab allocator allocate the memory in each cpu? Your per-cpu
>> data allocator sounds like the hot list skbs that are in the tcpip stack
>> in the sense it is one level above the slab allocator and the list is
>> kept per cpu.  If slab allocator is fixed for per cpu, do you still
>> need this per-cpu data allocator?

>Actually I don't know for sure what plans are afoot to fix the slab
allocator
>for per-cpu. One plan I heard about was allocating from per-cpu pools
>rather than per-cpu copies. My requirements are similar to
>the hot list skbs. I want to do this -

I looked at the slab code, per cpu slab is already implemented by Manfred
Spraul.
Look at cpu_data[NR_CPUS] in kmem_cache_s structure.


Regards,
    Mala


   Mala Anand
   E-mail:manand@us.ibm.com
   Linux Technology Center - Performance
   Phone:838-8088; Tie-line:678-8088



