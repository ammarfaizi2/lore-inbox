Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268163AbTB1UlF>; Fri, 28 Feb 2003 15:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268165AbTB1UlE>; Fri, 28 Feb 2003 15:41:04 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:64870 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S268163AbTB1UlD>; Fri, 28 Feb 2003 15:41:03 -0500
Date: Fri, 28 Feb 2003 15:51:23 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200302282051.h1SKpNm32220@devserv.devel.redhat.com>
To: dsaxena@mvista.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Proposal: Eliminate GFP_DMA
In-Reply-To: <mailman.1046456425.7772.linux-kernel2news@redhat.com>
References: <1046445897.16599.60.camel@irongate.swansea.linux.org.uk> <Pine.SGI.4.10.10302282138180.244855-100000@Sky.inp.nsk.su> <20030228155841.GA4678@gtf.org> <mailman.1046456425.7772.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This discussion raises an issue that I've been meaning to bring up for a bit.
> Currently, the DMA-API is defined as returning a cpu physical address [1],
> but should the API be redefined as returning an address which is valid on 
> the bus which the device sits on? [...]

>     dma_addr_t
>     dma_map_single(struct device *dev, void *cpu_addr, size_t size,
>                       enum dma_data_direction direction)
>     dma_addr_t
>     pci_map_single(struct device *dev, void *cpu_addr, size_t size,
>                       int direction)
> 
>     Maps a piece of processor virtual memory so it can be accessed by the
>     device and returns the _physical_ handle of the memory.

That's only a sloppy documentation, obviously it returns a bus
address, not a physical address. Simply the x86 graduate who wrote
it cannot see the difference, that's all. Pay it no mind and
implement it properly, that means copy it from sparc64.
Who reads documentation anyway when we have the source?

-- Pete
