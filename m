Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265169AbTLMRap (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 12:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265235AbTLMRap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 12:30:45 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:3204 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S265169AbTLMRaC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 12:30:02 -0500
Subject: linux-2.6.0-test11, Adaptec 2940UW2 and Matroxfb problems
From: "Nelson Ferreira" <Nelson.Ferreira@myrealbox.com>
To: linux-kernel@vger.kernel.org
Date: Sat, 13 Dec 2003 12:30:03 -0500
X-Mailer: NetMail ModWeb Module
X-Priority: 3
X-MSMail-Priority: Normal
MIME-Version: 1.0
Message-ID: <1071336603.be846560Nelson.Ferreira@myrealbox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I currently have two issues with linux-2.6.0-test11:

1) matroxfb does take the vesa:0x... mode set, it always starts at
   80x25 and is unusable due to the image becoming mangled when it
   scrolls or a clear command is issued, or I switch from X to the
   console. It never worked for me. I have a Matrox G200 Marvel with
   8MB. Anyone has managed to get it to work ? Is there any useful
   info that can provide, tests I can make ?

2) Ever since around 2.4.20 my Adaptec 2940UW2 card using the "new"
   driver consistently hangs the whole box on (re)boot trying to
   recover from errors. This issue is still present in 2.4.23 and
   2.6.0-test11. The work around is to always make a cold boot,but
   sometimes I forget and ocasionally I get corruption of all places
   in /etc/resolv.conf :( - ext3...
   I wonder if this has something to do with:

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
        <Adaptec 2940 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:2): 10.000MB/s transfers (10.000MHz, offset 8)
scsi0:A:4:0: DV failed to configure device.  Please file a bug report against this driver.
(scsi0:A:12): 80.000MB/s transfers (40.000MHz, offset 31, 16bit)
  Vendor: PLEXTOR   Model: CD-R   PX-W4220T  Rev: 1.04
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:4): 20.000MB/s transfers (20.000MHz, offset 15)
  Vendor: QUANTUM   Model: FIREBALL ST4.3S   Rev: 0F0C
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:4:0: Tagged Queuing enabled.  Depth 32
  Vendor: IBM       Model: DNES-309170W      Rev: SA30
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:12:0: Tagged Queuing enabled.  Depth 32

I have a Dual PIII-450Mhz with 1GB, TekRam P6B40D-A5 (440BX) - yes it
is an oldie, circa '99.

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux tuxie.homelinux.net 2.6.0-test11 #3 SMP Thu Dec 11 20:20:55 EST 2003 i686
unknown

Gnu C                  3.3.1
Gnu make               3.79.1
util-linux             2.11z
mount                  2.11z
module-init-tools      0.9.12
e2fsprogs              1.29
jfsutils               1.1.2
pcmcia-cs              3.0.14
PPP                    2.4.1
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.0
Procps                 3.0.1
Net-tools              1.54
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         ip_nat_irc ip_conntrack_irc ip_nat_ftp ip_conntrack_ftp ipt_conntrack ipt_iprange ipt_recent ipt_state ipt_mac ipt_physdev ipt_REDIRECT ipt_REJECT ipt_MASQUERADE ipt_LOG ipt_helper iptable_nat ip_conntrack iptable_filter ip_tables ppp_synctty ppp_async ppp_generic slhc e100 scanner snd_ens1371 snd_rawmidi snd_ac97_codec gameport

