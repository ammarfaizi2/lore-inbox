Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262682AbRGEVHo>; Thu, 5 Jul 2001 17:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261771AbRGEVHe>; Thu, 5 Jul 2001 17:07:34 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:29199 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S263149AbRGEVHS>;
	Thu, 5 Jul 2001 17:07:18 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, bcrl@redhat.com (Ben LaHaise),
        hiren_mehta@agilent.com ("MEHTA,HIREN (A-SanJose,ex1)"),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit m achi ne
In-Reply-To: <15164.18270.460245.219060@pizda.ninka.net> <E15Fv14-0008TB-00@the-village.bc.nu> <15164.59159.645521.383074@pizda.ninka.net>
From: Jes Sorensen <jes@sunsite.dk>
Date: 05 Jul 2001 23:06:25 +0200
In-Reply-To: "David S. Miller"'s message of "Fri, 29 Jun 2001 13:37:43 -0700 (PDT)"
Message-ID: <d3pubfw0fi.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David S Miller <davem@redhat.com> writes:

David> Alan Cox writes:
>> Thats something we already know has to be fixed. Its true with or
>> without an IOMMU that there may be cases where there is no free
>> mapping space

David> True, but my intended point is that starving the SAC-only users
David> then returning DAC addresses to DAC-capable devices is just as
David> unacceptable.

David> When we have one of these compute cluster cards in the box, and
David> Jes's suggested algorithm is used, the rest of the SAC devices
David> in the box would be totally screwed once the IOMMU fills up.

The dma_mask in struct pci_dev tells you whether you are DAC
capable. We pass a pointer to this struct when we call the pci_*
functions so the required information needed to make the decision
whether to return a SAC or a DAC address is already available.

Cheers
Jes
