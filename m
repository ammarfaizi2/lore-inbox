Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262911AbSJBBTn>; Tue, 1 Oct 2002 21:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262901AbSJBBTn>; Tue, 1 Oct 2002 21:19:43 -0400
Received: from cliff.cse.wustl.edu ([128.252.166.5]:60097 "EHLO
	cliff.cse.wustl.edu") by vger.kernel.org with ESMTP
	id <S262917AbSJBBTf> convert rfc822-to-8bit; Tue, 1 Oct 2002 21:19:35 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <15770.19197.730535.272727@samba.doc.wustl.edu>
Date: Tue, 1 Oct 2002 20:25:17 -0500
From: Krishnakumar B <kitty@cse.wustl.edu>
To: linux-kernel@vger.kernel.org
Subject: Multiple OOPS with Linux-2.5.40
X-Mailer: VM 7.07 under Emacs 21.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get the following oopsen with Linux-2.5.40 (using kksymoops). There is no
lockup and I am able to send this mail.

-kitty.


CPU0<T0:132976,T1:128944,D:3,S:4029,C:132976>
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
cpu: 1, clocks: 132976, slice: 4029
CPU1<T0:132976,T1:124912,D:6,S:4029,C:132976>
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
bad: scheduling while atomic!
c1531ee8 c0118203 c0261260 00000000 00000000 00000000 c1530000 c1531f88 
       c1530000 c1531f68 c011857d c0271c95 0000048e 00000000 c152f060 c0118260 
       00000000 00000000 c1531f58 c01175f2 c152f060 00000001 c152f060 c0118260 
Call Trace:
 [<c0118203>]schedule+0x343/0x350
 [<c011857d>]wait_for_completion+0xbd/0x120
 [<c0118260>]default_wake_function+0x0/0x40
 [<c01175f2>]try_to_wake_up+0x142/0x190
 [<c0118260>]default_wake_function+0x0/0x40
 [<c01198d6>]set_cpus_allowed+0xf6/0x110
 [<c0119945>]migration_thread+0x55/0x310
 [<c0107a19>]ret_from_fork+0x5/0x14
 [<c01198f0>]migration_thread+0x0/0x310
 [<c01198f0>]migration_thread+0x0/0x310
 [<c0105665>]kernel_thread_helper+0x5/0x10

bad: scheduling while atomic!
c152df08 c0118203 c0261260 00000000 00000000 00000000 c152c000 c152dfa8 
       c152c000 c152df88 c011857d c0271c95 0000048e 00000000 c152f780 c0118260 
       00000000 00000000 c152df78 c01175f2 c152f780 00000001 c152f780 c0118260 
Call Trace:
 [<c0118203>]schedule+0x343/0x350
 [<c011857d>]wait_for_completion+0xbd/0x120
 [<c0118260>]default_wake_function+0x0/0x40
 [<c01175f2>]try_to_wake_up+0x142/0x190
 [<c0118260>]default_wake_function+0x0/0x40
 [<c01198d6>]set_cpus_allowed+0xf6/0x110
 [<c0123520>]ksoftirqd+0x60/0x130
 [<c01234c0>]ksoftirqd+0x0/0x130
 [<c0105665>]kernel_thread_helper+0x5/0x10

CPUS done 4294967295

...


hda: WDC WD200BB-75AUA1, ATA DISK drive
hdb: WDC WD200BB-75AUA1, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Lite-On LTN483S 48x Max, ATAPI CD/DVD-ROM drive
Debug: sleeping function called from illegal context at slab.c:1374
c153de70 c013d090 c02629f4 0000055e c0385ed4 c0385f0c c0385ed4 00000000 
       c01d7925 dfdadb30 000001d0 0000000f c0385f24 c0385ed4 c0385ec4 c0385e18 
       00000000 c01d79db c0385ed4 c011524f 0000000f c02e09e0 00000046 c02e09e0 
Call Trace:
 [<c013d090>]__kmem_cache_alloc+0x180/0x190
 [<c01d7925>]blk_init_free_list+0x65/0x100
 [<c01d79db>]blk_init_queue+0x1b/0x120
 [<c011524f>]startup_edge_ioapic_irq+0x6f/0x90
 [<c010a46c>]setup_irq+0xbc/0xf0
 [<c01e54b0>]ide_intr+0x0/0x1d0
 [<c01dd409>]ide_init_queue+0x39/0xa0
 [<c01e50d0>]do_ide_request+0x0/0x30
 [<c01dd655>]init_irq+0x1e5/0x3c0
 [<c01e54b0>]ide_intr+0x0/0x1d0
 [<c01ddad8>]hwif_init+0xd8/0x270
 [<c01dd2f4>]probe_hwif_init+0x24/0x70
 [<c01ecf6f>]ide_setup_pci_device+0x6f/0x80
 [<c01dc686>]piix_init_one+0x36/0x40
 [<c0105094>]init+0x54/0x180
 [<c0105040>]init+0x0/0x180
 [<c0105665>]kernel_thread_helper+0x5/0x10

ide1 at 0x170-0x177,0x376 on irq 15

...

PCI: Setting latency timer of device 00:1f.2 to 64
hcd-pci.c: uhci-hcd @ 00:1f.2, Intel Corp. 82801AA USB
hcd-pci.c: irq 19, io base 0000ff80
hcd.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found at 0
hub.c: 2 ports detected
Debug: sleeping function called from illegal context at /u/scratch/downloads/kernel/linux-2.5.40/include/asm/semaphore.h:119
df675f70 e2886692 e28926c0 00000077 df675fa8 df808760 df664f88 df66e0d0 
       df674000 dfb36100 00000286 df674000 df674000 df675fc0 df674000 e28869f5 
       dfa1b860 dfb36100 df674000 df81df34 00000000 dfa1b860 c0118260 00000000 
Call Trace:
 [<e2886692>]usb_hub_events+0x82/0x3b0 [usbcore]
 [<e28926c0>].rodata.str1.32+0xd20/0x28e2 [usbcore]
 [<e28869f5>]usb_hub_thread+0x35/0x100 [usbcore]
 [<c0118260>]default_wake_function+0x0/0x40
 [<e28869c0>]usb_hub_thread+0x0/0x100 [usbcore]
 [<c0105665>]kernel_thread_helper+0x5/0x10

hub.c: new USB device 00:1f.2-1, assigned address 2
hub.c: new USB device 00:1f.2-2, assigned address 3
Debug: sleeping function called from illegal context at /u/scratch/downloads/kernel/linux-2.5.40/include/asm/semaphore.h:119
df675f70 e2886692 e28926c0 00000077 00000101 00000001 df664f88 df66e0d0 
       df674000 00000000 01010001 df674000 df674000 df675fc0 df674000 e28869f5 
       dfa1b860 dfb36100 df674000 df81df34 00000000 dfa1b860 c0118260 00000000 
Call Trace:
 [<e2886692>]usb_hub_events+0x82/0x3b0 [usbcore]
 [<e28926c0>].rodata.str1.32+0xd20/0x28e2 [usbcore]
 [<e28869f5>]usb_hub_thread+0x35/0x100 [usbcore]
 [<c0118260>]default_wake_function+0x0/0x40
 [<e28869c0>]usb_hub_thread+0x0/0x100 [usbcore]
 [<c0105665>]kernel_thread_helper+0x5/0x10

input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Optical] on
usb-00:1f.2-1

