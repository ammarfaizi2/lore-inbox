Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271981AbRI0IDX>; Thu, 27 Sep 2001 04:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271982AbRI0IDN>; Thu, 27 Sep 2001 04:03:13 -0400
Received: from mout02.kundenserver.de ([195.20.224.133]:11031 "EHLO
	mout02.kundenserver.de") by vger.kernel.org with ESMTP
	id <S271981AbRI0IDD> convert rfc822-to-8bit; Thu, 27 Sep 2001 04:03:03 -0400
Date: Thu, 27 Sep 2001 10:03:26 +0200 (MEST)
From: Armin Schindler <mac@melware.de>
To: Ingo Molnar <mingo@elte.hu>
cc: =?ISO-8859-1?B?yua5+se/?= <guoqiang@intec.iscas.ac.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Question about ioremap and io_remap_page_range
In-Reply-To: <Pine.LNX.4.33.0109270847070.2745-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.31.0109271001001.25611-100000@phoenix.one.melware.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2001, Ingo Molnar wrote:

>
> On Thu, 27 Sep 2001, [GB2312] Êæ¹úÇ¿ wrote:
>
> >  Here is some rather basic questions I want ask ,any reply or comment
> >  please CC to my emailbox,thank you very much.
> >
> >  When I work with kernel 2.4.2 in Intel X86 , I use
> >
> >      VIRT_ADDR = ioremap(BUS_ADDR); to map a section of PCI memory, and
> >      X_ADDR = virt_to_phys(VIRT_ADDR);
>
> i'd suggest to read Documentation/DMA-mapping.txt in any recent kernel
> source, the bus_to_virt()/virt_to_phys() interface is obsolete and has
> been replaced by the pci_alloc_*/pci_map_*/pci_free_*() dynamic
> DMA-mapping API. You can find some nice examples of usage in
> drivers/net/*.c.
>
> 	Ingo

virt_to_phys() is obsolete ? What should be used if I need the phys address
of a memory page ? (e.g. for mmap() remapping)

Armin

