Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWG3GoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWG3GoW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 02:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWG3GoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 02:44:21 -0400
Received: from ash25e.internode.on.net ([203.16.214.182]:15364 "EHLO
	ash25e.internode.on.net") by vger.kernel.org with ESMTP
	id S1751111AbWG3GoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 02:44:21 -0400
Subject: block-osm: NULL reply received (Promise SX6000) on 2.6.17 (was
	working on 2.6.16)
From: Rubens Ramos <rubensr@internode.on.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sun, 30 Jul 2006 16:14:16 +0930
Message-Id: <1154241856.4142.15.camel@hal9000.home.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

1. Full description
-------------------
 I've got a Fedora Core 5 system, which had the 2.6.16 kernel working
without any problems (disks were identified without any issues), until
the kernel was upgraded to 2.6.17. I can still boot using the old
kernel, so I was hoping to get some help from the list.

 Basically, when I boot the server with 2.6.17, I get only the first
initial kernel messages (just about 5 lines) indicating that the logical
volumes are being detected, and then:

block-osm: NULL reply received!

 the kernel freezes, and I need to reboot.

 (Please note I haven't subscribed to the list yet as I am not sure
it would be necessary - let me know otherwise)

 Detailed information below as per kernel.org bug submission
instructions.

Thanks in advance
Rubens

2. Keywords
-----------
SCSI, i2o, SX6000, Adaptec, Promise

4. Kernel Version
-----------------
Works: 2.6.16-1.2133
Do not work: 2.6.17-1.2139, 2.6.17-1.2157

5. Output of Oops
-----------------
block-osm: NULL reply received!
(this is all I get)

6. A small example
------------------
All I have to do is boot using 2.6.17

7. Environment
--------------
[root@jupiter rfernandes]# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 11
model name      : Intel(R) Pentium(R) III CPU family      1266MHz
stepping        : 1
cpu MHz         : 1267.384
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 2538.40

[root@jupiter rfernandes]# cat /proc/modules
nls_utf8 2241 1 - Live 0xf88fe000
cifs 197357 1 - Live 0xf8f92000
autofs4 19141 1 - Live 0xf8d9f000
hidp 16065 2 - Live 0xf8daa000
rfcomm 34901 0 - Live 0xf8f4b000
l2cap 23617 10 hidp,rfcomm, Live 0xf8dc5000
bluetooth 44709 5 hidp,rfcomm,l2cap, Live 0xf8db9000
sunrpc 139389 1 - Live 0xf8dd1000
video 15173 0 - Live 0xf8da5000
button 6609 0 - Live 0xf88a1000
battery 9285 0 - Live 0xf8d87000
ac 4933 0 - Live 0xf88fb000
ipv6 225825 24 - Live 0xf8e19000
lp 12169 0 - Live 0xf8d35000
parport_pc 25573 1 - Live 0xf8d59000
parport 34569 2 lp,parport_pc, Live 0xf8d46000
floppy 57733 0 - Live 0xf8d8f000
nvram 8393 0 - Live 0xf8d31000
uhci_hcd 29393 0 - Live 0xf8d50000
via_ircc 19541 0 - Live 0xf8d40000
irda 105721 1 via_ircc, Live 0xf8d62000
8139cp 21441 0 - Live 0xf8d39000
crc_ccitt 2241 1 irda, Live 0xf889f000
e100 33221 0 - Live 0xf8d1f000
8139too 25537 0 - Live 0xf8d29000
i2c_viapro 8277 0 - Live 0xf887c000
mii 5441 3 8139cp,e100,8139too, Live 0xf8879000
i2c_core 21057 1 i2c_viapro, Live 0xf88f4000
dm_snapshot 16493 0 - Live 0xf8899000
dm_zero 2113 0 - Live 0xf8840000
dm_mirror 20625 0 - Live 0xf8881000
dm_mod 51929 6 dm_snapshot,dm_zero,dm_mirror, Live 0xf88c5000
ext3 116681 2 - Live 0xf8d01000
jbd 52821 1 ext3, Live 0xf888b000
i2o_block 12621 3 - Live 0xf8845000
i2o_core 38757 1 i2o_block, Live 0xf884e000
aic7xxx 129525 0 - Live 0xf88a4000
scsi_transport_spi 21185 1 aic7xxx, Live 0xf8831000
sd_mod 16449 0 - Live 0xf8838000
scsi_mod 126185 3 aic7xxx,scsi_transport_spi,sd_mod, Live 0xf8859000

[root@jupiter rfernandes]# cat /proc/ioports
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
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f8-03ff : serial
04d0-04d1 : pnp 00:0b
0cf8-0cff : PCI conf1
0e00-0e7e : pnp 00:0b
2000-200f : motherboard
  2000-200f : pnp 00:0b
    2000-2007 : vt596_smbus
7000-7fff : PCI Bus #02
  7000-7007 : 0000:02:00.0
  7040-7043 : 0000:02:00.0
  7080-7087 : 0000:02:00.0
  70c0-70c3 : 0000:02:00.0
  7400-740f : 0000:02:00.0
  7440-7447 : 0000:02:01.0
  7480-7483 : 0000:02:01.0
  74c0-74c7 : 0000:02:01.0
  7800-7803 : 0000:02:01.0
  7840-784f : 0000:02:01.0
  7880-7887 : 0000:02:02.0
  78c0-78c3 : 0000:02:02.0
  7c00-7c07 : 0000:02:02.0
  7c40-7c43 : 0000:02:02.0
  7c80-7c8f : 0000:02:02.0
8000-8fff : PCI Bus #01
  8000-80ff : 0000:01:00.0
9000-90ff : 0000:00:0a.0
  9000-90ff : 8139too
9400-94ff : 0000:00:0d.0
9800-98ff : 0000:00:0d.1
9c80-9cbf : 0000:00:0e.0
  9c80-9cbf : e100
a000-a01f : 0000:00:11.2
  a000-a01f : uhci_hcd
a040-a04f : 0000:00:11.1
  a040-a047 : ide0
  a048-a04f : ide1
f000-f09e : motherboard
  f000-f003 : PM1a_EVT_BLK
  f004-f005 : PM1a_CNT_BLK
  f008-f00b : PM_TMR
  f020-f023 : GPE0_BLK

[root@jupiter rfernandes]# cat /proc/iomem
00000000-0009fbff : System RAM
  00000000-00000000 : Crash kernel
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cbfff : Adapter ROM
000e0000-000e07ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-002e5daf : Kernel code
  002e5db0-003a7503 : Kernel data
3fff0000-3fff7fff : ACPI Tables
3fff8000-3fffffff : ACPI Non-volatile Storage
80100000-801fffff : PCI Bus #02
  80100000-80103fff : 0000:02:00.0
  80104000-80107fff : 0000:02:01.0
  80108000-8010bfff : 0000:02:02.0
80200000-820fffff : PCI Bus #01
  80200000-80200fff : 0000:01:00.0
  80220000-8023ffff : 0000:01:00.0
  81000000-81ffffff : 0000:01:00.0
82100000-821000ff : 0000:00:0a.0
  82100000-821000ff : 8139too
82101000-82101fff : 0000:00:0d.0
  82101000-82101fff : aic7xxx
82102000-82102fff : 0000:00:0d.1
  82102000-82102fff : aic7xxx
82120000-8212ffff : 0000:00:0b.1
82140000-8215ffff : 0000:00:0d.0
82160000-8217ffff : 0000:00:0d.1
82400000-827fffff : 0000:00:0b.1
  82400000-827fffff : I2O-subsystem
82900000-82900fff : 0000:00:0e.0
  82900000-82900fff : e100
82920000-8293ffff : 0000:00:0e.0
  82920000-8293ffff : e100
82940000-8294ffff : 0000:00:0e.0
e0000000-e3ffffff : 0000:00:00.0
fff80000-ffffffff : reserved


[root@jupiter rfernandes]# /sbin/lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8653 Host Bridge
        Subsystem: Acer Incorporated [ALI] Unknown device 0018
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW-
Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP]
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00008000-00008fff
        Memory behind bridge: 80200000-820fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at 9000 [size=256]
        Region 1: Memory at 82100000 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1
