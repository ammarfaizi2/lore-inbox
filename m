Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261616AbREOV6s>; Tue, 15 May 2001 17:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261620AbREOV6l>; Tue, 15 May 2001 17:58:41 -0400
Received: from warp9.koschikode.com ([212.84.196.82]:13323 "HELO
	warp9.koschikode.com") by vger.kernel.org with SMTP
	id <S261616AbREOV6b>; Tue, 15 May 2001 17:58:31 -0400
Message-ID: <3B01A67C.757934A2@koschikode.com>
Date: Tue, 15 May 2001 23:58:20 +0200
From: Juri Haberland <juri@koschikode.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-SGI_XFS_1.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3c900 card and kernel 2.4.3
In-Reply-To: <20010504203107.DVQ23593.amsmta01-svc@[192.168.2.1]> <20010514111251.32556.qmail@babel.spoiled.org> <3AFFD5B1.82678220@uow.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Juri Haberland wrote:
> > Do you use 10Base2 (aka cheaper net)?
> > I do and after upgrading to 2.4.3 (I think) I had to force the driver to
> > use the BNC connector though the card was configured (via the little config
> > program supplied by 3com) to always use the BNC connector...
> > This way I lost several hours to figure out why it wasn't working anymore and
> > to discover that I have to build it as a module instead of having it compiled
> > into the kernel because I couldn't make it work with kernel options - only
> > with driver options...
> > Any suggestions?

> For non-modular drivers things are less easy.  If you
> want to force it to use 10baseT (if_port zero) then
> it should work OK if you cheat and use mem_start=0x400.
> So `ether=0,0,0x400'.
> 
> For BNC, it should work just fine with `ether=0,0,1'.
> If it doesn't, please shout at me.   Compile the
> driver with `static int vortex_debug = 7;' at line
> 183 and send me the boot logs.

Hi Andrew,

I tried it with 'ether=0,0,1', 3 and also 7, but to no avail. The output
of dmesg follows.

Thanks,
Juri

Linux version 2.4.4-xfs (root@pktomo.koschikode.com) (gcc version 2.96
20000731
(Red Hat Linux 7.1 2.96-81)) #4 Tue May 15 23:17:53 CEST 2001
[--snip--]
Kernel command line: auto BOOT_IMAGE=linux ro root=305
BOOT_FILE=/boot/vmlinuz hdc=ide-scsi ether=0,0,3
[--snip--]
PCI: Found IRQ 10 for device 00:0f.0
3c59x.c:LK1.1.13 27 Jan 2001  Donald Becker and others.
http://www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
eth0: 3Com PCI 3c900 Cyclone 10Mbps Combo at 0xc800,  00:10:5a:d6:84:df,
IRQ 10
  product code 5050 rev 00.4 date 11-21-98
  Internal config register is 1800000, transceivers 0x38.
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 1809.
  Enabling bus-master transmits and whole-frame receives.
eth0: scatter/gather enabled. h/w checksums enabled
[--snip--]
spurious 8259A interrupt: IRQ7.
eth0:  Filling in the Rx ring.
eth0: using NWAY device table, not 8
eth0: Initial media type Autonegotiate.
vortex_up(): writing 0x1800000 to InternalConfig
eth0: MII #24 status 1809, link partner capability 0000, info1 0010,
setting half-duplex.
eth0: vortex_up() InternalConfig 01800000.
eth0: vortex_up() irq 10 media status 8080.
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 0.
boomerang_interrupt. status=0xe201
eth0: interrupt, status e201, latency 5 ticks.
eth0: In interrupt loop, status e201.
boomerang_interrupt: wake queue
eth0: exiting interrupt, status e000.
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 1.
boomerang_interrupt. status=0xe201
eth0: interrupt, status e201, latency 5 ticks.
eth0: In interrupt loop, status e201.
boomerang_interrupt: wake queue
eth0: exiting interrupt, status e000.
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 2.
boomerang_interrupt. status=0xe201
eth0: interrupt, status e201, latency 4 ticks.
eth0: In interrupt loop, status e201.
boomerang_interrupt: wake queue
eth0: exiting interrupt, status e000.
eth0: Media selection timer tick happened, Autonegotiate.
dev->watchdog_timeo=500
eth0: MII transceiver has status 1809.
eth0: Media selection timer finished, Autonegotiate.
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 3.
boomerang_interrupt. status=0xe201
eth0: interrupt, status e201, latency 5 ticks.
eth0: In interrupt loop, status e201.
boomerang_interrupt: wake queue
eth0: exiting interrupt, status e000.
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 4.
boomerang_interrupt. status=0xe201
eth0: interrupt, status e201, latency 5 ticks.
eth0: In interrupt loop, status e201.
boomerang_interrupt: wake queue
eth0: exiting interrupt, status e000.
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 5.
boomerang_interrupt. status=0xe201
eth0: interrupt, status e201, latency 4 ticks.
eth0: In interrupt loop, status e201.
boomerang_interrupt: wake queue
eth0: exiting interrupt, status e000.
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 6.
boomerang_interrupt. status=0xe201
eth0: interrupt, status e201, latency 6 ticks.
eth0: In interrupt loop, status e201.
boomerang_interrupt: wake queue
eth0: exiting interrupt, status e000.
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 7.
boomerang_interrupt. status=0xe201
eth0: interrupt, status e201, latency 5 ticks.
eth0: In interrupt loop, status e201.
boomerang_interrupt: wake queue
eth0: exiting interrupt, status e000.
boomerang_interrupt. status=0xe081
eth0: interrupt, status e081, latency 4 ticks.
eth0: In interrupt loop, status e081.
eth0: vortex_error(), status=0xe081
eth0: Updating stats.
eth0: exiting interrupt, status e000.
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 8.
boomerang_interrupt. status=0xe201
eth0: interrupt, status e201, latency 5 ticks.
eth0: In interrupt loop, status e201.
boomerang_interrupt: wake queue
eth0: exiting interrupt, status e000.
eth0: Media selection timer tick happened, Autonegotiate.
dev->watchdog_timeo=500
eth0: MII transceiver has status 1809.
eth0: Media selection timer finished, Autonegotiate.
eth0: Media selection timer tick happened, Autonegotiate.
dev->watchdog_timeo=500
eth0: MII transceiver has status 1809.
eth0: Media selection timer finished, Autonegotiate.
eth0: Media selection timer tick happened, Autonegotiate.
dev->watchdog_timeo=500
eth0: MII transceiver has status 1809.
eth0: Media selection timer finished, Autonegotiate.
