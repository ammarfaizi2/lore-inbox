Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262961AbUKYDvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262961AbUKYDvo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 22:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbUKYDuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 22:50:22 -0500
Received: from zeus.kernel.org ([204.152.189.113]:52406 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262962AbUKYDte (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 22:49:34 -0500
Date: Wed, 24 Nov 2004 17:26:29 -0800
From: Greg KH <greg@kroah.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [SMP, USB] UHCI interrupt wrongly routed?
Message-ID: <20041125012629.GA21569@kroah.com>
References: <Pine.LNX.4.60.0411242352370.3896@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0411242352370.3896@poirot.grange>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2004 at 11:57:15PM +0100, Guennadi Liakhovetski wrote:
> Hello
> 
> I guess, it is not a USB problem, really, it just appeared with USB. On a 
> 2-way running 2.6.9 the onboard UHCI device is configured to IRQ 9 via 
> XT-PIC???
> 
>            CPU0       CPU1       
>   0:     588054        123    IO-APIC-edge  timer
>   1:        360          0    IO-APIC-edge  i8042
>   2:          0          0          XT-PIC  cascade
>   8:          4          0    IO-APIC-edge  rtc
>   9:          0          0    IO-APIC-edge  acpi
>  11:          0          0          XT-PIC  uhci_hcd
>  15:          2          0    IO-APIC-edge  ide1
>  16:        173          1   IO-APIC-level  ehci_hcd
>  17:          0          0   IO-APIC-level  ohci_hcd
>  18:          0          0   IO-APIC-level  ohci_hcd
>  19:      99999          1   IO-APIC-level  ohci_hcd
>  20:        332          0   IO-APIC-level  eth0
>  21:       2576          0   IO-APIC-level  sym53c8xx
> NMI:          0          0 
> LOC:     587726     587988 
> ERR:          0
> MIS:          0
> 
> Non-surprisingly, it doesn't work. Below is a complete dmesg (I first 
> connected the card-reader to an ohci / ehci PCI board, and then 
> re-connected it to an on-board UHCI port.
> 
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski
> 
> Linux version 2.6.9-rc4-tmscsim (lyakh@poirot.grange) (gcc version 3.3.2 (Debian)) #1 SMP Mon Oct 25 23:38:23 CEST 2004

Can you try 2.6.10-rc2 or the latest -bk snapshot?  Hopefully this is
fixed there.

thanks,

greg k-h
