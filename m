Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278387AbRJ1OeO>; Sun, 28 Oct 2001 09:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278395AbRJ1OeE>; Sun, 28 Oct 2001 09:34:04 -0500
Received: from medelec.uia.ac.be ([143.169.17.1]:36362 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S278387AbRJ1Od4>;
	Sun, 28 Oct 2001 09:33:56 -0500
Date: Sun, 28 Oct 2001 15:34:19 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linux-2.4.13 - i8xx series chipsets patches
Message-ID: <20011028153419.A24908@medelec.uia.ac.be>
In-Reply-To: <20011028123941.A24412@medelec.uia.ac.be> <E15xqOj-0007s2-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15xqOj-0007s2-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Oct 28, 2001 at 01:54:45PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

> >  static struct pci_device_id i810tco_pci_tbl[] __initdata = {
> > -	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_0,	PCI_ANY_ID, PCI_ANY_ID, },
> > -	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_0,	PCI_ANY_ID, PCI_ANY_ID, },
> > -	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0,	PCI_ANY_ID, PCI_ANY_ID, },
> > -	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_10,	PCI_ANY_ID, PCI_ANY_ID, },
> > +	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_0, PCI_ANY_ID, PCI_ANY_ID, },
> > +	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_0, PCI_ANY_ID, PCI_ANY_ID, },
> > +	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0, PCI_ANY_ID, PCI_ANY_ID, },
> 
> Why all this renaming and reformatting - what does your patch really do
> other than generate a lot of pointless noise

Sorry to upset you for this reformatting. What I did was look at the I/O Controller Hub of the intel 8xx series of chipsets and had a look what was supported and what was not. The 82801CA and 82801CAM I/O Controller Hubs were not supported yet and thus I added support for this in the IDE code, the watchdog timer and the random number generator. These Hubs will support intel 830 and intel 830MP (and probably others in the future as well) series of motherboards. 
My main source of info was the datasheets from intel on the different 82801 chips.

> 
> > -	1a21  82840 840 (Carmel) Chipset Host Bridge (Hub A)
> > +	1a21  82840 840 [Carmel] Chipset Host Bridge (Hub A)
> 
> And why break all the bracketing so that it isnt like other table
> entries ?

I checked why I changed to the square brackets: they are normally used when you need to strip if the
description is too long. In this case it indeeds make no sense. Sorry about this.

Greetings,
Wim.

