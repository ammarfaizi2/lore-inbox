Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbVJCFF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbVJCFF7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 01:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbVJCFF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 01:05:58 -0400
Received: from smtpout1.uol.com.br ([200.221.4.192]:30594 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S1750783AbVJCFF5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 01:05:57 -0400
Date: Mon, 3 Oct 2005 02:05:55 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: vherva@vianova.fi, linux-kernel@vger.kernel.org
Subject: Re: Strange disk corruption with Linux >= 2.6.13
Message-ID: <20051003050555.GC5576@ime.usp.br>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>, vherva@vianova.fi,
	linux-kernel@vger.kernel.org
References: <20050927111038.GA22172@ime.usp.br> <20050928084330.GC24760@viasys.com> <1127949809.26686.14.camel@localhost.localdomain> <20050929062937.GY24719@viasys.com> <1128010484.5774.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1128010484.5774.13.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 29 2005, Alan Cox wrote:
> Some fixes went in early 2.4 and they got refined later on. See the
> function quirk_vialatency). There is a brief summary at the first URL
> listed still. Essentially the chip has a flaw where it can lose a
> transfer.
> 
> If people see this behaviour on a KT133 can you please check the quirk
> is being run and displaying
> 
>    printk(KERN_INFO "Applying VIA southbridge workaround.\n");

Just as an information, I get the following messages on my system:

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
rbrito@dumont:~$ dmesg | grep -i via
Disabling VIA memory write queue (PCI ID 0305, rev 02): [55] 89 & 1f -> 09
PCI: Disabling Via external APIC routing
agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
parport_pc: VIA 686A/8231 detected
parport_pc: VIA parallel port: io=0x378, irq=7
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci0000:00:04.1
Netfilter messages via NETLINK v0.30.
rbrito@dumont:~$ dmesg | grep -i memor
Memory: 775776k/786352k available (1847k kernel code, 10076k reserved, 733k data, 148k init, 0k highmem)
Disabling VIA memory write queue (PCI ID 0305, rev 02): [55] 89 & 1f -> 09
Non-volatile memory driver v1.2
Freeing unused kernel memory: 148k freed
rbrito@dumont:~$
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Is this what is supposed to appear when one is using a 2.6.1x kernel?


Thanks for any hints, Rogério Brito.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
