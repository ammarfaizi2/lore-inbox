Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318990AbSIDADr>; Tue, 3 Sep 2002 20:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318991AbSIDADr>; Tue, 3 Sep 2002 20:03:47 -0400
Received: from a.mail.peak.org ([198.88.144.70]:44299 "EHLO a.mail.peak.org")
	by vger.kernel.org with ESMTP id <S318990AbSIDADo>;
	Tue, 3 Sep 2002 20:03:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kenneth Corbin <kencx@peak.org>
Subject: PROBLEM: Linux consistently crashes running grip. (continued)
Date: Tue, 3 Sep 2002 16:55:56 -0700
User-Agent: KMail/1.4.1
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209031655.56412.kencx@peak.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Long description of same problem.   Still continuing after dumping the nvidia 
drivers and upgrading to the latest Redhat kernel.   Anything else I can do?

I am not subscribed to this list, please cc me with any response.
Thanks in advance for wading through this.

1. Linux consistently crashes running grip.

2. Grip 3.0.1-1 is a graphical X frontend for a variety of CD ripper and MP3
encoder programs.   When it is only ripping CD's everything is OK.  But when
it is ripping and encoding tracks, the system will die shortly after the
ripping operation finishes while the encoding operation is going on.   The
time till death is variable, it has ranged from 5 seconds to 5 minutes on one
occasion, but it always crashes.  It happens with two different encoders
(notlame and oggenc) and two different rippers (cdparanoia and cdda2wav)  The
quickest way to induce a failure is to make one pass ripping tracks and a
second pass asking it to rip and encode.  It is smart enough to realize the
tracks have already been ripped and doesn't do much beyond checking that they
are all accounted for.   But my system still crashes.

Nothing whatsoever appears on the system console when it crashes.  Just locks
up solid.

It should be noted that this system has been crashing with the same symtpoms
sporadically for over a year, generally about once a day.  Not surprising for
Windows but less that I would expect from a Linux system.  What has changed
is that I can make it happen on demand.

It is, unfortunately, highly improbably that some will be able to reproduce
this on another system, but I might get lucky.   Failing that, I would be
happy to do any testing or debugging on my system.   I want to get this
fixed.

3. Misc information
root-/usr/src/linux-2.4.18-10>. scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux corbin1 2.4.18-10 #1 Wed Aug 7 11:41:24 EDT 2002 i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.14
e2fsprogs              1.27
reiserfsprogs          3.x.0j
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         ppp_deflate zlib_deflate ppp_async ppp_generic slhc 
ymfpci ac97_codec uart401 sound soundcore parport_pc lp parport autofs tulip 
ipchains ide-scsi scsi_mod ide-cd cdrom nls_iso8859-1 nls_cp437 vfat fat 
usb-uhci usbcore ext3 jbd

ken-~>cd /proc
ken-/proc>cat cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 706.300
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat 
pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1409.02
 (Interesting side note, when I ran this last time the apic flag was on, 
whatever that might mean)

ken-/proc>cat modules
ppp_deflate             3936   0 (autoclean)
zlib_deflate           20032   0 (autoclean) [ppp_deflate]
ppp_async               8320   1 (autoclean)
ppp_generic            23980   3 (autoclean) [ppp_deflate ppp_async]
slhc                    6284   1 (autoclean) [ppp_generic]
ymfpci                 44260   2 (autoclean)
ac97_codec             12256   0 (autoclean) [ymfpci]
uart401                 7744   0 (autoclean) [ymfpci]
sound                  70892   0 (autoclean) [uart401]
soundcore               6340   4 (autoclean) [ymfpci sound]
parport_pc             16932   1 (autoclean)
lp                      8928   0 (autoclean)
parport                33280   1 (autoclean) [parport_pc lp]
autofs                 11748   0 (autoclean) (unused)
tulip                  41696   1
ipchains               40392  26
ide-scsi                9312   0
scsi_mod              104656   1 [ide-scsi]
ide-cd                 29856   0
cdrom                  33088   0 [ide-cd]
nls_iso8859-1           3456   2 (autoclean)
nls_cp437               5088   2 (autoclean)
vfat                   11452   2 (autoclean)
fat                    36344   0 (autoclean) [vfat]
usb-uhci               23492   0 (unused)
usbcore                69984   1 [usb-uhci]
ext3                   64608   5
jbd                    47736   5 [ext3]

ken-/proc>cat ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
8800-883f : Promise Technology, Inc. 20265
  8800-8807 : ide2
  8808-880f : ide3
  8810-883f : PDC20265
9000-9003 : Promise Technology, Inc. 20265
9400-9407 : Promise Technology, Inc. 20265
9800-9803 : Promise Technology, Inc. 20265
a000-a007 : Promise Technology, Inc. 20265
a400-a4ff : Linksys Network Everywhere Fast Ethernet 10/100 model NC100
  a400-a4ff : tulip
d000-d01f : VIA Technologies, Inc. UHCI USB (#2)
  d000-d01f : usb-uhci
d400-d41f : VIA Technologies, Inc. UHCI USB
  d400-d41f : usb-uhci
d800-d80f : VIA Technologies, Inc. Bus Master IDE
  d800-d807 : ide0
  d808-d80f : ide1
e400-e4ff : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
e800-e80f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]

ken-/proc>cat iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07febfff : System RAM
  00100000-0021aaeb : Kernel code
  0021aaec-002e38df : Kernel data
07fec000-07feefff : ACPI Tables
07fef000-07ffefff : reserved
07fff000-07ffffff : ACPI Non-volatile Storage
d4800000-d481ffff : Promise Technology, Inc. 20265
d5000000-d5007fff : Yamaha Corporation YMF-724F [DS-1 Audio Controller]
  d5000000-d5007fff : ymfpci
d5800000-d58003ff : Linksys Network Everywhere Fast Ethernet 10/100 model 
NC100
  d5800000-d58003ff : tulip
d6000000-d7dfffff : PCI Bus #01
  d6000000-d6ffffff : nVidia Corporation NV11 (GeForce2 MX)
d7f00000-e3ffffff : PCI Bus #01
  d8000000-dfffffff : nVidia Corporation NV11 (GeForce2 MX)
e4000000-e7ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
ffff0000-ffffffff : reserved

ken-/proc>cat interrupts
           CPU0
  0:     132474          XT-PIC  timer
  1:       2673          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  4:        439          XT-PIC  serial
  5:     147724          XT-PIC  ymfpci
  8:          1          XT-PIC  rtc
 10:          5          XT-PIC  eth0
 11:         95          XT-PIC  usb-uhci, usb-uhci
 12:      28082          XT-PIC  PS/2 Mouse
 14:      19811          XT-PIC  ide0
 15:        499          XT-PIC  ide1
NMI:          0
ERR:          0

