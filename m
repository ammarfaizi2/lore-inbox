Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265474AbTLILjU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 06:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265478AbTLILjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 06:39:20 -0500
Received: from ee.oulu.fi ([130.231.61.23]:14038 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S265474AbTLILij (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 06:38:39 -0500
Date: Tue, 9 Dec 2003 13:38:37 +0200 (EET)
From: Tuukka Toivonen <tuukkat@ee.oulu.fi>
X-X-Sender: tuukkat@stekt37
To: linux-kernel@vger.kernel.org
Subject: computer hangs with 2.4.23 (2.4.22 works)
Message-ID: <Pine.GSO.4.58.0312091309090.15061@stekt37>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
Computer hangs after few hours of uptime

[2.] Full description of the problem/report:
I boot this computer daily at morning, and usually around 12:30-13:15 it
crashes. SysRq+U ans SysRq+S appear to do nothing (hard disk led doesn't
flash) but SysRq+B reboots. After reboot, the computer works fine until
evening when I shut it down. This did not happen with 2.4.22 (and still
does not happen if I choose to use it instead of 23).
After hang, except of SysRq, computer doesn't respond at all, mouse doesn't
move, ping over networks doesn't answer, etc.
Also keyboard LEDs don't blink (shouldn't they blink if it were a kernel
panic?).

Since I haven't been running 2.4.23 for long, I've had only about seven
crashes so far. But the pattern is clear: 2.4.23 always crashes when booted
at the morning, 2.4.22 never does. Also haven't yet had 2.4.23 crash if
rebooted afternoon.

[3.] Keywords (i.e., modules, networking, kernel):
stable kernel crash

[4.] Kernel version (from /proc/version):
Linux version 2.4.23 (root@s-inf-pc24.oulu.fi) (gcc version 2.95.4 20011002
(Debian prerelease)) #19 Tue Dec 2 10:57:57 EET 2003

[5.] Output of Oops.. message (if applicable) with symbolic information
Kernel logs contain nothing special (no oops). I have to run
X on this computer, so I haven't seen any possible messages on screen
either.

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Linux xxx.yyy.zz 2.4.23 #19 Tue Dec 2 10:57:57 EET 2003 i686
unknown

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         nfs lockd sunrpc mga smbfs agpgart sd_mod ipchains
tulip crc32 af_packet ide-cd sr_mod scsi_mod cdrom floppy serial videodev
usb-uhci usbcore autofs4 es1371 ac97_codec soundcore 3c59x rtc unix

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 807.199
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1608.90

[7.3.] Module information (from /proc/modules):
nfs                    65116   1 (autoclean)
lockd                  48928   1 (autoclean) [nfs]
sunrpc                 62612   1 (autoclean) [nfs lockd]
mga                    98544   1
smbfs                  33152  13 (autoclean)
agpgart                13120   3 (autoclean)
sd_mod                 10300   0 (autoclean) (unused)
ipchains               38376   1
tulip                  38272   1
crc32                   2816   0 [tulip]
af_packet              12072   0 (autoclean)
ide-cd                 29088   0 (autoclean)
sr_mod                 13464   0 (autoclean) (unused)
scsi_mod               81928   2 (autoclean) [sd_mod sr_mod]
cdrom                  29088   0 (autoclean) [ide-cd sr_mod]
floppy                 47168   0 (autoclean)
serial                 42528   1 (autoclean)
videodev                5696   0 (unused)
usb-uhci               21764   0 (unused)
usbcore                61760   1 [usb-uhci]
autofs4                 8548   1
es1371                 26080   0
ac97_codec             12128   0 [es1371]
soundcore               3460   4 [es1371]
3c59x                  25032   1
rtc                     6012   0 (autoclean)
unix                   14340  28 (autoclean)

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
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
02f8-02ff : serial(set)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
8000-803f : Promise Technology, Inc. 20265
  8000-8007 : ide2
  8008-800f : ide3
  8010-803f : PDC20265
8400-8403 : Promise Technology, Inc. 20265
8800-8807 : Promise Technology, Inc. 20265
9000-9003 : Promise Technology, Inc. 20265
  9002-9002 : ide2
9400-9407 : Promise Technology, Inc. 20265
  9400-9407 : ide2
9800-983f : Ensoniq 5880 AudioPCI
  9800-983f : es1371
a000-a07f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
  a000-a07f : 00:0b.0
a400-a47f : Digital Equipment Corporation DECchip 21142/43
  a400-a47f : tulip
d000-d01f : VIA Technologies, Inc. USB (#2)
  d000-d01f : usb-uhci
d400-d41f : VIA Technologies, Inc. USB
  d400-d41f : usb-uhci
d800-d80f : VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC
Bus Master IDE
  d800-d807 : ide0
e400-e4ff : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
e800-e80f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]

00000000-0009e7ff : System RAM
0009e800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c9fff : Extension ROM
000cc000-000cc7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0ffebfff : System RAM
  00100000-001d1ad1 : Kernel code
  001d1ad2-00205a63 : Kernel data
0ffec000-0ffeefff : ACPI Tables
0ffef000-0fffefff : reserved
0ffff000-0fffffff : ACPI Non-volatile Storage
df000000-df01ffff : Promise Technology, Inc. 20265
df800000-df80007f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
e0000000-e00003ff : Digital Equipment Corporation DECchip 21142/43
  e0000000-e00003ff : tulip
e0800000-e1dfffff : PCI Bus #01
  e0800000-e0ffffff : Matrox Graphics, Inc. MGA G400 AGP
  e1000000-e1003fff : Matrox Graphics, Inc. MGA G400 AGP
e1f00000-e3ffffff : PCI Bus #01
  e2000000-e3ffffff : Matrox Graphics, Inc. MGA G400 AGP
e4000000-e7ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 8033
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x1
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000e000-0000dfff
	Memory behind bridge: e0800000-e1dfffff
	Prefetchable memory behind bridge: e1f00000-e3ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
	Subsystem: Asustek Computer, Inc.: Unknown device 8033
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d800 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 15
	Region 4: I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 15
	Region 4: I/O ports at d000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: Compex: Unknown device 0113
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (5000ns min, 10000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at a400 [size=128]
	Region 1: Memory at e0000000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=256K]

00:0b.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 74)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at a000 [size=128]
	Region 1: Memory at df800000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME+

