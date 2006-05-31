Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751721AbWEaQrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721AbWEaQrN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 12:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965070AbWEaQrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 12:47:13 -0400
Received: from penda.cc.fh-lippe.de ([193.16.112.79]:4299 "EHLO
	penda.cc.fh-lippe.de") by vger.kernel.org with ESMTP
	id S1751721AbWEaQrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 12:47:11 -0400
Envelope-to: linux-kernel@vger.kernel.org
Date: Wed, 31 May 2006 18:47:07 +0200
From: Martin Hierling <martin.hierling@fh-luh.de>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.16.18 with general protection fault, perhaps nfsd
Message-ID: <20060531164707.GA19547@cc.fh-luh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-URL: http://www.fh-luh.de/skim/netzwerk.html
User-Agent: Mutt/1.5.11
X-Skim-SendBy: pike.cc.fh-luh.de on Wed, 31 May 2006 18:47:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi List, 

this is my first report, so donÅœt be to picky. thanks.

[1] Kernel 2.6.16.18 with general protection fault
[2] Kernel prints general protection fault, some times, unitl now not
reproducible, but occurs one to three times a month.
[3] nfs, kernel
[4] Linux version 2.6.16.18-xen (root@defiant) (gcc version 3.4.4
(Gentoo 3.4.4-r1, ssp-3.4.4-1.0, pie-8.7.8)) #1 SMP Tue May 30 21:24:10
MEST 2006
[5] ... perhaps 2.6.12, donÅœt know exactly
[6]
general protection fault: 0000 [#1]
SMP
Modules linked in: budget_ci tda1004x firmware_class budget_core
ttpci_eeprom stv0297 bridge lp parport_pc parport saa7146 stv0299
dvb_core crc32 video_buf v4l2_common v4l1_compat evdev nfs nfsd exportfs
lockd nfs_acl sunrpc
CPU:    0
EIP:    0061:[<e1213c67>]    Not tainted VLI
EFLAGS: 00010286   (2.6.16.18-xen #1)
EIP is at nfsd_setuser+0x77/0x230 [nfsd]
eax: ffffe000   ebx: d276c9e0   ecx: d276c9e0   edx: 00000000
esi: 00000002   edi: dca9c02c   ebp: dca9ce00   esp: d7e85ed0
ds: 007b   es: 007b   ss: 0069
Process nfsd (pid: 11976, threadinfo=d7e84000 task=dc4d1a90)
Stack: <0>dc9db4e0 d276c9e0 00000002 01000000 dca9ce00 e120c82b dca9c000
d276c9e0
       dca9c150 dca9c150 d7e85f40 00000070 00000005 dca9ce10 e11f5ba8
dca9c000
       d24513e0 d7e85f45 df9c8000 dca9ce00 dca9c000 d7f2e014 e120b291
dca9c000
Call Trace:
 [<e120c82b>] fh_verify+0x16b/0x5e0 [nfsd]
 [<e120b291>] nfsd_proc_getattr+0x81/0xc0 [nfsd]
 [<e120a6f3>] nfsd_dispatch+0xa3/0x250 [nfsd]
 [<e120a650>] nfsd_dispatch+0x0/0x250 [nfsd]
 [<e11dff4d>] svc_process+0x28d/0x6b0 [sunrpc]
 [<e120a4c5>] nfsd+0x1c5/0x350 [nfsd]
 [<e120a300>] nfsd+0x0/0x350 [nfsd]
 [<c0102f79>] kernel_thread_helper+0x5/0xc
Code: 83 fa ff 0f 84 2b 01 00 00 b8 00 e0 ff ff 21 e0 8b 00 89 90 74 01
00 00 8b 57 04 83 fa ff 0f 84 40 01 00 00 b8 00 e0 ff ff 21 c0 <8b> 00
89 90 84 01 00 00 8b 57 08 b8 f4 ff ff ff 85 d2 74 29 89
[7] not possible
[8] 
[8.1]
# sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux defiant 2.6.16.18-xen #1 SMP Tue May 30 21:24:10 MEST 2006 i686
Pentium III (Coppermine) GNU/Linux

Gnu C                  3.4.4
Gnu make               3.80
binutils               2.16.1
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.1
e2fsprogs              1.38
reiserfsprogs          3.6.19
reiser4progs           line
quota-tools            3.12.
nfs-utils              1.0.6
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.6
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.94
udev                   087
Modules Loaded         budget_ci tda1004x firmware_class budget_core
ttpci_eeprom stv0297 bridge lp parport_pc parport saa7146 stv0299
dvb_core crc32 video_buf v4l2_common v4l1_compat evdev nfs nfsd exportfs
lockd nfs_acl sunrpc

[8.2]
# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 1002.271
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 3
wp              : yes
flags           : fpu tsc msr pae mce cx8 apic mtrr mca cmov pat pse36
mmx fxsr sse
bogomips        : 1908.62

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 1002.271
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 3
wp              : yes
flags           : fpu tsc msr pae mce cx8 apic mtrr mca cmov pat pse36
mmx fxsr sse
bogomips        : 1908.62

[8.3]
# cat /proc/modules
budget_ci 13088 2 - Live 0xe1835000
tda1004x 16132 1 budget_ci, Live 0xe1830000
firmware_class 8224 2 budget_ci,tda1004x, Live 0xe1826000
budget_core 7492 1 budget_ci, Live 0xe1823000
ttpci_eeprom 2400 1 budget_core, Live 0xe1819000
stv0297 8416 1 budget_ci, Live 0xe181b000
bridge 38572 0 - Live 0xe1280000
lp 8804 0 - Live 0xe1244000
parport_pc 22372 1 - Live 0xe126c000
parport 20928 2 lp,parport_pc, Live 0xe1265000
saa7146 14920 2 budget_ci,budget_core, Live 0xe123f000
stv0299 10600 1 budget_ci, Live 0xe1224000
dvb_core 77896 3 budget_ci,budget_core,stv0299, Live 0xe1250000
crc32 4032 1 dvb_core, Live 0xe1237000
video_buf 17796 0 - Live 0xe122c000
v4l2_common 6720 0 - Live 0xe11b1000
v4l1_compat 13540 0 - Live 0xe1232000
evdev 8416 0 - Live 0xe1228000
nfs 110640 0 - Live 0xe11b9000
nfsd 100520 17 - Live 0xe120a000
exportfs 4896 1 nfsd, Live 0xe11b6000
lockd 61192 3 nfs,nfsd, Live 0xe11fa000
nfs_acl 3040 2 nfs,nfsd, Live 0xe11b4000
sunrpc 138748 12 nfs,nfsd,lockd,nfs_acl, Live 0xe11d7000

[8.4]
# cat /proc/ioports
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
0378-037a : parport0
03c0-03df : vga+
0cf8-0cff : PCI conf1
4000-40ff : 0000:00:07.4
  4000-4003 : PM1a_EVT_BLK
  4008-400b : PM_TMR
  4020-4023 : GPE0_BLK
  40f0-40f1 : PM1a_CNT_BLK
5000-500f : 0000:00:07.4
  5000-5007 : vt596_smbus
6000-607f : 0000:00:07.4
9000-900f : 0000:00:07.1
  9000-9007 : ide0
9400-941f : 0000:00:07.2
  9400-941f : uhci_hcd
9800-981f : 0000:00:07.3
  9800-981f : uhci_hcd
9c00-9c07 : 0000:00:0c.0
  9c00-9c07 : ide2
a000-a003 : 0000:00:0c.0
  a002-a002 : ide2
a400-a407 : 0000:00:0c.0
  a400-a407 : ide3
a800-a803 : 0000:00:0c.0
  a802-a802 : ide3
ac00-ac3f : 0000:00:0c.0
  ac00-ac07 : ide2
  ac08-ac0f : ide3
  ac10-ac3f : PDC20265
b000-b03f : 0000:00:0e.0
b400-b43f : 0000:00:0f.0
  b400-b43f : sata_promise
b800-b80f : 0000:00:0f.0
  b800-b80f : sata_promise
bc00-bc7f : 0000:00:0f.0
  bc00-bc7f : sata_promise
c000-c03f : 0000:00:10.0
  c000-c03f : sata_promise
c400-c40f : 0000:00:10.0
  c400-c40f : sata_promise
c800-c87f : 0000:00:10.0
  c800-c87f : sata_promise

# cat /proc/iomem
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c9fff : Adapter ROM
000ca000-000ccfff : Adapter ROM
000f0000-000fffff : System ROM
00100000-5ffeffff : System RAM
5fff0000-5fff2fff : reserved
5fff3000-5fffffff : reserved
60000000-6000ffff : 0000:00:0c.0
60010000-6001ffff : 0000:00:0e.0
60020000-60023fff : 0000:00:0f.0
60024000-60027fff : 0000:00:10.0
d0000000-d2ffffff : PCI Bus #01
  d0000000-d0003fff : 0000:01:00.0
  d0010000-d001ffff : 0000:01:00.0
  d1000000-d17fffff : 0000:01:00.0
d3000000-d3ffffff : PCI Bus #01
  d3000000-d3ffffff : 0000:01:00.0
d5000000-d53fffff : 0000:00:00.0
d5400000-d541ffff : 0000:00:0c.0
d5420000-d543ffff : 0000:00:0f.0
  d5420000-d543ffff : sata_promise
d5440000-d545ffff : 0000:00:10.0
  d5440000-d545ffff : sata_promise
d5460000-d5460fff : 0000:00:10.0
  d5460000-d5460fff : sata_promise
d5461000-d5461fff : 0000:00:0f.0
  d5461000-d5461fff : sata_promise
d5462000-d54621ff : 0000:00:12.0
  d5462000-d54621ff : saa7146
fec00000-ffffffff : reserved

[8.5]
# lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo
PRO133x] (rev c4)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 0
        Region 0: Memory at d5000000 (32-bit, prefetchable) [size=4M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: d0000000-d2ffffff
        Prefetchable memory behind bridge: d3000000-d3ffffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 22)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 10)
(prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at 9000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 10) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size 08
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at 9400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 10) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size 08
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at 9800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 30)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Mass storage controller: Promise Technology, Inc. PDC20265
(FastTrak100 Lite/Ultra100) (rev 02)
        Subsystem: Promise Technology, Inc. Ultra100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at 9c00 [size=8]
        Region 1: I/O ports at a000 [size=4]
        Region 2: I/O ports at a400 [size=8]
        Region 3: I/O ports at a800 [size=4]
        Region 4: I/O ports at ac00 [size=64]
        Region 5: Memory at d5400000 (32-bit, non-prefetchable)
