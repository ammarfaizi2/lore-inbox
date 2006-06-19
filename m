Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWFSKSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWFSKSI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 06:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWFSKSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 06:18:08 -0400
Received: from bay106-dav24.bay106.hotmail.com ([65.54.161.96]:41357 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S932347AbWFSKSF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 06:18:05 -0400
Message-ID: <BAY106-DAV24D0AA7BAA7A946D8C92A5DD860@phx.gbl>
X-Originating-IP: [151.82.1.26]
X-Originating-Email: [milanraf@hotmail.com]
From: "Raf" <milanraf@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: KERNEL OOPS: Unable to handle kernel paging request at virtual address 6c000000
Date: Mon, 19 Jun 2006 12:17:30 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-OriginalArrivalTime: 19 Jun 2006 10:18:05.0590 (UTC) FILETIME=[A774F360:01C69389]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] Server freezed after OOPS: Unable to handle kernel paging request at 
virtual address 6c000000

[2.] The server machine freezed after OOPS. Unable to read screen output. 
Appears randomly. Appears also in no-load moments.

[3.] kernel, firewire, ext3, kernel paging

[4.] Linux 2.6.16-1.2111_FC4 #1 Sat May 20 19:59:40 EDT 2006 i686 i686 i386 
GNU/Linux

[5.]
Jun 16 04:00:05 backup kernel:  <1>Unable to handle kernel paging request at 
virtual address 6c000000
Jun 16 04:00:05 backup kernel:  printing eip:
Jun 16 04:00:05 backup kernel: c0170387
Jun 16 04:00:05 backup kernel: *pde = 00000000
Jun 16 04:00:05 backup kernel: Oops: 0000 [#2]
Jun 16 04:00:05 backup kernel: last sysfs file: /class/vc/vcs4/dev
Jun 16 04:00:05 backup kernel: Modules linked in: ipv6 autofs4 sg sd_mod 
sbp2 scsi_mod dm_mod video button battery ac ohci1394 ieee1394 ohci_hcd 
ehci_hcd sis900 mii r8169 floppy ext3 jbd
Jun 16 04:00:05 backup kernel: CPU:    0
Jun 16 04:00:05 backup kernel: EIP:    0060:[<c0170387>]    Not tainted VLI
Jun 16 04:00:05 backup kernel: EFLAGS: 00010206   (2.6.16-1.2111_FC4 #1)
Jun 16 04:00:11 backup kernel: EIP is at __d_lookup+0x58/0x104
Jun 16 04:00:16 backup kernel: eax: 6c000000   ebx: 6c000000   ecx: 00000010 
edx: 00002751
Jun 16 04:00:16 backup kernel: esi: c9263e44   edi: c9263f10   ebp: d597fca8 
esp: c9263da4
Jun 16 04:00:16 backup kernel: ds: 007b   es: 007b   ss: 0068
Jun 16 04:00:16 backup kernel: Process BackupPC_nightl (pid: 21574, 
threadinfo=c9263000 task=ddfde000)
Jun 16 04:00:16 backup kernel: Stack: <0>d7c7b240 00002751 dd3e564c c01d952f 
c9263e44 d7c7b248 c9263000 00000001
Jun 16 04:00:16 backup kernel:        d79db018 c9263e44 c9263e44 c9263f10 
c9263e50 c0166e34 ddfe39c0 de88b540
Jun 16 04:00:16 backup kernel:        00000001 c0166108 00002751 c9263e44 
00000000 d79db019 c0167727 00000000
Jun 16 04:00:16 backup kernel: Call Trace:
Jun 16 04:00:16 backup kernel:  [<c01d952f>] _atomic_dec_and_lock+0x27/0x38
Jun 16 04:00:16 backup kernel:  [<c0166e34>] do_lookup+0x1a/0x150 
[<de88b540>] ext3_permission+0x0/0xa [ext3]
Jun 16 04:00:16 backup kernel:  [<c0166108>] permission+0x6d/0xa3 
[<c0167727>] __link_path_walk+0x7bd/0xeee
Jun 16 04:00:16 backup kernel:  [<c015dc54>] __find_get_block+0x152/0x188 
[<c0167e9b>] link_path_walk+0x43/0xc7
Jun 16 04:00:16 backup kernel:  [<c0171058>] file_update_time+0x2d/0x8b 
[<c013b34c>] audit_syscall_entry+0x11a/0x13b
Jun 16 04:00:16 backup kernel:  [<c0158aac>] sys_chdir+0x3c/0x61 
[<c0168330>] do_path_lookup+0x110/0x27c
Jun 16 04:00:16 backup kernel:  [<c0165ed7>] getname+0x87/0xc5 
[<c01689c8>] __user_walk_fd+0x2f/0x42
Jun 16 04:00:16 backup kernel:  [<c016203f>] vfs_stat_fd+0x19/0x40 
[<c0171058>] file_update_time+0x2d/0x8b
Jun 16 04:00:16 backup kernel:  [<c013b34c>] audit_syscall_entry+0x11a/0x13b 
[<c0158aac>] sys_chdir+0x3c/0x61
Jun 16 04:00:16 backup kernel:  [<c01627fe>] sys_stat64+0xf/0x31 
[<c010538d>] do_syscall_trace+0x1ad/0x1c5
Jun 16 04:00:16 backup kernel:  [<c0102d35>] syscall_call+0x7/0xb 
<0>Code: 9e c1 e8 07 01 d0 89 c2 81 f2 01 00 37 9e 8b 0d 04 2d 44 c0 d3 ea 
31 d0 23 05 08 2d 44 c0 8b 15 00 2d 44 c0 8b 1c 82 85 db 74 20 <8b> 03 0f 18 
00 90 8d 6b e4 8b 54 24 04 3b 55 28 75 08 8b 34 24
Continuing in 85 seconds.  el: Continuing in 120 seconds.
Continuing in 48 seconds. nel: tinuing in 84 seconds.
Continuing in 11 seconds. nel: tinuing in 47 seconds.
Continuing in 1 seconds. rnel: tinuing in 10 seconds.

[6.] The problem appeared during hard file working on external 1TB FIREWIRE 
RAID MODULE EXT3 FORMATTED

[7.]
Linux Fedora Core 4 on i686 Intel chipset pc
256 MB memory
4GB swap partition
system on internal IDE 80GB disk
data on external Firewire 1TB Raid Disk Module
Gigabit NIC r8169

[7.1.]
Linux backup.noa.local 2.6.16-1.2111_FC4 #1 Sat May 20 19:59:40 EDT 2006 
i686 i686 i386 GNU/Linux

Gnu C                  4.0.0
Gnu make               3.80
binutils               2.15.94.0.2.2
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2-pre9
e2fsprogs              1.37
reiserfsprogs          3.6.19
reiser4progs           line
quota-tools            3.12.
PPP                    2.4.2
isdn4k-utils           3.7
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   071
Modules Loaded         loop ipv6 autofs4 sg sd_mod sbp2 scsi_mod dm_mod 
video button battery ac ohci1394 ieee1394 ohci_hcd ehci_hcd sis900 mii r8169 
floppy ext3 jbd

[7.2.]
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping        : 9
cpu MHz         : 2806.819
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips        : 5619.92

[7.3.]
loop 15945 0 - Live 0xde9db000
ipv6 249217 22 - Live 0xdec56000
autofs4 19397 2 - Live 0xde9d5000
sg 34909 0 - Live 0xdea0c000
sd_mod 18369 2 - Live 0xde9cf000
sbp2 21829 1 - Live 0xde9c8000
scsi_mod 132301 3 sg,sd_mod,sbp2, Live 0xde9ea000
dm_mod 53973 0 - Live 0xde8f2000
video 15173 0 - Live 0xde8d8000
button 6609 0 - Live 0xde8d2000
battery 9413 0 - Live 0xde8dd000
ac 4933 0 - Live 0xde8d5000
ohci1394 34821 0 - Live 0xde8c0000
ieee1394 296473 2 sbp2,ohci1394, Live 0xde90a000
ohci_hcd 21725 0 - Live 0xde89a000
ehci_hcd 31949 0 - Live 0xde8a5000
sis900 23489 0 - Live 0xde86e000
mii 5697 1 sis900, Live 0xde856000
r8169 29513 0 - Live 0xde85d000
floppy 63869 0 - Live 0xde831000
ext3 128329 3 - Live 0xde879000
jbd 56789 1 ext3, Live 0xde844000

[7.4.]
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
1000-1003 : PM1a_EVT_BLK
1004-1005 : PM1a_CNT_BLK
1008-100b : PM_TMR
1016-1016 : PM2_CNT_BLK
1020-1023 : GPE0_BLK
1030-1033 : GPE1_BLK
4000-400f : 0000:00:02.5
  4000-4007 : ide0
  4008-400f : ide1
d000-dfff : PCI Bus #01
  d000-d07f : 0000:01:00.0
e000-e0ff : 0000:00:04.0
  e000-e0ff : sis900
e100-e1ff : 0000:00:06.0
  e100-e1ff : r8169
e200-e27f : 0000:00:07.0

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1dfeffff : System RAM
  00100000-00314d67 : Kernel code
  00314d68-003d1503 : Kernel data
1dff0000-1dff2fff : ACPI Non-volatile Storage
1dff3000-1dffffff : ACPI Tables
20000000-2001ffff : 0000:00:04.0
20020000-2003ffff : 0000:00:06.0
e0000000-e7ffffff : PCI Bus #01
  e0000000-e7ffffff : 0000:01:00.0
e8000000-ebffffff : 0000:00:00.0
ec000000-ec0fffff : PCI Bus #01
  ec000000-ec01ffff : 0000:01:00.0
ec120000-ec120fff : 0000:00:03.1
  ec120000-ec120fff : ohci_hcd
ec121000-ec121fff : 0000:00:03.2
  ec121000-ec121fff : ohci_hcd
ec122000-ec122fff : 0000:00:03.3
  ec122000-ec122fff : ehci_hcd
ec123000-ec123fff : 0000:00:04.0
  ec123000-ec123fff : sis900
ec124000-ec1240ff : 0000:00:06.0
  ec124000-ec1240ff : r8169
ec125000-ec1257ff : 0000:00:07.0
  ec125000-ec1257ff : ohci1394
ec126000-ec126fff : 0000:00:03.0
  ec126000-ec126fff : ohci_hcd
fec00000-ffffffff : reserved

[7.5.]
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 661FX/M661FX/M661MX 
Host (rev 11)
        Subsystem: Silicon Integrated Systems [SiS] 661FX/M661FX/M661MX Host
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=64M]
        Capabilities: [c0] AGP version 3.5
                Status: RQ=32 Iso- ArqSz=2 Cal=3 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>

00:01.0 PCI bridge: Silicon Integrated Systems [SiS]: Unknown device 0003 
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: ec000000-ec0fffff
        Prefetchable memory behind bridge: e0000000-e7ffffff
        Secondary status: 66Mhz+ FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS964 [MuTIOL Media 
IO] (rev 36)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev 01) 
(prog-if 80 [Master])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7060
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Interrupt: pin ? routed to IRQ 16
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at 4000 [size=16]
        Capabilities: [58] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller 
