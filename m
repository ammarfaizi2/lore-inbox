Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272106AbRHWBc6>; Wed, 22 Aug 2001 21:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272107AbRHWBcs>; Wed, 22 Aug 2001 21:32:48 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:56326 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S272106AbRHWBcn>; Wed, 22 Aug 2001 21:32:43 -0400
Message-Id: <200108230132.f7N1WkY22194@aslan.scsiguy.com>
To: "David S. Miller" <davem@redhat.com>
cc: groudier@free.fr, axboe@suse.de, skraw@ithnet.com, phillips@bonn-fries.net,
        linux-kernel@vger.kernel.org
Subject: Re: With Daniel Phillips Patch 
In-Reply-To: Your message of "Wed, 22 Aug 2001 18:08:58 PDT."
             <20010822.180858.89278064.davem@redhat.com> 
Date: Wed, 22 Aug 2001 19:32:46 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   From: "Justin T. Gibbs" <gibbs@scsiguy.com>
>   Date: Wed, 22 Aug 2001 18:55:21 -0600
>   
>   Then it is poorly named.  How about "pci_dma32_t".  Or better yet,
>   uint32_t.  How do the guys writing SBUS drivers like the fact that
>   all of this mapping stuff is so PCI centric?
>   
>Please actually take a look at a few SBUS drivers before
>you open your big mouth.  SBUS drivers use a totally different
>API.

Perhaps its different for SBUS, but its not different for ISA
or EISA.  The main point here is that if a single driver has
multiple bus attachements they either "luck out" and can use a
"pci api" to talk to their non-pci devices (the aic7xxx driver talks
EISA/VL/PCI) or they have to have different mapping paths (SBUS/PCI driver).
Do you believe that it is architecturally correct to have a single
api or multiple apis?  From your "big mouth" comment above, I assume
the later.  From the driver's standpoint, the task is pretty much the
same, with perhaps different contraints on the types of address that
can be supported by the device.  The "pci" api already allows you
to express this.

--
Justin
