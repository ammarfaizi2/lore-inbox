Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270919AbTGPPgm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 11:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270923AbTGPPgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 11:36:42 -0400
Received: from lakemtao01.cox.net ([68.1.17.244]:15832 "EHLO
	lakemtao01.cox.net") by vger.kernel.org with ESMTP id S270919AbTGPPge
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 11:36:34 -0400
Date: Wed, 16 Jul 2003 11:51:56 -0400
From: Wil Reichert <wilreichert@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6.0-test1 snd-ice1724 module OOPS
Message-Id: <20030716115156.2b5a1992.wilreichert@yahoo.com>
Organization: NA
X-Mailer: Sylpheed version 0.9.3claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following OOPS when loading the snd-ice1724 module for my Envy 24HT card.  Works fine if I build all the alsa code straight into the kernel.

Wil


Unable to handle kernel paging request at virtual address e4b11000
e4b11000
*pde = 1fe3a067
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<e4b11000>]    Tainted: P  
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: fffffff4   ebx: deb2ce14   ecx: ddc18e8c   edx: deb2ce0c
esi: deb2c018   edi: df19d04f   ebp: dd993e74   esp: dd993e54
ds: 007b   es: 007b   ss: 0068
Stack: e4b0500a deb2ce14 e4b056c0 e4b05760 deb2c018 e4b2cd60 e4b05880 e4b2979d 
       dd993eb4 e4b04e8e deb2c018 c15e0800 dd993ea4 00000000 00000000 dd993eac 
       c017a8a2 dd993e9c df19d038 df19d014 deb2c018 e4b2cd60 ffffffed c15e0800 
Call Trace:
 [<e4b0500a>] revo_init+0x8a/0x130 [snd_ice1724]
 [<e4b04e8e>] snd_vt1724_probe+0x28e/0x2c0 [snd_ice1724]
 [<c017a8a2>] sysfs_new_inode+0x62/0xb0
 [<c01d242b>] pci_device_probe_static+0x4b/0x60
 [<c01d258c>] __pci_device_probe+0x3c/0x50
 [<c01d25cf>] pci_device_probe+0x2f/0x50
 [<c0207413>] bus_match+0x43/0x70
 [<c020751d>] driver_attach+0x5d/0x70
 [<c02077af>] bus_add_driver+0x8f/0xb0
 [<c0207c11>] driver_register+0x31/0x40
 [<c01d289f>] pci_register_driver+0x6f/0xa0
 [<e4b04ed5>] alsa_card_ice1724_init+0x15/0x50 [snd_ice1724]
 [<c012ecd8>] sys_init_module+0x108/0x220
 [<c010923f>] syscall_call+0x7/0xb
Code:  Bad EIP value.


>>EIP; e4b11000 <__crc_d_find_alias+9699e/32742c>   <=====

>>eax; fffffff4 <__kernel_rt_sigreturn+1bb4/????>
>>ebx; deb2ce14 <__crc_totalram_pages+1f6d5a/218da2>
>>ecx; ddc18e8c <__crc_ide_build_dmatable+151146/6d7e01>
>>edx; deb2ce0c <__crc_totalram_pages+1f6d52/218da2>
>>esi; deb2c018 <__crc_totalram_pages+1f5f5e/218da2>
>>edi; df19d04f <__crc_pci_dev_driver+166363/34a945>
>>ebp; dd993e74 <__crc_notify_parent+68ab4/19c986>
>>esp; dd993e54 <__crc_notify_parent+68a94/19c986>

Trace; e4b0500a <__crc_d_find_alias+8a9a8/32742c>
Trace; e4b04e8e <__crc_d_find_alias+8a82c/32742c>
Trace; c017a8a2 <sysfs_new_inode+62/b0>
Trace; c01d242b <pci_device_probe_static+4b/60>
Trace; c01d258c <__pci_device_probe+3c/50>
Trace; c01d25cf <pci_device_probe+2f/50>
Trace; c0207413 <bus_match+43/70>
Trace; c020751d <driver_attach+5d/70>
Trace; c02077af <bus_add_driver+8f/b0>
Trace; c0207c11 <driver_register+31/40>
Trace; c01d289f <pci_register_driver+6f/a0>
Trace; e4b04ed5 <__crc_d_find_alias+8a873/32742c>
Trace; c012ecd8 <sys_init_module+108/220>
Trace; c010923f <syscall_call+7/b>



Linux darwin.goathorde.org 2.6.0-test1 #1 Mon Jul 14 12:49:48 EDT 2003 i686 GNU/Linux
 
Gnu C                  3.3.1
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
e2fsprogs              1.34-WIP
xfsprogs               2.5.3
quota-tools            3.09.
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.9
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
Modules Loaded         snd_ice1724 snd_ice17xx_ak4xxx snd_ac97_codec snd_pcm snd_page_alloc snd_timer snd_ak4xxx_adda snd_mpu401_uart snd_rawmidi snd soundcore nls_iso8859_1 nls_cp437 dm_mod w83781d i2c_sensor i2c_core



