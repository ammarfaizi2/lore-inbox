Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292391AbSB0N1O>; Wed, 27 Feb 2002 08:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292406AbSB0N1H>; Wed, 27 Feb 2002 08:27:07 -0500
Received: from basfegw1.basf-ag.de ([141.6.1.21]:36514 "EHLO
	basfegw1.basf-ag.de") by vger.kernel.org with ESMTP
	id <S292391AbSB0N0y>; Wed, 27 Feb 2002 08:26:54 -0500
Subject: Kernel Hangs 2.4.16 on heay io on a reiserfs mounted on a lvm partition
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Version 5.0 (Intl)   14. April 1999
Message-ID: <OFBD35F27E.C229DA29-ONC1256B6D.0049B834@bcs.de>
From: Oliver.Schersand@BASF-IT-Services.com
Date: Wed, 27 Feb 2002 14:26:53 +0100
X-MIMETrack: Serialize by Router on EUROPE-Gw03/EUROPE/BASF(Release 5.0.8 |June 18, 2001) at
 27/02/2002 14:26:27
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On heavy load ( ADSM BAckup / Oracle Online Backup to disk with rman System
hangs.
You can ping the server but you cannot login local or over network. It is
not possible
to switch localy to an other loginscreen. ( Alt-f1 Alt-f2). There is no log
information on the
server an no kernel messages send to other server (loghost ) via syslogd.

Kernel:
Linux version 2.4.16-4GB-SMP (root@SMP_X86.suse.de) (gcc version 2.95.3
20010315 (SuSE)) #1 SMP Tue Dec 18 16:19:18 GMT 2001

Messages:
  No Messages in syslog

Problem:
     Backup with tsm / dump oracle database with rmam no disk

Filesystem:
     reiserfs on a lvm partition

lxlu1213:~ # mount
/dev/ida/c0d0p8 on / type reiserfs (rw)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,mode=0620,gid=5)
/dev/ida/c0d0p9 on /old type reiserfs (rw)
/dev/ida/c0d0p6 on /boot type ext2 (rw)
/dev/ida/c0d0p7 on /boot_old type ext2 (rw)
/dev/ora00/vg01lv00 on /vg01lv00 type reiserfs (rw)
/dev/ora00/vg01lv11 on /vg01lv11 type reiserfs (rw)
/dev/ora00/vg01lv21 on /vg01lv21 type reiserfs (rw)
/dev/ora00/vg01lv22 on /vg01lv22 type reiserfs (rw)
/dev/ora00/vg01lv23 on /vg01lv23 type reiserfs (rw)
/dev/ora00/vg01lv24 on /vg01lv24 type reiserfs (rw)
/dev/ora00/vg01lv25 on /vg01lv25 type reiserfs (rw)
/dev/ora00/vg01lv26 on /vg01lv26 type reiserfs (rw)
/dev/ora00/vg01lv27 on /vg01lv27 type reiserfs (rw)
/dev/ora00/vg01lv28 on /vg01lv28 type reiserfs (rw)
/dev/ora00/vg01lv31 on /vg01lv31 type reiserfs (rw)
/dev/ora00/vg01lv32 on /vg01lv32 type reiserfs (rw)
/dev/ora00/vg01lv33 on /vg01lv33 type reiserfs (rw)
/dev/ora00/vg01lv34 on /vg01lv34 type reiserfs (rw)
/dev/ora00/vg01lv35 on /vg01lv35 type reiserfs (rw)
/dev/ora00/vg01lv36 on /vg01lv36 type reiserfs (rw)
/dev/ora00/vg01lv37 on /vg01lv37 type reiserfs (rw)
/dev/ora00/vg01lv38 on /vg01lv38 type reiserfs (rw)
/dev/ora00/vg01lv41 on /vg01lv41 type reiserfs (rw)
/dev/ora00/vg01lv42 on /vg01lv42 type reiserfs (rw)
/dev/ora00/vg01lv43 on /vg01lv43 type reiserfs (rw)
/dev/ora00/vg01lv44 on /vg01lv44 type reiserfs (rw)
/dev/ora00/vg01lv45 on /vg01lv45 type reiserfs (rw)
/dev/ora00/vg01lv46 on /vg01lv46 type reiserfs (rw)
/dev/ora00/vg01lv47 on /vg01lv47 type reiserfs (rw)
/dev/ora00/vg01lv48 on /vg01lv48 type reiserfs (rw)
shmfs on /dev/shm type shm (rw)
automount(pid329) on /misc type autofs
(rw,fd=5,pgrp=329,minproto=2,maxproto=3)
automount(pid358) on /APPS type autofs
(rw,fd=5,pgrp=358,minproto=2,maxproto=3)
automount(pid356) on /home type autofs
(rw,fd=5,pgrp=356,minproto=2,maxproto=3)
wolke.rz-c007-j650.basf-ag.de:/oradump on /oradumpold type nfs
(rw,addr=10.4.20.42)
neroG.rz-c007-j650.basf-ag.de:/Y/fs1773/mux on /home/uranus type nfs
(rw,nosuid,soft,timeo=600,retrans=5,addr=10.4.
20.142)
neroG.rz-c007-j650.basf-ag.de:/Y/fs2271/uran2 on /home/uranus2 type nfs
(rw,nosuid,soft,timeo=600,retrans=5,addr=10
.4.20.142)
neroG.rz-c007-j650.basf-ag.de:/Y/fs2270/uran3 on /home/uranus3 type nfs
(rw,nosuid,soft,timeo=600,retrans=5,addr=10
.4.20.142)
neroG.rz-c007-j650.basf-ag.de:/Y/fs1769/uran5 on /APPS/uranus type nfs
(rw,nosuid,soft,timeo=600,retrans=5,addr=10.
4.20.142)
wolke.rz-c007-j650.basf-ag.de:/install/linux on /APPS/linux type nfs
(ro,nosuid,soft,timeo=600,retrans=5,addr=10.4.
20.42)
/dev/ora00/oradump on /oradump type reiserfs (rw)

Software:
   SuSE-7 Enterprise Server

Prozessor:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 930.465
cache size      : 256 KB
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
bogomips        : 1854.66

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 930.465
cache size      : 256 KB
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
bogomips        : 1854.66

Modules:
nfsd                   65856   0 (autoclean)
cpqrid                 50896   4
cpqhealth             670284  18 [cpqrid]
cpqrom                 21416   0 [cpqhealth]
autofs                  9412   3 (autoclean)
ipv6                  158496  -1 (autoclean)
eepro100               17296   4 (autoclean)
lvm-mod                46336  55 (autoclean)
reiserfs              155968  28
cciss                  17056   7
cpqarray               16320   7

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
01f0-01f7 : ide0
02f8-02ff : serial(auto)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
1800-18ff : PCI device 0e11:a0f0
2000-20ff : PCI device 1000:0010
2400-243f : PCI device 8086:1229
  2400-243f : eepro100
2800-28ff : PCI device 1002:4756
2c00-2c3f : PCI device 8086:1229
  2c00-2c3f : eepro100
2c40-2c4f : PCI device 1166:0211
  2c40-2c47 : ide0
  2c48-2c4f : ide1
3000-3fff : PCI Bus #01
  3000-30ff : PCI device 1002:4756
4000-403f : PCI device 8086:1229
  4000-403f : eepro100
4040-407f : PCI device 8086:1229
  4040-407f : eepro100
4400-44ff : PCI device 0e11:b060

00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000cd7ff : Extension ROM
000cd800-000cefff : Extension ROM
000cf000-000d07ff : Extension ROM
000d0800-000d47ff : Extension ROM
000f0000-000fffff : System ROM
00100000-3fffbfff : System RAM
  00100000-002603c4 : Kernel code
  002603c5-002c525f : Kernel data
3fffc000-3fffffff : ACPI Tables
c0fc0000-c0ffffff : PCI device 8086:1960
c1000000-c1ffffff : PCI device 1002:4756
c2000000-c2ffffff : PCI Bus #01
  c2000000-c2ffffff : PCI device 1002:4756
c3c00000-c3cfffff : PCI device 8086:1229
c3dfd000-c3dfdfff : PCI device 8086:1229
  c3dfd000-c3dfdfff : eepro100
c3dfef00-c3dfefff : PCI device 0e11:a0f0
c3dff000-c3dfffff : PCI device 1002:4756
c3e00000-c3efffff : PCI device 8086:1229
c3fff000-c3ffffff : PCI device 8086:1229
  c3fff000-c3ffffff : eepro100
c4000000-c4ffffff : PCI device 1000:0010
c5000000-c5ffffff : PCI device 1000:0010
c6900000-c69fffff : PCI Bus #01
  c69ff000-c69fffff : PCI device 1002:4756
c6a00000-c6afffff : PCI device 0e11:b060
c6bc0000-c6bfffff : PCI device 0e11:b060
c6c00000-c6cfffff : PCI device 8086:1229
c6dff000-c6dfffff : PCI device 8086:1229
  c6dff000-c6dfffff : eepro100
c6e00000-c6efffff : PCI device 8086:1229
c6fff000-c6ffffff : PCI device 8086:1229
  c6fff000-c6ffffff : eepro100
fec00000-fec0ffff : reserved
fee00000-fee0ffff : reserved
fff80000-ffffffff : reserved

PCI BUS

00:00.0 Host bridge: ServerWorks CNB20LE (rev 05)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64, cache line size 08

00:00.1 Host bridge: ServerWorks CNB20LE (rev 05)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08

00:01.0 RAID bus controller: Symbios Logic Inc. (formerly NCR): Unknown
device 0010 (rev 02)
        Subsystem: Compaq Computer Corporation: Unknown device 4040
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 192 (7500ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 15
        Region 0: I/O ports at 2000 [size=256]
        Region 1: Memory at c5000000 (32-bit, non-prefetchable) [size=16M]
        Region 2: Memory at c4000000 (32-bit, non-prefetchable) [size=16M]
        Expansion ROM at <unassigned> [disabled] [size=512K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 08)
        Subsystem: Compaq Computer Corporation: Unknown device b134
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at c3fff000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 2400 [size=64]
        Region 2: Memory at c3e00000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:03.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC 215IIC
[Mach64 GT IIC] (rev 7a) (prog-if 00 [VGA])
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Region 0: Memory at c1000000 (32-bit, prefetchable) [disabled]
[size=16M]
        Region 1: I/O ports at 2800 [disabled] [size=256]
        Region 2: Memory at c3dff000 (32-bit, non-prefetchable) [disabled]
[size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [5c] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 System peripheral: Compaq Computer Corporation Advanced System
Management Controller
        Subsystem: Compaq Computer Corporation: Unknown device b0f3
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 0
        Region 0: I/O ports at 1800 [size=256]
        Region 1: Memory at c3dfef00 (32-bit, non-prefetchable) [size=256]

00:05.0 PCI bridge: Intel Corporation 80960RP [i960 RP
Microprocessor/Bridge] (rev 05) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: c6900000-c69fffff
        Prefetchable memory behind bridge: c2000000-c2ffffff
        BridgeCtl: Parity+ SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:05.1 Memory controller: Intel Corporation 80960RP [i960RP
Microprocessor] (rev 05)
        Subsystem: Compaq Computer Corporation: Unknown device c000
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at c0fc0000 (32-bit, prefetchable) [size=256K]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:06.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 08)
        Subsystem: Compaq Computer Corporation: Unknown device b144
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at c3dfd000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 2c00 [size=64]
        Region 2: Memory at c3c00000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0f.0 ISA bridge: ServerWorks OSB4 (rev 4f)
        Subsystem: ServerWorks OSB4
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:0f.1 IDE interface: ServerWorks: Unknown device 0211 (prog-if 8a [Master
SecP PriP])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at 2c40 [size=16]

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC 215IIC
[Mach64 GT IIC] (rev 7a) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc 3D Rage IIC 215IIC [Mach64 GT IIC]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 08
        Region 0: Memory at c2000000 (32-bit, prefetchable) [size=16M]
        Region 1: I/O ports at 3000 [size=256]
        Region 2: Memory at c69ff000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [5c] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:03.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 08)
        Subsystem: Compaq Computer Corporation: Unknown device b144
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at c6fff000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 4000 [size=64]
        Region 2: Memory at c6e00000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

03:04.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 08)
        Subsystem: Compaq Computer Corporation: Unknown device b144
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at c6dff000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 4040 [size=64]
        Region 2: Memory at c6c00000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

03:06.0 RAID bus controller: Compaq Computer Corporation: Unknown device
b060 (rev 02)
        Subsystem: Compaq Computer Corporation: Unknown device 4070
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Interrupt: pin A routed to IRQ 15
        Region 0: Memory at c6bc0000 (32-bit, non-prefetchable) [size=256K]
        Region 1: Memory at c6a00000 (32-bit, non-prefetchable) [size=1M]
        Region 4: I/O ports at 4400 [size=256]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [f0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f8] Vital Product Data


Oracle Version
     8.1.7

Memory :
     1GB

Server:
     ML370 with 5300 Controller and Smart Array Controller




