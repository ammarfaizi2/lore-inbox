Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263099AbSIPVm4>; Mon, 16 Sep 2002 17:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263113AbSIPVmz>; Mon, 16 Sep 2002 17:42:55 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:6163 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id <S263099AbSIPVmz>; Mon, 16 Sep 2002 17:42:55 -0400
Date: Mon, 16 Sep 2002 23:51:29 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
To: "David S. Miller" <davem@redhat.com>
cc: akropel1@rochester.rr.com, linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: Streaming DMA mapping question
In-Reply-To: <20020916.135606.107746701.davem@redhat.com>
Message-ID: <Pine.LNX.4.21.0209162342480.16996-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Sep 2002, David S. Miller wrote:

>    From: Martin Diehl <lists@mdiehl.de>
>    Date: Mon, 16 Sep 2002 23:06:35 +0200 (CEST)
>    
>    Wasn't there a patch submitted which suggested to add pci_dma_prep_*()
>    calls in order to sync the cpu-driven changes back to the bus? I'm asking
>    because I'm dealing with a driver that needs to reuse streaming pci maps.
>    
> Yes, basically this is what must happen.
> 
> If someone would code up a patch that includes the MIPS
> implementation, adds NOP implementations to every other asm/pci.h file
> and updates the Documentation/DMA-mapping.txt file appropriately,
> I'll probably just apply the patch and merge it upstream immediately.

Ok, thanks. The MIPS thing is far beyond my coverage anyway. Seems I just 
gonna stay with the my dummy __pci_dma_prep_single() simply to remind me
of the missing api call. The driver is i86-only, so it's a non-issue...

Martin