[size=128K]
        Expansion ROM at 60000000 [size=64K]
        Capabilities: [58] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX
[Boomerang]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at b000 [size=64]
        [virtual] Expansion ROM at 60010000 [disabled] [size=64K]

00:0f.0 Mass storage controller: Promise Technology, Inc. PDC20375
(SATA150 TX2plus) (rev 02)
        Subsystem: Promise Technology, Inc. PDC20375 (SATA150 TX2plus)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 96 (1000ns min, 4500ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at b400 [size=64]
        Region 1: I/O ports at b800 [size=16]
        Region 2: I/O ports at bc00 [size=128]
        Region 3: Memory at d5461000 (32-bit, non-prefetchable)
[size=4K]
        Region 4: Memory at d5420000 (32-bit, non-prefetchable)
[size=128K]
        [virtual] Expansion ROM at 60020000 [disabled] [size=16K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 Mass storage controller: Promise Technology, Inc. PDC20375
(SATA150 TX2plus) (rev 02)
        Subsystem: Promise Technology, Inc. PDC20375 (SATA150 TX2plus)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 96 (1000ns min, 4500ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at c000 [size=64]
        Region 1: I/O ports at c400 [size=16]
        Region 2: I/O ports at c800 [size=128]
        Region 3: Memory at d5460000 (32-bit, non-prefetchable)
[size=4K]
        Region 4: Memory at d5440000 (32-bit, non-prefetchable)
[size=128K]
        [virtual] Expansion ROM at 60024000 [disabled] [size=16K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:12.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
        Subsystem: Technotrend Systemtechnik GmbH Technotrend-Budget /
Hauppauge WinTV-NOVA-CI DVB card
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (3750ns min, 9500ns max)
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at d5462000 (32-bit, non-prefetchable)
[size=512]

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G100
[Productiva] AGP (rev 02) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. MGA-G100 Productiva AGP
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 255
        Region 0: Memory at d3000000 (32-bit, prefetchable) [size=16M]
        Region 1: Memory at d0000000 (32-bit, non-prefetchable)
[size=16K]
        Region 2: Memory at d1000000 (32-bit, non-prefetchable)
[size=8M]
        [virtual] Expansion ROM at d0010000 [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 1.0
                Status: RQ=2 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
Rate=<none>

[8.6]
# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: SAMSUNG SP1614C  Rev: SW10
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: SAMSUNG SP1614C  Rev: SW10
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: SAMSUNG SP1614C  Rev: SW10
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi3 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: SAMSUNG SP1614C  Rev: SW10
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi4 Channel: 00 Id: 00 Lun: 00
  Vendor: OTi      Model: Flash Disk       Rev: 2.00
  Type:   Direct-Access                    ANSI SCSI revision: 02

[8.7]
# showmount  -e
Export list for defiant:
/nfs/video            192.168.1.0/24
/files/mp3            192.168.1.0/24
/export/home          192.168.1.0/24
/mnt/tricorder        192.168.1.0/24
/files/netboot        192.168.1.0/24
/export/overlay       192.168.1.0/24
/export/portage       192.168.1.0/24
/files/incoming       192.168.1.0/24
/export/packages      192.168.1.0/24
/files/incoming/24    192.168.1.0/24

nfs-utils-1.0.6-r6

# grep NFS .config
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
# CONFIG_NFSD_V4 is not set
CONFIG_NFSD_TCP=y
CONFIG_NFS_ACL_SUPPORT=m
CONFIG_NFS_COMMON=y

regards Martin
-- 
----------------------------------------------------------------
  Knowing Murphy's Law won't help either.
----------------------------------------------------------------
