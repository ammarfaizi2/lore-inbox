Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315172AbSEIWu3>; Thu, 9 May 2002 18:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315175AbSEIWu2>; Thu, 9 May 2002 18:50:28 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:52705 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S315172AbSEIWu1>; Thu, 9 May 2002 18:50:27 -0400
Date: Fri, 10 May 2002 00:50:07 +0200
From: Andi Kleen <ak@muc.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: PATCH & call for help: Marking ISA only drivers
Message-ID: <20020510005007.B1327@averell>
In-Reply-To: <20020509203719.A3746@averell> <E175ubJ-0004T4-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2002 at 10:33:21PM +0200, Alan Cox wrote:
> > BTW I think CONFIG_ISA would be an useful configuration option for 
> > i386 too - at least most modern PCs do not come with ISA slots anymore.
> 
> ISA slots != ISA devices
> 
> And ISA stuff hanging off things like chipset glue busses is everywhere
> 
> > +if [ "$CONFIG_ISA" = "y" ]; then
> > +   dep_tristate 'Adaptec AHA152X/2825 support' CONFIG_SCSI_AHA152X $CONFIG_SCSI
> 
> 2825 is not ISA bus

What then ?

> 
> > +# does not use pci dma and seems to be isa/onboard only for old machines
> > +if [ "$CONFIG_X86_64" != "y" ]; then
> > +  dep_tristate 'AM53/79C974 PCI SCSI support' CONFIG_SCSI_AM53C974 $CONFIG_SCSI $CONFIG_PCI
> > +fi
> 
> Thats PCI.

But seems to be not 64bit safe and miss pci dma support (note the CONFIG_X86_64). 

> 
> > +if [ "$CONFIG_ISA" = "y" ]; then
> > +  dep_tristate 'Generic NCR5380/53c400 SCSI support' CONFIG_SCSI_GENERIC_NCR5380 $CONFIG_SCSI
> > +  if [ "$CONFIG_SCSI_GENERIC_NCR5380" != "n" ]; then
> 
> This is used in multiple non ISA situations.

Only on ancient motherboards (I remember having it on some really old EISA
machine) and non PC devices, no ? 
I'm hoping the non PC users will add their perspective architecture again.

-Andi
