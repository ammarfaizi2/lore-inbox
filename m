Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315200AbSEIW7Y>; Thu, 9 May 2002 18:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315206AbSEIW7X>; Thu, 9 May 2002 18:59:23 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17935 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315200AbSEIW7W>; Thu, 9 May 2002 18:59:22 -0400
Subject: Re: PATCH & call for help: Marking ISA only drivers
To: ak@muc.de (Andi Kleen)
Date: Fri, 10 May 2002 00:18:21 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), ak@muc.de (Andi Kleen),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020510005007.B1327@averell> from "Andi Kleen" at May 10, 2002 12:50:07 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E175xAz-0004kH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +if [ "$CONFIG_ISA" = "y" ]; then
> > > +   dep_tristate 'Adaptec AHA152X/2825 support' CONFIG_SCSI_AHA152X $CONFIG_SCSI
> > 
> > 2825 is not ISA bus
> 
> What then ?

Vesa local bus

> But seems to be not 64bit safe and miss pci dma support (note the CONFIG_X86_64). 

My fault

> > > +if [ "$CONFIG_ISA" = "y" ]; then
> > > +  dep_tristate 'Generic NCR5380/53c400 SCSI support' CONFIG_SCSI_GENERIC_NCR5380 $CONFIG_SCSI
> > > +  if [ "$CONFIG_SCSI_GENERIC_NCR5380" != "n" ]; then
> > 
> > This is used in multiple non ISA situations.
> 
> Only on ancient motherboards (I remember having it on some really old EISA
> machine) and non PC devices, no ? 

On just about anything. If you have some old (or new) random weird box
then so long as you know the address this works. NCR5380 macrocells are
still being used I'm afraid to say, and attached to pretty much any bus
people can find.

Alan
