Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318346AbSIBS6n>; Mon, 2 Sep 2002 14:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318355AbSIBS6n>; Mon, 2 Sep 2002 14:58:43 -0400
Received: from b.mail.peak.org ([198.88.144.71]:41231 "EHLO b.mail.peak.org")
	by vger.kernel.org with ESMTP id <S318346AbSIBS6k>;
	Mon, 2 Sep 2002 14:58:40 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Kenneth Corbin <kencx@peak.org>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Linux consistently crashes running grip.
Date: Mon, 2 Sep 2002 11:49:41 -0700
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200209021149.41654.kencx@peak.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

I normally use nvidia drivers which require a NVdriver kernel module to 
operate.   I've tried switching to the standard nv driver, which may have had 
some effect.  The first time I tried it with that configuration it crashed X 
but not the system, but when I tried it a second time it crashed the system 
good and proper.   Still, this remains the only time since loading Redhat 7.3 
that my system has survived this operation, which may be significant.

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

ken-/usr/src/linux-2.4>sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

3. Misc information

ver_linux output
Linux corbin1 2.4.18-3 #1 Thu Apr 18 07:32:41 EDT 2002 i686 unknown

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
ymfpci ac97_codec uart401 sound soundcore NVdriver parport_pc lp parport 
autofs tulip ipchains ide-scsi scsi_mod ide-cd cdrom nls_iso8859-1 nls_cp437 
vfat fat usb-uhci usbcore ext3 jbd

ken-/proc>cat cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 706.301
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1409.02

ken-/proc>cat modules
ppp_deflate             4000   0 (autoclean)
zlib_deflate           21344   0 (autoclean) [ppp_deflate]
ppp_async               8256   0 (autoclean)
ppp_generic            24140   0 (autoclean) [ppp_deflate ppp_async]
slhc                    6508   0 (autoclean) [ppp_generic]
ymfpci                 44196   1 (autoclean)
ac97_codec             11936   0 (autoclean) [ymfpci]
uart401                 7936   0 (autoclean) [ymfpci]
sound                  71916   0 (autoclean) [uart401]
soundcore               6692   4 (autoclean) [ymfpci sound]
NVdriver             1067552  10 (autoclean)
parport_pc             18724   1 (autoclean)
lp                      8864   0 (autoclean)
parport                34208   1 (autoclean) [parport_pc lp]
autofs                 12132   0 (autoclean) (unused)
tulip                  43104   1
ipchains               43528  24
ide-scsi                9664   0
scsi_mod              108608   1 [ide-scsi]
ide-cd                 30272   1
cdrom                  32224   0 [ide-cd]
nls_iso8859-1           3488   2 (autoclean)
nls_cp437               5120   2 (autoclean)
vfat                   12092   2 (autoclean)
fat                    37432   0 (autoclean) [vfat]
usb-uhci               24452   0 (unused)
usbcore                73216   1 [usb-uhci]
ext3                   67136   5
jbd                    49400   5 [ext3]

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
  00100000-002197d8 : Kernel code
  002197d9-002e23bf : Kernel data
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


