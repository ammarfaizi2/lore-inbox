Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263434AbUKZWZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263434AbUKZWZq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 17:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263407AbUKZWZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 17:25:26 -0500
Received: from pop.gmx.net ([213.165.64.20]:45012 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263402AbUKZWWN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 17:22:13 -0500
X-Authenticated: #20450766
Date: Fri, 26 Nov 2004 23:21:23 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       Jan Dittmer <jdittmer@ppp0.net>
Subject: Re: [SMP, USB] UHCI interrupt wrongly routed?
In-Reply-To: <Pine.LNX.4.60.0411252233470.2518@poirot.grange>
Message-ID: <Pine.LNX.4.60.0411262317200.2279@poirot.grange>
References: <Pine.LNX.4.60.0411242352370.3896@poirot.grange>
 <20041125012629.GA21569@kroah.com> <Pine.LNX.4.60.0411252233470.2518@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Thu, 25 Nov 2004, Guennadi Liakhovetski wrote:
> On Wed, 24 Nov 2004, Greg KH wrote:
> > On Wed, Nov 24, 2004 at 11:57:15PM +0100, Guennadi Liakhovetski wrote:
> > > 2-way running 2.6.9 the onboard UHCI device is configured to IRQ 9 via 
> > > XT-PIC???
> > > 
> > >            CPU0       CPU1       
> > >   0:     588054        123    IO-APIC-edge  timer
> > >   1:        360          0    IO-APIC-edge  i8042
> > >   2:          0          0          XT-PIC  cascade
> > >   8:          4          0    IO-APIC-edge  rtc
> > >   9:          0          0    IO-APIC-edge  acpi
> > >  11:          0          0          XT-PIC  uhci_hcd
> > >  15:          2          0    IO-APIC-edge  ide1
> > >  16:        173          1   IO-APIC-level  ehci_hcd
> > >  17:          0          0   IO-APIC-level  ohci_hcd
> > >  18:          0          0   IO-APIC-level  ohci_hcd
> > >  19:      99999          1   IO-APIC-level  ohci_hcd
> > >  20:        332          0   IO-APIC-level  eth0
> > >  21:       2576          0   IO-APIC-level  sym53c8xx
> > > NMI:          0          0 
> > > LOC:     587726     587988 
> > > ERR:          0
> > > MIS:          0
> ...
> 
> > > Linux version 2.6.9-rc4-tmscsim (lyakh@poirot.grange) (gcc version 3.3.2 (Debian)) #1 SMP Mon Oct 25 23:38:23 CEST 2004
> > 
> > Can you try 2.6.10-rc2 or the latest -bk snapshot?  Hopefully this is
> > fixed there.
> 
> Unfortunately, the problem is still there with rc2. Do you expect a later 

...

> in (stock) kernel, without quirks? Is my only solution PCI rescan with 
> dummy-php? Or fix acpi table?... I just still don't understand why irq 11 
> is configured as XT-PIC?

fakephp worked out like a charm! Thanks, Jan!

Thanks
Guennadi
---
Guennadi Liakhovetski

