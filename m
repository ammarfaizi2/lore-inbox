Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266123AbUAQTnj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 14:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266132AbUAQTnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 14:43:39 -0500
Received: from power.vereya.net ([62.73.72.3]:37980 "HELO power.vereya.net")
	by vger.kernel.org with SMTP id S266123AbUAQTmv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 14:42:51 -0500
Message-ID: <00e201c3dd32$25bde0d0$8648493e@ixip.net>
From: "Condor" <condor@vereya.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.24 may be bug in prints.c:341
Date: Sat, 17 Jan 2004 21:42:46 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

1. My server stop work after trying to access hard drives.
2. My server have kernel panic when trying to access hard drives. I don't
now what is the real problem,
one moment work, and kernel panic. Here are error message:


Jan 15 19:59:00 heaven kernel: reiserfs: found format "3.6" with standard
journal
Jan 15 19:59:20 heaven kernel: reiserfs: checking transaction log (device
sd(8,1)) ...
Jan 15 19:59:20 heaven kernel: for (sd(8,1))
Jan 15 19:59:20 heaven kernel: sd(8,1):Using r5 hash to sort names
Jan 15 21:34:03 heaven kernel: 3w-xxxx: scsi0: Command failed: status =
0xc7, flags = 0x1b, unit #2.
Jan 15 21:34:03 heaven last message repeated 27 times
Jan 15 21:34:07 heaven kernel: 3w-xxxx: scsi0: Command failed: status =
0xc7, flags = 0xd0, unit #2.
Jan 15 21:34:25 heaven last message repeated 5 times
Jan 15 21:34:28 heaven kernel: 3w-xxxx: scsi0: AEN: WARNING: ATA port
timeout: Port #2.
Jan 15 21:34:29 heaven last message repeated 18 times
Jan 15 21:34:29 heaven kernel: 3w-xxxx: scsi0: AEN: INFO: AEN queue
overflow.
Jan 15 21:34:31 heaven kernel: 3w-xxxx: scsi0: Reset succeeded.
Jan 16 01:53:39 heaven kernel: Device busy for revalidation (usage=2)
Jan 16 01:55:17 heaven kernel: is_tree_node: node level 0 does not match to
the expected one -1
Jan 16 01:55:17 heaven kernel: sd(8,1):vs-5150: search_by_key: invalid
format found in block 0. Fsck?
Jan 16 01:55:17 heaven kernel: sd(8,1):vs-13050: reiserfs_update_sd: i/o
failure occurred trying to update [403 8975 0x0 SD] stat data
Jan 16 01:55:18 heaven kernel: is_tree_node: node level 0 does not match to
the expected one -1
Jan 16 01:55:18 heaven kernel: sd(8,1):vs-5150: search_by_key: invalid
format found in block 0. Fsck?
Jan 16 01:55:18 heaven kernel: sd(8,1):vs-13050: reiserfs_update_sd: i/o
failure occurred trying to update [403 8975 0x0 SD] stat data
Jan 16 01:55:19 heaven kernel: journal-003: journal_end: j_start (4757) is
too high
Jan 16 01:55:19 heaven kernel:  (device sd(8,1))
Jan 16 01:55:19 heaven kernel: kernel BUG at prints.c:341!
Jan 16 01:55:19 heaven kernel: invalid operand: 0000
Jan 16 01:55:19 heaven kernel: CPU:    1
Jan 16 01:55:19 heaven kernel: EIP:    0010:[<c01a3eb8>]    Not tainted
Jan 16 01:55:19 heaven kernel: EFLAGS: 00010286
Jan 16 01:55:19 heaven kernel: eax: 0000004a   ebx: eac82800   ecx: 00000000
edx: f6febf7c
Jan 16 01:55:19 heaven kernel: esi: 00000000   edi: c2849ed4   ebp: 00000002
esp: c2849e24
Jan 16 01:55:19 heaven kernel: ds: 0018   es: 0018   ss: 0018
Jan 16 01:55:19 heaven kernel: Process kupdated (pid: 7, stackpage=c2849000)
Jan 16 01:55:19 heaven kernel: Stack: c0270d4d c0324fc0 c0323560 eac82800
c01b33f9 eac82800 c027b9a0 00001295
Jan 16 01:55:19 heaven kernel:        00000296 00000001 00000004 eac82800
00000006 c2849ed4 00000000 c01b39e7
Jan 16 01:55:19 heaven kernel:        c2849ed4 eac82800 00000001 00000006
f899d38c 00000000 00000024 00000004
Jan 16 01:55:19 heaven kernel: Call Trace:    [<c01b33f9>] [<c01b39e7>]
[<c01b30e7>] [<c01a0c50>] [<c014785c>]
Jan 16 01:55:19 heaven kernel:   [<c014684c>] [<c0146c02>] [<c0107652>]
[<c0146ac0>] [<c0105000>] [<c01058be>]
Jan 16 01:55:19 heaven kernel:   [<c0146ac0>]
Jan 16 01:55:19 heaven kernel:
Jan 16 01:55:19 heaven kernel: Code: 0f 0b 55 01 60 0d 27 c0 85 db 74 0e 0f
b7 43 08 89 04 24 e8

7.1. sh scripts/ver_linux is:
Linux vcable 2.4.24-ow1 #5 SMP Wed Jan 14 17:52:34 EET 2004 i686 unknown

