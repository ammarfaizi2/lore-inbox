Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278142AbRJLVQe>; Fri, 12 Oct 2001 17:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278143AbRJLVQZ>; Fri, 12 Oct 2001 17:16:25 -0400
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:8252 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S278142AbRJLVQJ>; Fri, 12 Oct 2001 17:16:09 -0400
Date: Fri, 12 Oct 2001 16:15:54 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Greg KH <greg@kroah.com>
cc: Stelian Pop <stelian.pop@fr.alcove.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI device search.
In-Reply-To: <20011012135556.A21296@kroah.com>
Message-ID: <Pine.LNX.3.96.1011012161504.13514A-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2001, Greg KH wrote:
> On Fri, Oct 12, 2001 at 05:04:11PM +0200, Stelian Pop wrote:
> > 	1. Create a PCI driver (pci_device_id, struct pci_driver etc)
> > 	and in init_module call pci_module_init. If it fails,
> > 	assume the driver deals with newer hardware and 
> > 	call 'by hand' the 'probe' routine from pci_driver struct.

> > What is considered to be the best way to do it ?
> > (this is _not_ a hotplug device if it matters).

> I'd say 1.  If a device is hotpluggable or not does not matter.  For
> 2.5, the boot process will be able to load modules for all PCI
> devices seen in the system.  In order for that to happen, they need to
> use the MODULE_DEVICE structure and the 2.4 pci driver subsystem.

I'd say 1.5.  :)  For the "newer hardware" consider using the PCI host
bridge or ISA bridge for your "container" PCI device.

	Jeff