[njsf@tuxie linux-2.6.0-test11]$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 504.831
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr sse
bogomips        : 997.37

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 504.831
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr sse
bogomips        : 1007.61
[njsf@tuxie linux-2.6.0-test11]$ cat /proc/modules
ip_nat_irc 4720 0 - Live 0xf99f1000
ip_conntrack_irc 71540 1 ip_nat_irc, Live 0xf99de000
ip_nat_ftp 5776 0 - Live 0xf99c7000
ip_conntrack_ftp 72436 1 ip_nat_ftp, Live 0xf99cb000
ipt_conntrack 2400 0 - Live 0xf99c0000
ipt_iprange 1664 0 - Live 0xf99be000
ipt_recent 11532 0 - Live 0xf99c3000
ipt_state 1760 0 - Live 0xf99bc000
ipt_mac 1824 0 - Live 0xf99ba000
ipt_physdev 2032 0 - Live 0xf99b8000
ipt_REDIRECT 2048 0 - Live 0xf997b000
ipt_REJECT 6816 0 - Live 0xf9966000
ipt_MASQUERADE 4768 0 - Live 0xf9969000
ipt_LOG 5632 0 - Live 0xf9961000
ipt_helper 2880 0 - Live 0xf9964000
iptable_nat 30980 4 ip_nat_irc,ip_nat_ftp,ipt_REDIRECT,ipt_MASQUERADE, Live 0xf998e000
ip_conntrack 44716 10 ip_nat_irc,ip_conntrack_irc,ip_nat_ftp,ip_conntrack_ftp,ipt_conntrack,ipt_state,ipt_REDIRECT,ipt_MASQUERADE,ipt_helper,iptable_nat, Live 0xf996f000
iptable_filter 2688 0 - Live 0xf992d000
ip_tables 21664 13 ipt_conntrack,ipt_iprange,ipt_recent,ipt_state,ipt_mac,ipt_physdev,ipt_REDIRECT,ipt_REJECT,ipt_MASQUERADE,ipt_LOG,ipt_helper,iptable_nat,iptable_filter, Live 0xf9937000
ppp_synctty 9824 0 - Live 0xf9933000
ppp_async 12000 1 - Live 0xf992f000
ppp_generic 33584 6 ppp_synctty,ppp_async, Live 0xf994f000
slhc 7136 1 ppp_generic, Live 0xf98c9000
e100 65064 0 - Live 0xf993e000
scanner 22564 0 - Live 0xf98cf000
snd_ens1371 26376 2 - Live 0xf98f0000
snd_rawmidi 26880 1 snd_ens1371, Live 0xf98d8000
snd_ac97_codec 55716 1 snd_ens1371, Live 0xf98e1000
gameport 4928 1 snd_ens1371, Live 0xf98cc000
[njsf@tuxie linux-2.6.0-test11]$ cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
  03c0-03df : matrox
03e8-03ef : serial
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
5000-501f : 0000:00:07.3
  5000-5007 : piix4-smbus
5800-583f : 0000:00:07.3
9000-9fff : PCI Bus #01
a000-a01f : 0000:00:07.2
a400-a43f : 0000:00:08.0
  a400-a43f : e100
a800-a807 : 0000:00:09.0
  a800-a807 : ide2
ac00-ac03 : 0000:00:09.0
  ac02-ac02 : ide2
b000-b007 : 0000:00:09.0
b400-b403 : 0000:00:09.0
b800-b80f : 0000:00:09.0
  b800-b807 : ide2
  b808-b80f : ide3
bc00-bcff : 0000:00:0a.0
c000-c03f : 0000:00:0c.0
  c000-c03f : Ensoniq AudioPCI
f000-f00f : 0000:00:07.1
  f000-f007 : ide0
  f008-f00f : ide1

[njsf@tuxie linux-2.6.0-test11]$ cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c8000-000c8fff : Extension ROM
000c9000-000cb7ff : Extension ROM
000cc000-000d25ff : Extension ROM
000f0000-000fffff : System ROM
00100000-3fffffff : System RAM
  00100000-00402296 : Kernel code
  00402297-005332bf : Kernel data
e0000000-e7ffffff : 0000:00:00.0
e8000000-ebffffff : PCI Bus #01
  e8000000-e8003fff : 0000:01:00.0
    e8000000-e8003fff : matroxfb MMIO
  e9000000-e97fffff : 0000:01:00.0
ec000000-ecffffff : PCI Bus #01
  ec000000-ecffffff : 0000:01:00.0
    ec000000-ecffffff : matroxfb FB
f0000000-f00fffff : 0000:00:08.0
  f0000000-f00fffff : e100
f0100000-f0103fff : 0000:00:09.0
f0104000-f0104fff : 0000:00:0a.0
  f0104000-f0104fff : aic7xxx
f0105000-f0105fff : 0000:00:08.0
  f0105000-f0105fff : e100
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[njsf@tuxie linux-2.6.0-test11]$ /sbin/lspci -vvv
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0 set
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 set
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: e8000000-ebffffff
        Prefetchable memory behind bridge: ec000000-ecffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80
[Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set
        Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set
        Interrupt: pin D routed to IRQ 19
        Region 4: I/O ports at a000 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:08.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
        Subsystem: Intel Corp. EtherExpress PRO/100+ Management Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 56 max, 64 set, cache line size 08
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at f0105000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at a400 [size=64]
        Region 2: Memory at f0000000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at ed000000 [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI+ D1+ D2+ PME+
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:09.0 Unknown mass storage controller: Promise Technology, Inc. 20269 (rev 02) (prog-if 85)
        Subsystem: Promise Technology, Inc. Ultra133TX2
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 4 min, 18 max, 0 set, cache line size 08
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at a800 [size=8]
        Region 1: I/O ports at ac00 [size=4]
        Region 2: I/O ports at b000 [size=8]
        Region 3: I/O ports at b400 [size=4]
        Region 4: I/O ports at b800 [size=16]
        Region 5: Memory at f0100000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at ee000000 [disabled] [size=16K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI+ D1+ D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 SCSI storage controller: Adaptec AHA-2940U2/U2W
        Subsystem: Adaptec AHA-2940U2W SCSI Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 39 min, 25 max, 64 set
        Interrupt: pin A routed to IRQ 18
        BIST result: 00
        Region 0: I/O ports at bc00 [disabled] [size=256]
        Region 1: Memory at f0104000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at ef000000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
        Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 12 min, 128 max, 64 set
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at c000 [size=64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr+ DSI+ D1- D2+ PME+
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev 01) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Marvel G200 AGP
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 16 min, 32 max, 0 set, cache line size 08
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at ec000000 (32-bit, prefetchable) [size=16M]
        Region 1: Memory at e8000000 (32-bit, non-prefetchable) [size=16K]
        Region 2: Memory at e9000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI+ D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x2

[njsf@tuxie linux-2.6.0-test11]$ cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-W4220T Rev: 1.04
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: QUANTUM  Model: FIREBALL ST4.3S  Rev: 0F0C
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 12 Lun: 00
  Vendor: IBM      Model: DNES-309170W     Rev: SA30
  Type:   Direct-Access                    ANSI SCSI revision: 03

[njsf@tuxie linux-2.6.0-test11]$ dmesg
twice.
On node 0 totalpages: 262144
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32768 pages, LIFO batch:8
DMI 2.2 present.
ACPI disabled because your bios is from 00 and too old
You can enable it with acpi=force
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 6:7 APIC version 17
Processor #1 6:7 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=DK ro root=81b video=matrox:mem:8M,enabled,accel,mtrr,sgram,hwcursor,fastfont:64K,vesa:0x11E apm=off acpi=off ide2=ata66 hdc=cdrom matroxfb:off
ide_setup: ide2=ata66
ide_setup: hdc=cdrom
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 504.831 MHz processor.
Console: colour VGA+ 80x60
Memory: 1032296k/1048576k available (3080k kernel code, 15320k reserved, 1220k data, 228k init, 131072k highmem)
Calibrating delay loop... 997.37 BogoMIPS
Security Scaffold v1.0.0 initialized
Capability LSM initialized
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium III (Katmai) stepping 03
per-CPU timeslice cutoff: 1462.29 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 3000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1007.61 BogoMIPS
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Katmai) stepping 03
Total of 2 processors activated (2004.99 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-9, 2-10, 2-11, 2-13, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 19.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 001 01  0    0    0   0   0    1    1    71
 0d 000 00  1    0    0   0   0    0    0    00
 0e 001 01  0    0    0   0   0    1    1    79
 0f 001 01  0    0    0   0   0    1    1    81
 10 001 01  1    1    0   1   0    1    1    89
 11 001 01  1    1    0   1   0    1    1    91
 12 001 01  1    1    0   1   0    1    1    99
 13 001 01  1    1    0   1   0    1    1    A1
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ12 -> 0:12
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 504.0663 MHz.
..... host bus clock speed is 112.0147 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 2
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb3c0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
ACPI: Subsystem revision 20031002
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: the driver 'system' has been registered
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbff0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc018, dseg 0xf0000
pnp: match found with the PnP device '00:07' and the driver 'system'
pnp: match found with the PnP device '00:08' and the driver 'system'
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:07.0
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
PCI->APIC IRQ transform: (B0,I8,P0) -> 17
PCI->APIC IRQ transform: (B0,I9,P0) -> 19
PCI->APIC IRQ transform: (B0,I10,P0) -> 18
PCI->APIC IRQ transform: (B0,I12,P0) -> 16
PCI: No IRQ known for interrupt pin A of device 0000:01:00.0. Probably buggy MP
table.
matroxfb: Matrox Marvel G200 (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 640x480x8bpp (virtual: 640x65536)
matroxfb: framebuffer at 0xEC000000, mapped to 0xf8805000, size 8388608
fb0: MATROX frame buffer device
fb0: initializing hardware
speedstep-smi: signature:0x00008680, command:0x0000e6f5, event:0x00000000, perf_level:0x47534943.
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: disabled on user request.
Starting balanced_irq
Total HugeTLB memory allocated, 0
ikconfig 0.7 with /proc/config*
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
NTFS driver 2.1.5 [Flags: R/W].
udf: registering filesystem
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Console: switching to colour frame buffer device 80x30
pty: 256 Unix98 ptys configured
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: Maximum main memory to use for agp memory: 942M
agpgart: AGP aperture is 128M @ 0xe0000000
[drm] Initialized mga 3.1.0 20021029 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:0c' and the driver 'serial'
pnp: match found with the PnP device '00:10' and the driver 'serial'
pnp: the driver 'parport_pc' has been registered
pnp: match found with the PnP device '00:0f' and the driver 'parport_pc'
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(18)
parport0: assign_addrs: aa5500ff(18)
parport0: Printer, Lexmark Lexmark Z53
lp0: using parport0 (polling).
lp0: console ready
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 90845D4, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: SAMSUNG SC-140B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
PDC20269: IDE controller at PCI slot 0000:00:09.0
PDC20269: chipset revision 2
PDC20269: ROM enabled at 0xee000000
PDC20269: 100% native mode on irq 19
    ide2: BM-DMA at 0xb800-0xb807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xb808-0xb80f, BIOS settings: hdg:pio, hdh:pio
hde: Maxtor 4G160J8, ATA DISK drive
ide2 at 0xa800-0xa807,0xac02 on irq 19
hda: max request size: 128KiB
hda: 16514064 sectors (8455 MB) w/512KiB Cache, CHS=16383/16/63, UDMA(33)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 >
hde: max request size: 1024KiB
hde: 320173056 sectors (163928 MB) w/2048KiB Cache, CHS=19929/255/63, UDMA(133)
 /dev/ide/host2/bus0/target0/lun0: p1 < p5 p6 p7 p8 >
end_request: I/O error, dev hdc, sector 0
hdc: ATAPI 40X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
PCI: Setting latency timer of device 0000:00:0a.0 to 64
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
        <Adaptec 2940 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:2): 10.000MB/s transfers (10.000MHz, offset 8)
scsi0:A:4:0: DV failed to configure device.  Please file a bug report against this driver.
(scsi0:A:12): 80.000MB/s transfers (40.000MHz, offset 31, 16bit)
  Vendor: PLEXTOR   Model: CD-R   PX-W4220T  Rev: 1.04
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:4): 20.000MB/s transfers (20.000MHz, offset 15)
  Vendor: QUANTUM   Model: FIREBALL ST4.3S   Rev: 0F0C
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:4:0: Tagged Queuing enabled.  Depth 32
  Vendor: IBM       Model: DNES-309170W      Rev: SA30
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:12:0: Tagged Queuing enabled.  Depth 32
SCSI device sda: 8519216 512-byte hdwr sectors (4362 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target4/lun0: p1 < p5 >
Attached scsi disk sda at scsi0, channel 0, id 4, lun 0
SCSI device sdb: 17916240 512-byte hdwr sectors (9173 MB)
SCSI device sdb: drive cache: write back
 /dev/scsi/host0/bus0/target12/lun0: p1 p2 p3 < p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 >
Attached scsi disk sdb at scsi0, channel 0, id 12, lun 0
sr0: scsi3-mmc drive: 20x/20x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 2, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 2, lun 0,  type 5
Attached scsi generic sg1 at scsi0, channel 0, id 4, lun 0,  type 0
Attached scsi generic sg2 at scsi0, channel 0, id 12, lun 0,  type 0
Console: switching to colour frame buffer device 80x30
mice: PS/2 mouse device common for all mice
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
parport0: cannot grant exclusive access for device parkbd
i2c /dev entries driver
piix4-smbus 0000:00:07.3: Found 0000:00:07.3 device
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
BIOS EDD facility v0.10 2003-Oct-11, 4 devices found
Please report your BIOS at http://domsch.com/linux/edd30/results.html
Software Suspend has malfunctioning SMP support. Disabled :(
PM: Reading pmdisk image.
PM: Resume from disk failed.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 228k freed
Adding 1049576k swap on /dev/sdb6.  Priority:-1 extents:1
PCI: Setting latency timer of device 0000:00:0c.0 to 64
drivers/usb/core/usb.c: registered new driver usbscanner
drivers/usb/image/scanner.c: 0.4.15:USB Scanner Driver
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb14, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hde6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hde8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb13, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
NTFS volume version 3.0.
setserial sets custom speed on ttyS0. This is deprecated.
Intel(R) PRO/100 Network Driver - version 2.3.30-k1
Copyright (c) 2003 Intel Corporation

PCI: Setting latency timer of device 0000:00:08.0 to 64
e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled
  cpu cycle saver enabled

e100: eth0 NIC Link is Up 100 Mbps Full duplex
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
ip_tables: (C) 2000-2002 Netfilter core team
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
ip_conntrack version 2.1 (8192 buckets, 65536 max) - 304 bytes per conntrack
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/

--
Nelson Ferreira


