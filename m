Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263761AbUGYJUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbUGYJUt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 05:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263769AbUGYJUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 05:20:49 -0400
Received: from pop.gmx.de ([213.165.64.20]:5339 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263761AbUGYJUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 05:20:46 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: SiS900: NULL pointer encountered in Rx ring, skipping
Date: Sun, 25 Jul 2004 11:21:03 +0200
User-Agent: KMail/1.6.2
Cc: Daniele Venzano <webvenza@libero.it>
References: <200407232052.06616.dominik.karall@gmx.net>
In-Reply-To: <200407232052.06616.dominik.karall@gmx.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200407251121.04975.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After doing some changes in the /proc/sys/, it works now without problems!
My settings:

net.ipv4.tcp_keepalive_time=3600
net.ipv4.tcp_rmem=4096 25165824 25165824
net.core.rmem_max=25165824
net.core.rmem_default=25165824
net.ipv4.tcp_wmem=4096 65536 25165824
net.core.wmem_max=25165824
net.core.wmem_default=65536
net.core.optmem_max=25165824

________
dominik


On Friday 23 July 2004 20:52, Dominik Karall wrote:
> After a few hours my network doesn't work on my laptop. There appear a lot
> of those messages:
>
> eth0: NULL pointer encountered in Rx ring, skipping
> eth0: NULL pointer encountered in Rx ring, skipping
> eth0: NULL pointer encountered in Rx ring, skipping
> eth0: NULL pointer encountered in Rx ring, skipping
> eth0: NULL pointer encountered in Rx ring, skipping
> eth0: NULL pointer encountered in Rx ring, skipping
> eth0: NULL pointer encountered in Rx ring, skipping
> eth0: NULL pointer encountered in Rx ring, skipping
> eth0: NULL pointer encountered in Rx ring, skipping
> eth0: NULL pointer encountered in Rx ring, skipping
>
> It works again after restarting network. I'm using 2.6.8-rc2 now. It was
> the same problem in 2.6.7, but I didn't test it with earlier kernels.
>
> And right now I got one more eth0 message:
> eth0: Too much work at interrupt, interrupt status = 0x00000031.
> eth0: Too much work at interrupt, interrupt status = 0x00000001.
>
> Here the messages after module loading:
> eth0: SiS 900 Internal MII PHY transceiver found at address 1.
> eth0: Using transceiver found at address 1 as default
> eth0: SiS 900 PCI Fast Ethernet at 0xd000, IRQ 9, 00:a0:cf:c0:8a:dc.
> eth0: Media Link On 100mbps full-duplex
> eth0: Memory squeeze,deferring packet.
>
> lspci:
> 0000:00:01.1 Ethernet controller: Silicon Integrated Systems [SiS] SiS900
> PCI Fast Ethernet (rev 80)
>         Subsystem: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet
> Adapter
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (13000ns min, 2750ns max)
>         Interrupt: pin C routed to IRQ 9
>         Region 0: I/O ports at d000 [size=ffda0000]
>         Region 1: Memory at ffdc0000 (32-bit, non-prefetchable) [size=4K]
>         Expansion ROM at 00020000 [disabled]
>         Capabilities: [40] Power Management version 1
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> ____________
> dominik