+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 PCI bridge: Intel Corporation 80960RM [i960RM Bridge] (rev 02)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size 08
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 00007000-00007fff
        Memory behind bridge: 80100000-801fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:0b.1 I2O: Intel Corporation 80960RM [i960RM Microprocessor] (rev 02)
(prog-if 01)
        Subsystem: Promise Technology, Inc. SuperTrak SX6000 I2O CPU
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size 08
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at 82400000 (32-bit, prefetchable) [size=4M]
        Expansion ROM at 82120000 [disabled] [size=64K]

00:0d.0 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
        Subsystem: Acer Incorporated [ALI] Unknown device 2005
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (10000ns min, 6250ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 16
        BIST result: 00
        Region 0: I/O ports at 9400 [disabled] [size=256]
        Region 1: Memory at 82101000 (64-bit, non-prefetchable)
[size=4K]
        Expansion ROM at 82140000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
        Subsystem: Acer Incorporated [ALI] Unknown device 2005
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (10000ns min, 6250ns max), Cache Line Size 08
        Interrupt: pin B routed to IRQ 17
        BIST result: 00
        Region 0: I/O ports at 9800 [disabled] [size=256]
        Region 1: Memory at 82102000 (64-bit, non-prefetchable)
[size=4K]
        Expansion ROM at 82160000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro
100] (rev 0d)
        Subsystem: Acer Incorporated [ALI] Unknown device 0040
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at 82900000 (32-bit, non-prefetchable)
[size=4K]
        Region 1: I/O ports at 9c80 [size=64]
        Region 2: Memory at 82920000 (32-bit, non-prefetchable)
[size=128K]
        Expansion ROM at 82940000 [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1
+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
        Subsystem: Acer Incorporated [ALI] Unknown device 0018
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
        Subsystem: Acer Incorporated [ALI] Unknown device 0018
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at a040 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 1b) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size 08
        Interrupt: pin D routed to IRQ 17
        Region 4: I/O ports at a000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Rage XL AGP 2X
(rev 27) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Unknown device 8008
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), Cache Line Size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at 81000000 (32-bit, non-prefetchable)
[size=16M]
        Region 1: I/O ports at 8000 [size=256]
        Region 2: Memory at 80200000 (32-bit, non-prefetchable)
[size=4K]
        Expansion ROM at 80220000 [disabled] [size=128K]
        Capabilities: [50] AGP version 1.0
                Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
Rate=<none>
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:00.0 RAID bus controller: Promise Technology, Inc. PDC20276
(MBFastTrak133 Lite) (rev ff) (prog-if ff)
        !!! Unknown header type 7f

02:01.0 RAID bus controller: Promise Technology, Inc. PDC20276
(MBFastTrak133 Lite) (rev ff) (prog-if ff)
        !!! Unknown header type 7f

02:02.0 RAID bus controller: Promise Technology, Inc. PDC20276
(MBFastTrak133 Lite) (rev ff) (prog-if ff)
        !!! Unknown header type 7f

[root@jupiter rfernandes]#

[root@jupiter rfernandes]# cat /proc/scsi/scsi
Attached devices:



