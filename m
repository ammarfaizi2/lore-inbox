Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbUCLBPF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 20:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbUCLBPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 20:15:05 -0500
Received: from a213-22-119-56.netcabo.pt ([213.22.119.56]:49801 "HELO
	rootisg0d.org") by vger.kernel.org with SMTP id S261897AbUCLBOV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 20:14:21 -0500
Message-ID: <004c01c407cf$5fffa270$0700a8c0@darkgod>
From: "psycosonic" <psycosonic@rootisg0d.org>
To: <linux-net@oss.sgi.com>, <linux-kernel@vger.kernel.org>
Subject: Abysmal network performance since 2.4.25 !!!!!...
Date: Fri, 12 Mar 2004 01:14:32 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2055
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2055
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey.

I'm having some problems since i updated from kernel 2.4.24 to 2.4.25 .. it
seems that 2.4.25 has some real performance problems.
The problem is that i can't get the NIC's to work fine.. i don't know why, 
i've already used several kernel configurations..
i've also tried with patch2.4.25pre4 and... nothin' ...even used another 
switch 10/100mbit.. not even with patch-2.4.26pre2 it goes normal,
I've compiled the kernel in another computer, with too many different 
configurations, different hardware.. etc.. and the result is the same.
Some friends of mine are having the same problem.
Well.. with kernel 2.4.24 i usually had a max speed of 12Mb/s .. now , with 
2.4.25 it only goes to 2,2Mb/s MAX speed.  :(
I've tried to use vsftpd, proftpd, apache 1.3.x, apache 2.x, samba.. etc 
etc.. with kernel 2.4.24 works pretty fine... but since 2.4.25.. wow..
Not even with the patches 2.4.25rcX it worked.. and.. i don't know what more 
to do.
Here you have some information:

Computer 1:

Pentium 3 @ 733Mhz
Board with SIS Chipset.
NIC's: SIS900 & Realtek 8139
....
OS: Slackware 9.0


Computer 2:

AMD XP 2600+
Board ASUS A7V8X-MX Chipset VIA KT400
NIC's: VIA Rhine
....
OS: Slackware 9.1


----------
None of this computers works OK with kernel 2.4.25.. well.. the problem is
that with apache... proftpd.. vsftpd... i only can get speeds of  ~2,4Mb/s
MAX! .. i've tried to change cables.. switch.. etc.. nothin'.. i boot to
kernel 2.4.24 and everything went normal.
----------


INFO:

Computer 1:

root@rootisg0d:~# lspci -vv
00:00.0 Host bridge: ALi Corporation M1621 (rev 04)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at da000000 (32-bit, prefetchable) [size=32M]
        Capabilities: [b0] AGP version 1.0
                Status: RQ=28 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW-
Rate=x2
        Capabilities: [a4] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:01.0 PCI bridge: ALi Corporation PCI to AGP Controller (rev 01) (prog-if
00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000b000-0000bfff
        Memory behind bridge: dce00000-deefffff
        Prefetchable memory behind bridge: d2c00000-d6cfffff
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if
10 [OHCI])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at dfffb000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
(rev c3)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
00:0c.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
        Subsystem: C-Media Electronics Inc CMI8738/C3DX PCI Audio Device
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at dc00 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:0e.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100
Ethernet (rev 02)
        Subsystem: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet
Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (13000ns min, 2750ns max)
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at d800 [size=256]
        Region 1: Memory at dfffa000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at dffc0000 [disabled] [size=128K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:0f.0 IDE interface: ALi Corporation M5229 IDE (rev c2) (prog-if fa)
        Subsystem: ALi Corporation M5229 IDE
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 14
        Region 4: I/O ports at ffa0 [size=16]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:10.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2164W
[Millennium II] (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc.: Unknown device 0100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at d7000000 (32-bit, prefetchable) [size=16M]
        Region 1: Memory at dfffc000 (32-bit, non-prefetchable) [size=16K]
        Region 2: Memory at df000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at dffe0000 [disabled] [size=64K]
00:14.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at d400 [size=256]
        Region 1: Memory at dfff9f00 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at dffb0000 [disabled] [size=64K]
01:00.0 VGA compatible controller: nVidia Corporation NV5 [Aladdin TNT2]
(rev 20) (prog-if 00 [VGA])
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at dd000000 (32-bit, non-prefetchable) [disabled]
[size=16M]
        Region 1: Memory at d4000000 (32-bit, prefetchable) [disabled]
[size=32M]
        Expansion ROM at deef0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 1.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
Rate=<none>

=======================================

demsg:

Mar 10 21:43:25 rootisg0d init: Switching to runlevel: 6
Mar 10 21:43:28 rootisg0d exiting on signal 15
Mar 10 21:44:13 rootisg0d syslogd 1.4.1: restart.
Mar 10 21:44:14 rootisg0d kernel: klogd 1.4.1, log source = /proc/kmsg
started.
Mar 10 21:44:14 rootisg0d kernel: BIOS-provided physical RAM map:
Mar 10 21:44:14 rootisg0d kernel: 255MB LOWMEM available.
Mar 10 21:44:15 rootisg0d kernel: Initializing CPU#0
Mar 10 21:44:15 rootisg0d kernel: Memory: 255996k/262080k available (1860k
kernel code, 5696k reserved, 307k data, 128k init, 0k highmem)
Mar 10 21:44:15 rootisg0d kernel: Dentry cache hash table entries: 32768
(order: 6, 262144 bytes)
Mar 10 21:44:15 rootisg0d kernel: Inode cache hash table entries: 16384
(order: 5, 131072 bytes)
Mar 10 21:44:15 rootisg0d kernel: Mount cache hash table entries: 512
(order: 0, 4096 bytes)
Mar 10 21:44:15 rootisg0d kernel: Buffer cache hash table entries: 16384
(order: 4, 65536 bytes)
Mar 10 21:44:15 rootisg0d kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Mar 10 21:44:15 rootisg0d kernel: CPU: L2 cache: 256K
Mar 10 21:44:15 rootisg0d kernel: CPU serial number disabled.
Mar 10 21:44:15 rootisg0d kernel: Enabling fast FPU save and restore...
done.
Mar 10 21:44:15 rootisg0d kernel: Enabling unmasked SIMD FPU exception
support... done.
Mar 10 21:44:15 rootisg0d kernel: Checking 'hlt' instruction... OK.
Mar 10 21:44:15 rootisg0d kernel: PCI: PCI BIOS revision 2.10 entry at
0xfdb01, last bus=1
Mar 10 21:44:15 rootisg0d kernel: PCI: Using configuration type 1
Mar 10 21:44:15 rootisg0d kernel: PCI: Probing PCI hardware
Mar 10 21:44:15 rootisg0d kernel: PCI: Using IRQ router ALI [10b9/1533] at
00:07.0
Mar 10 21:44:15 rootisg0d kernel: PCI: Hardcoded IRQ 14 for device 00:0f.0
Mar 10 21:44:15 rootisg0d kernel: Linux NET4.0 for Linux 2.4
Mar 10 21:44:15 rootisg0d kernel: Based upon Swansea University Computer
Society NET3.039
Mar 10 21:44:15 rootisg0d kernel: VFS: Disk quotas vdquot_6.5.1
Mar 10 21:44:15 rootisg0d kernel: Journalled Block Device driver loaded
Mar 10 21:44:15 rootisg0d kernel: Detected PS/2 Mouse Port.
Mar 10 21:44:15 rootisg0d kernel: Serial driver version 5.05c (2001-07-08)
with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
Mar 10 21:44:15 rootisg0d kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Mar 10 21:44:15 rootisg0d kernel: Real Time Clock Driver v1.10e
Mar 10 21:44:15 rootisg0d kernel: Floppy drive(s): fd0 is 1.44M
Mar 10 21:44:15 rootisg0d kernel: FDC 0 is a post-1991 82077
Mar 10 21:44:15 rootisg0d kernel: loop: loaded (max 8 devices)
Mar 10 21:44:15 rootisg0d kernel: Uniform Multi-Platform E-IDE driver
Revision: 7.00beta4-2.4
Mar 10 21:44:15 rootisg0d kernel: ide: Assuming 33MHz system bus speed for
PIO modes; override with idebus=xx
Mar 10 21:44:15 rootisg0d kernel: ALI15X3: IDE controller at PCI slot
00:0f.0
Mar 10 21:44:15 rootisg0d kernel: PCI: Hardcoded IRQ 14 for device 00:0f.0
Mar 10 21:44:15 rootisg0d kernel: ALI15X3: chipset revision 194
Mar 10 21:44:15 rootisg0d kernel: ALI15X3: not 100%% native mode: will probe
irqs later
Mar 10 21:44:15 rootisg0d kernel:     ide0: BM-DMA at 0xffa0-0xffa7, BIOS
settings: hda:DMA, hdb:pio
Mar 10 21:44:15 rootisg0d kernel:     ide1: BM-DMA at 0xffa8-0xffaf, BIOS
settings: hdc:pio, hdd:DMA
Mar 10 21:44:15 rootisg0d kernel: ide: Assuming 33MHz system bus speed for
PIO modes; override with idebus=xx
Mar 10 21:44:15 rootisg0d kernel: hda: 40021632 sectors (20491 MB) w/2048KiB
Cache, CHS=2491/255/63, UDMA(66)
Mar 10 21:44:15 rootisg0d kernel: hdd: ATAPI 48X CD-ROM drive, 128kB Cache,
DMA
Mar 10 21:44:15 rootisg0d kernel: Uniform CD-ROM driver Revision: 3.12
Mar 10 21:44:15 rootisg0d kernel: Partition check:
Mar 10 21:44:15 rootisg0d kernel:  hda: hda1 < hda5 > hda2
Mar 10 21:44:15 rootisg0d kernel: Initializing Cryptographic API
Mar 10 21:44:15 rootisg0d kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Mar 10 21:44:15 rootisg0d kernel: IP Protocols: ICMP, UDP, TCP
Mar 10 21:44:15 rootisg0d kernel: IP: routing cache hash table of 2048
buckets, 16Kbytes
Mar 10 21:44:15 rootisg0d kernel: TCP: Hash tables configured (established
16384 bind 32768)
Mar 10 21:44:15 rootisg0d kernel: NET4: Unix domain sockets 1.0/SMP for
Linux NET4.0.
Mar 10 21:44:15 rootisg0d kernel: kjournald starting.  Commit interval 5
seconds
Mar 10 21:44:15 rootisg0d kernel: EXT3-fs: mounted filesystem with ordered
data mode.
Mar 10 21:44:15 rootisg0d kernel: Freeing unused kernel memory: 128k freed
Mar 10 21:44:15 rootisg0d kernel: Adding Swap: 497944k swap-space
(priority -1)
Mar 10 21:44:15 rootisg0d kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on
ide0(3,2), internal journal
Mar 10 21:44:15 rootisg0d kernel: grsec: mount /dev/hda2 to / by
(mount:5035) UID(0) EUID(0), parent (rc.S:12520) UID(0) EUID(0)
Mar 10 21:44:15 rootisg0d kernel: grsec: mount /dev/hda2 to / by
(mount:22511) UID(0) EUID(0), parent (rc.S:12520) UID(0) EUID(0)
Mar 10 21:44:15 rootisg0d kernel: grsec: mount /dev/hda2 to / by
(mount:5035) UID(0) EUID(0), parent (rc.S:12520) UID(0) EUID(0)
Mar 10 21:44:15 rootisg0d kernel: grsec: mount /dev/hda2 to / by
(mount:22511) UID(0) EUID(0), parent (rc.S:12520) UID(0) EUID(0)
Mar 10 21:44:15 rootisg0d kernel: grsec: mount devpts to /dev/pts by
(mount:26665) UID(0) EUID(0), parent (rc.S:12520) UID(0) EUID(0)
Mar 10 21:44:15 rootisg0d kernel: grsec: mount proc to /proc by
(mount:26665) UID(0) EUID(0), parent (rc.S:12520) UID(0) EUID(0)
Mar 10 21:44:15 rootisg0d kernel: 8139too Fast Ethernet driver 0.9.26
Mar 10 21:44:15 rootisg0d kernel: PCI: Found IRQ 12 for device 00:14.0
Mar 10 21:44:15 rootisg0d kernel: PCI: Sharing IRQ 12 with 00:0e.0
Mar 10 21:44:15 rootisg0d kernel: eth0: RealTek RTL8139 at 0xd0856f00,
00:50:fc:3d:53:5e, IRQ 12
Mar 10 21:44:15 rootisg0d kernel: 8139cp: 10/100 PCI Ethernet driver v1.1
(Aug 30, 2003)
Mar 10 21:44:15 rootisg0d kernel: sis900.c: v1.08.06 9/24/2002
Mar 10 21:44:15 rootisg0d kernel: PCI: Found IRQ 12 for device 00:0e.0
Mar 10 21:44:15 rootisg0d kernel: PCI: Sharing IRQ 12 with 00:14.0
Mar 10 21:44:15 rootisg0d kernel: eth1: SiS 900 Internal MII PHY transceiver
found at address 1.
Mar 10 21:44:15 rootisg0d kernel: eth1: Using transceiver found at address 1
as default
Mar 10 21:44:15 rootisg0d kernel: eth1: SiS 900 PCI Fast Ethernet at 0xd800,
IRQ 12, 00:d0:09:5d:ae:e4.
Mar 10 21:44:15 rootisg0d kernel: 8139cp: 10/100 PCI Ethernet driver v1.1
(Aug 30, 2003)
Mar 10 21:44:15 rootisg0d last message repeated 8 times

=======================================

root@rootisg0d:~# netstat -i
Kernel Interface table
Iface   MTU Met   RX-OK RX-ERR RX-DRP RX-OVR   TX-OK TX-ERR TX-DRP TX-OVR
Flg
eth0   1500   0   19039      0      0      0   14660      0      0      0
BMRU
eth1   1500   0   23312      0      0      0   22803      0      0      0
BMRU
lo    16436   0       2      0      0      0       2      0      0      0
LRU


=======================================

root@rootisg0d:~# cat /proc/interrupts
           CPU0
  0:    1312079          XT-PIC  timer
  1:          3          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
 12:      79138          XT-PIC  PS/2 Mouse, eth0, eth1
 14:      12941          XT-PIC  ide0
 15:          4          XT-PIC  ide1
NMI:          0
LOC:    1312084
ERR:          0
MIS:          0
root@rootisg0d:~# cat /proc/interrupts
           CPU0
  0:    1312153          XT-PIC  timer
  1:          3          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
 12:      79152          XT-PIC  PS/2 Mouse, eth0, eth1
 14:      12941          XT-PIC  ide0
 15:          4          XT-PIC  ide1
NMI:          0
LOC:    1312158
ERR:          0
MIS:          0


=======================================

root@rootisg0d:~# mii-tool -v
eth0: negotiated 100baseTx-FD, link ok
  product info: vendor 00:00:00, model 0 rev 0
  basic mode:   autonegotiation enabled
  basic status: autonegotiation complete, link ok
  capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  advertising:  100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  link partner: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD flow-control
eth1: negotiated 100baseTx-FD, link ok
  product info: vendor 00:07:60, model 0 rev 0
  basic mode:   autonegotiation enabled
  basic status: autonegotiation complete, link ok
  capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  advertising:  100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  link partner: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD flow-control


======================================= ...... EOMachineNumberOne

Let's check the second...

root@heaven:~# lspci -vv
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3205
        Subsystem: Asustek Computer, Inc.: Unknown device 80f9
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [80] AGP version 3.5
                Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b198 (prog-if 00
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: dc000000-ddffffff
        Prefetchable memory behind bridge: d8000000-dbffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00
[UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80ed
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 21
        Region 4: I/O ports at d000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00
[UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80ed
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin B routed to IRQ 21
        Region 4: I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00
[UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80ed
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin C routed to IRQ 21
        Region 4: I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20
[EHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80ed
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 21
        Region 0: Memory at de000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
        Subsystem: Asustek Computer, Inc.: Unknown device 80f9
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus
Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: Asustek Computer, Inc.: Unknown device 80ed
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 20
        Region 4: I/O ports at dc00 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97
Audio Controller (rev 50)
        Subsystem: Asustek Computer, Inc.: Unknown device 80b0
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 22
        Region 0: I/O ports at e000 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev
74)
        Subsystem: Asustek Computer, Inc.: Unknown device 80ff
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 23
        Region 0: I/O ports at e800 [size=256]
        Region 1: Memory at de001000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
01:00.0 VGA compatible controller: VIA Technologies, Inc.: Unknown device
7205 (rev 01) (prog-if 00 [VGA])
        Subsystem: Asustek Computer, Inc.: Unknown device 80ed
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=64M]
        Region 1: Memory at dc000000 (32-bit, non-prefetchable) [size=16M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [70] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
Rate=<none>

=======================================

dmesg...


PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off'
PCI: Via IRQ fixup for 00:10.0, from 11 to 5
PCI: Via IRQ fixup for 00:10.1, from 11 to 5
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 189M
agpgart: Unsupported Via chipset (device id: 3205), you might want to boot
with agp=try_unsupported
agpgart: no supported devices found.
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
[drm] Initialized radeon 1.7.0 20020828 on minor 1
[drm:drm_init] *ERROR* Cannot initialize the agpgart module.
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: ST380011A, ATA DISK drive
hdb: ST360014A, ATA DISK drive
hdc: ASUS DVD-ROM E612, ATAPI CD/DVD-ROM drive
hdd: SAMSUNG CD-R/RW SW-408B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=9729/255/63
hdb: attached ide-disk driver.
hdb: host protected area => 1
hdb: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=7297/255/63
hdc: attached ide-cdrom driver.
hdc: ATAPI 40X DVD-ROM drive, 640kB Cache
Uniform CD-ROM driver Revision: 3.12
hdd: attached ide-cdrom driver.
hdd: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache
Partition check:
 hda: hda1 hda2
 hdb: unknown partition table
es1371: version v0.32 time 05:23:28 Jan 14 2004
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
usb.c: registered new driver hub
host/uhci.c: USB Universal Host Controller Interface driver v1.1
host/uhci.c: USB UHCI at I/O 0xd000, IRQ 21
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
host/uhci.c: USB UHCI at I/O 0xd400, IRQ 21
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
host/uhci.c: USB UHCI at I/O 0xd800, IRQ 21
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
EXT2-fs warning (device ide0(3,1)): ext2_read_super: mounting ext3
filesystem as ext2
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 120k freed
Adding Swap: 538168k swap-space (priority -1)
via-rhine.c:v1.10-LK1.1.19  July-12-2003  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
eth0: VIA VT6102 Rhine-II at 0xe800, 00:0c:6e:a6:cc:05, IRQ 23.
eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 45e1.
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.

=======================================
root@heaven:~# netstat -i
Kernel Interface table
Iface   MTU Met   RX-OK RX-ERR RX-DRP RX-OVR   TX-OK TX-ERR TX-DRP TX-OVR
Flg
eth0   1500   0     911      0      0      0     496      0      0      0
BMRU
lo    16436   0       0      0      0      0       0      0      0      0
LRU

=======================================

root@heaven:~# cat /proc/interrupts
           CPU0
  0:    1418420    IO-APIC-edge  timer
  1:          3    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  9:          0    IO-APIC-edge  acpi
 12:          0    IO-APIC-edge  PS/2 Mouse
 14:       5487    IO-APIC-edge  ide0
 15:          7    IO-APIC-edge  ide1
 21:          0   IO-APIC-level  usb-uhci, usb-uhci, usb-uhci
 23:       1409   IO-APIC-level  eth0
NMI:          0
LOC:    1418315
ERR:          0
MIS:          0
root@heaven:~# cat /proc/interrupts
           CPU0
  0:    1418476    IO-APIC-edge  timer
  1:          3    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  9:          0    IO-APIC-edge  acpi
 12:          0    IO-APIC-edge  PS/2 Mouse
 14:       5487    IO-APIC-edge  ide0
 15:          7    IO-APIC-edge  ide1
 21:          0   IO-APIC-level  usb-uhci, usb-uhci, usb-uhci
 23:       1424   IO-APIC-level  eth0
NMI:          0
LOC:    1418371
ERR:          0
MIS:          0


=======================================

root@heaven:~# mii-tool -v
eth0: negotiated 100baseTx-FD flow-control, link ok
  product info: vendor 00:40:63, model 50 rev 8
  basic mode:   autonegotiation enabled
  basic status: autonegotiation complete, link ok
  capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  advertising:  100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD flow-control
  link partner: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD flow-control


============



EOF EOF EOF



Please gimme some answer ASAP.. i'm getting crazy :(



(()) 


