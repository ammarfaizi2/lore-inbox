Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271686AbRHUOMQ>; Tue, 21 Aug 2001 10:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271690AbRHUOMG>; Tue, 21 Aug 2001 10:12:06 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51729 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271686AbRHUOL5>; Tue, 21 Aug 2001 10:11:57 -0400
Subject: Re: agpgart.o and intel i810-chipset
To: wicki@terror.de (Victoria W.)
Date: Tue, 21 Aug 2001 15:10:07 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10108210734370.27906-100000@csb.terror.de> from "Victoria W." at Aug 21, 2001 07:59:43 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZCEJ-0007vF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 00:00.0 Host bridge: Intel Corporation: Unknown device 7124 (rev 03)
> 00:01.0 VGA compatible controller: Intel Corporation: Unknown device 7125
> (rev 03)

Ok

> In the driver, there is no case-statement for 
> "PCI_DEVICE_ID_INTEL_810_E_1" like the
> one for "PCI_DEVICE_ID_INTEL_810_E_0" but the one for "810_E_0" searches
> for "PCI_DEVICE_ID_INTEL_810_E_1".
> 
>                 case PCI_DEVICE_ID_INTEL_810_E_0:
>                         i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
>                                              PCI_DEVICE_ID_INTEL_810_E_1,
>                                                    NULL);

This code looks right. 

We see an 810E_0 (host bridge)
We look for an 810E_1 secondary 
If we dont find it we abort

So the question I guess is what do you hav and why didnt it find it

8086 7124, 8086 7125 is the intel 810E GMCH and 810E CGC

Which of the checks fail - and also did you remember to include 810 support
in your agp options ?