00:0d.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
	Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 15
	Region 0: I/O ports at 9800 [size=64]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 02)
	Subsystem: Promise Technology, Inc.: Unknown device 4d33
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 9400 [size=8]
	Region 1: I/O ports at 9000 [size=4]
	Region 2: I/O ports at 8800 [size=8]
	Region 3: I/O ports at 8400 [size=4]
	Region 4: I/O ports at 8000 [size=64]
	Region 5: Memory at df000000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [58] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G400 16Mb SGRAM
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e2000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at e1000000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at e0800000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at e1ff0000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices: none

[7.7.] Other information that might be relevant to the problem
My .config:
CONFIG_X86=y
CONFIG_UID16=y

CONFIG_EXPERIMENTAL=y

CONFIG_MODULES=y
CONFIG_KMOD=y

CONFIG_MK7=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_EDD=m
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_X86_TSC=y

CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PM=y
CONFIG_APM=m
CONFIG_APM_RTC_IS_GMT=y

CONFIG_MTD=m
CONFIG_MTD_PARTITIONS=m
CONFIG_MTD_CONCAT=m
CONFIG_MTD_REDBOOT_PARTS=m
CONFIG_MTD_CMDLINE_PARTS=m

CONFIG_MTD_CHAR=m
CONFIG_MTD_BLOCK=m
CONFIG_MTD_BLOCK_RO=m
CONFIG_FTL=m
CONFIG_NFTL=m

CONFIG_MTD_PCI=m

CONFIG_MTD_NAND=m
CONFIG_MTD_NAND_IDS=m

CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_PC_FIFO=y

CONFIG_BLK_DEV_FD=m
CONFIG_PARIDE=m
CONFIG_PARIDE_PARPORT=m

CONFIG_PARIDE_PD=m
CONFIG_PARIDE_PF=m
CONFIG_PARIDE_PG=m

CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096

CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
CONFIG_MD_MULTIPATH=m
CONFIG_BLK_DEV_LVM=m

CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=m
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=m
CONFIG_INET=y

CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_COMPAT_IPCHAINS=m
CONFIG_IP_NF_NAT_NEEDED=y

CONFIG_IPV6_SCTP__=y
CONFIG_IP_SCTP=m

CONFIG_IDE=y

CONFIG_BLK_DEV_IDE=y

CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_IDE_TASK_IOCTL=y

CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PDC202XX_OLD=y
CONFIG_PDC202XX_BURST=y
CONFIG_BLK_DEV_PDC202XX_NEW=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_BLK_DEV_IDE_MODES=y

CONFIG_SCSI=m

CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m

CONFIG_SCSI_CONSTANTS=y

CONFIG_NETDEVICES=y

CONFIG_DUMMY=m

CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m
CONFIG_NET_PCI=y
CONFIG_TULIP=m
CONFIG_NE2K_PCI=m
CONFIG_8139CP=m
CONFIG_8139TOO=m

CONFIG_PLIP=m
CONFIG_PPP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m

CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=m
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_TIPAR=m

CONFIG_MOUSE=m
CONFIG_PSMOUSE=y

CONFIG_NVRAM=m
CONFIG_RTC=m

CONFIG_AGP=m
CONFIG_AGP_VIA=y

CONFIG_DRM=y

CONFIG_DRM_NEW=y
CONFIG_DRM_MGA=m

CONFIG_VIDEO_DEV=m

CONFIG_VIDEO_PROC_FS=y

CONFIG_AUTOFS4_FS=m
CONFIG_REISERFS_FS=m
CONFIG_AFFS_FS=m
CONFIG_HFSPLUS_FS=m
CONFIG_BEFS_FS=m
CONFIG_EXT3_FS=m
CONFIG_JBD=m
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_UMSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_CRAMFS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_JFS_FS=m
CONFIG_MINIX_FS=m
CONFIG_NTFS_FS=m
CONFIG_NTFS_RW=y
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_DEVPTS_FS=y
CONFIG_ROMFS_FS=m
CONFIG_EXT2_FS=y
CONFIG_UDF_FS=m

CONFIG_CODA_FS=m
CONFIG_INTERMEZZO_FS=m
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m

CONFIG_PARTITION_ADVANCED=y
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_UTF8=m

CONFIG_VGA_CONSOLE=y

CONFIG_SOUND=m
CONFIG_SOUND_ES1371=m
CONFIG_SOUND_OSS=m

CONFIG_USB=m
CONFIG_USB_DEBUG=y

CONFIG_USB_DEVICEFS=y

CONFIG_USB_UHCI=m
CONFIG_USB_UHCI_ALT=m

CONFIG_USB_AUDIO=m
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_HP8200e=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m

CONFIG_USB_HID=m

CONFIG_USB_HIDDEV=y

CONFIG_USB_DC2XX=m
CONFIG_USB_MDC800=m
CONFIG_USB_SCANNER=m
CONFIG_USB_MICROTEK=m
CONFIG_USB_HPUSBSCSI=m

CONFIG_USB_IBMCAM=m
CONFIG_USB_KONICAWC=m
CONFIG_USB_OV511=m
CONFIG_USB_PWC=m
CONFIG_USB_SE401=m
CONFIG_USB_STV680=m
CONFIG_USB_VICAM=m
CONFIG_USB_DSBR=m
CONFIG_USB_DABUSB=m

CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_KAWETH=m
CONFIG_USB_CATC=m
CONFIG_USB_AX8817X=m
CONFIG_USB_CDCETHER=m
CONFIG_USB_USBNET=m

CONFIG_USB_USS720=m

CONFIG_USB_RIO500=m
CONFIG_USB_AUERSWALD=m
CONFIG_USB_TIGL=m
CONFIG_USB_BRLVGER=m
CONFIG_USB_LCD=m

CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_LOG_BUF_SHIFT=0

CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_TEST=m

CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m

[X.] Other notes, patches, fixes, workarounds:
I guess this might not be easy to find out why it crashes, but if other
people experience the same, maybe this gives a pattern. If I have time I'll
look the changes between 2.4.22 and 23 and try to isolate the problem.
