Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313501AbSDYWQC>; Thu, 25 Apr 2002 18:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313504AbSDYWQB>; Thu, 25 Apr 2002 18:16:01 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:35293 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S313501AbSDYWQB>;
	Thu, 25 Apr 2002 18:16:01 -0400
Date: Fri, 26 Apr 2002 08:15:19 +1000
From: Anton Blanchard <anton@samba.org>
To: Santiago Garcia Mantinan <manty@manty.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pcnet32 on 2.4.18 doesn't init on IBM rs/6000 B50 (powerpc)
Message-ID: <20020425221519.GA13245@krispykreme>
In-Reply-To: <20020425220402.GA3654@man.beta.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> I've been playing around with one of this machines and trying to get the net
> to work seems quite difficult because the driver doesn't want to init the
> card well, when you do a modprobe you get this:
> 
> riazor:~# modprobe pcnet32
> pcnet32_probe_pci: found device 0x001022.0x002000
> PCI: Enabling device 00:0c.0 (0140 -> 0143)
>     ioaddr=0xbff400  resource_flags=0x000101
> /lib/modules/2.4.18/kernel/drivers/net/pcnet32.o: init_module: No such
> device
> Hint: insmod errors can be caused by incorrect module parameters, including
> invalid IO or IRQ parameters
> /lib/modules/2.4.18/kernel/drivers/net/pcnet32.o: insmod
> /lib/modules/2.4.18/kernel/drivers/net/pcnet32.o failed
> /lib/modules/2.4.18/kernel/drivers/net/pcnet32.o: insmod pcnet32 failed

Can you try something newer (eg 2.4.19-pre7)? There have been a number
of changes to the pcnet32 driver, one of them (from Paul Mackerras)
should fix your problem.

Anton
