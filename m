Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265026AbSJWOXZ>; Wed, 23 Oct 2002 10:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265025AbSJWOWv>; Wed, 23 Oct 2002 10:22:51 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:25853 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265022AbSJWOWR>;
	Wed, 23 Oct 2002 10:22:17 -0400
Date: Wed, 23 Oct 2002 20:01:53 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: Re: [patch] kstat cleanup
Message-ID: <20021023200153.B32662@in.ibm.com>
References: <20021022194111.A27878@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021022194111.A27878@in.ibm.com>; from kiran@in.ibm.com on Tue, Oct 22, 2002 at 07:41:11PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
Here is the kstat cleanup patch set with all the arch changes.
Applies neatly on mm-3.  I am mailing the url since both the patches
exceed 40k limit by  900 bytes  :).  The first patch is for
generic+i386 changes, the second patch is for arch specific changes
for all other archs. Tested well on a PIII 4 way.
 
Patches can be found at:
http://osdn.dl.sourceforge.net/sourceforge/lse/kstat-2.5.44-mm3-2.patch
and
http://osdn.dl.sourceforge.net/sourceforge/lse/kstat-arch-2.5.44-mm3.patch
 
Thanks,
Kiran

On Tue, Oct 22, 2002 at 07:41:11PM +0530, Ravikiran G Thirumalai wrote:
> Hi Andrew,
> Here's the kstat cleanup you'd suggested sometime ago.
> I have used Rusty's per_cpu infrastructure for the stats now.
> Here're the changes in short.
> 
> 1. Break out disk stats from kernel_stat and move disk stat to blkdev.h
> 2. Group cpu stat in kernel_stat and make them "per_cpu" instead of
>    the NR_CPUS array
> 3. Remove EXPORT_SYMBOL(kstat) from ksyms.c (as I noticed that no module is
>    using kstat)
> 
> The foll patch is tested on a 4 way PIII xeon. This patch has changes
> for i386 files (+ arch independent changes)(.. it'll break other archs).  
> I am in the process of changing other archs.  Patch for the same to follow 
> soon. In the meanwhile, do let me know if the patch is ok by you. Patch
> applies neatly on 2.5..44-mm2