Gnu C                  3.2.2
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
modutils               2.4.22
e2fsprogs              1.32
jfsutils               1.1.1
reiserfsprogs          3.6.4
quota-tools            3.08.
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Linux C++ Library      5.0.2
Procps                 3.1.8
Net-tools              1.60
Kbd                    1.08
Sh-utils               2.0
Modules Loaded         ipt_REJECT ide-scsi iptable_filter ip_tables 3w-xxxx
e100 rtc sd_mod scsi_mod unix

7.2. proc/cpu:
# more /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 11
model name      : Intel(R) Pentium(R) III CPU family      1266MHz
stepping        : 1
cpu MHz         : 1263.496
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
cmov pat pse36 mmx fxsr sse
bogomips        : 2523.13

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 11
model name      : Intel(R) Pentium(R) III CPU family      1266MHz
stepping        : 1
cpu MHz         : 1263.496
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
cmov pat pse36 mmx fxsr sse
bogomips        : 2523.13

7.3. proc/modules
ipt_REJECT              3480   3 (autoclean)
ide-scsi               10512   0
iptable_filter          1740   1
ip_tables              16064   2 [ipt_REJECT iptable_filter]
3w-xxxx                37120   4
e100                   50852   1
rtc                     7836   0 (autoclean)
sd_mod                 12044   8 (autoclean)
scsi_mod               98548   3 (autoclean) [ide-scsi 3w-xxxx sd_mod]
unix                   17640  11 (autoclean)

7.4. Loaded driver and hardware information (/proc/ioports, /proc/iomem)

/proc/ioports:
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03a0-03af : ServerWorks CSB5 IDE Controller
  03a0-03a7 : ide0
  03a8-03af : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0410-0413 : ServerWorks CSB5 IDE Controller
0cf8-0cff : PCI conf1
1000-10ff : ATI Technologies Inc Rage XL
1400-143f : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  1400-143f : e100
1440-147f : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
  1440-147f : e100
2000-200f : 3ware Inc 3ware 7000-series ATA-RAID
  2000-200f : 3ware Storage Controller

/proc/iomem :
00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c8fff : Extension ROM
000c9800-000cafff : Extension ROM
000cb000-000cc7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-7ffeffff : System RAM
  00100000-0025e632 : Kernel code
  0025e633-002a72df : Kernel data
7fff0000-7fffefff : ACPI Tables
7ffff000-7fffffff : ACPI Non-volatile Storage
fc000000-fcffffff : ATI Technologies Inc Rage XL
fda60000-fda7ffff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
  fda60000-fda7ffff : e100
fda80000-fda80fff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
  fda80000-fda80fff : e100
fdaa0000-fdabffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  fdaa0000-fdabffff : e100
fdae0000-fdae0fff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  fdae0000-fdae0fff : e100
fdaf0000-fdaf0fff : ATI Technologies Inc Rage XL
fe000000-fe7fffff : 3ware Inc 3ware 7000-series ATA-RAID
febf0000-febf000f : 3ware Inc 3ware 7000-series ATA-RAID
fec00000-fec01fff : reserved
fee00000-fee00fff : reserved
fff00000-ffffffff : reserved

7.5. lspci -vvv
00:00.0 Host bridge: ServerWorks CNB20HE Host Bridge (rev 23)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:00.1 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64, cache line size 08

00:00.2 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-

00:00.3 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-

00:03.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
0d)
        Subsystem: Intel Corp.: Unknown device 3410
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 21
        Region 0: Memory at fdae0000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 1400 [size=64]
        Region 2: Memory at fdaa0000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at fda90000 [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
0d)
        Subsystem: Intel Corp.: Unknown device 3410
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at fda80000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 1440 [size=64]
        Region 2: Memory at fda60000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at fda50000 [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0c.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
(prog-if 00 [VGA])
        Subsystem: Intel Corp.: Unknown device 3410
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at 1000 [size=256]
        Region 2: Memory at fdaf0000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at fdac0000 [disabled] [size=128K]
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 92)
        Subsystem: Intel Corp.: Unknown device 3410
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32

00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 92) (prog-if 8a
[Master SecP PriP])
        Subsystem: Intel Corp.: Unknown device 3410
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at 03a0 [size=16]
        Region 5: I/O ports at 0410 [size=4]

00:0f.3 Host bridge: ServerWorks: Unknown device 0230
        Subsystem: Intel Corp.: Unknown device 3410
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 10

01:08.0 RAID bus controller: 3ware Inc 3ware 7000-series ATA-RAID (rev 01)
        Subsystem: 3ware Inc 3ware 7000-series ATA-RAID
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2250ns min), cache line size 08
        Interrupt: pin A routed to IRQ 31
        Region 0: I/O ports at 2000 [size=16]
        Region 1: Memory at febf0000 (32-bit, non-prefetchable) [size=16]
        Region 2: Memory at fe000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at febe0000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

7.6. SCSI information (from /proc/scsi/scsi):

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: 3ware    Model: Logical Disk 0   Rev: 1.0
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: 3ware    Model: Logical Disk 1   Rev: 1.0
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: 3ware    Model: Logical Disk 2   Rev: 1.0
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: 3ware    Model: Logical Disk 3   Rev: 1.0
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: 3ware    Model: Logical Disk 4   Rev: 1.0
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff


Any body can say me where is error, and how to fix ?

Best Regards,
Condor



