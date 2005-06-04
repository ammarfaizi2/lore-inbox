Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVFDQQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVFDQQh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 12:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbVFDQQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 12:16:37 -0400
Received: from umbar.esa.informatik.tu-darmstadt.de ([130.83.163.30]:54400
	"EHLO umbar.esa.informatik.tu-darmstadt.de") by vger.kernel.org
	with ESMTP id S261360AbVFDQQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 12:16:35 -0400
Date: Sat, 4 Jun 2005 18:16:33 +0200
From: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>
To: Greg KH <gregkh@suse.de>
Cc: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
Message-ID: <20050604161633.GB14384@erebor.esa.informatik.tu-darmstadt.de>
References: <20050603232828.GA29860@erebor.esa.informatik.tu-darmstadt.de> <20050604064627.GB13238@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050604064627.GB13238@suse.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 11:46:27PM -0700, Greg KH wrote:
> On Sat, Jun 04, 2005 at 01:28:28AM +0200, Andreas Koch wrote:
> > Specifically, this occurs on my Acer Travelmate 8100 notebook (Pentium
> > M, Intel 915M chipset) when it is connected via PCI Express to the
> > ezDock docking station.
> 
> Are you connecting it at boot time, or after the box is up and running?

The dock is already connected at power-up time.

> Hm, another idea, can you load the pci express and standard pci hotplug
> drivers?  You might have to "enable" those slots in order for the pci
> core to scan the devices and set everything up properly.  
> 
> To do this, after loading the modules (pciehp and shpchp), look in
> /sys/bus/pci/slots/

I have already experimented with compiled-in versions of these drivers
(as well as the ACPI PCI hotplug driver).

> 
> If there are any "slots" listed there, go into those directories and
> "power them on" by simply writing a "1" to the file 'power' by using
> echo.
> 
> Let us know if that helps out any or not.

I have /sys/bus/pci/slots/, but it is empty. Should I make another
attempt with driver modules instead of the compiled in versions?

> 
> Oh, and this isn't "PCI ExpressCard" type hardware is it (next
> generation pcmcia/cardbus evolution.)

Actually, the dock itself has a PCI ExpressCard slot (currently
empty) as one of its peripherals. But my current difficulties are
with the PCI-Express connection between notebook and dock.

Andreas
