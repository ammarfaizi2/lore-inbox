Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135522AbRAQTqW>; Wed, 17 Jan 2001 14:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135613AbRAQTqM>; Wed, 17 Jan 2001 14:46:12 -0500
Received: from madaket.netwizards.net ([208.164.216.19]:44557 "EHLO
	madaket.netwizards.net") by vger.kernel.org with ESMTP
	id <S135522AbRAQTpy>; Wed, 17 Jan 2001 14:45:54 -0500
Date: Wed, 17 Jan 2001 11:46:36 -0800
From: hgp-linux@madaket.netwizards.net
Message-Id: <200101171946.LAA25426@madaket.netwizards.net>
To: linux-kernel@vger.kernel.org
Subject: Strange mm problem??
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm having a crazy mm problem with the new 2.4.0 kernel. I've got a
device in which I do DMA i/o from user space.

I have a dd which allocs mem (for use as a DMA staging area)  and then
I use remap_page_range() to map it into user land (via the mmap()
interface). I was using __get_dma_pages(), the MAP_NR macro, and
mem_map_reserve() to allocate and reserve the mem.

It works great in  2.2.12 and 2.4.0-test4. Now with 2.4.0 production,
I  borrowed the uvirt_to_kva(), uvirt_to_bus(), kvirt_to_pa()
and rvmalloc() functions from drivers/media/video/bttv-driver.c

Now here's the wierd part: Memory is allocated ok and I can read to and
write from it in the dd. But in the userland application, I can write
to it OK, but all reads return 0xff!

I'm sure I'm doing something wrong but can't figure out what!

Any assistance would be appreciated.

REgards,

Howard G Page
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
