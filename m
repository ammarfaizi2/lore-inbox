Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135306AbRD1PoJ>; Sat, 28 Apr 2001 11:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135325AbRD1PoA>; Sat, 28 Apr 2001 11:44:00 -0400
Received: from d141-223-202.home.cgocable.net ([24.141.223.202]:34986 "HELO
	localhost.localdomain") by vger.kernel.org with SMTP
	id <S135306AbRD1Pns>; Sat, 28 Apr 2001 11:43:48 -0400
Date: Sat, 28 Apr 2001 11:44:58 -0400 (EDT)
From: Garett Spencley <gspen@home.com>
To: Michael F Gordon <Michael.Gordon@ee.ed.ac.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4 breaks dhcpcd with Realtek 8139
In-Reply-To: <200104281530.f3SFU4Y09756@hop2-ee-net2.ee.ed.ac.uk>
Message-ID: <Pine.LNX.4.30.0104281142520.3423-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Apr 2001, Michael F Gordon wrote:

> dhcpcd stops working if I install 2.4.4.  Replacing the 2.4.4 version of
> 8139too.c with the 2.4.3 version and leaving everything else exactly
> the same gets things working again.  Configuring the interface by hand
> after dhcpcd has timed out also works.  Has anyone else seen this?

I noticed this in 2.4.3-acX series as well. But here's the funny part:
When dhcp starts up during bootup it doesn't work. But as
soon as I log in and do a su -c '/etc/rc.d/init.d/network restart' there's
instant success!

This is on Mandrake 8.0

It doesn't make much sense to me.

--
Garett

> ISC
DHCP 2.0, kernel compiled with gcc 2.95.2 >
> lspci:
>   00:12.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 8139 (rev 10)
>
> Boot messages with 2.4.3 version:
>   8139too Fast Ethernet driver 0.9.15c loaded
>   PCI: Found IRQ 5 for device 00:12.0
>   eth0: RealTek RTL8139 Fast Ethernet at 0xc9804f00, 00:10:a7:05:8e:da, IRQ 5
>   eth0:  Identified 8139 chip type 'RTL-8139C'
>
> Boot messages with 2.4.4 version:
>   8139too Fast Ethernet driver 0.9.16
>   PCI: Found IRQ 5 for device 00:12.0
>   eth0: RealTek RTL8139 Fast Ethernet at 0xc9804f00, 00:10:a7:05:8e:da, IRQ 5
>   eth0:  Identified 8139 chip type 'RTL-8139C'
>
>
>
> Michael Gordon
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

