Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311244AbSDIUIV>; Tue, 9 Apr 2002 16:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311242AbSDIUIU>; Tue, 9 Apr 2002 16:08:20 -0400
Received: from 217-13-4-9.dd.nextgentel.com ([217.13.4.9]:13240 "HELO
	mail.broadpark.no") by vger.kernel.org with SMTP id <S311239AbSDIUIR>;
	Tue, 9 Apr 2002 16:08:17 -0400
Message-ID: <001e01c1e003$2dd7ddd0$3201000a@rom5>
From: "=?iso-8859-1?Q?Rune_F._V=E6rnes?=" <rune@nailflare.com>
To: <linux-kernel@vger.kernel.org>
Subject: kernel BUG at slab.c:1099!
Date: Tue, 9 Apr 2002 22:14:38 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1.] One line summary of the problem:
setting up a nokia_c110 pcmcia card. Problem with slab.h/malloc.h

[2.] Full description of the problem/report:
Compiled code for the nokia card and loaded the module(nokia_c110)
The code uses malloc.h... tried to ues slab.h but no  help.
When cardmgr starts up the kernel reports a kernel BUG.


[3.] Keywords (i.e., modules, networking, kernel):
module kernel

[4.] Kernel version (from /proc/version):
2.4.18-6mdk


[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

C110: ----------------------------------------------------------------
C110: - Nokia C110/C111 WLAN Card Driver.
C110: - Version 1.01 (Fri May  4 15:08:00 EEST 2001).
C110: ----------------------------------------------------------------
C110: Card Inserted. Initializing...
C110: Config: index 0x01: Vcc 5.0, irq 3, io 0x0100-0x010f
kernel BUG at slab.c:1099!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012c306>]    Tainted: P
EFLAGS: 00010282
eax: 0000001b   ebx: 00000007   ecx: c0262520   edx: 000019ea
esi: c7fdd1f0   edi: c7fdd1f8   ebp: c7fdd1f0   esp: c5f8bbbc
ds: 0018   es: 0018   ss: 0018
Process cardmgr (pid: 1012, stackpage=c5f8b000)
Stack: c0234c23 0000044b c126ce00 c126c830 c01dc350 c126ce00 c0252e49
c02748e8
       c7fdd1f0 00000202 c7fdd1f8 c7fdd1f0 c012c6c3 c7fdd1f0 00000007
c126cc00
       00000000 c88a612f c5f599ac 00000100 c126ce05 c5f59a11 c5f59980
c88aa450
Call Trace: [<c01dc350>] [<c012c6c3>] [<c88a612f>] [<c88aa450>] [<c88b17a0>]
   [<c88a67e4>] [<c8892075>] [<c017077e>] [<c88b2fe0>] [<c88a7100>]
[<c889f98f>]
   [<c88a1400>] [<c88a36a4>] [<c88a4166>] [<c01d6e4c>] [<c01d6367>]
[<c01d88f9>]
   [<c0219a94>] [<c013d4a0>] [<c01d3e2f>] [<c01d6a59>] [<c01d4bbc>]
[<c012d075>]
   [<c0123e58>] [<c0125d0d>] [<c01260b4>] [<c0141617>] [<c0106f23>]

Code: 0f 0b 5d 58 f7 c3 00 10 00 00 0f 85 d8 01 00 00 a1 68 76 2c
 <6>Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
device eth0 entered promiscuous mode

[6.] A small shell script or example program which triggers the
     problem (if possible)
N/A

[7.] Environment
mandrake 8.2 cleaninstalled with default options

[7.1.] Software (add the output of the ver_linux script here)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux test 2.4.18-6mdk #1 Fri Mar 15 02:59:08 CET 2002 i586 unknown

Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.13
e2fsprogs              1.26
pcmcia-cs              3.1.31
PPP                    2.4.1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         nfsd lockd sunrpc nokia_c110 ds i82365 pcmcia_core
af_packet ip_vs ipchains usb-uhci usbcore ne2k-pci 8390 supermount rtc ext3
jbd

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 4
model name      : Pentium MMX
stepping        : 3
cpu MHz         : 167.048
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mmx
bogomips        : 333.41

[7.3.] Module information (from /proc/modules):
nfsd                   69536   8 (autoclean)
lockd                  49344   1 (autoclean) [nfsd]
sunrpc                 62964   1 (autoclean) [nfsd lockd]
nokia_c110             58468   0 (unused)
ds                      6848   1 [nokia_c110]
i82365                 13504   2
pcmcia_core            41824   0 [nokia_c110 ds i82365]
af_packet              12488   2 (autoclean)
ip_vs                  65400   0 (autoclean)
ipchains               35816   0
usb-uhci               21668   0 (unused)
usbcore                59072   1 [usb-uhci]
ne2k-pci                5120   1 (autoclean)
8390                    6416   0 (autoclean) [ne2k-pci]
supermount             62180   1 (autoclean)
rtc                     5912   0 (autoclean)
ext3                   62092   1
jbd                    39356   1 [ext3]


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
ioports:
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0100-010f : nc110_cs
01f0-01f7 : ide0
0213-0213 : isapnp read
02f8-02ff : serial(auto)
03c0-03df : vga+
03e0-03e1 : i82365
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
d400-d41f : Realtek Semiconductor Co., Ltd. RTL-8029(AS)
  d400-d41f : ne2k-pci
d800-d81f : Intel Corp. 82371AB PIIX4 USB
  d800-d81f : usb-uhci
e000-e00f : Intel Corp. 82371AB PIIX4 IDE
  e000-e007 : ide0
  e008-e00f : ide1
e400-e43f : Intel Corp. 82371AB PIIX4 ACPI
e800-e81f : Intel Corp. 82371AB PIIX4 ACPI

iomem:
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0100-010f : nc110_cs
01f0-01f7 : ide0
0213-0213 : isapnp read
02f8-02ff : serial(auto)
03c0-03df : vga+
03e0-03e1 : i82365
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
d400-d41f : Realtek Semiconductor Co., Ltd. RTL-8029(AS)
  d400-d41f : ne2k-pci
d800-d81f : Intel Corp. 82371AB PIIX4 USB
  d800-d81f : usb-uhci
e000-e00f : Intel Corp. 82371AB PIIX4 IDE
  e000-e007 : ide0
  e008-e00f : ide1
e400-e43f : Intel Corp. 82371AB PIIX4 ACPI
e800-e81f : Intel Corp. 82371AB PIIX4 ACPI
[root@test root]# less /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d0000-000d0fff : card services
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-00224a95 : Kernel code
  00224a96-00277d6b : Kernel data
e6000000-e67fffff : Matrox Graphics, Inc. MGA 1064SG [Mystique]
e6800000-e6803fff : Matrox Graphics, Inc. MGA 1064SG [Mystique]
e7800000-e7ffffff : Matrox Graphics, Inc. MGA 1064SG [Mystique]
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corp. 430TX - 82439TX MTXC (rev 01)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32

00:01.0 ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:01.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01) (prog-if 80
[Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 4: I/O ports at e000 [size=16]

00:01.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01) (prog-if 00
[UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at d800 [size=32]

00:01.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 01)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8029(AS)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at d400 [size=32]

00:0c.0 VGA compatible controller: Matrox Graphics, Inc. MGA 1064SG
[Mystique] (rev 03) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. MGA 1064SG [Mystique]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e7800000 (32-bit, prefetchable) [size=8M]
        Region 1: Memory at e6800000 (32-bit, non-prefetchable) [size=16K]
        Region 2: Memory at e6000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]



[7.6.] SCSI information (from /proc/scsi/scsi)
N/A


Hope this is what you need.
Rune

