Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbUCJMao (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 07:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbUCJMan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 07:30:43 -0500
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:13517 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S262585AbUCJM30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 07:29:26 -0500
From: Richard Browning <richard@redline.org.uk>
Organization: Redline Software Engineering
To: linux-kernel@vger.kernel.org
Subject: SMP + Hyperthreading / Asus PCDL Deluxe / Kernel 2.4.x 2.6.x / Crash/Freeze
Date: Wed, 10 Mar 2004 12:27:32 +0000
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403101227.32322.richard@redline.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

**** SUMMARY
Enabling hyperthreading on Asus PCDL Deluxe motherboard w/ 2xP4Xeon causes 
system freeze in short order.

**** DESCRIPTION
I have an Asus PCDL Deluxe P4Xeon motherboard which has a north/southbridge 
combination allowing system memory to run at 533MHz . The motherboard has the 
usual Asus onboard gigabit ethernet, AD1985 audio, Intel and Promise SATA 
controllers, firewire. All are enabled and operate. I am running dual 2.8GHz 
P4 Xeons.

When hyperthreading is disabled the system is perfectly stable and usable. No 
operating artefacts seem to occur and SMP appears to workcorrectly.

However when hyperthreading is enabled, the system operates for a brief period 
(enough for KDE to boot, for example) before halting. When operating from the 
command line it is usual to see a Machine Check Exception error immediately 
prior to system failure.

**** KEYWORDS
SMP Hyperthreading Asus Xeon Freeze Crash

**** KERNELS
2.4.2x 2.6.x

**** OOPS
Not available

**** CATALYST
Enable hyperthreading

**** ENVIRONMENT
Asus PCDL Deluxe motherboard
(http://usa.asus.com/products/server/srv-mb/pc-dl/overview.HTM)

**** SOFTWARE
Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      0.9.15-pre4
e2fsprogs              1.34
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.15
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0.91
Modules Loaded         fglrx eeprom i2c_isa lm75 i2c_i801 i2c_algo_bit i2c_dev 
i2c_sensor i2c_core

**** PROCESSOR
NOTE Hyperthreading disabled
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 7
cpu MHz         : 2807.537
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
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5537.79

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 7
cpu MHz         : 2807.537
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
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5603.32

**** MODULES
fglrx 208932 7 - Live 0xe09d5000
eeprom 11656 0 - Live 0xe08c9000
i2c_isa 6144 0 - Live 0xe08b3000
lm75 11908 0 - Live 0xe08c0000
i2c_i801 12176 0 - Live 0xe089f000
i2c_algo_bit 13832 0 - Live 0xe08bb000
i2c_dev 14976 0 - Live 0xe08b6000
i2c_sensor 7168 2 eeprom,lm75, Live 0xe08a3000
i2c_core 27524 7 eeprom,i2c_isa,lm75,i2c_i801,i2c_algo_bit,i2c_dev,i2c_sensor, 
Live 0xe08a8000

**** DRIVER AND HARDWARE
(IOPORTS)
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : libata
01f0-01f7 : ide0
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0500-051f : 0000:00:1f.3
  0500-050f : i801-smbus
0cf8-0cff : PCI conf1
9000-9fff : PCI Bus #01
  9000-90ff : 0000:01:00.0
a000-afff : PCI Bus #02
  a000-a01f : 0000:02:01.0
    a000-a01f : e1000
b000-b01f : 0000:00:1d.0
  b000-b01f : uhci_hcd
b400-b41f : 0000:00:1d.1
  b400-b41f : uhci_hcd
b800-b81f : 0000:00:1d.2
  b800-b81f : uhci_hcd
bc00-bc1f : 0000:00:1d.3
  bc00-bc1f : uhci_hcd
d800-d8ff : 0000:00:1f.5
dc00-dc3f : 0000:00:1f.5
f000-f00f : 0000:00:1f.2
  f000-f00f : libata

(IOMEM)
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000d0000-000d0fff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-0036a323 : Kernel code
  0036a324-00492e7f : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
e0000000-e7ffffff : 0000:00:00.0
e8000000-f7ffffff : PCI Bus #01
  e8000000-efffffff : 0000:01:00.0
  f0000000-f7ffffff : 0000:01:00.1
f8000000-f9ffffff : PCI Bus #01
  f9000000-f900ffff : 0000:01:00.0
  f9010000-f901ffff : 0000:01:00.1
fa000000-fa0fffff : PCI Bus #02
  fa000000-fa01ffff : 0000:02:01.0
    fa000000-fa01ffff : e1000
fa100000-fa103fff : 0000:03:03.0
fa104000-fa1047ff : 0000:03:03.0
  fa104000-fa1047ff : ohci1394
fa200000-fa2003ff : 0000:00:1d.7
  fa200000-fa2003ff : ehci_hcd
fa201000-fa2011ff : 0000:00:1f.5
  fa201000-fa2011ff : Intel ICH5 - AC'97
fa202000-fa2020ff : 0000:00:1f.5
  fa202000-fa2020ff : Intel ICH5 - Controller
fec00000-ffffffff : reserved

**** PCI
(lspci not available; here output of cat /proc/bus/pci/devices)
0000    80862578        0       e0000008        00000000        00000000        
00000000        00000000        00000000        00000000     08000000        
00000000        00000000        00000000        00000000        00000000        
00000000        agpgart-intel
0008    80862579        0       00000000        00000000        00000000        
00000000        00000000        00000000        00000000     00000000        
00000000        00000000        00000000        00000000        00000000        
00000000
0018    8086257b        0       00000000        00000000        00000000        
00000000        00000000        00000000        00000000     00000000        
00000000        00000000        00000000        00000000        00000000        
00000000
00e8    808624d2        10      00000000        00000000        00000000        
00000000        0000b001        00000000        00000000     00000000        
00000000        00000000        00000000        00000020        00000000        
00000000        uhci_hcd
00e9    808624d4        13      00000000        00000000        00000000        
00000000        0000b401        00000000        00000000     00000000        
00000000        00000000        00000000        00000020        00000000        
00000000        uhci_hcd
00ea    808624d7        12      00000000        00000000        00000000        
00000000        0000b801        00000000        00000000     00000000        
00000000        00000000        00000000        00000020        00000000        
00000000        uhci_hcd
00eb    808624de        10      00000000        00000000        00000000        
00000000        0000bc01        00000000        00000000     00000000        
00000000        00000000        00000000        00000020        00000000        
00000000        uhci_hcd
00ef    808624dd        17      fa200000        00000000        00000000        
00000000        00000000        00000000        00000000     00000400        
00000000        00000000        00000000        00000000        00000000        
00000000        ehci_hcd
00f0    8086244e        0       00000000        00000000        00000000        
00000000        00000000        00000000        00000000     00000000        
00000000        00000000        00000000        00000000        00000000        
00000000
00f8    808624d0        0       00000000        00000000        00000000        
00000000        00000000        00000000        00000000     00000000        
00000000        00000000        00000000        00000000        00000000        
00000000
00fa    808624d1        12      00000000        00000000        00000000        
00000000        0000f001        00000000        00000000     00000000        
00000000        00000000        00000000        00000010        00000000        
00000000        ata_piix
00fb    808624d3        11      00000000        00000000        00000000        
00000000        00000501        00000000        00000000     00000000        
00000000        00000000        00000000        00000020        00000000        
00000000        i801 smbus
00fd    808624d5        11      0000d801        0000dc01        fa201000        
fa202000        00000000        00000000        00000000     00000100        
00000040        00000200        00000100        00000000        00000000        
00000000        Intel ICH
0100    10024e48        10      e8000008        00009001        f9000000        
00000000        00000000        00000000        00000000     08000000        
00000100        00010000        00000000        00000000        00000000        
00020000
0101    10024e68        0       f0000008        f9010000        00000000        
00000000        00000000        00000000        00000000     08000000        
00010000        00000000        00000000        00000000        00000000        
00000000
0208    80861019        12      fa000000        00000000        0000a001        
00000000        00000000        00000000        00000000     00020000        
00000000        00000020        00000000        00000000        00000000        
00000000        e1000
0318    104c8023        14      fa104000        fa100000        00000000        
00000000        00000000        00000000        00000000     00000800        
00004000        00000000        00000000        00000000        00000000        
00000000        ohci1394

**** SCSI
/proc/scsi/scsi not available
