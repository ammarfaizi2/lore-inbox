Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbVHVW7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbVHVW7j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbVHVW7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:59:38 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:56718 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932310AbVHVW7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:59:35 -0400
Message-ID: <001001c5a6c9$7a0e1df0$6301a8c0@finian.net>
From: "Terry" <tmacmill@rivernet.net>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: Incorrect RAM Detected at kernel init
Date: Sun, 21 Aug 2005 23:27:51 -0400
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2670
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure if I have provided enough info, or to much info, but here it goes:

[1.] One line summary of the problem:
Not Detecting all the memory installed in the system.

[2.] Full description of the problem/report:
I have Linux Kernel 2.4.31 running on a Compaq 5000R server with 2 PPro 200
processors, 768M RAM, RealTeck 8139 Network Card, and Compaq Smart 2 Raid
controller with 5 9.1G drives in Raid 5 configuration.
The kernel appears to compile perfectly, installs fine, but after reboot it
is only reporting 16M of RAM. I have tried with and without the mem=768M
boot up option in the lilo.conf script. All other modules and boot up
includes appear to run perfectly fine. I had a 2.4.18 kernel running on this
box just fine, detected all 768M of RAM and ran perfectly. The 2.4.31 Kernel
runs almost perfectly, the only hold back is the false detection of memory.

[3.] Keywords (i.e., modules, networking, kernel):
kernel

[4.] Kernel version (from /proc/version):
Linux version 2.4.31 (root@tunes) (gcc version 3.3.4) #3 SMP Sun Aug 21 
10:34:35 EDT 2005

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

[6.] A small shell script or example program which triggers the
     problem (if possible)
N/A

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux tunes 2.4.31 #1 SMP Sun Aug 14 11:08:56 EDT 2005 i686 unknown unknown
GNU/
Linux

Gnu C                  3.3.4
Gnu make               3.80
util-linux             2.12p
mount                  2.12p
modutils               2.4.27
e2fsprogs              1.35
quota-tools            3.12.
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Linux C++ Library      5.0.6
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         8139too mii

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 1
model name      : Pentium Pro
stepping        : 9
cpu MHz         : 200.003
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
bogomips        : 398.95

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 1
model name      : Pentium Pro
stepping        : 9
cpu MHz         : 200.003
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
bogomips        : 399.76

[7.3.] Module information (from /proc/modules):
sym53c8xx_2            70688   0 (unused)
scsi_mod               91412   1 [sym53c8xx_2]
8139too                14760   1
mii                     2560   0 [8139too]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
0000-001f : dma1
0020-003f : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
02f8-02ff : serial(auto)
03c0-03df : vga+
03f8-03ff : serial(auto)
5000-50ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  5000-50ff : 8139too
6000-60ff : LSI Logic / Symbios Logic 53c825
  6000-607f : sym53c8xx
7000-7fff : PCI Bus #02
  7000-70ff : Compaq Computer Corporation Smart-2/P RAID Controller
    7000-70ff : cpqarray
root@tunes:/proc# more iomem
00000000-0009efff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cbfff : Extension ROM
000f0000-000fffff : System ROM
00100000-00efffff : System RAM
  00100000-00252746 : Kernel code
  00252747-0029ceff : Kernel data
c2800000-c2ffffff : Matrox Graphics, Inc. MGA 1064SG [Mystique]
c37fbf00-c37fbfff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  c37fbf00-c37fbfff : 8139too
c37fc000-c37fffff : Matrox Graphics, Inc. MGA 1064SG [Mystique]
c3800000-c3ffffff : Matrox Graphics, Inc. MGA 1064SG [Mystique]
c4000000-c5ffffff : PCI Bus #02
  c4000000-c5ffffff : Compaq Computer Corporation Smart-2/P RAID Controller
c6efff00-c6efffff : LSI Logic / Symbios Logic 53c825
c6f00000-c6ffffff : PCI Bus #02
  c6ffff00-c6ffffff : Compaq Computer Corporation Smart-2/P RAID Controller

[7.5.] PCI information ('lspci -vvv' as root)
00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/813
C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Ste
ping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbor
- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at 5000 [size=256]
        Region 1: Memory at c37fbf00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3ho
+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 VGA compatible controller: Matrox Graphics, Inc. MGA 1064SG
[Mystique]
rev 02) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc.: Unknown device 0300
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Ste
ping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbor
- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at c37fc000 (32-bit, non-prefetchable) [size=16K]
        Region 1: Memory at c2800000 (32-bit, prefetchable) [size=8M]
        Region 2: Memory at c3800000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:0f.0 Non-VGA unclassified device: Intel Corp. 82375EB (rev 15)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Ste
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbor
- <MAbort- >SERR- <PERR-
        Latency: 248

00:14.0 RAM memory: Intel Corp. 450KX/GX [Orion] - 82453KX/GX Memory
controller
(rev 05)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Ste
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort-
<MAbort- >SERR- <PERR-

00:19.0 Host bridge: Intel Corp. 450KX/GX [Orion] - 82454KX/GX PCI bridge
(rev
6)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+
Ste
ping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbor
- <MAbort+ >SERR- <PERR-
        Latency: 32, cache line size 08

00:1a.0 Host bridge: Intel Corp. 450KX/GX [Orion] - 82454KX/GX PCI bridge
(rev
6)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+
Ste
ping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbor
- <MAbort+ >SERR- <PERR-
        Latency: 32, cache line size 08

01:0a.0 SCSI storage controller: LSI Logic / Symbios Logic 53c825 (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Ste
ping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbor
- <MAbort- >SERR- <PERR-
        Latency: 255
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at 6000 [size=256]
        Region 1: Memory at c6efff00 (32-bit, non-prefetchable) [size=256]

01:0e.0 PCI bridge: IBM IBM27-82351 (rev 01) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Ste
ping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbor
- <MAbort- >SERR- <PERR-
        Latency: 96, cache line size 08
        Bus: primary=01, secondary=02, subordinate=02, sec-latency=248
        I/O behind bridge: 00007000-00007fff
        Memory behind bridge: c6f00000-c6ffffff
        Prefetchable memory behind bridge: c4000000-c5ffffff
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

01:0f.0 Non-VGA unclassified device: Intel Corp. 82375EB (rev 15)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Ste
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbor
- <MAbort- >SERR- <PERR-

02:00.0 Unknown mass storage controller: Compaq Computer Corporation
Smart-2/P
AID Controller (rev 02)
        Subsystem: Compaq Computer Corporation Smart-2/P Array Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Ste
ping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbor
- <MAbort- >SERR- <PERR-
        Latency: 0, cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 7000 [size=256]
        Region 1: Memory at c6ffff00 (32-bit, non-prefetchable) [size=256]
        Region 2: Memory at c4000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at <unassigned> [disabled] [size=16K]

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: COMPAQ   Model: CRD-254V         Rev: 1.06
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: IBM      Model: CDRM00203     !K Rev: 8B08
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

[X.] Other notes, patches, fixes, workarounds: 



-- 
No virus found in this outgoing message.
Checked by AVG Anti-Virus.
Version: 7.0.338 / Virus Database: 267.10.13/78 - Release Date: 8/19/2005

