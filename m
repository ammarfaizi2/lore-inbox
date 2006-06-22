Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751540AbWFVApJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540AbWFVApJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 20:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbWFVApJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 20:45:09 -0400
Received: from xenotime.net ([66.160.160.81]:59061 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751540AbWFVApH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 20:45:07 -0400
Date: Wed, 21 Jun 2006 17:47:54 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: sergio@sergiomb.no-ip.org
Cc: kernel@agotnes.com, akpm@osdl.org, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net,
       linux-usb-devel@lists.sourceforge.net, stern@rowland.harvard.edu,
       cw@f00f.org, vsu@altlinux.ru
Subject: Re: who I do know if a interrupt is ioapic_edge_type or 
 ioapic_level_type? [Was Re: [Fwd: Re: [Linux-usb-users] Fwd: Re:
 2.6.17-rc6-mm2 - USB issues]]
Message-Id: <20060621174754.159bb1d0.rdunlap@xenotime.net>
In-Reply-To: <1150936606.2855.21.camel@localhost.portugal>
References: <44953B4B.9040108@agotnes.com>
	<4497DA3F.80302@agotnes.com>
	<20060620044003.4287426d.akpm@osdl.org>
	<4499245C.8040207@agotnes.com>
	<1150936606.2855.21.camel@localhost.portugal>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 01:36:46 +0100 Sergio Monteiro Basto wrote:

> who I do know if a interrupt is ioapic_edge_type or ioapic_edge_type ? 

Do you mean how they are configured in a running kernel?

cat /proc/interrupts ::

           CPU0       CPU1       
  0:   12412944   12407808    IO-APIC-edge  timer
  1:     122673     124208    IO-APIC-edge  i8042
  7:          0          0    IO-APIC-edge  parport0
  9:          0          0   IO-APIC-level  acpi
 12:    1141950    1138138    IO-APIC-edge  i8042
 14:    1107749    1109102    IO-APIC-edge  ide0
 58:     451498          0         PCI-MSI  eth0
 66:     530689     495356         PCI-MSI  libata
 74:          0          0   IO-APIC-level  ehci_hcd:usb1, uhci_hcd:usb6
 82:         31          3   IO-APIC-level  ohci_hcd:usb2, ohci_hcd:usb3, ohci_hcd:usb4, ohci_hcd:usb5
 90:        561        492   IO-APIC-level  HDA Intel
169:          3          0   IO-APIC-level  ohci1394
177:          0          0   IO-APIC-level  uhci_hcd:usb8
185:          0          0   IO-APIC-level  uhci_hcd:usb7
193:          0          0   IO-APIC-level  uhci_hcd:usb9


or how they should be configured in case you are not sure?
See a hardware spec. for that.


> On Wed, 2006-06-21 at 20:50 +1000, Johny wrote:
> > Success :)
> > 
> > I simply made the change 
> > manually, based on your and others' inputs (it seemed the simpler
> > option).
> > 
> > Both kernels now boot, and all USB devices are recognised correctly.
> > 
> 
> > I run in XT_PIC mode for interrupts.
> > 
> 
> Hi, thanks for your positive test on "my" theory.
> 
> Here it goes the link that I talked about on last email 
> http://lkml.org/lkml/2005/8/18/92 (you can read the previous messages on
> this thread) 
> 
> The patch of this link doesn't compile (at least for me), but have a
> simple idea, which is just quirk the VIA_PCIs if they are in XT_PIC mode
> and I think that is the way of this quirks should go.
> 
> So someone help me out and do a patch that recognize if the interrupt is
> in XT-PIC mode or not ? 
> 
> Thanks,  
> -- 
> Sérgio M. B.
> 


---
~Randy
