Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132238AbRANSAZ>; Sun, 14 Jan 2001 13:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132413AbRANSAQ>; Sun, 14 Jan 2001 13:00:16 -0500
Received: from dsl254-036-092-sea1.dsl-isp.net ([216.254.36.92]:15488 "EHLO
	shockwave.linux2go.org") by vger.kernel.org with ESMTP
	id <S132238AbRANSAH>; Sun, 14 Jan 2001 13:00:07 -0500
Message-ID: <3A61E91C.F375EE82@linux2go.org>
Date: Sun, 14 Jan 2001 12:59:56 -0500
From: Bruce Collins <bruce@linux2go.org>
Organization: Celestial Systems, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: aic7xxx hangs 2.4.0 with SMP
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1]
aic7xxx hangs 2.4.0 with SMP
[2]
SCSI device errors that only occur in a SMP machine with an aic7xxx with
2.4.0.  The problem manifests itself with multiple SCSI bus resets and
data error.
[3]
SMP SCSI aic7xxx
[4]
Linux version 2.4.0 (root@shockwave.linux2go.org) (gcc version
egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #5 SMP Sun Jan 14
10:01:24 EST 2001a
[5]
N/A
[6]
N/A
[7]
N/A
[7.1]
Linux shockwave.linux2go.org 2.4.0 #5 SMP Sun Jan 14 10:01:24 EST 2001
i686 unknown
Kernel modules         2.3.16
Gnu C                  egcs-2.91.66
Gnu Make               3.77
Binutils               2.9.1.0.24
Linux C Library        2.1.3
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.4
Mount                  2.9u
Net-tools              1.57
Console-tools          1999.03.02
Sh-utils               2.0
Modules Loaded         tvaudio bttv msp3400 tuner i2c-algo-bit i2c-core
videodev rtc ip_nat_ftp ip_conntrack_ftp ipt_MASQUERADE iptable_filter
iptable_nat ip_conntrack ip_tables vmnet vmmon eepro100 st nls_iso8859-1
nls_cp437 vfat fat es1371 ac97_codec soundcore unix
[7.2]
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 551.255
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1101.00

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 551.255
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1101.00
[7.3]
tvaudio                 8208   0 (autoclean) (unused)
bttv                   57904   2 (autoclean)
msp3400                13904   0 (autoclean) (unused)
tuner                   3296   1 (autoclean)
i2c-algo-bit            7296   2 (autoclean) [bttv]
i2c-core               12112   0 (autoclean) [tvaudio bttv msp3400 tuner
i2c-algo-bit]
videodev                4960   6 (autoclean) [bttv]
rtc                     6320   0 (unused)
ip_nat_ftp              4080   0 (unused)
ip_conntrack_ftp        2560   0 [ip_nat_ftp]
ipt_MASQUERADE          2048   1 (autoclean)
iptable_filter          1920   0 (autoclean) (unused)
iptable_nat            19520   1 [ip_nat_ftp ipt_MASQUERADE]
ip_conntrack           22848   2 [ip_nat_ftp ip_conntrack_ftp
ipt_MASQUERADE iptable_nat]
ip_tables              13216   5 [ipt_MASQUERADE iptable_filter
iptable_nat]
vmnet                  16960   3
vmmon                  18288   0 (unused)
eepro100               17312   1 (autoclean)
st                     27664   0 (unused)
nls_iso8859-1           2832   5 (autoclean)
nls_cp437               4352   5 (autoclean)
vfat                   11696   5 (autoclean)
fat                    32480   0 (autoclean) [vfat]
es1371                 31056   5 (autoclean)
ac97_codec              7952   0 (autoclean) [es1371]
soundcore               3920   4 (autoclean) [es1371]
unix                   16816 116 (autoclean)
[7.4]
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
02e8-02ef : serial(set)
02f8-02ff : serial(auto)
03c0-03df : vga+
03f6-03f6 : ide0
0400-043f : Intel Corporation 82371AB PIIX4 ACPI
0800-081f : Intel Corporation 82371AB PIIX4 ACPI
0cf8-0cff : PCI conf1
9000-9fff : PCI Bus #01
  9000-90ff : 3Dfx Interactive, Inc. Voodoo 3
a000-afff : PCI Bus #02
  a000-a0ff : Adaptec 7896
    a000-a0fe : aic7xxx
  a400-a4ff : Adaptec 7896 (#2)
    a400-a4fe : aic7xxx
b000-b03f : Ensoniq ES1371 [AudioPCI-97]
  b000-b03f : es1371
b0c0-b0df : Intel Corporation 82557 [Ethernet Pro 100]
  b0c0-b0df : eepro100
b400-b41f : Intel Corporation 82371AB PIIX4 USB
b440-b44f : Intel Corporation 82371AB PIIX4 IDE
  b440-b447 : ide0

00000000-0009efff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-1fffffff : System RAM
  00100000-001ea9c5 : Kernel code
  001ea9c6-0023a55f : Kernel data
80100000-840fffff : PCI Bus #01
  82000000-83ffffff : 3Dfx Interactive, Inc. Voodoo 3
84100000-841fffff : PCI Bus #02
  84100000-84100fff : Adaptec 7896
  84101000-84101fff : Adaptec 7896 (#2)
84300000-880fffff : PCI Bus #01
  86000000-87ffffff : 3Dfx Interactive, Inc. Voodoo 3
88100000-881fffff : PCI Bus #02
  88100000-88100fff : Brooktree Corporation Bt878 (#2)
    88100000-88100fff : bttv
  88101000-88101fff : Brooktree Corporation Bt878 (#2)
88200000-88200fff : Brooktree Corporation Bt878
  88200000-88200fff : bttv
88201000-88201fff : Brooktree Corporation Bt878
88300000-883fffff : Intel Corporation 82557 [Ethernet Pro 100]
88600000-88600fff : Intel Corporation 82557 [Ethernet Pro 100]
  88600000-88600fff : eepro100
e0000000-e3ffffff : Intel Corporation 440GX - 82443GX Host bridge
[7.5]
00:00.0 Host bridge: Intel Corporation 440GX - 82443GX Host bridge
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64 set
        Region 0: Memory at e0000000 (32-bit, prefetchable)
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=21
                Command: RQ=31 SBA+ AGP- 64bit- FW- Rate=21

00:01.0 PCI bridge: Intel Corporation 440GX - 82443GX AGP bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 set
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: 80100000-840fffff
        Prefetchable memory behind bridge: 84300000-880fffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
(prog-if 80)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 224 set
        Region 4: I/O ports at b440

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 224 set
        Interrupt: pin D routed to IRQ 19
        Region 4: I/O ports at b400

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:0d.0 Multimedia audio controller: Ensoniq ES1371 (rev 08)
        Subsystem: Unknown device 1274:1371
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort+ <MAbort- >SERR- <PERR-
        Latency: 12 min, 128 max, 224 set
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at b000
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI+ D1- D2+ PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 Multimedia video controller: Brooktree Corporation Bt878 (rev
02)
        Subsystem: Unknown device 1851:1851
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 16 min, 40 max, 224 set
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at 88200000 (32-bit, prefetchable)

00:0e.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
        Subsystem: Unknown device 1851:1851
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 4 min, 255 max, 224 set
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at 88201000 (32-bit, prefetchable)

00:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 224 set, cache line size 08
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=224
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: 84100000-841fffff
        Prefetchable memory behind bridge:
0000000088100000-0000000088100000
        BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:10.0 Ethernet controller: Intel Corporation 82557 (rev 05)
        Subsystem: Unknown device 8086:0008
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 56 max, 224 set, cache line size 08
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at 88600000 (32-bit, prefetchable)
        Region 1: I/O ports at b0c0
        Region 2: Memory at 88300000 (32-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr+ DSI+ D1+ D2+ PME+
                Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: 3Dfx Interactive, Inc.: Unknown
device 0005 (rev 01)
        Subsystem: Unknown device 121a:003a
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at 82000000 (32-bit, non-prefetchable)
        Region 1: Memory at 86000000 (32-bit, prefetchable)
        Region 2: I/O ports at 9000
        Capabilities: [54] AGP version 1.0
                Status: RQ=7 SBA+ 64bit+ FW- Rate=21
                Command: RQ=7 SBA+ AGP- 64bit+ FW- Rate=21
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI+ D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:04.0 Multimedia video controller: Brooktree Corporation Bt878 (rev
02)
        Subsystem: Unknown device 0070:13eb
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 16 min, 40 max, 224 set
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at 88100000 (32-bit, prefetchable)

02:04.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
        Subsystem: Unknown device 0070:13eb
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 4 min, 255 max, 224 set
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at 88101000 (32-bit, prefetchable)

02:09.0 SCSI storage controller: Adaptec 7896
        Subsystem: Unknown device 9005:080f
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 39 min, 25 max, 224 set, cache line size 08
        Interrupt: pin A routed to IRQ 23
        BIST result: 00
        Region 0: I/O ports at a000
        Region 1: Memory at 84100000 (64-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:09.1 SCSI storage controller: Adaptec 7896
        Subsystem: Unknown device 9005:080f
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 39 min, 25 max, 224 set, cache line size 08
        Interrupt: pin A routed to IRQ 23
        BIST result: 00
        Region 0: I/O ports at a400
        Region 1: Memory at 84101000 (64-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
[7.6]
Attached devices: 
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DRVS09D          Rev: 0270
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: DRVS09D          Rev: 0140
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: DRVS09D          Rev: 0270
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 03 Lun: 00
  Vendor: SEAGATE  Model: ST39103LC        Rev: 0002
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: SEAGATE  Model: DAT    06240-XXX Rev: 8071
  Type:   Sequential-Access                ANSI SCSI revision: 03
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: ATAPI    Model: CD-ROM DRIVE-40X Rev: T0DP
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 01 Lun: 00
  Vendor: HP       Model: CD-Writer+ 7200  Rev: 3.01
  Type:   CD-ROM                           ANSI SCSI revision: 02
[7.7]
Output from messages:
Jan 14 11:17:23 shockwave kernel: scsi1 channel 0 : resetting for second
half of retries. 
Jan 14 11:17:23 shockwave kernel: SCSI bus is being reset for host 1
channel 0. 
Jan 14 11:17:25 shockwave kernel: SCSI host 1 channel 0 reset (pid 0)
timed out - trying harder 
Jan 14 11:17:25 shockwave kernel: SCSI bus is being reset for host 1
channel 0. 
Jan 14 11:17:25 shockwave kernel: SCSI host 1 reset (pid 0) timed out
again - 
Jan 14 11:17:25 shockwave kernel: probably an unrecoverable SCSI bus or
device hang. 
Jan 14 11:17:27 shockwave kernel: (scsi1:0:0:0) Synchronous at 80.0
Mbyte/sec, offset 15. 
Jan 14 11:17:27 shockwave kernel: (scsi1:0:1:0) Synchronous at 80.0
Mbyte/sec, offset 15. 
Jan 14 11:17:27 shockwave kernel: (scsi1:0:6:0) Synchronous at 80.0
Mbyte/sec, offset 32. 
Jan 14 11:17:27 shockwave kernel: st0: Error with sense data: [valid=0]
Info fld=0x0, Current st09:00: sns = 70  6 
Jan 14 11:17:27 shockwave kernel: ASC=29 ASCQ= 0 
Jan 14 11:17:27 shockwave kernel: Raw sense data:0x70 0x00 0x06 0x00
0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x29 0x00 0x00 0x00 0x01 0x01  
Jan 14 11:17:37 shockwave kernel: scsi : aborting command due to timeout
: pid 0, scsi1, channel 0, id 6, lun 0 0x1e 00 00 00 01 00  
Jan 14 11:17:47 shockwave kernel: SCSI host 1 abort (pid 0) timed out -
resetting 
Jan 14 11:17:47 shockwave kernel: SCSI bus is being reset for host 1
channel 0. 
Jan 14 11:17:51 shockwave kernel: (scsi1:0:6:0) Synchronous at 80.0
Mbyte/sec, offset 32. 
Jan 14 11:18:01 shockwave kernel: SCSI host 1 channel 0 reset (pid 0)
timed out - trying harder 
Jan 14 11:18:01 shockwave kernel: SCSI bus is being reset for host 1
channel 0. 
Jan 14 11:18:05 shockwave kernel: (scsi1:0:1:0) Synchronous at 80.0
Mbyte/sec, offset 15. 
Jan 14 11:18:05 shockwave kernel: (scsi1:0:6:0) Synchronous at 80.0
Mbyte/sec, offset 32. 
Jan 14 11:18:15 shockwave kernel: SCSI host 1 abort (pid 0) timed out -
resetting 
Jan 14 11:18:15 shockwave kernel: SCSI bus is being reset for host 1
channel 0. 
Jan 14 11:18:19 shockwave kernel: (scsi1:0:6:0) Synchronous at 80.0
Mbyte/sec, offset 32. 
Jan 14 11:18:30 shockwave kernel: SCSI host 1 channel 0 reset (pid 0)
timed out - trying harder 
Jan 14 11:18:30 shockwave kernel: SCSI bus is being reset for host 1
channel 0. 
Jan 14 11:18:33 shockwave kernel: (scsi1:0:1:0) Synchronous at 80.0
Mbyte/sec, offset 15. 
Jan 14 11:18:33 shockwave kernel: (scsi1:0:6:0) Synchronous at 80.0
Mbyte/sec, offset 32. 
Jan 14 11:18:43 shockwave kernel: SCSI host 1 abort (pid 0) timed out -
resetting 
Jan 14 11:18:43 shockwave kernel: SCSI bus is being reset for host 1
channel 0. 
Jan 14 11:18:47 shockwave kernel: (scsi1:0:6:0) Synchronous at 80.0
Mbyte/sec, offset 32. 
Jan 14 11:18:57 shockwave kernel: scsi : aborting command due to timeout
: pid 0, scsi1, channel 0, id 6, lun 0 0x1e 00 00 00 01 00  
Jan 14 11:19:07 shockwave kernel: SCSI host 1 abort (pid 0) timed out -
resetting 
Jan 14 11:19:07 shockwave kernel: SCSI bus is being reset for host 1
channel 0. 
Jan 14 11:19:11 shockwave kernel: (scsi1:0:6:0) Synchronous at 80.0
Mbyte/sec, offset 32. 
Jan 14 11:19:22 shockwave kernel: SCSI host 1 channel 0 reset (pid 0)
timed out - trying harder 
Jan 14 11:19:22 shockwave kernel: SCSI bus is being reset for host 1
channel 0. 
Jan 14 11:19:25 shockwave kernel: (scsi1:0:1:0) Synchronous at 80.0
Mbyte/sec, offset 15. 
Jan 14 11:19:25 shockwave kernel: (scsi1:0:6:0) Synchronous at 80.0
Mbyte/sec, offset 32. 
Jan 14 11:19:35 shockwave kernel: SCSI host 1 abort (pid 0) timed out -
resetting 
Jan 14 11:19:35 shockwave kernel: SCSI bus is being reset for host 1
channel 0. 
Jan 14 11:19:39 shockwave kernel: (scsi1:0:6:0) Synchronous at 80.0
Mbyte/sec, offset 32. 
Jan 14 11:19:50 shockwave kernel: SCSI host 1 channel 0 reset (pid 0)
timed out - trying harder 
Jan 14 11:19:50 shockwave kernel: SCSI bus is being reset for host 1
channel 0. 
Jan 14 11:19:54 shockwave kernel: (scsi1:0:1:0) Synchronous at 80.0
Mbyte/sec, offset 15. 
Jan 14 11:19:54 shockwave kernel: (scsi1:0:6:0) Synchronous at 80.0
Mbyte/sec, offset 32. 
Jan 14 11:20:04 shockwave kernel: SCSI host 1 abort (pid 0) timed out -
resetting 
Jan 14 11:20:04 shockwave kernel: SCSI bus is being reset for host 1
channel 0. 
Jan 14 11:20:08 shockwave kernel: (scsi1:0:6:0) Synchronous at 80.0
Mbyte/sec, offset 32. 
Jan 14 11:20:18 shockwave kernel: scsi : aborting command due to timeout
: pid 0, scsi1, channel 0, id 6, lun 0 0x1e 00 00 00 01 00  
Jan 14 11:20:28 shockwave kernel: SCSI host 1 abort (pid 0) timed out -
resetting 
Jan 14 11:20:28 shockwave kernel: SCSI bus is being reset for host 1
channel 0. 
Jan 14 11:20:32 shockwave kernel: (scsi1:0:6:0) Synchronous at 80.0
Mbyte/sec, offset 32. 
Jan 14 11:20:43 shockwave kernel: SCSI host 1 channel 0 reset (pid 0)
timed out - trying harder 
Jan 14 11:20:43 shockwave kernel: SCSI bus is being reset for host 1
channel 0. 
Jan 14 11:20:46 shockwave kernel: (scsi1:0:1:0) Synchronous at 80.0
Mbyte/sec, offset 15. 
Jan 14 11:20:46 shockwave kernel: (scsi1:0:6:0) Synchronous at 80.0
Mbyte/sec, offset 32. 
Jan 14 11:20:56 shockwave kernel: SCSI host 1 abort (pid 0) timed out -
resetting 
Jan 14 11:20:56 shockwave kernel: SCSI bus is being reset for host 1
channel 0. 
Jan 14 11:21:00 shockwave kernel: (scsi1:0:6:0) Synchronous at 80.0
Mbyte/sec, offset 32. 
Jan 14 11:21:11 shockwave kernel: SCSI host 1 channel 0 reset (pid 0)
timed out - trying harder 
Jan 14 11:21:11 shockwave kernel: SCSI bus is being reset for host 1
channel 0. 
Jan 14 11:21:14 shockwave kernel: (scsi1:0:1:0) Synchronous at 80.0
Mbyte/sec, offset 15. 
Jan 14 11:21:14 shockwave kernel: (scsi1:0:6:0) Synchronous at 80.0
Mbyte/sec, offset 32. 
Jan 14 11:21:24 shockwave kernel: SCSI host 1 abort (pid 0) timed out -
resetting 
Jan 14 11:21:24 shockwave kernel: SCSI bus is being reset for host 1
channel 0. 
Jan 14 11:21:28 shockwave kernel: (scsi1:0:6:0) Synchronous at 80.0
Mbyte/sec, offset 32. 
Jan 14 11:21:38 shockwave kernel: scsi : aborting command due to timeout
: pid 0, scsi1, channel 0, id 6, lun 0 0x1e 00 00 00 01 00  
Jan 14 11:21:48 shockwave kernel: SCSI host 1 abort (pid 0) timed out -
resetting 
Jan 14 11:21:48 shockwave kernel: SCSI bus is being reset for host 1
channel 0. 
Jan 14 11:21:52 shockwave kernel: (scsi1:0:6:0) Synchronous at 80.0
Mbyte/sec, offset 32.
 
[X.]
I can generate a hang every couple of hours by doing heavy disc IO.  If
I remove a processor, I can stay up at least 48 hours under a heavy
load.  If anyone needs more info I can be reached at bruce@linux2go.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