...


atkbd.c: Unknown key (set 2, scancode 0x150, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0x150, on isa0060/serio0) released.
atkbd.c: Unknown key (set 2, scancode 0x120, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0x120, on isa0060/serio0) released.
atkbd.c: Unknown key (set 2, scancode 0x120, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0x120, on isa0060/serio0) released.
atkbd.c: Unknown key (set 2, scancode 0x150, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0x150, on isa0060/serio0) released.
Debug: sleeping function called from illegal context at slab.c:1374
dcf7df74 c013d090 c02629f4 0000055e dcf7c000 df7c0cc0 00000000 00000001 
       c010cc8f c15075b8 000001d0 de708920 dd178ea0 00000000 c02de900 dcf7c000 
       ffffffff 00000002 bffff788 c0107abb 00000000 00000400 00000001 ffffffff 
Call Trace:
 [<c013d090>]__kmem_cache_alloc+0x180/0x190
 [<c010cc8f>]sys_ioperm+0x9f/0x170
 [<c0107abb>]syscall_call+0x7/0xb


It's a dual Pentium III 933 MHz box with a Microsoft Natural Pro Keyboard
(PS/2), Microsoft Optical mouse and a USB cdrw.


lspci -vv output:
-----------------


00:00.0 Host bridge: Intel Corp. 82820 820 (Camino) Chipset Host Bridge (MCH) (rev 04)
	Subsystem: Dell Computer Corporation: Unknown device 0095
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: Intel Corp. 82820 820 (Camino) Chipset AGP Bridge (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	Memory behind bridge: fc000000-fdffffff
	Prefetchable memory behind bridge: f4000000-f5ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fa000000-fbffffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801AA IDE (rev 02) (prog-if 80 [Master])
	Subsystem: Intel Corp. 82801AA IDE
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at ffa0 [size=16]

00:1f.2 USB Controller: Intel Corp. 82801AA USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corp. 82801AA USB
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 19
	Region 4: I/O ports at ff80 [size=32]

00:1f.3 SMBus: Intel Corp. 82801AA SMBus (rev 02)
	Subsystem: Intel Corp. 82801AA SMBus
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 17
	Region 4: I/O ports at dcd0 [size=16]

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 82) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G450 32Mb SDRAM Dual Head
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f4000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at fcffc000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at fc000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at c0000000 [disabled] [size=128K]
	Capabilities: <available only to root>

02:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 05)
	Subsystem: Creative Labs CT4790 SoundBlaster PCI512
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at ece0 [size=32]
	Capabilities: <available only to root>

02:0b.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 05)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 0: I/O ports at ecd8 [size=8]
	Capabilities: <available only to root>

02:0c.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)
	Subsystem: Dell Computer Corporation: Unknown device 0095
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08

-- 
Krishnakumar B <kitty at cs dot wustl dot edu>
Distributed Object Computing Laboratory, Washington University in St.Louis
