Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266968AbSK2ECL>; Thu, 28 Nov 2002 23:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266969AbSK2ECL>; Thu, 28 Nov 2002 23:02:11 -0500
Received: from guru.webcon.net ([66.11.168.140]:44236 "EHLO guru.webcon.net")
	by vger.kernel.org with ESMTP id <S266968AbSK2ECK>;
	Thu, 28 Nov 2002 23:02:10 -0500
Date: Thu, 28 Nov 2002 23:09:27 -0500 (EST)
From: Ian Morgan <imorgan@webcon.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Alain Tesio <alain@onesite.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Asus P4B533 and resource conflict on IDE (P4PE also)
In-Reply-To: <20021129014416.54940079.alain@onesite.org>
Message-ID: <Pine.LNX.4.50.0211282256120.2289-100000@light.webcon.net>
References: <20021129014416.54940079.alain@onesite.org>
Organization: "Webcon, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu Jul 18 2002 - 06:12:02 Alan Cox wrote :
>  
> > On Thu, 2002-07-18 at 13:45, Andrew Halliwell wrote: 
> > > The P4B533 has the intel 801DB IDE controller (stated as supported in rc1) 
> > > but in every 2.4 kernel I've seen so far, this appears in the bootup. 
> > > 
> > > Uniform Multi-Platform E-IDE driver Revision: 6.31 
> > > ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx 
> > > PCI_IDE: unknown IDE controller on PCI bus 00 device f9, VID=8086, DID=24cb 
> > > PCI: Device 00:1f.1 not available because of resource collisions 
> > > PCI_IDE: (ide_setup_pci_device:) Could not enable device 
> > 
> > Blame your BIOS vendor 
> > The -ac tree has workarounds for the BIOS forgetting to set up the chip. 
> > Let me know if rc1-ac7 works for you 

The ICH4 IDE on my ASUS P4PE had the exact same problem, but the -ac pathes
make it hum along very nicely. Requring the PIIX driver, though, seems a
little wonky. Without -ac, the controller is detected as "ICH4" and doesn't
work. With the -ac patches, it works, but is detected as PIIX. Rather
confusing. Perhaps the the Configure.help should mention the ICH4?

2.4.19-vanilla didn't work. The first patch tried was 2.4.19-ac4, and that
worked. Now on 2.4.20-rc4-ac1 and all is still good.

I hope the workarounds for this get merged into 2.4.21-preX.

Regards,
Ian Morgan

-- 
-------------------------------------------------------------------
 Ian E. Morgan          Vice President & C.O.O.       Webcon, Inc.
 imorgan@webcon.ca          PGP: #2DA40D07           www.webcon.ca
    *  Customized Linux network solutions for your business  *
-------------------------------------------------------------------
