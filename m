Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273734AbRI0RmN>; Thu, 27 Sep 2001 13:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273736AbRI0Rlx>; Thu, 27 Sep 2001 13:41:53 -0400
Received: from geos.coastside.net ([207.213.212.4]:7564 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S273734AbRI0Rlq>; Thu, 27 Sep 2001 13:41:46 -0400
Mime-Version: 1.0
Message-Id: <p0510031bb7d912c2c374@[207.213.214.37]>
In-Reply-To: <20010927143338.20730.qmail@eklektix.com>
In-Reply-To: <20010927143338.20730.qmail@eklektix.com>
Date: Thu, 27 Sep 2001 10:42:15 -0700
To: corbet-lk@lwn.net (Jonathan Corbet), linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: Question about ioremap and io_remap_page_range
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 8:33 AM -0600 2001-09-27, Jonathan Corbet wrote:
>  > >      VIRT_ADDR = ioremap(BUS_ADDR); to map a section of PCI memory, and
>>  >      X_ADDR = virt_to_phys(VIRT_ADDR);
>>
>>  i'd suggest to read Documentation/DMA-mapping.txt in any recent kernel
>>  source, the bus_to_virt()/virt_to_phys() interface is obsolete and has
>>  been replaced by the pci_alloc_*/pci_map_*/pci_free_*() dynamic
>>  DMA-mapping API.
>
>...or, of course, _Linux_Device_Drivers_, Second Edition, available online
>at http://www.xml.com/ldd/chapter/book/index.html.  The DMA chapter covers
>this API as well.

That chapter says, in small part,

>Based on this discussion, you might also want to map addresses 
>returned by ioremap to user space. This mapping is easily 
>accomplished because you can use remap_page_range directly, without 
>implementing methods for virtual memory areas. In other words, 
>remap_page_range is already usable for building new page tables that 
>map I/O memory to user space

Are you suggesting that ioremap() objects can be passed to 
remap_page_range()? How can that be valid?


Also, there's an html conversion error:

>      if (offset >= _&thinsp;_pa(high_memory) || (filp->f_flags & O_SYNC))

  Looks like &thinsp; got translated to &amp;thinsp;
-- 
/Jonathan Lundell.
