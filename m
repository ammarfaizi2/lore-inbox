Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132958AbRDETPe>; Thu, 5 Apr 2001 15:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132975AbRDETPY>; Thu, 5 Apr 2001 15:15:24 -0400
Received: from mail.digitalme.com ([193.97.97.75]:5389 "EHLO digitalme.com")
	by vger.kernel.org with ESMTP id <S132958AbRDETPQ>;
	Thu, 5 Apr 2001 15:15:16 -0400
Message-ID: <3ACCC3FD.90509@bigfoot.com>
Date: Thu, 05 Apr 2001 15:14:05 -0400
From: "Trever L. Adams" <trever_Adams@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3 i686; en-US; 0.8.1)
X-Accept-Language: en
MIME-Version: 1.0
To: linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.3 (and possibly 2.4.2) don't enter S5 (ACPI) on shutdown
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

2.4.3 no longer shuts down automatically with S5.

[2.] Full description of the problem/report:

2.4.3 no longer shuts down automatically with S5.  I have an Athlon 
based system using the FIC-SD11 motherboard.  In 2.4.1 and possibly 
2.4.2 the system used to shut down just fine.

[3.] Keywords (i.e., modules, networking, kernel):

ACPI, S5, acpid-071100

[4.] Kernel version (from /proc/version):

Linux version 2.4.3 (root@aurora) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #4 Sat Mar 31 13:21:44 EST 2001

[5.] Output of Oops.. message (if applicable) with symbolic information
       resolved (see Documentation/oops-tracing.txt)

No oops

[6.] A small shell script or example program which triggers the
       problem (if possible)

Simply tell the machine to halt and I get a message saying cannot enter 
S5 and the machine stays alive.

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux aurora 2.4.3 #4 Sat Mar 31 13:21:44 EST 2001 i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.0.18
util-linux             2.10m
modutils               2.3.21
e2fsprogs              1.18
PPP                    2.3.11
Linux C Library        > libc.2.2
Dynamic linker (ldd)   2.2
Procps                 2.0.7
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0
acpi daemon		acpid-071100
Modules Loaded         af_packet agpgart

[7.2.] Processor information (from /proc/cpuinfo):

processor : 0
vendor_id : AuthenticAMD
cpu family : 6
model 	: 2
model name	: AMD Athlon(tm) Processor
stepping : 1
cpu MHz		: 798.478
cache size	: 512 KB
fdiv_bug : no
hlt_bug : no
f00f_bug : no
coma_bug : no
fpu 	: yes
fpu_exception : yes
cpuid level	: 1
wp 	: yes
flags 	: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat 
pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips : 1592.52


[7.3.] Module information (from /proc/modules):

af_packet              11200   0 (autoclean)
agpgart                14640   0 (unused)

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)


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
03c0-03df : vga+
03f6-03f6 : ide0
0400-040f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
0cf8-0cff : PCI conf1
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
8000-8fff : PCI Bus #01
c000-c0ff : Symbios Logic Inc. (formerly NCR) 53c875
    c000-c07f : sym53c8xx
cc00-ccff : Trident Microsystems 4DWave NX
    cc00-ccff : Trident 4DWave NX
d000-d07f : Digital Equipment Corporation DECchip 21140 [FasterNet]
    d000-d07f : eth0
d400-d403 : Advanced Micro Devices [AMD] AMD-751 [Irongate] System
Controller
d800-d8ff : Symbios Logic Inc. (formerly NCR) 53c875 (#2)
    d800-d87f : sym53c8xx
ffa0-ffaf : VIA Technologies, Inc. Bus Master IDE
    ffa0-ffa7 : ide0
    ffa8-ffaf : ide1

cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07feffff : System RAM
    00100000-002155f5 : Kernel code
    002155f6-00278f37 : Kernel data
07ff0000-07ff7fff : ACPI Tables
07ff8000-07ffffff : ACPI Non-volatile Storage
e9c00000-e9cfffff : PCI Bus #01
ea000000-ebffffff : Advanced Micro Devices [AMD] AMD-751 [Irongate]
System Controller
eddff000-eddfffff : Advanced Micro Devices [AMD] AMD-751 [Irongate]
System Controller
ede00000-efefffff : PCI Bus #01
    ee800000-eeffffff : Texas Instruments TVP4020 [Permedia 2]
    ef000000-ef7fffff : Texas Instruments TVP4020 [Permedia 2]
    efee0000-efefffff : Texas Instruments TVP4020 [Permedia 2]
efffc000-efffcfff : Symbios Logic Inc. (formerly NCR) 53c875
efffd000-efffdfff : Trident Microsystems 4DWave NX
efffe000-efffefff : Symbios Logic Inc. (formerly NCR) 53c875 (#2)

effffd00-effffdff : Symbios Logic Inc. (formerly NCR) 53c875
effffe80-effffeff : Digital Equipment Corporation DECchip 21140 [FasterNet]
    effffe80-effffeff : eth0
efffff00-efffffff : Symbios Logic Inc. (formerly NCR) 53c875 (#2)
ffff0000-ffffffff : reserved[7.5.] PCI information ('lspci -vvv' as root)

[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi1 Channel: 00 Id: 05 Lun: 00
    Vendor: NEC      Model: CD-ROM DRIVE:464 Rev: 1.05
    Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 00
    Vendor: RICOH    Model: MP6200S          Rev: 2.40
    Type:   CD-ROM                           ANSI SCSI revision: 02

