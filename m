Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311960AbSDOK4C>; Mon, 15 Apr 2002 06:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312255AbSDOK4B>; Mon, 15 Apr 2002 06:56:01 -0400
Received: from mr.tuwien.ac.at ([128.130.2.10]:31117 "EHLO mr.tuwien.ac.at")
	by vger.kernel.org with ESMTP id <S311960AbSDOKz7>;
	Mon, 15 Apr 2002 06:55:59 -0400
Date: Mon, 15 Apr 2002 12:55:52 +0200 (CEST)
From: Hubert Mara <mara@prip.tuwien.ac.at>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: BUG in buffer.c Line 508
Message-ID: <Pine.LNX.4.44.0204151238120.19976-100000@ilx00.prip.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My linuxbox crashed with a something that looked like a kernel-panic 
starting with "BUG in buffer.c line 508"

Kernel-Version: Linux version 2.4.19-pre6 (gcc version 
2.95.2 19991024 (release))
#1 SMP Mon Apr 15 00:26:10 UTC 2002

Software:
Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.10
usage: fdformat [ -n ] device
mount                  2.10h
modutils               2.4.12
e2fsprogs              1.18
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.20
PPP                    2.4.0b1
Linux C Library        2.1.3
ldd: version 1.9.10
Procps                 2.0.7
Net-tools              1.52
Kbd                    0.99
Sh-utils               2.0
Modules Loaded         eeprom w83781d i2c-proc i2c-isa i2c-piix4 
i2c-core eepro100

CPU Info:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 501.148
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov

pat pse36 mmx fxsr sse
bogomips        : 999.42

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 2
cpu MHz         : 501.148
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov
pat pse36 mmx fxsr sse
bogomips        : 999.42

Module Info:
eeprom                  3184   0 (unused)
w83781d                17388   0 (unused)
i2c-proc                6224   0 [eeprom w83781d]
i2c-isa                 1196   0 (unused)
i2c-piix4               3760   0 (unused)
i2c-core               13124   0 [eeprom w83781d i2c-proc i2c-isa 
i2c-piix4]
eepro100               17048   1

Loaded Driver & Hardware Info:
00000000-0009e7ff : System RAM
0009e800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000d17ff : Extension ROM
000d4000-000d4fff : Extension ROM
000d8000-000d9fff : Extension ROM
000f0000-000fffff : System ROM
00100000-0fffcfff : System RAM
  00100000-002375e9 : Kernel code
  002375ea-002a2bdf : Kernel data
0fffd000-0fffefff : ACPI Tables
0ffff000-0fffffff : ACPI Non-volatile Storage
e0800000-e081ffff : Promise Technology, Inc. 20262
e1000000-e10fffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
e1800000-e1800fff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  e1800000-e1800fff : eepro100
e2000000-e2000fff : Adaptec AHA-2940U2/U2W / 7890/7891
  e2000000-e2000fff : aic7xxx
e2800000-e33fffff : PCI Bus #01
  e2800000-e280ffff : Silicon Integrated Systems [SiS] 86C326
e3700000-e3ffffff : PCI Bus #01
  e3800000-e3ffffff : Silicon Integrated Systems [SiS] 86C326
e4000000-e7ffffff : Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0290-0297 : w83781d
02f8-02ff : serial(auto)
0378-037a : parport0
03c0-03df : vga+
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
9000-903f : Promise Technology, Inc. 20262
  9000-9007 : ide0
  9008-900f : ide1
  9010-903f : PDC20262
9400-9403 : Promise Technology, Inc. 20262
  9402-9402 : ide1
9800-9807 : Promise Technology, Inc. 20262
  9800-9807 : ide1
a000-a003 : Promise Technology, Inc. 20262
  a002-a002 : ide0
a400-a407 : Promise Technology, Inc. 20262
  a400-a407 : ide0
a800-a83f : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  a800-a83f : eepro100
b000-b0ff : Adaptec AHA-2940U2/U2W / 7890/7891
b400-b41f : Intel Corp. 82371AB/EB/MB PIIX4 USB
b800-b80f : Intel Corp. 82371AB/EB/MB PIIX4 IDE
  b800-b807 : ide2
  b808-b80f : ide3
d000-dfff : PCI Bus #01
  d800-d87f : Silicon Integrated Systems [SiS] 86C326
e400-e43f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
e800-e81f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
  e800-e807 : piix4-smbus

PCI Info:
n.A. - If you need it i can send it on request

SCSI Info:
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DNES-309170W     Rev: SA30
  Type:   Direct-Access                    ANSI SCSI revision: 03

Other Info:
I use reiserfs on all disks (1x LVD and 2x IDE) and i have to 
swap-partitions located in sda1 and sda2 (both are approx. 128 MB)

kind regards,
-- 
Hubert Mara
Vienna University of Technology
Institute for Computer Aided Automation
Pattern Recognition & Image Processing Group
Favoritenstr. 9 // 1040 Vienna // AUSTRIA
Phone: +43 (1) 58801 / 18371
Fax:   +43 (1) 58801 / 18392
EMail: mara@prip.tuwien.ac.at
Web:   http://www.prip.tuwien.ac.at


