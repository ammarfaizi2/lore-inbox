Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292928AbSCELwo>; Tue, 5 Mar 2002 06:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292914AbSCELwf>; Tue, 5 Mar 2002 06:52:35 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:30666 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S292907AbSCELwV>; Tue, 5 Mar 2002 06:52:21 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 5 Mar 2002 03:52:14 -0800
Message-Id: <200203051152.DAA05010@adam.yggdrasil.com>
To: davem@redhat.com
Subject: Re: Does kmalloc always return address below 4GB?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Just use pci_alloc_consistent, it never gives you
>anything larger than 32-bit addresses, please read the
>documentation :-)

	I see the smiley, but let me point out that I have
read Documentation/DMA-mapping.txt and I was misled by this
sentence:

| If you acquired your memory via the page allocator
| (i.e. __get_free_page*()) or the generic memory allocators
| (i.e. kmalloc() or kmem_cache_alloc()) then you may DMA to/from
| that memory using the addresses returned from those routines.

	It might be a good idea to rephrase it.  If I knew what that
sentence I would propose a patch to the DMA-mapping.txt file, but I
honestly don't know what proposition that sentence is supposed
to convey.  If there really is no guarantee that this sentence is
conveying, then I guess the sentence should be deleted.

	Anyhow, thanks for your quick clarification.  The driver
breaking on 64-bit architectures was exactly what I was worried about.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
