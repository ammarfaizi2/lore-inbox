Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266224AbUBKWur (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 17:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266237AbUBKWuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 17:50:46 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.22]:50786 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S266224AbUBKWtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 17:49:47 -0500
From: wim delvaux <wim.delvaux@adaptiveplanet.com>
Organization: adaptive planet
To: linux-kernel@vger.kernel.org
Subject: PROBLEM : Idle system taks 30-40 % system CPU for no apparent reason
Date: Wed, 11 Feb 2004 23:49:45 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_JGrKAC84kSyrQi7"
Message-Id: <200402112349.45580.wim.delvaux@adaptiveplanet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_JGrKAC84kSyrQi7
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

[1.] One line summary of the problem:    
Idle system taks 30-40 % system CPU for no apparent reason
[2.] Full description of the problem/report:
After a while working (and for the time being for unknown reasons) the system 
becomes clearly slower.  Checking with top shows that the system eats up 30 
and more % :

top - 23:44:02 up 1 day, 20:34,  2 users,  load average: 1.03, 1.25, 1.19
Tasks: 105 total,   1 running, 104 sleeping,   0 stopped,   0 zombie
Cpu(s): 48.7% us, 51.3% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,  0.0% si
Mem:    516244k total,   509132k used,     7112k free,    12168k buffers
Swap:   524280k total,      708k used,   523572k free,   353252k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 2849 root      15   0  152m  22m 131m S 11.0  4.4  20:42.81 X
17885 u19809    15   0 24912  13m  23m S  1.0  2.7   0:00.41 kdeinit
18131 root      16   0  2080 1040 1872 R  0.3  0.2   0:00.02 top
    1 root      16   0  1520  516 1368 S  0.0  0.1   0:04.53 init
    2 root      34  19     0    0    0 S  0.0  0.0   0:00.05 ksoftirqd/0
    3 root       5 -10     0    0    0 S  0.0  0.0   0:00.93 events/0
    4 root       5 -10     0    0    0 S  0.0  0.0   0:00.00 kblockd/0
    5 root      25   0     0    0    0 S  0.0  0.0   0:00.00 pdflush
--- SNIP