00:00.0 Host bridge: nVidia Corporation: Unknown device 01e0 (rev c1)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at c0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: <available only to root>

00:00.1 RAM memory: nVidia Corporation: Unknown device 01eb (rev c1)
	Subsystem: nVidia Corporation: Unknown device 0c17
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.2 RAM memory: nVidia Corporation: Unknown device 01ee (rev c1)
	Subsystem: nVidia Corporation: Unknown device 0c17
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.3 RAM memory: nVidia Corporation: Unknown device 01ed (rev c1)
	Subsystem: nVidia Corporation: Unknown device 0c17
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.4 RAM memory: nVidia Corporation: Unknown device 01ec (rev c1)
	Subsystem: nVidia Corporation: Unknown device 0c17
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.5 RAM memory: nVidia Corporation: Unknown device 01ef (rev c1)
	Subsystem: nVidia Corporation: Unknown device 0c17
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
	Subsystem: nVidia Corporation: Unknown device 0c11
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: <available only to root>

00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
	Subsystem: nVidia Corporation: Unknown device 0c11
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at dc00 [size=32]
	Capabilities: <available only to root>

00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) (prog-if 10 [OHCI])
	Subsystem: nVidia Corporation: Unknown device 0c11
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at dd083000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) (prog-if 10 [OHCI])
	Subsystem: nVidia Corporation: Unknown device 0c11
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin B routed to IRQ 4
	Region 0: Memory at dd081000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) (prog-if 20 [EHCI])
	Subsystem: nVidia Corporation: Unknown device 0c11
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin C routed to IRQ 3
	Region 0: Memory at dd082000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

00:05.0 Multimedia audio controller: nVidia Corporation nForce MultiMedia audio [Via VT82C686B] (rev a2)
	Subsystem: nVidia Corporation: Unknown device 0c11
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (250ns min, 3000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at dd000000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: <available only to root>

00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio Controler (MCP) (rev a1)
	Subsystem: nVidia Corporation: Unknown device 4144
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (500ns min, 1250ns max)
	Interrupt: pin A routed to IRQ 7
	Region 0: I/O ports at e000 [size=256]
	Region 1: I/O ports at d000 [size=128]
	Region 2: Memory at dd084000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

00:08.0 PCI bridge: nVidia Corporation: Unknown device 006c (rev a3) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 00009000-0000bfff
	Memory behind bridge: db000000-dcffffff
	Prefetchable memory behind bridge: d8000000-d8ffffff
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) (prog-if 8a [Master SecP PriP])
	Subsystem: nVidia Corporation: Unknown device 0c11
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Region 4: I/O ports at f000 [size=16]
	Capabilities: <available only to root>

00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: d9000000-daffffff
	Prefetchable memory behind bridge: d0000000-d7ffffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

01:07.0 Multimedia audio controller: IC Ensemble Inc ICE1724 [Envy24HT] (rev 01)
	Subsystem: IC Ensemble Inc: Unknown device 3630
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 9000 [size=32]
	Region 1: I/O ports at 9400 [size=128]
	Capabilities: <available only to root>

01:08.0 Network controller: Harris Semiconductor Prism 2.5 Wavelan chipset (rev 01)
	Subsystem: Netgear: Unknown device 4105
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 12
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=4K]
	Capabilities: <available only to root>

01:09.0 Unknown mass storage controller: Promise Technology, Inc. 20269 (rev 02) (prog-if 85)
	Subsystem: Promise Technology, Inc.: Unknown device 4d68
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 4500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 9800 [size=8]
	Region 1: I/O ports at 9c00 [size=4]
	Region 2: I/O ports at a000 [size=8]
	Region 3: I/O ports at a400 [size=4]
	Region 4: I/O ports at a800 [size=16]
	Region 5: Memory at dc000000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at <unassigned> [disabled] [size=16K]
	Capabilities: <available only to root>

01:0b.0 RAID bus controller: Triones Technologies, Inc. HPT372A (rev 02)
	Subsystem: Triones Technologies, Inc.: Unknown device 0001
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 120 (2000ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at ac00 [size=8]
	Region 1: I/O ports at b000 [size=4]
	Region 2: I/O ports at b400 [size=8]
	Region 3: I/O ports at b800 [size=4]
	Region 4: I/O ports at bc00 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>

02:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 If [Radeon 9000] (rev 01) (prog-if 00 [VGA])
	Subsystem: C.P. Technology Co. Ltd R250 If [Radeon 9000 Pro "Evil Commando"]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Region 1: I/O ports at c000 [size=256]
	Region 2: Memory at da000000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>

02:00.1 Display controller: ATI Technologies Inc Radeon R250 [Radeon 9000] (Secondary) (rev 01)
	Subsystem: C.P. Technology Co. Ltd: Unknown device 2038
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 0: Memory at d4000000 (32-bit, prefetchable) [disabled] [size=64M]
	Region 1: Memory at da010000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Capabilities: <available only to root>


