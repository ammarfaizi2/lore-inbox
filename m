Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270619AbRI0GyP>; Thu, 27 Sep 2001 02:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270992AbRI0GyF>; Thu, 27 Sep 2001 02:54:05 -0400
Received: from chiara.elte.hu ([157.181.150.200]:4621 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S270619AbRI0Gx6> convert rfc822-to-8bit;
	Thu, 27 Sep 2001 02:53:58 -0400
Date: Thu, 27 Sep 2001 08:52:02 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: =?GB2312?Q?=CA=E6=B9=FA=C7=BF?= <guoqiang@intec.iscas.ac.cn>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Question about ioremap and io_remap_page_range
In-Reply-To: <200109270557.NAA22817@intec.iscas.ac.cn>
Message-ID: <Pine.LNX.4.33.0109270847070.2745-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Sep 2001, [GB2312] Êæ¹úÇ¿ wrote:

>  Here is some rather basic questions I want ask ,any reply or comment
>  please CC to my emailbox,thank you very much.
>
>  When I work with kernel 2.4.2 in Intel X86 , I use
>
>      VIRT_ADDR = ioremap(BUS_ADDR); to map a section of PCI memory, and
>      X_ADDR = virt_to_phys(VIRT_ADDR);

i'd suggest to read Documentation/DMA-mapping.txt in any recent kernel
source, the bus_to_virt()/virt_to_phys() interface is obsolete and has
been replaced by the pci_alloc_*/pci_map_*/pci_free_*() dynamic
DMA-mapping API. You can find some nice examples of usage in
drivers/net/*.c.

	Ingo

