Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317525AbSFEBHh>; Tue, 4 Jun 2002 21:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317526AbSFEBHg>; Tue, 4 Jun 2002 21:07:36 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:2222 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317525AbSFEBHd>;
	Tue, 4 Jun 2002 21:07:33 -0400
Date: Tue, 04 Jun 2002 18:10:25 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: Ruth Forester <lilo@us.ibm.com>, linux-kernel@vger.kernel.org
cc: hannal@us.ibm.com
Subject: Re: Lockstats for SMP DB Workload
Message-ID: <55990000.1023239425@w-hlinder.des>
In-Reply-To: <200206050016.g550Gl110934@eng4.beaverton.ibm.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Tuesday, June 04, 2002 17:16:46 -0700 Ruth Forester <lilo@us.ibm.com> wrote:

> Everyone, 
> 
> I am running with the following configuration
> 
> 	2.4.19pre8aa2+dj2+ (dj2 removes global semaphore_lock spinlock)
> 	 +fast_walkA3-2_4_19-pre8_patch.
> 
> The database is set up to use raw-io, yet looking at this data, it appears that
> I am still hitting a lot of filesystem accesses, among other things.  This is an
> oltp workload, although there are some contentions (pread?) that cause the 
> cpu sys time to go to 99%, it was during this part of the "workload" that this
> snapshot of lockmeter was taken.
> 

> SPINLOCKS         HOLD            WAIT
>   UTIL  CON    MEAN(  MAX )   MEAN(  MAX )(% CPU)     TOTAL NOWAIT SPIN RJECT  NAME
> 
>         6.7%  2.5us(  25ms)   62us(  12ms)( 6.8%)   2650959 93.3%  6.6% 0.05%  *TOTAL*
> 
>   2.4%  1.0%   38us(  15ms) 3185us(  12ms)(0.13%)      6291 99.0%  1.0%    0%  kernel_flag_cacheline
>   2.3%  9.1% 6865us(  15ms) 3551us(5592us)(0.01%)        33 90.9%  9.1%    0%    do_exit+0xf4


Dave Hanson has a do_exit patch you might want to look at...

Hanna

