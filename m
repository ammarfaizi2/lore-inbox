Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287499AbSAEEHE>; Fri, 4 Jan 2002 23:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287500AbSAEEGy>; Fri, 4 Jan 2002 23:06:54 -0500
Received: from elin.scali.no ([62.70.89.10]:45063 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S287499AbSAEEGg>;
	Fri, 4 Jan 2002 23:06:36 -0500
Message-ID: <3C367A21.77E443F@scali.no>
Date: Sat, 05 Jan 2002 04:59:29 +0100
From: Steffen Persvold <sp@scali.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-ac18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tommy Reynolds <reynolds@redhat.com>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.org>
Subject: Re: Short question about the mmap method
In-Reply-To: <3C360FD5.91285F5D@scali.no> <20020104145949.682d51c4.reynolds@redhat.com> <3C3651E4.777EABA@scali.no> <3C366B70.DB1E9F0A@scali.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steffen Persvold wrote:
> 
> Another thing, when allocating memory with vmalloc, how can I be sure that the pages I get is
> adressable within 4GB (i.e I wan't to call pci_map_sg on this buffer for my 32bit PCI device without
> having to use bounce buffers ) ? On systems with less that 4GB of physical memory there's no
> problem, but what happens if you have more (lets say an IA64 server with 16GB of RAM) and don't have
> an IOMMU (like alpha and sparc) ?
> 
> I noticed a vmalloc_32 in linux/vmalloc.h (the comment says "32bit PA addressable pages - eg for PCI
> 32bit devices"), but is that one platform independent (I see that it is only using GFP_KERNEL, while
> vmalloc is using GFP_KERNEL | __GFP_HIGHMEM) ? This issue goes for __get_free_pages too I guess.
> 

Hmm, it helps looking back at old threads (which I actually was involved in).

What ever happened to Jens Axboe's "zone_dma32" patch ? Why wasn't it included in the main 2.4.6
kernel tree (seemed like a good idea to me) ?

Regards,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best   
 mailto:sp@scali.no  |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.12.2 -         
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >300MBytes/s and <4uS latency
