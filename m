Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265823AbUFDTES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265823AbUFDTES (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 15:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265921AbUFDTES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 15:04:18 -0400
Received: from mail-gateway-0-1.landonet.net ([196.25.111.196]:29921 "EHLO
	mail-gateway-0-1.landonet.net") by vger.kernel.org with ESMTP
	id S265823AbUFDTEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 15:04:09 -0400
Message-ID: <40C0E37C.4030905@lbsd.net>
Date: Fri, 04 Jun 2004 21:02:52 +0000
From: Nigel Kukard <nkukard@lbsd.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040604
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [HANG] SIS900 + P4 Hyperthread
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Using kernel 2.6.6 on a m/b with an builtin sis900 network adapter i get 
a soft hang during HEAVY network traffic (ie. 7.5Mb/s). I tried to 
enable sysrq to no avail. Keyboard is still active but any attempt to 
run any command hangs.

Disabling hyperthreading in the bios seems to solve the problem. I think 
this is smp related.

When using 2.4.x all is ok with hyperthreading enabled.

here is some info with hyperthreading disabled.... if you need anymore 
info plz don't hesitate to mail me directly.


[root@nigel-linux.landonet root]# lspci -v
00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 
0648 (rev 50)
        Subsystem: Elitegroup Computer Systems: Unknown device 1803
        Flags: bus master, medium devsel, latency 32
        Memory at c0000000 (32-bit, non-prefetchable) [size=256M]
        Capabilities: [c0] AGP version 3.5

00:01.0 PCI bridge: Silicon Integrated Systems [SiS]: Unknown device 
0003 (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, fast devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        Memory behind bridge: d8000000-d9ffffff
        Prefetchable memory behind bridge: d0000000-d7ffffff

00:02.0 ISA bridge: Silicon Integrated Systems [SiS]: Unknown device 
0963 (rev 25)
        Flags: bus master, medium devsel, latency 0

00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
        Flags: medium devsel, IRQ 169
        I/O ports at 1080 [size=32]

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] 
(prog-if 80 [Master])
        Subsystem: Elitegroup Computer Systems: Unknown device 1803
        Flags: bus master, medium devsel, latency 128, IRQ 193
        I/O ports at 4000 [size=16]
        Capabilities: [58] Power Management version 2

00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] 
SiS7012 PCI Audio Accelerator (rev a0)
        Subsystem: Elitegroup Computer Systems: Unknown device 1803
        Flags: bus master, medium devsel, latency 32, IRQ 177
        I/O ports at dc00 [size=256]
        I/O ports at e000 [size=128]
        Capabilities: [48] Power Management version 2

00:03.0 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 0f) 
(prog-if 10 [OHCI])
        Subsystem: Elitegroup Computer Systems: Unknown device 1803
        Flags: bus master, medium devsel, latency 32, IRQ 201
        Memory at da023000 (32-bit, non-prefetchable) [size=4K]

00:03.1 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 0f) 
(prog-if 10 [OHCI])
        Subsystem: Elitegroup Computer Systems: Unknown device 1803
        Flags: bus master, medium devsel, latency 32, IRQ 209
        Memory at da020000 (32-bit, non-prefetchable) [size=4K]

00:03.3 USB Controller: Silicon Integrated Systems [SiS]: Unknown device 
7002 (prog-if 20 [EHCI])
        Subsystem: Elitegroup Computer Systems: Unknown device 1803
        Flags: bus master, medium devsel, latency 32, IRQ 225
        Memory at da021000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [50] Power Management version 2

00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 
10/100 Ethernet (rev 91)
        Subsystem: Elitegroup Computer Systems: Unknown device 1803
        Flags: bus master, medium devsel, latency 32, IRQ 185
        I/O ports at e400 [size=256]
        Memory at da022000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [40] Power Management version 2

00:0b.0 FireWire (IEEE 1394): Lucent Microelectronics FW323 (rev 61) 
(prog-if 10 [OHCI])
        Subsystem: Lucent Microelectronics FW323
        Flags: bus master, medium devsel, latency 32, IRQ 169
        Memory at da024000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

01:00.0 VGA compatible controller: nVidia Corporation: Unknown device 
0281 (rev a1) (prog-if 00 [VGA])
        Subsystem: Micro-star International Co Ltd: Unknown device 8943
        Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 193
        Memory at d8000000 (32-bit, non-prefetchable) [size=16M]
        Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 3.0


[root@nigel-linux.landonet root]# cat /proc/interrupts
           CPU0
  0:    1146943    IO-APIC-edge  timer
  4:         29    IO-APIC-edge  serial
  7:          2    IO-APIC-edge  parport0
  9:        171   IO-APIC-level  acpi
 14:     134449    IO-APIC-edge  ide0
 15:         24    IO-APIC-edge  ide1
169:        171   IO-APIC-level  ohci1394
185:     684341   IO-APIC-level  eth0
193:      55506   IO-APIC-level  nvidia
201:      12379   IO-APIC-level  ohci_hcd
209:       4069   IO-APIC-level  ohci_hcd
225:          0   IO-APIC-level  ehci_hcd
NMI:          0
LOC:    1146994
ERR:          0
MIS:          0



[root@nigel-linux.landonet root]# cat /proc/iomem
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000ce3ff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-004eb0ed : Kernel code
  004eb0ee-0071faff : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
c0000000-cfffffff : 0000:00:00.0
d0000000-d7ffffff : PCI Bus #01
  d0000000-d7ffffff : 0000:01:00.0
d8000000-d9ffffff : PCI Bus #01
  d8000000-d8ffffff : 0000:01:00.0
da020000-da020fff : 0000:00:03.1
  da020000-da020fff : ohci_hcd
da021000-da021fff : 0000:00:03.3
  da021000-da021fff : ehci_hcd
da022000-da022fff : 0000:00:04.0
  da022000-da022fff : sis900
da023000-da023fff : 0000:00:03.0
  da023000-da023fff : ohci_hcd
da024000-da024fff : 0000:00:0b.0
  da024000-da0247ff : ohci1394
fec00000-ffffffff : reserved



[root@nigel-linux.landonet root]# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping        : 9
cpu MHz         : 2806.126
cache size      : 512 KB
physical id     : 0
siblings        : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5570.56




