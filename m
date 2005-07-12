Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262332AbVGLEAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262332AbVGLEAe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 00:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbVGLEAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 00:00:34 -0400
Received: from li4-142.members.linode.com ([66.220.1.142]:40974 "EHLO
	li4-142.members.linode.com") by vger.kernel.org with ESMTP
	id S262332AbVGLD7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 23:59:35 -0400
Date: Mon, 11 Jul 2005 23:59:33 -0400
From: Michael B Allen <mba2000@ioplex.com>
To: Jar <jar@pcuf.fi>
Cc: linux-kernel@vger.kernel.org, linux-thinkpad@linux-thinkpad.org
Subject: Re: [SOLVED] Prism 2.5 MiniPCI Wireless Unstable
Message-Id: <20050711235933.17a560a8.mba2000@ioplex.com>
In-Reply-To: <42D2F6DC.2090405@pcuf.fi>
References: <1108.192.168.0.150.1121089967.squirrel@kone>
	<1118.192.168.0.150.1121090918.squirrel@kone>
	<20050711174359.6de1f4df.mba2000@ioplex.com>
	<42D2F6DC.2090405@pcuf.fi>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My Thinkpad T30 "Intel" wireless now works perfectly after switching to the hostap_pci driver and updating the primary and station firmware (pk010101.hex and sf010804.hex respectively) on the MiniPCI card using the WinUpdate program (I dual boot Win2K) as described in the below link.

I re-ran my rsync test and it completed without error at a smooth 550Kbps from two floors up.

Thanks,
Mike

hostap_pci: Registered netdevice wifi0
wifi0: NIC: id=0x8013 v1.0.0
wifi0: PRI: id=0x15 v1.1.1
wifi0: STA: id=0x1f v1.8.4
wifi0: Intersil Prism2.5 PCI: mem=0xf8000000, irq=11

On Tue, 12 Jul 2005 01:46:52 +0300
Jar <jar@pcuf.fi> wrote:

> Michael B Allen wrote:
> > hostap_pci: 0.3.9 - 2005-06-10 (Jouni Malinen <jkmaline@cc.hut.fi>)
> > ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 11 (level, low) -> IRQ 11
> > hostap_pci: Registered netdevice wifi0
> > wifi0: NIC: id=0x8013 v1.0.0
> > wifi0: PRI: id=0x15 v1.1.0
> > wifi0: STA: id=0x1f v1.4.9
> > wifi0: Intersil Prism2.5 PCI: mem=0xf8000000, irq=11
> 
> Maybe you should try to update the firmwares, that is all you can do at 
> this point. For me the 1.1.1/1.7.4 combination has been worked like a 
> charm, also when used in heavy load. I belive the driver itself is 
> stable (the PCI prism2.5 card never timed out for me). So there has to 
> be hardware/firmware problem somewhere.
> 
> PRI: id=0x15 v1.1.0 --> v1.1.1
> STA: id=0x1f v1.4.9 --> v1.7.4
> 
> The Flashing HOWTO: http://linux.junsun.net/intersil-prism/
> The firmware collection: http://www.red-bean.com/~proski/firmware/
> 
> You can try the RAM (volatile) firmawares first and if it helps you can 
> flash the non volatile versions (Flash) if you want. Newer flash primary 
> firmware alone, but primary and station firmwares simultaneously. The 
> filenames (if I remember correctly) are:
> 
> ak010104.hex (RAM PRI:1.1.4)
> rf010704.hex (RAM STA:1.7.4)
> 
> pk010101.hex (Flash PRI:1.1.1)
> sf010704.hex (Flash STA:1.7.4)
> 
> There is also newer verisons available:
> 
> The latest firmwares in the collection are:
> 
>                              RAM           Flash
> Prism 2      PCMCIA         1.7.1         1.7.1
> Prism 2.5/3  PCI/PCMCIA     1.8.4 (NEW!)  1.8.4
> Prism 3      USB            1.8.3         1.8.4
> 
> -- 
> Best Regards, Jar
> 