(rev 0f) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7060
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at ec126000 (32-bit, non-prefetchable) [size=4K]

00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller 
(rev 0f) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7060
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), Cache Line Size 08
        Interrupt: pin B routed to IRQ 21
        Region 0: Memory at ec120000 (32-bit, non-prefetchable) [size=4K]

00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller 
(rev 0f) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7060
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), Cache Line Size 08
        Interrupt: pin C routed to IRQ 22
        Region 0: Memory at ec121000 (32-bit, non-prefetchable) [size=4K]

00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 Controller 
(prog-if 20 [EHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 5332
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max)
        Interrupt: pin D routed to IRQ 19
        Region 0: Memory at ec122000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 PCI 
Fast Ethernet (rev 90)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7060
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (13000ns min, 2750ns max)
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at e000 [size=256]
        Region 1: Memory at ec123000 (32-bit, non-prefetchable) [size=4K]
        [virtual] Expansion ROM at 20000000 [disabled] [size=128K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 
Gigabit Ethernet (rev 10)
        Subsystem: ZyXEL Communication Corporation: Unknown device 330b
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max), Cache Line Size 20
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at e100 [size=256]
        Region 1: Memory at ec124000 (32-bit, non-prefetchable) [size=256]
        [virtual] Expansion ROM at 20020000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host 
Controller (rev 46) (prog-if 10 [OHCI])
        Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 23
        Region 0: Memory at ec125000 (32-bit, non-prefetchable) [size=2K]
        Region 1: I/O ports at e200 [size=128]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 
661/741/760 PCI/AGP VGA Display Adapter (prog-if 00 [VGA])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7060
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 5
        BIST result: 00
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at ec000000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at d000 [size=128]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] AGP version 3.0
                Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>

[7.6.]
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: DP-405CI Model:         Volume S Rev: 0100
  Type:   Direct-Access-RBC                ANSI SCSI revision: 04

