Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262263AbSJKAt6>; Thu, 10 Oct 2002 20:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262265AbSJKAt5>; Thu, 10 Oct 2002 20:49:57 -0400
Received: from pacific.moreton.com.au ([203.143.238.4]:23263 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S262263AbSJKAt4>; Thu, 10 Oct 2002 20:49:56 -0400
Message-ID: <3DA621DA.4050504@snapgear.com>
Date: Fri, 11 Oct 2002 10:56:58 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: linux-2.5.41uc1 (MMU-less support)
References: <3DA5A42F.6030001@snapgear.com> <20021010171816.A21468@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Christoph Hellwig wrote:
> On Fri, Oct 11, 2002 at 02:00:47AM +1000, Greg Ungerer wrote:
>>An updated uClinux patch is available at:
>>
>>http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.41uc1.patch.gz
>>
>>This one has the long awaited merge of the mmnommu and mm directories.
>>Went pretty smoothly really. The patches are not too bad, but there is
>>still some cleaning to do. A couple of files are still heavily #ifdef'ed
>>(like mm/mmap.c, mm/swap_state.c and mm/swapfile.c) but I think these
>>can ironed out a bit.
> 
> 
> Could you please merge the patches Ib sent you instead of this horrible
> ifdef mess?

Hey, slow down :-)
This contains 6 of the 8 patches you sent. And I am working
through the other 2 now. They mess with a lot of files, many
not in mm.


>  and yes, page_io.o, swapfile.o and swap_state.o shouldn't
> be compiled at all for !CONFIG_SWAP dito for highmem.o, madvise.o, 
> memory.o, mincore.o, mmap.o, mprotect.o, mremap.o, msync.o, rmap.o,
> shmem.o, vmalloc.o for !CONFIG_MMU

This is trivial to clean up in the Makefile, like I said still some
cleaning still to do. I'll have new patches probably each day as I
work through the issues.

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

