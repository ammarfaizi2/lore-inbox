Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318044AbSGRMmC>; Thu, 18 Jul 2002 08:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318042AbSGRMmC>; Thu, 18 Jul 2002 08:42:02 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:6334 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S318044AbSGRMmA>; Thu, 18 Jul 2002 08:42:00 -0400
Date: Thu, 18 Jul 2002 15:02:42 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Dale Amon <amon@vnl.com>
Cc: Frank Davis <fdavis@si.rr.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.24 : BusLogic cleanup
In-Reply-To: <20020718111847.GF19403@vnl.com>
Message-ID: <Pine.LNX.4.44.0207181458140.29194-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2002, Dale Amon wrote:

> On Mon, Jun 24, 2002 at 01:07:18AM -0400, Frank Davis wrote:
> > Hello all,
> >   The following patch removes some unneccessary (it seems) typedefs, and 
> > adds in the pci_set_dma_mask() check mentioned in 
> > Documentation/DMA-mapping.txt . Please review.

The driver needs more than just the dma mask set.

> Did your Buslogic patch ever get included? I'm still
> getting errors compiling 2.5.x as of .26 last night:

Probably didn't get in because the driver is still not compliant with the 
new kernel requirements for PCI/DMA

> BusLogic.c:32: #error Please convert me to Documentation/DMA-mapping.txt
> BusLogic.c: In function `BusLogic_DetectHostAdapter':
> BusLogic.c:2841: warning: long unsigned int format, BusLogic_IO_Address_T arg (arg 2)
> BusLogic.c: In function `BusLogic_QueueCommand':
> BusLogic.c:3415: structure has no member named `address'

That probably wants sg_dma_address()

> BusLogic.c: In function `BusLogic_BIOSDiskParameters':
> BusLogic.c:4141: warning: implicit declaration of function `scsi_bios_ptable'
> BusLogic.c:4141: warning: assignment makes pointer from integer without a cast
> make[2]: *** [BusLogic.o] Error 1
> 
> Given that your patch was against .24, I would guess
> it should be "relatively" safe against a .26 since it's
> only driver code that everyone else seems to be ignoring.

Well its not the friendliest code either ;)

Cheers,
	Zwane Mwaikambo

-- 
function.linuxpower.ca

