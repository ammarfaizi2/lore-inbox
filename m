Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131568AbQLVJ1e>; Fri, 22 Dec 2000 04:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131841AbQLVJ1Y>; Fri, 22 Dec 2000 04:27:24 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:42769 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131568AbQLVJ1L>; Fri, 22 Dec 2000 04:27:11 -0500
Subject: Re: bigphysarea support in 2.2.19 and 2.4.0 kernels
To: middelink@polyware.nl (Pauline Middelink)
Date: Fri, 22 Dec 2000 08:58:39 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
In-Reply-To: <20001222093928.A30636@polyware.nl> from "Pauline Middelink" at Dec 22, 2000 09:39:28 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E149O2D-0004M0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (Alan: bootmem allocation just won't do. I need that memory
> in modules which get potentially loaded/unloaded, hence a
> wrapper interface for allowing access to a bootmem allocated
> piece of memory)

Yes, I pointed him at you for 2.4test because you had the code sitting on
top of bootmem which is the right way to do it.

> Or do you want it rolled in kmalloc? So GFP_DMA with size>128K
> would take memory from this? That would mean a much more intrusive
> patch in very sensitive and rapidly changing parts of the kernel
> (2.2->2.4 speaking)...

bigmem is 'last resort' stuff. I'd much rather it is as now a seperate
allocator so you actually have to sit and think and decide to give up on
kmalloc/vmalloc/better algorithms and only use it when the hardware sucks

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
