Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265563AbRFVW6y>; Fri, 22 Jun 2001 18:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265562AbRFVW6o>; Fri, 22 Jun 2001 18:58:44 -0400
Received: from aragorn.ics.muni.cz ([147.251.4.33]:23508 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S265561AbRFVW63>; Fri, 22 Jun 2001 18:58:29 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.5-ac17 oops on Sony Vaio pCG-FX140
X-URL: http://www.fi.muni.cz/~pekon/
From: Petr Konecny <pekon@informatics.muni.cz>
Date: 23 Jun 2001 00:58:25 +0200
Message-ID: <qwwu218w29a.fsf@decibel.fi.muni.cz>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.5 (anise)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

ac17 oopsed on boot, ac16 runs fine.  Here is the output of lspci -v and
ksymoops. I hope I did not make too many typos when I copied the oops.

                                             Regards, Petr

lspci -v output:
00:00.0 Host bridge: Intel Corporation: Unknown device 1130 (rev 11)
	Subsystem: Sony Corporation: Unknown device 80df
	Flags: bus master, fast devsel, latency 0
	Capabilities: [88] #09 [f205]

00:02.0 VGA compatible controller: Intel Corporation: Unknown device 1132 (rev 11) (prog-if 00 [VGA])
	Subsystem: Sony Corporation: Unknown device 80df
	Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 10
	Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Memory at f4000000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [dc] Power Management version 2

00:1e.0 PCI bridge: Intel Corporation: Unknown device 2448 (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: f4100000-f41fffff

00:1f.0 ISA bridge: Intel Corporation: Unknown device 244c (rev 03)
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corporation: Unknown device 244a (rev 03) (prog-if 80 [Master])
	Subsystem: Sony Corporation: Unknown device 80df
	Flags: bus master, medium devsel, latency 0
	I/O ports at 1800 [size=16]

00:1f.2 USB Controller: Intel Corporation 82820 820 (Camino 2) Chipset USB (Hub A) (rev 03) (prog-if 00 [UHCI])
	Subsystem: Sony Corporation: Unknown device 80df
	Flags: bus master, medium devsel, latency 0, IRQ 9
	I/O ports at 1820 [size=32]

00:1f.3 SMBus: Intel Corporation 82820 820 (Camino 2) Chipset SMBus (rev 03)
	Subsystem: Sony Corporation: Unknown device 80df
	Flags: medium devsel, IRQ 5
	I/O ports at 1810 [size=16]

00:1f.4 USB Controller: Intel Corporation 82820 820 (Camino 2) Chipset USB (Hub B) (rev 03) (prog-if 00 [UHCI])
	Subsystem: Sony Corporation: Unknown device 80df
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at 2400 [size=32]

00:1f.5 Multimedia audio controller: Intel Corporation: Unknown device 2445 (rev 03)
	Subsystem: Sony Corporation: Unknown device 80df
	Flags: bus master, medium devsel, latency 0, IRQ 5
	I/O ports at 1c00 [size=256]
	I/O ports at 1840 [size=64]

00:1f.6 Modem: Intel Corporation: Unknown device 2446 (rev 03) (prog-if 00 [Generic])
	Subsystem: Sony Corporation: Unknown device 80df
	Flags: medium devsel, IRQ 5
	I/O ports at 2000 [size=256]
	I/O ports at 1880 [size=128]

01:00.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8021 (rev 02) (prog-if 10 [OHCI])
	Subsystem: Sony Corporation: Unknown device 80df
	Flags: medium devsel
	Memory at f4104000 (32-bit, non-prefetchable) [disabled] [size=2K]
	Memory at f4100000 (32-bit, non-prefetchable) [disabled] [size=16K]
	Capabilities: [44] Power Management version 2

01:02.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
	Subsystem: Sony Corporation: Unknown device 80df
	Flags: bus master, medium devsel, latency 0
	Memory at f4106000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=01, secondary=02, subordinate=05, sec-latency=0
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	16-bit legacy interface ports at 0001

01:02.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
	Subsystem: Sony Corporation: Unknown device 80df
	Flags: bus master, medium devsel, latency 0
	Memory at f4107000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=01, secondary=06, subordinate=09, sec-latency=0
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	16-bit legacy interface ports at 0001

01:08.0 Ethernet controller: Intel Corporation 82820 820 (Camino 2) Chipset Ethernet (rev 03)
	Subsystem: Intel Corporation: Unknown device 3013
	Flags: bus master, medium devsel, latency 66, IRQ 9
	Memory at f4105000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at 3000 [size=64]
	Capabilities: [dc] Power Management version 2


------------------------------------------------
ksymoops 2.4.1 on i686 2.4.5-ac16.  Options used
     -V (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.5-ac17 (specified)
     -m /boot/System.map-2.4.5-ac17 (specified)

No modules in ksyms, skipping objects
Unable to handle kernel NULL pointer dereference at virtual address 00000030
c019c23c
*pde = 00000000
Oops: 0000
CPU:  0
EIP:  0010:[<c019c23c>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax:  00000000    ebx: 00000286  ecx: c0267784   edx: c14f7fd3
esi:  00000040    edi: 00000000  ebp: 0008e000   esp: c14f7fb4
Process swapper (pid: 1, stackpage=c14f7000)
Stack: c14f7fd3 c0255fc0 c018f0cb c0267784 00000040 c14f7fd3 c0287b58 00000000
       c0260c05 c0256856 00010f00 c0256892 c010503b 00010f00 c0255fc0 c010545c
       00000000 00000078 00098700
Call Trace: [<c018f0cb>] [<c010503b>] [<c010545c>]
Code: 8b 40 30 52 56 51 8b 00 ff d0 83 c4 0c 53 9d 5b 5e c3 89 f6

>>EIP; c019c23c <pci_read_config_byte+14/28>   <=====
Trace; c018f0cb <i810tco_getdevice+4b/140>
Trace; c010503b <init+7/11c>
Trace; c010545c <kernel_thread+28/38>
Code;  c019c23c <pci_read_config_byte+14/28>
00000000 <_EIP>:
Code;  c019c23c <pci_read_config_byte+14/28>   <=====
   0:   8b 40 30                  mov    0x30(%eax),%eax   <=====
Code;  c019c23f <pci_read_config_byte+17/28>
   3:   52                        push   %edx
Code;  c019c240 <pci_read_config_byte+18/28>
   4:   56                        push   %esi
Code;  c019c241 <pci_read_config_byte+19/28>
   5:   51                        push   %ecx
Code;  c019c242 <pci_read_config_byte+1a/28>
   6:   8b 00                     mov    (%eax),%eax
Code;  c019c244 <pci_read_config_byte+1c/28>
   8:   ff d0                     call   *%eax
Code;  c019c246 <pci_read_config_byte+1e/28>
   a:   83 c4 0c                  add    $0xc,%esp
Code;  c019c249 <pci_read_config_byte+21/28>
   d:   53                        push   %ebx
Code;  c019c24a <pci_read_config_byte+22/28>
   e:   9d                        popf   
Code;  c019c24b <pci_read_config_byte+23/28>
   f:   5b                        pop    %ebx
Code;  c019c24c <pci_read_config_byte+24/28>
  10:   5e                        pop    %esi
Code;  c019c24d <pci_read_config_byte+25/28>
  11:   c3                        ret    
Code;  c019c24e <pci_read_config_byte+26/28>
  12:   89 f6                     mov    %esi,%esi

 <0>Kernel panic: Attempted to kill init!

-- 
While you recently had your problems on the run, they've regrouped and
are making another attack.