The only way to solve this is to reboot.  They the CPU is idle again when no 
user activity is present
[3.] Keywords (i.e., modules, networking, kernel):
Kernel, Scheduling, IO ...
[4.] Kernel version (from /proc/version):
Linux version 2.6.2-rc1 (root@buro) (gcc version 3.3.3 20040125 (prerelease) 
(Debian)) #8 Sun Feb 8 15:51:19 CET 2004
[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
NO OOPS
[6.] A small shell script or example program which triggers the
     problem (if possible)
NO example
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Gnu C                  3.3.3
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      3.0-pre9
e2fsprogs              1.35-WIP
pcmcia-cs              3.2.5
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.15
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         nfs sg tda9887 tuner saa7134 video_buf v4l2_common 
v4l1_compat i2c_core ir_common videodev iptable_filter smbfs bnep rfcomm 
l2cap ipv6 nfsd exportfs lockd sunrpc isofs zlib_inflate nls_cp437 vfat fat 
nls_iso8859_1 ntfs sd_mod hci_usb bluetooth usbnet usb_storage snd_intel8x0 
snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi 
snd_seq_device snd soundcore rtc ipt_MASQUERADE ip_nat_irc ip_conntrack_irc 
ip_nat_ftp ip_conntrack_ftp iptable_nat ip_conntrack ip_tables uhci_hcd 
sr_mod ohci_hcd ehci_hcd usbcore ide_scsi scsi_mod sis900 crc32 parport_pc lp 
parport ide_floppy dm_mod evdev psmouse
[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.60GHz
stepping        : 7
cpu MHz         : 2607.150
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
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5144.57
[7.3.] Module information (from /proc/modules):nfs 97968 0 - Live 0xe0b9d000
sg 33176 0 - Live 0xe0b76000
tda9887 7300 0 - Live 0xe0ad2000
tuner 17932 0 - Live 0xe0aba000
saa7134 92360 0 - Live 0xe0b1c000
video_buf 20996 1 saa7134, Live 0xe0b15000
v4l2_common 6400 1 saa7134, Live 0xe0a84000
v4l1_compat 14468 1 saa7134, Live 0xe0ac0000
i2c_core 23300 3 tda9887,tuner,saa7134, Live 0xe0aef000
ir_common 4740 1 saa7134, Live 0xe0a77000
videodev 9856 1 saa7134, Live 0xe0a73000
iptable_filter 2944 1 - Live 0xe08a1000
smbfs 66936 2 - Live 0xe0b03000
bnep 14592 2 - Live 0xe0a0a000
rfcomm 38684 0 - Live 0xe0ac7000
l2cap 25220 9 bnep,rfcomm, Live 0xe0a7c000
ipv6 250304 13 - Live 0xe0b37000
nfsd 95432 2 - Live 0xe0ad6000
exportfs 6656 1 nfsd, Live 0xe09e2000
lockd 61384 3 nfs,nfsd, Live 0xe0a87000
sunrpc 130248 3 nfs,nfsd,lockd, Live 0xe0a99000
isofs 34616 1 - Live 0xe0a69000
zlib_inflate 22144 1 isofs, Live 0xe0a62000
nls_cp437 5888 2 - Live 0xe09df000
vfat 15616 1 - Live 0xe0a05000
fat 45504 1 vfat, Live 0xe0a55000
nls_iso8859_1 4224 3 - Live 0xe09dc000
ntfs 89548 1 - Live 0xe0a0f000
sd_mod 13984 2 - Live 0xe0954000
hci_usb 13440 2 - Live 0xe0991000
bluetooth 49636 8 bnep,rfcomm,l2cap,hci_usb, Live 0xe09e6000
usbnet 17928 0 - Live 0xe0998000
usb_storage 41472 1 - Live 0xe09a0000
snd_intel8x0 31620 2 - Live 0xe0980000
snd_ac97_codec 53380 1 snd_intel8x0, Live 0xe09c7000
snd_pcm 96420 1 snd_intel8x0, Live 0xe09ae000
snd_timer 25092 1 snd_pcm, Live 0xe0989000
snd_page_alloc 11780 2 snd_intel8x0,snd_pcm, Live 0xe0964000
snd_mpu401_uart 7808 1 snd_intel8x0, Live 0xe0961000
snd_rawmidi 22784 1 snd_mpu401_uart, Live 0xe0979000
snd_seq_device 8200 1 snd_rawmidi, Live 0xe095d000
snd 45880 11 
snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device, 
Live 0xe096c000
soundcore 9952 2 saa7134,snd, Live 0xe0959000
rtc 12856 0 - Live 0xe0911000
ipt_MASQUERADE 4096 2 - Live 0xe08ae000
ip_nat_irc 4464 0 - Live 0xe090e000
ip_conntrack_irc 71476 1 ip_nat_irc, Live 0xe0941000
ip_nat_ftp 5104 0 - Live 0xe08e3000
ip_conntrack_ftp 72244 1 ip_nat_ftp, Live 0xe092e000
iptable_nat 22316 4 ipt_MASQUERADE,ip_nat_irc,ip_nat_ftp, Live 0xe0916000
ip_conntrack 31920 6 
ipt_MASQUERADE,ip_nat_irc,ip_conntrack_irc,ip_nat_ftp,ip_conntrack_ftp,iptable_nat, 
Live 0xe0905000
ip_tables 17792 3 iptable_filter,ipt_MASQUERADE,iptable_nat, Live 0xe08c4000
uhci_hcd 32524 0 - Live 0xe08da000
sr_mod 15780 0 - Live 0xe08ca000
ohci_hcd 30336 0 - Live 0xe08a3000
ehci_hcd 37508 0 - Live 0xe0883000
usbcore 116956 8 hci_usb,usbnet,usb_storage,uhci_hcd,ohci_hcd,ehci_hcd, Live 
0xe08e7000
ide_scsi 15108 0 - Live 0xe0807000
scsi_mod 75564 5 sg,sd_mod,usb_storage,sr_mod,ide_scsi, Live 0xe08b0000
sis900 19972 0 - Live 0xe0874000
crc32 4608 2 usbnet,sis900, Live 0xe0871000
parport_pc 29096 1 - Live 0xe088e000
lp 10180 0 - Live 0xe0820000
parport 28384 2 parport_pc,lp, Live 0xe087b000
ide_floppy 18432 0 - Live 0xe0818000
dm_mod 39072 3 - Live 0xe0825000
evdev 9728 0 - Live 0xe0814000
psmouse 19336 0 - Live 0xe080e000
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
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
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f0-03f1 : pnp 00:0c
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-107f : pnp 00:0b
1080-109f : 0000:00:02.1
10c0-10df : pnp 00:0b
4000-400f : 0000:00:02.5
  4000-4007 : ide0
  4008-400f : ide1
9000-9fff : PCI Bus #01
  9000-90ff : 0000:01:00.0
b400-b4ff : 0000:00:02.7
  b400-b4ff : SiS SI7012 - AC'97
b800-b87f : 0000:00:02.7
  b800-b83f : SiS SI7012 - Controller
bc00-bcff : 0000:00:04.0
  bc00-bcff : sis900
c000-c0ff : 0000:00:06.0

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000d4000-000d47ff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-002808e0 : Kernel code
  002808e1-0032957f : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
d0000000-d7ffffff : 0000:00:00.0
d8000000-e7ffffff : PCI Bus #01
  d8000000-dfffffff : 0000:01:00.0
  e0000000-e7ffffff : 0000:01:00.1
e8000000-e83fffff : 0000:00:0a.0
e8400000-e84fffff : PCI Bus #01
  e8420000-e842ffff : 0000:01:00.0
  e8430000-e843ffff : 0000:01:00.1
e8520000-e8520fff : 0000:00:03.0
  e8520000-e8520fff : ohci_hcd
e8521000-e8521fff : 0000:00:03.1
  e8521000-e8521fff : ohci_hcd
e8522000-e8522fff : 0000:00:03.2
  e8522000-e8522fff : ohci_hcd
e8523000-e8523fff : 0000:00:03.3
  e8523000-e8523fff : ehci_hcd
e8524000-e8524fff : 0000:00:04.0
  e8524000-e8524fff : sis900
e8525000-e8525fff : 0000:00:06.0
e8526000-e85263ff : 0000:00:08.0
  e8526000-e85263ff : saa7134[0]
e8527000-e8527fff : 0000:00:02.3
fec00000-ffffffff : reserved
[7.5.] PCI information ('lspci -vvv' as root)00:00.0 Host bridge: Silicon 
Integrated Systems [SiS] SiS 645xx (rev 03)
        Subsystem: Silicon Integrated Systems [SiS] SiS 645xx
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=128M]
        Capabilities: [c0] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=2 Cal=3 SBA+ ITACoh- GART64- HTrans- 
64bit- FW- AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SG86C202 (prog-if 00 
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: e8400000-e84fffff
        Prefetchable memory behind bridge: d8000000-e7ffffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:02.0 ISA bridge: Silicon Integrated Systems [SiS]: Unknown device 0963 (rev 
14)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at 1080 [size=32]

00:02.3 FireWire (IEEE 1394): Silicon Integrated Systems [SiS] FireWire 
Controller (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 701d
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 3000ns max)
        Interrupt: pin B routed to IRQ 11
        Region 0: Memory at e8527000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [64] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (prog-if 80 
[Master])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Interrupt: pin ? routed to IRQ 5
        Region 4: I/O ports at 4000 [size=16]
        Capabilities: [58] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] Sound 
Controller (rev a0)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (13000ns min, 2750ns max)
        Interrupt: pin C routed to IRQ 9
        Region 0: I/O ports at b400 [size=256]
        Region 1: I/O ports at b800 [size=128]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller 
(rev 0f) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at e8520000 (32-bit, non-prefetchable) [size=4K]

00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller 
(rev 0f) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin B routed to IRQ 3
        Region 0: Memory at e8521000 (32-bit, non-prefetchable) [size=4K]

00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller 
(rev 0f) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin C routed to IRQ 13
        Region 0: Memory at e8522000 (32-bit, non-prefetchable) [size=4K]

00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 Controller 
(prog-if 20 [EHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max)
        Interrupt: pin D routed to IRQ 11
        Region 0: Memory at e8523000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 
Ethernet (rev 91)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 0900
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (13000ns min, 2750ns max)
        Interrupt: pin A routed to IRQ 3
        Region 0: I/O ports at bc00 [size=256]
        Region 1: Memory at e8524000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 SCSI storage controller: Adaptec AHA-2940U2/U2W
        Subsystem: Adaptec AHA-2940U2W SCSI Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (9750ns min, 6250ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 11
        BIST result: 00
        Region 0: I/O ports at c000 [size=256]
        Region 1: Memory at e8525000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 Multimedia controller: Philips Semiconductors SAA7134 (rev 01)
        Subsystem: Creatix Polymedia GmbH: Unknown device 0003
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 8000ns max)
        Interrupt: pin A routed to IRQ 3
        Region 0: Memory at e8526000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-

00:0a.0 Communication controller: Intel Corp. 536EP Data Fax Modem
        Subsystem: Creatix Polymedia GmbH V.9X DSP Data Fax Modem
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=4M]
        Capabilities: [e0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=375mA 
PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R300 NF [Radeon 
9700] (prog-if 00 [VGA])
        Subsystem: Hightech Information System Ltd.: Unknown device 8486
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 9000 [size=256]
        Region 2: Memory at e8420000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] AGP version 3.0
                Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- 
Rate=<none>
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.1 Display controller: ATI Technologies Inc Radeon R300 [Radeon 9700] 
(Secondary)
        Subsystem: Hightech Information System Ltd.: Unknown device 8487
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), Cache Line Size: 0x08 (32 bytes)
        Region 0: Memory at e0000000 (32-bit, prefetchable) [disabled] 
[size=128M]
        Region 1: Memory at e8430000 (32-bit, non-prefetchable) [disabled] 
[size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
[7.6.] SCSI information (from /proc/scsi/scsi)Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: PIONEER  Model: DVD-RW  DVR-105  Rev: 1.21
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: Medion   Model: Flash XL      CF Rev: 2.7D
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: USB      Model: Flash Drive      Rev: 1.05
  Type:   Direct-Access                    ANSI SCSI revision: 02
[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
config.gz of kernel attached
[X.] Other notes, patches, fixes, workarounds:
NIHIL



--Boundary-00=_JGrKAC84kSyrQi7
Content-Type: application/x-gzip;
  name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="config.gz"

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
FJJp4YgAAA==

--Boundary-00=_JGrKAC84kSyrQi7--

