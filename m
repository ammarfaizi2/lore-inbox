Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291346AbSBSMJ3>; Tue, 19 Feb 2002 07:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291343AbSBSMJK>; Tue, 19 Feb 2002 07:09:10 -0500
Received: from pheriche.sun.com ([192.18.98.34]:19129 "EHLO pheriche.sun.com")
	by vger.kernel.org with ESMTP id <S291340AbSBSMIw>;
	Tue, 19 Feb 2002 07:08:52 -0500
Message-ID: <3C724055.1811D3D6@sun.com>
Date: Tue, 19 Feb 2002 09:08:53 -0300
From: Sebastian Manzano <sebastian.manzano@sun.com>
Organization: Sun Microsystems
X-Mailer: Mozilla 4.76C-CCK-MCD  [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Sony P-I/O device?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I have tried sonypi module in my Sony PCG-FXA36 and it seems to be looking for
a 0x7113 device that I don't have (lspci):

  # grep DEVICE_ID_INTEL drivers/char/sonypi.c
    PCI_DEVICE_ID_INTEL_82371AB_3, 

  # grep DEVICE_ID_INTEL_82371AB_3 include/linux/pci_ids.h
  #define PCI_DEVICE_ID_INTEL_82371AB_3   0x7113

Has sony stop including this device in their laptops? Is sonypi only for _some_ laptops? 

Cheers,
--
Sebastian Manzano B.                   Phone : +56.2.372.45.77 

# sh ver_linux

Linux localhost.localdomain 2.4.18-rc1 #25 Mon Feb 18 08:58:17 CLST 2002 i686 un
known
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11f
mount                  2.11g
modutils               2.4.13
e2fsprogs              1.23
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.22
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         sr_mod vfat fat autofs 8139too mii ide-scsi scsi_mod ide-
cd cdrom usb-uhci usbcore

# lspci -v
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
        Subsystem: Sony Corporation: Unknown device 80f6
        Flags: bus master, medium devsel, latency 8
        Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
(prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: e8100000-e9ffffff
        Capabilities: [80] Power Management version 2

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev
40)
        Subsystem: Sony Corporation: Unknown device 80f6
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if
8a [Master SecP PriP])
        Subsystem: Sony Corporation: Unknown device 80f6
        Flags: bus master, medium devsel, latency 0
        I/O ports at 1c40 [size=16]
        Capabilities: [c0] Power Management version 2

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a) (prog-if 00
[UHCI])
        Subsystem: Sony Corporation: Unknown device 80f6
        Flags: bus master, medium devsel, latency 64, IRQ 9
        I/O ports at 1c00 [size=32]
        Capabilities: [80] Power Management version 2

00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a) (prog-if 00
[UHCI])
        Subsystem: Sony Corporation: Unknown device 80f6
        Flags: bus master, medium devsel, latency 64, IRQ 9
        I/O ports at 1c20 [size=32]
        Capabilities: [80] Power Management version 2

00:07.4 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
        Subsystem: Sony Corporation: Unknown device 80f6
        Flags: medium devsel, IRQ 9
        Capabilities: [68] Power Management version 2

00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio
Controller (rev 50)
        Subsystem: Sony Corporation: Unknown device 80f6
        Flags: medium devsel, IRQ 5
        I/O ports at 1000 [size=256]
        I/O ports at 1c54 [size=4]
        I/O ports at 1c50 [size=4]
        Capabilities: [c0] Power Management version 2

00:07.6 Communication controller: VIA Technologies, Inc. AC97 Modem Controller
(rev 30)
        Subsystem: Sony Corporation: Unknown device 80f6
        Flags: medium devsel, IRQ 5
        I/O ports at 1400 [size=256]
        Capabilities: [d0] Power Management version 2

00:0a.0 CardBus bridge: Texas Instruments PCI1420
        Subsystem: Sony Corporation: Unknown device 80f6
        Flags: bus master, medium devsel, latency 0, IRQ 9
        Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=0
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        16-bit legacy interface ports at 0001

00:0a.1 CardBus bridge: Texas Instruments PCI1420
        Subsystem: Sony Corporation: Unknown device 80f6
        Flags: bus master, medium devsel, latency 0, IRQ 10
        Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=06, subordinate=09, sec-latency=0
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        16-bit legacy interface ports at 0001

00:0e.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8020 (prog-if 10
[OHCI])
        Subsystem: Sony Corporation: Unknown device 80f6
        Flags: medium devsel, IRQ 9
        Memory at e8004000 (32-bit, non-prefetchable) [size=2K]
        Memory at e8000000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 1

00:10.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
        Subsystem: Sony Corporation: Unknown device 80f6
        Flags: bus master, medium devsel, latency 64, IRQ 10
        I/O ports at 1800 [size=256]
        Memory at e8004800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M AGP 2x
(rev 64) (prog-if 00 [VGA])
        Subsystem: Sony Corporation: Unknown device 80f6
        Flags: bus master, stepping, medium devsel, latency 66, IRQ 5
        Memory at e9000000 (32-bit, non-prefetchable) [size=16M]
        I/O ports at 9000 [size=256]
        Memory at e8100000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [50] AGP version 1.0
        Capabilities: [5c] Power Management version 1

# lspci -n
00:00.0 Class 0600: 1106:0305 (rev 03)
00:01.0 Class 0604: 1106:8305
00:07.0 Class 0601: 1106:0686 (rev 40)
00:07.1 Class 0101: 1106:0571 (rev 06)
00:07.2 Class 0c03: 1106:3038 (rev 1a)
00:07.3 Class 0c03: 1106:3038 (rev 1a)
00:07.4 Class 0601: 1106:3057 (rev 40)
00:07.5 Class 0401: 1106:3058 (rev 50)
00:07.6 Class 0780: 1106:3068 (rev 30)
00:0a.0 Class 0607: 104c:ac51
00:0a.1 Class 0607: 104c:ac51
00:0e.0 Class 0c00: 104c:8020
00:10.0 Class 0200: 10ec:8139 (rev 10)
01:00.0 Class 0300: 1002:4c4d (rev 64)

# modprobe sonypi
/lib/modules/2.4.18-rc1/kernel/drivers/char/sonypi.o: init_module: No such devic
e
Hint: insmod errors can be caused by incorrect module parameters, including inva
lid IO or IRQ parameters
/lib/modules/2.4.18-rc1/kernel/drivers/char/sonypi.o: insmod /lib/modules/2.4.18
-rc1/kernel/drivers/char/sonypi.o failed
/lib/modules/2.4.18-rc1/kernel/drivers/char/sonypi.o: insmod sonypi failed
