Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276305AbRJPOOJ>; Tue, 16 Oct 2001 10:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276329AbRJPONu>; Tue, 16 Oct 2001 10:13:50 -0400
Received: from jalon.able.es ([212.97.163.2]:37355 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S276305AbRJPONd>;
	Tue, 16 Oct 2001 10:13:33 -0400
Date: Tue, 16 Oct 2001 16:13:23 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Status of ServerWorks UDMA
Message-ID: <20011016161323.A7710@werewolf.able.es>
In-Reply-To: <20011016003812.A28638@werewolf.able.es> <E15tGWg-0003fP-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E15tGWg-0003fP-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Oct 16, 2001 at 00:48:02 +0200
X-Mailer: Balsa 1.2.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20011016 Alan Cox wrote:
>
>Please send me details on the system. lspci -v output too.
>

Here is the info. I CC the list because of the high number of 'unknown devices',
parhaps it is worth a bunch of PCI ids update (kernel is a 2.4.10, still have to
build a .12, perhaps they are updated there...).

I was not completely correct, this mobo is a SuperMicro P3TD6 (it is the front
end, the 370DLE is the one for the cluster nodes...). Specs:

- Chipset: ServerWorks HE-SL
- AGP 2x Pro, say the specs...
- On board Intel 82559 Ethernet (not recognised)
- Onboard Adaptec AIC-7899W (7902 future option) dual channel
	Ultra160 (320) SCSI controller
- Dual Ultra DMA (UDMA/33) bus master/EIDE  channels
- Dual USB (Universal Serial Bus) port
- Ethernet 3Com 905C-TX card
- Ehternet 3Com 980TX (not recognised in .10 bu present in .12-ac3 pci.ids
- Creative GeForce3 (not recognised)

lspci -v
00:00.0 Host bridge: ServerWorks CNB20HE (rev 23)
	Flags: fast devsel
	Memory at e8000000 (32-bit, prefetchable) [disabled] [size=128M]
	Memory at e7fff000 (32-bit, non-prefetchable) [disabled] [size=4K]

00:00.1 PCI bridge: ServerWorks CNB20HE (rev 01) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fc500000-fe5fffff
	Prefetchable memory behind bridge: f4100000-fc2fffff
	Capabilities: [80] AGP version 2.0

00:00.2 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
	Flags: medium devsel

00:00.3 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
	Flags: medium devsel

00:01.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
	Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
	Flags: bus master, slow devsel, latency 64, IRQ 16
	I/O ports at df00 [size=64]
	Capabilities: [dc] Power Management version 1

00:03.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 74)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Flags: bus master, medium devsel, latency 64, IRQ 20
	I/O ports at dc00 [size=128]
	Memory at feafb800 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at fea60000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2

00:05.0 SCSI storage controller: Adaptec 7899P (rev 01)
	Subsystem: Unknown device 9d15:0001
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 26
	BIST result: 00
	I/O ports at d000 [disabled] [size=256]
	Memory at feafc000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at feaa0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2

00:05.1 SCSI storage controller: Adaptec 7899P (rev 01)
	Subsystem: Unknown device 9d15:0001
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 27
	BIST result: 00
	I/O ports at d800 [disabled] [size=256]
	Memory at feaff000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at feac0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2

00:06.0 Ethernet controller: Intel Corporation: Unknown device 2449 (rev 08)
	Subsystem: Intel Corporation: Unknown device 100c
	Flags: bus master, medium devsel, latency 64, IRQ 31
	Memory at feafd000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at d400 [size=64]
	Memory at fe900000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at fe800000 [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2

00:0f.0 ISA bridge: ServerWorks OSB4 (rev 50)
	Subsystem: ServerWorks OSB4
	Flags: bus master, medium devsel, latency 0

00:0f.1 IDE interface: ServerWorks: Unknown device 0211 (prog-if 8a [Master SecP PriP])
	Flags: bus master, medium devsel, latency 64
	I/O ports at ffa0 [size=16]

00:0f.2 USB Controller: ServerWorks: Unknown device 0220 (rev 04) (prog-if 10 [OHCI])
	Subsystem: ServerWorks: Unknown device 0220
	Flags: bus master, medium devsel, latency 64, IRQ 10
	Memory at feafe000 (32-bit, non-prefetchable) [size=4K]

01:00.0 VGA compatible controller: nVidia Corporation: Unknown device 0200 (rev a3) (prog-if 00 [VGA])
	Subsystem: Micro-star International Co Ltd: Unknown device 8822
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 30
	Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Memory at fc280000 (32-bit, prefetchable) [size=512K]
	Expansion ROM at fe5f0000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
	Capabilities: [44] AGP version 2.0

02:02.0 Ethernet controller: 3Com Corporation: Unknown device 9805 (rev 78)
	Subsystem: 3Com Corporation: Unknown device 1000
	Flags: bus master, medium devsel, latency 64, IRQ 24
	I/O ports at ec00 [size=128]
	Memory at febffc00 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at febc0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2

cat /proc/ide/ide0/config
pci bus 00 device 79 vid 1166 did 0211 channel 0
66 11 11 02 05 00 00 02 00 8a 01 01 00 40 80 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a1 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5d 20 5d 22 00 00 00 00 08 08 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

cat /proc/ide/ide1/config
pci bus 00 device 79 vid 1166 did 0211 channel 1
66 11 11 02 05 00 00 02 00 8a 01 01 00 40 80 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a1 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5d 20 5d 22 00 00 00 00 08 08 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.12-ac3-beo #2 SMP Tue Oct 16 01:08:46 CEST 2001 i686
