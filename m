Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266563AbRGDWEH>; Wed, 4 Jul 2001 18:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266562AbRGDWD6>; Wed, 4 Jul 2001 18:03:58 -0400
Received: from 24-25-197-107.san.rr.com ([24.25.197.107]:35061 "HELO
	sink.san.rr.com") by vger.kernel.org with SMTP id <S266566AbRGDWDn>;
	Wed, 4 Jul 2001 18:03:43 -0400
Date: Wed, 4 Jul 2001 15:03:42 -0700
From: acmay@acmay.homeip.net
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: virt_to_bus and virt_to_phys on Apple G4 target
Message-ID: <20010704150342.C822@sink.san.rr.com>
In-Reply-To: <CA256A7E.0020F52C.00@d73mta01.au.ibm.com> <15169.29154.670946.785981@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15169.29154.670946.785981@pizda.ninka.net>; from davem@redhat.com on Tue, Jul 03, 2001 at 12:18:58AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2001 at 12:18:58AM -0700, David S. Miller wrote:
> 
> mdaljeet@in.ibm.com writes:
>  > I am running linux 2.4.2 on Apple G4 machine. I think the 'PCI bus
>  > addresses' and 'physical addresses' are same on this architecture. I
>  > expected the two be different but according to asm/io.h 'virt_to_bus(addr)
>  > = virt_to_phys(addr) + PCI_DRAM_OFFSET'. I printed the value of
>  > 'PCI_DRAM_OFFSET' and that come out to be zero. Is this correct?
>  > 
>  > If I somehow get the physical address of a user space buffer in a module
>  > and take this as a PCI bus address, will I be able to do DMA properly?
> 
> virt_to_bus() and bus_to_virt() are deprecated interfaces and should
> not be used by anything new.  See Documentation/DMA-mapping.txt for
> details.

What about non-PCI devices? The IBM 405GP on-chip ethernet controller
is not PCI. It isn't in the standard kernel yet, but I am sure there
are other things that do DMA that aren't PCI.
