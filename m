Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270560AbRHITKf>; Thu, 9 Aug 2001 15:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270556AbRHITKZ>; Thu, 9 Aug 2001 15:10:25 -0400
Received: from quattro.sventech.com ([205.252.248.110]:52750 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S270559AbRHITKL>; Thu, 9 Aug 2001 15:10:11 -0400
Date: Thu, 9 Aug 2001 15:10:22 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: struct page to 36 (or 64) bit bus address?
Message-ID: <20010809151022.C1575@sventech.com>
In-Reply-To: <20010809144000.B1575@sventech.com> <E15UvAy-0007qI-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E15UvAy-0007qI-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Aug 09, 2001 at 08:09:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2001, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > I have a 64 bit PCI card which I'd like to do 64 bit DMA with. I have a
> > struct page, but I don't see an easy way of determining what the bus
> > address for that page is.
> > 
> > Is there a way to do it at all?
> 
> Yes but its not the right way to do it (bttv does it for example). You want 
> to be using the pci or kiovec apis (Documentation/DMA-mapping.txt)
> 
> Thats important because it may well be an iommu that handles the mapping to
> make the stuff visible - not the cpu

Unfortunately the PCI DMA API on i386 will only return 32 bit addresses,
which kinda defeats the purpose of what I'm doing.

Obviously the more portable way across architectures is using the PCI
DMA API but when will the implementation be fixed so I can use it to
exploit the full potential of this device?

I'll take a look at the BTTV for a short term solution.

JE

