Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262216AbSJKDnD>; Thu, 10 Oct 2002 23:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262328AbSJKDnC>; Thu, 10 Oct 2002 23:43:02 -0400
Received: from pacific.moreton.com.au ([203.143.238.4]:53440 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S262216AbSJKDnB>; Thu, 10 Oct 2002 23:43:01 -0400
Message-ID: <3DA64A79.6020401@snapgear.com>
Date: Fri, 11 Oct 2002 13:50:17 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH]: linux-2.5.41uc1 (MMU-less support)
References: <3DA5A42F.6030001@snapgear.com> <20021010171816.A21468@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Heres a tivial mm (MMU-less) patch that cleans up many of
the "#ifdef COFNIG_MMU" littered all over the mm/* files.
The Makefile now chooses which files to compile appropriately.

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.41uc2-mm.patch.gz

This leaves the following files as the only ones with
conditionals:

   mm/filemap.c
   mm/mmap.c
   mm/page_alloc.c
   mm/page_io.c
   mm/slab.c
   mm/swap_state.c
   mm/swapfile.c
   mm/vmscan.c

I have a patch from Christoph that will take care of much
of the swap stuff still to apply.

Regards
Greg



> On Fri, Oct 11, 2002 at 02:00:47AM +1000, Greg Ungerer wrote:
> 
>>Hi All,
>>
>>An updated uClinux patch is available at:
>>
>>http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.41uc1.patch.gz
>>
>>This one has the long awaited merge of the mmnommu and mm directories.
>>Went pretty smoothly really. The patches are not too bad, but there is
>>still some cleaning to do. A couple of files are still heavily #ifdef'ed
>>(like mm/mmap.c, mm/swap_state.c and mm/swapfile.c) but I think these
>>can ironed out a bit.



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

