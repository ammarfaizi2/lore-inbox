Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbUCIT44 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 14:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbUCIT44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 14:56:56 -0500
Received: from 212-214-140-145.v-by.wtnord.net ([212.214.140.145]:6810 "EHLO
	ricercar.mine.nu") by vger.kernel.org with ESMTP id S262122AbUCITza
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 14:55:30 -0500
Date: Tue, 9 Mar 2004 20:55:27 +0100
From: Daniel Brahneborg <daniel.com@wtnord.net>
To: linux-kernel@vger.kernel.org
Subject: BUG: 2.6.3 badblocks -> halt
Message-ID: <20040309205527.A4250@nettis.grimsta>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

My machine is halting again.

I have a new Promise TX4 SATA card, and when running badblocks
on the drives (read or write doesn't matter), the machine
suddenly comes to a complete stop and must be reset.
I've tried both 2.6.3 and 2.6.3-mm1.
It dies on different blocks each time.

Specs:
Abit KV7 motherboard, with via-rhine nic
AMD Duron 800 MHz
S3 vga card on the PCI bus
RedHat 8

How do I debug this? I've run memtest86 for several hours
without problem. The cpu fan is working. I got similar hangs
with a Silicon Image SATA card two months ago in the same
machine. The FSB is running on 100 MHz, which is the lowest
possible setting.

I've attached all information I could find about interrupts,
boot messages etc.

/Basic


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-2.6.3.lst"

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_STANDALONE=y
CONFIG_BROKEN=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_X86_PC=y
CONFIG_MK7=y
CONFIG_X86_GENERIC=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_NOHIGHMEM=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_SATA=y
CONFIG_SCSI_SATA_PROMISE=m
CONFIG_SCSI_SATA_VIA=m
CONFIG_SCSI_QLA2XXX=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=y
CONFIG_BLK_DEV_DM=y
CONFIG_DM_IOCTL_V4=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_DEBUG=y
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IPV6_SCTP__=y
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_QOS=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
CONFIG_NET_PCI=y
CONFIG_8139TOO=m
CONFIG_8139_RXBUF_IDX=2
CONFIG_VIA_RHINE=m
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_RTC=y
CONFIG_VIDEO_SELECT=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_USB=m
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_UHCI_HCD=m
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_ISO9660_FS=y
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_DEVPTS_FS=y
CONFIG_RAMFS=y
CONFIG_CIFS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_CRC32=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="interrupts-2.6.3.lst"

           CPU0       
  0:     472331    IO-APIC-edge  timer
  1:          9    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:          1    IO-APIC-edge  rtc
 14:       2529    IO-APIC-edge  ide0
 15:         17    IO-APIC-edge  ide1
 16:          4   IO-APIC-level  libata
 23:       2847   IO-APIC-level  eth0
NMI:          0 
LOC:     472290 
ERR:          0
MIS:          0

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="iomem-2.6.3.lst"

00000000-0009ebff : System RAM
0009ec00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c8000-000cb3ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0feeffff : System RAM
  00100000-003011f2 : Kernel code
  003011f3-003bed7f : Kernel data
0fef0000-0fef2fff : ACPI Non-volatile Storage
0fef3000-0fefffff : ACPI Tables
10000000-13ffffff : 0000:00:0c.0
d0000000-d7ffffff : 0000:00:00.0
e0000000-e001ffff : 0000:00:08.0
  e0000000-e001ffff : sata_promise
e0020000-e0020fff : 0000:00:08.0
  e0020000-e0020fff : sata_promise
e0022000-e00220ff : 0000:00:12.0
  e0022000-e00220ff : via-rhine
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ioports-2.6.3.lst"

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
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
9000-903f : 0000:00:08.0
  9000-903f : sata_promise
9400-940f : 0000:00:08.0
  9400-940f : sata_promise
9800-987f : 0000:00:08.0
  9800-987f : sata_promise
9c00-9c07 : 0000:00:0f.0
a000-a003 : 0000:00:0f.0
a400-a407 : 0000:00:0f.0
a800-a803 : 0000:00:0f.0
ac00-ac0f : 0000:00:0f.0
b000-b0ff : 0000:00:0f.0
b400-b40f : 0000:00:0f.1
  b400-b407 : ide0
  b408-b40f : ide1
c800-c8ff : 0000:00:12.0
  c800-c8ff : via-rhine

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci-2.6.3.lst"

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3189 (rev 80)
	Subsystem: ABIT Computer Corp.: Unknown device 1408
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [80] AGP version 3.5
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b198 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown device 3318 (rev 02)
	Subsystem: Promise Technology, Inc.: Unknown device 3318
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 96 (1000ns min, 4500ns max), cache line size 90
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at 9000 [size=64]
	Region 1: I/O ports at 9400 [size=16]
	Region 2: I/O ports at 9800 [size=128]
	Region 3: Memory at e0020000 (32-bit, non-prefetchable) [size=4K]
	Region 4: Memory at e0000000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=16K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 VGA compatible controller: S3 Inc. 86c968 [Vision 968 VRAM] rev 0 (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=64M]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:0f.0 RAID bus controller: VIA Technologies, Inc.: Unknown device 3149 (rev 80)
	Subsystem: ABIT Computer Corp.: Unknown device 1408
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin B routed to IRQ 20
	Region 0: I/O ports at 9c00 [size=8]
	Region 1: I/O ports at a000 [size=4]
	Region 2: I/O ports at a400 [size=8]
	Region 3: I/O ports at a800 [size=4]
	Region 4: I/O ports at ac00 [size=16]
	Region 5: I/O ports at b000 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: ABIT Computer Corp.: Unknown device 1408
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 20
	Region 4: I/O ports at b400 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3227
	Subsystem: ABIT Computer Corp.: Unknown device 1408
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 78)
	Subsystem: ABIT Computer Corp.: Unknown device 1408
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (750ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 23
	Region 0: I/O ports at c800 [size=256]
	Region 1: Memory at e0022000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="messages-2.6.3.lst"

Mar  9 21:17:37 fw syslogd 1.4.1: restart.
Mar  9 21:17:37 fw syslog: syslogd startup succeeded
Mar  9 21:17:37 fw kernel: klogd 1.4.1, log source = /proc/kmsg started.
Mar  9 21:17:37 fw kernel: Linux version 2.6.3 (root@fw.grimsta) (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #17 Tue Mar 9 21:11:20 CET 2004
Mar  9 21:17:37 fw kernel: BIOS-provided physical RAM map:
Mar  9 21:17:37 fw kernel:  BIOS-e820: 0000000000000000 - 000000000009ec00 (usable)
Mar  9 21:17:37 fw kernel:  BIOS-e820: 000000000009ec00 - 00000000000a0000 (reserved)
Mar  9 21:17:37 fw kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Mar  9 21:17:37 fw kernel:  BIOS-e820: 0000000000100000 - 000000000fef0000 (usable)
Mar  9 21:17:37 fw kernel:  BIOS-e820: 000000000fef0000 - 000000000fef3000 (ACPI NVS)
Mar  9 21:17:37 fw kernel:  BIOS-e820: 000000000fef3000 - 000000000ff00000 (ACPI data)
Mar  9 21:17:37 fw kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Mar  9 21:17:37 fw kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Mar  9 21:17:37 fw kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Mar  9 21:17:37 fw syslog: klogd startup succeeded
Mar  9 21:17:37 fw kernel: 254MB LOWMEM available.
Mar  9 21:17:37 fw kernel: found SMP MP-table at 000f5e70
Mar  9 21:17:37 fw kernel: hm, page 000f5000 reserved twice.
Mar  9 21:17:37 fw keytable: Loading keymap: 
Mar  9 21:17:37 fw kernel: hm, page 000f6000 reserved twice.
Mar  9 21:17:37 fw kernel: hm, page 000f0000 reserved twice.
Mar  9 21:17:37 fw kernel: hm, page 000f1000 reserved twice.
Mar  9 21:17:37 fw kernel: On node 0 totalpages: 65264
Mar  9 21:17:37 fw keytable: ^[[60G
Mar  9 21:17:37 fw kernel:   DMA zone: 4096 pages, LIFO batch:1
Mar  9 21:17:37 fw kernel:   Normal zone: 61168 pages, LIFO batch:14
Mar  9 21:17:37 fw keytable: 
Mar  9 21:17:37 fw kernel:   HighMem zone: 0 pages, LIFO batch:1
Mar  9 21:17:37 fw keytable: 
Mar  9 21:17:37 fw kernel: DMI 2.2 present.
Mar  9 21:17:38 fw rc: Starting keytable:  succeeded
Mar  9 21:17:38 fw kernel: Intel MultiProcessor Specification v1.4
Mar  9 21:17:38 fw kernel:     Virtual Wire compatibility mode.
Mar  9 21:17:38 fw kernel: OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Mar  9 21:17:38 fw kernel: Processor #0 6:3 APIC version 17
Mar  9 21:17:38 fw kernel: I/O APIC #2 Version 17 at 0xFEC00000.
Mar  9 21:17:38 fw random: Initializing random number generator:  succeeded
Mar  9 21:17:38 fw kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Mar  9 21:17:38 fw kernel: Processors: 1
Mar  9 21:17:38 fw mount: mount: wrong fs type, bad option, bad superblock on none,
Mar  9 21:17:38 fw kernel: Built 1 zonelists
Mar  9 21:17:38 fw mount:        or too many mounted file systems
Mar  9 21:17:38 fw kernel: Kernel command line: ro root=/dev/hda3
Mar  9 21:17:38 fw netfs: Mounting other filesystems:  failed
Mar  9 21:17:38 fw kernel: Initializing CPU#0
Mar  9 21:17:38 fw kernel: PID hash table entries: 1024 (order 10: 8192 bytes)
Mar  9 21:17:39 fw kernel: Detected 819.564 MHz processor.
Mar  9 21:17:37 fw ifup:  done. 
Mar  9 21:17:39 fw kernel: Using tsc for high-res timesource
Mar  9 21:17:37 fw network: Bringing up interface eth0:  succeeded 
Mar  9 21:17:40 fw kernel: Console: colour VGA+ 80x25
Mar  9 21:17:40 fw kernel: Memory: 254656k/261056k available (2052k kernel code, 5668k reserved, 758k data, 128k init, 0k highmem)
Mar  9 21:17:40 fw kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Mar  9 21:17:40 fw kernel: Calibrating delay loop... 1613.82 BogoMIPS
Mar  9 21:17:40 fw autofs: automount startup succeeded
Mar  9 21:17:40 fw kernel: Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Mar  9 21:17:40 fw kernel: Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mar  9 21:17:40 fw kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Mar  9 21:17:40 fw smartd[540]: smartd version 5.26 Copyright (C) 2002-3 Bruce Allen 
Mar  9 21:17:40 fw smartd[540]: Home page is http://smartmontools.sourceforge.net/  
Mar  9 21:17:40 fw smartd[540]: Opened configuration file /etc/smartd.conf 
Mar  9 21:17:40 fw kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Mar  9 21:17:40 fw smartd[540]: Configuration file /etc/smartd.conf parsed. 
Mar  9 21:17:40 fw kernel: CPU: L2 Cache: 64K (64 bytes/line)
Mar  9 21:17:40 fw smartd[540]: Device: /dev/hda, opened 
Mar  9 21:17:41 fw smartd[540]: Device: /dev/hda, not found in smartd database. 
Mar  9 21:17:41 fw kernel: Intel machine check architecture supported.
Mar  9 21:17:41 fw kernel: Intel machine check reporting enabled on CPU#0.
Mar  9 21:17:41 fw kernel: CPU: AMD Duron(tm) processor stepping 01
Mar  9 21:17:41 fw kernel: Enabling fast FPU save and restore... done.
Mar  9 21:17:41 fw smartd[540]: Device: /dev/hda, is SMART capable. Adding to "monitor" list. 
Mar  9 21:17:41 fw kernel: Checking 'hlt' instruction... OK.
Mar  9 21:17:41 fw smartd[540]: Device: /dev/hdi, No such device or address, open() failed 
Mar  9 21:17:41 fw kernel: POSIX conformance testing by UNIFIX
Mar  9 21:17:41 fw smartd[540]: Unable to register ATA device /dev/hdi at line 31 of file /etc/smartd.conf 
Mar  9 21:17:41 fw kernel: enabled ExtINT on CPU#0
Mar  9 21:17:41 fw smartd[540]: Unable to register device /dev/hdi (no Directive -d removable). Exiting. 
Mar  9 21:17:41 fw kernel: ESR value before enabling vector: 00000000
Mar  9 21:17:41 fw smartd: smartd startup failed
Mar  9 21:17:41 fw kernel: ESR value after enabling vector: 00000000
Mar  9 21:17:42 fw kernel: ENABLING IO-APIC IRQs
Mar  9 21:17:42 fw kernel: Setting 2 in the phys_id_present_map
Mar  9 21:17:42 fw named[551]: starting BIND 9.2.1 -u named
Mar  9 21:17:42 fw kernel: ...changing IO-APIC physical APIC ID to 2 ... ok.
Mar  9 21:17:42 fw named[551]: using 1 CPU
Mar  9 21:17:42 fw named: named startup succeeded
Mar  9 21:17:42 fw named[554]: loading configuration from '/etc/named.conf'
Mar  9 21:17:42 fw kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
Mar  9 21:17:43 fw sshd: Starting sshd:
Mar  9 21:17:43 fw named[554]: no IPv6 interfaces found
Mar  9 21:17:43 fw sshd:  succeeded
Mar  9 21:17:43 fw named[554]: listening on IPv4 interface lo, 127.0.0.1#53
Mar  9 21:17:43 fw sshd: ^[[60G
Mar  9 21:17:43 fw named[554]: listening on IPv4 interface eth0, 192.168.50.59#53
Mar  9 21:17:43 fw kernel: testing the IO APIC.......................
Mar  9 21:17:43 fw sshd: 
Mar  9 21:17:43 fw named[554]: command channel listening on 127.0.0.1#953
Mar  9 21:17:43 fw rc: Starting sshd:  succeeded
Mar  9 21:17:44 fw named[554]: zone 0.0.127.in-addr.arpa/IN: loaded serial 1997022700
Mar  9 21:17:44 fw named[554]: zone localhost/IN: loaded serial 42
Mar  9 21:17:44 fw named[554]: running
Mar  9 21:17:44 fw kernel: .................................... done.
Mar  9 21:17:44 fw kernel: Using local APIC timer interrupts.
Mar  9 21:17:44 fw kernel: calibrating APIC timer ...
Mar  9 21:17:44 fw kernel: ..... CPU clock speed is 819.0133 MHz.
Mar  9 21:17:44 fw kernel: ..... host bus clock speed is 204.0783 MHz.
Mar  9 21:17:44 fw kernel: NET: Registered protocol family 16
Mar  9 21:17:44 fw kernel: PCI: PCI BIOS revision 2.10 entry at 0xfaf40, last bus=1
Mar  9 21:17:44 fw kernel: PCI: Using configuration type 1
Mar  9 21:17:44 fw kernel: SCSI subsystem initialized
Mar  9 21:17:44 fw kernel: PCI: Probing PCI hardware
Mar  9 21:17:44 fw kernel: PCI: Probing PCI hardware (bus 00)
Mar  9 21:17:44 fw kernel: PCI: Using IRQ router VIA [1106/3227] at 0000:00:11.0
Mar  9 21:17:44 fw kernel: PCI->APIC IRQ transform: (B0,I8,P0) -> 16
Mar  9 21:17:45 fw kernel: PCI->APIC IRQ transform: (B0,I12,P0) -> 19
Mar  9 21:17:45 fw kernel: PCI->APIC IRQ transform: (B0,I15,P1) -> 20
Mar  9 21:17:45 fw kernel: PCI->APIC IRQ transform: (B0,I15,P0) -> 20
Mar  9 21:17:45 fw kernel: PCI->APIC IRQ transform: (B0,I18,P0) -> 23
Mar  9 21:17:45 fw kernel: Machine check exception polling timer started.
Mar  9 21:17:45 fw kernel: SGI XFS with ACLs, no debug enabled
Mar  9 21:17:45 fw kernel: pty: 256 Unix98 ptys configured
Mar  9 21:17:45 fw kernel: Real Time Clock Driver v1.12
Mar  9 21:17:45 fw kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Mar  9 21:17:45 fw kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Mar  9 21:17:45 fw kernel: VP_IDE: IDE controller at PCI slot 0000:00:0f.1
Mar  9 21:17:45 fw kernel: VP_IDE: chipset revision 6
Mar  9 21:17:45 fw kernel: VP_IDE: not 100%% native mode: will probe irqs later
Mar  9 21:17:45 fw kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Mar  9 21:17:45 fw kernel: VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
Mar  9 21:17:45 fw kernel:     ide0: BM-DMA at 0xb400-0xb407, BIOS settings: hda:DMA, hdb:pio
Mar  9 21:17:45 fw kernel:     ide1: BM-DMA at 0xb408-0xb40f, BIOS settings: hdc:pio, hdd:DMA
Mar  9 21:17:45 fw kernel: hda: FUJITSU MHM2060AT, ATA DISK drive
Mar  9 21:17:45 fw xinetd[584]: pmap_set failed. service=sgi_fam program=391002 version=2
Mar  9 21:17:45 fw kernel: Using anticipatory io scheduler
Mar  9 21:17:45 fw kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Mar  9 21:17:45 fw kernel: hdd: MATSHITA CD-RW CW-7586, ATAPI CD/DVD-ROM drive
Mar  9 21:17:45 fw kernel: ide1 at 0x170-0x177,0x376 on irq 15
Mar  9 21:17:45 fw kernel: hda: max request size: 128KiB
Mar  9 21:17:45 fw kernel: hda: 11733120 sectors (6007 MB) w/2048KiB Cache, CHS=12416/15/63, UDMA(66)
Mar  9 21:17:45 fw kernel:  hda: hda1 hda2 hda3
Mar  9 21:17:45 fw kernel: hdd: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Mar  9 21:17:45 fw kernel: Uniform CD-ROM driver Revision: 3.20
Mar  9 21:17:46 fw kernel: mice: PS/2 mouse device common for all mice
Mar  9 21:17:46 fw kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Mar  9 21:17:46 fw kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Mar  9 21:17:46 fw kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Mar  9 21:17:46 fw kernel: md: raid1 personality registered as nr 3
Mar  9 21:17:46 fw kernel: md: raid5 personality registered as nr 4
Mar  9 21:17:46 fw kernel: raid5: measuring checksumming speed
Mar  9 21:17:46 fw kernel:    8regs     :  1092.000 MB/sec
Mar  9 21:17:46 fw kernel:    8regs_prefetch:  1036.000 MB/sec
Mar  9 21:17:46 fw kernel:    32regs    :   916.000 MB/sec
Mar  9 21:17:46 fw kernel:    32regs_prefetch:   796.000 MB/sec
Mar  9 21:17:46 fw kernel:    pII_mmx   :  2180.000 MB/sec
Mar  9 21:17:46 fw kernel:    p5_mmx    :  2916.000 MB/sec
Mar  9 21:17:46 fw kernel: raid5: using function: p5_mmx (2916.000 MB/sec)
Mar  9 21:17:46 fw kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Mar  9 21:17:46 fw kernel: device-mapper: 4.0.0-ioctl (2003-06-04) initialised: dm@uk.sistina.com
Mar  9 21:17:46 fw kernel: NET: Registered protocol family 2
Mar  9 21:17:46 fw kernel: IP: routing cache hash table of 2048 buckets, 16Kbytes
Mar  9 21:17:46 fw kernel: TCP: Hash tables configured (established 16384 bind 32768)
Mar  9 21:17:46 fw kernel: NET: Registered protocol family 1
Mar  9 21:17:46 fw kernel: NET: Registered protocol family 17
Mar  9 21:17:46 fw kernel: md: Autodetecting RAID arrays.
Mar  9 21:17:46 fw kernel: md: autorun ...
Mar  9 21:17:46 fw kernel: md: ... autorun DONE.
Mar  9 21:17:46 fw kernel: EXT3-fs: INFO: recovery required on readonly filesystem.
Mar  9 21:17:46 fw kernel: EXT3-fs: write access will be enabled during recovery.
Mar  9 21:17:46 fw kernel: kjournald starting.  Commit interval 5 seconds
Mar  9 21:17:46 fw kernel: EXT3-fs: recovery complete.
Mar  9 21:17:46 fw kernel: EXT3-fs: mounted filesystem with ordered data mode.
Mar  9 21:17:46 fw kernel: VFS: Mounted root (ext3 filesystem) readonly.
Mar  9 21:17:46 fw kernel: Freeing unused kernel memory: 128k freed
Mar  9 21:17:46 fw kernel: drivers/usb/core/usb.c: registered new driver hub
Mar  9 21:17:46 fw kernel: EXT3 FS on hda3, internal journal
Mar  9 21:17:46 fw kernel: Adding 522104k swap on /dev/hda2.  Priority:-1 extents:1
Mar  9 21:17:46 fw kernel: kjournald starting.  Commit interval 5 seconds
Mar  9 21:17:46 fw kernel: EXT3 FS on hda1, internal journal
Mar  9 21:17:46 fw kernel: EXT3-fs: mounted filesystem with ordered data mode.
Mar  9 21:17:46 fw kernel: blk: queue cfde3400, I/O limit 4095Mb (mask 0xffffffff)
Mar  9 21:17:46 fw kernel: via-rhine.c:v1.10-LK1.1.19-2.5  July-12-2003  Written by Donald Becker
Mar  9 21:17:46 fw kernel:   http://www.scyld.com/network/via-rhine.html
Mar  9 21:17:46 fw kernel: eth0: VIA VT6102 Rhine-II at 0xc800, 00:50:8d:4f:f5:f7, IRQ 23.
Mar  9 21:17:46 fw kernel: eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 45e1.
Mar  9 21:17:46 fw kernel: eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
Mar  9 21:17:46 fw kernel: process `named' is using obsolete setsockopt SO_BSDCOMPAT
Mar  9 21:17:46 fw xinetd[584]: xinetd Version 2.3.7 started with libwrap options compiled in.
Mar  9 21:17:46 fw xinetd[584]: Started working: 0 available services
Mar  9 21:17:47 fw xinetd: xinetd startup succeeded
Mar  9 21:17:48 fw crond: crond startup succeeded
Mar  9 21:17:49 fw smb: smbd startup succeeded
Mar  9 21:17:49 fw smb: nmbd startup succeeded
Mar  9 21:17:49 fw anacron: anacron startup succeeded
Mar  9 21:17:49 fw atd: atd startup succeeded
Mar  9 21:17:50 fw rc: Starting mdmonitor:  succeeded
Mar  9 21:17:50 fw kernel: warning: process `update' used the obsolete bdflush system call
Mar  9 21:17:50 fw kernel: Fix your initscripts?
Mar  9 21:17:55 fw kernel: warning: process `update' used the obsolete bdflush system call
Mar  9 21:17:55 fw kernel: Fix your initscripts?
Mar  9 21:18:07 fw sshd(pam_unix)[654]: session opened for user basic by (uid=500)
Mar  9 21:18:10 fw su(pam_unix)[667]: session opened for user root by basic(uid=500)
Mar  9 21:18:15 fw kernel: ata1: SATA max UDMA/133 cmd 0xD0800200 ctl 0xD0800238 bmdma 0x0 irq 16
Mar  9 21:18:15 fw kernel: ata2: SATA max UDMA/133 cmd 0xD0800280 ctl 0xD08002B8 bmdma 0x0 irq 16
Mar  9 21:18:15 fw kernel: ata3: SATA max UDMA/133 cmd 0xD0800300 ctl 0xD0800338 bmdma 0x0 irq 16
Mar  9 21:18:15 fw kernel: ata4: SATA max UDMA/133 cmd 0xD0800380 ctl 0xD08003B8 bmdma 0x0 irq 16
Mar  9 21:18:15 fw kernel: ata1: dev 0 ATA, max UDMA7, 312581808 sectors (lba48)
Mar  9 21:18:15 fw kernel: ata1: dev 0 configured for UDMA/133
Mar  9 21:18:15 fw kernel: scsi0 : sata_promise
Mar  9 21:18:15 fw kernel: ata2: dev 0 ATA, max UDMA7, 312581808 sectors (lba48)
Mar  9 21:18:15 fw kernel: ata2: dev 0 configured for UDMA/133
Mar  9 21:18:15 fw kernel: scsi1 : sata_promise
Mar  9 21:18:16 fw kernel: ata3: dev 0 ATA, max UDMA7, 312581808 sectors (lba48)
Mar  9 21:18:16 fw kernel: ata3: dev 0 configured for UDMA/133
Mar  9 21:18:16 fw kernel: scsi2 : sata_promise
Mar  9 21:18:16 fw kernel: ata4: dev 0 ATA, max UDMA7, 312581808 sectors (lba48)
Mar  9 21:18:16 fw kernel: ata4: dev 0 configured for UDMA/133
Mar  9 21:18:16 fw kernel: scsi3 : sata_promise
Mar  9 21:18:16 fw kernel:   Vendor: ATA       Model: SAMSUNG SP1614C   Rev: 1.00
Mar  9 21:18:16 fw kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Mar  9 21:18:16 fw kernel: SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
Mar  9 21:18:16 fw kernel: SCSI device sda: drive cache: write through
Mar  9 21:18:16 fw kernel:  sda: sda1 sda2 sda3 sda4
Mar  9 21:18:16 fw kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Mar  9 21:18:16 fw kernel:   Vendor: ATA       Model: SAMSUNG SP1614C   Rev: 1.00
Mar  9 21:18:16 fw kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Mar  9 21:18:16 fw kernel: SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
Mar  9 21:18:16 fw kernel: SCSI device sdb: drive cache: write through
Mar  9 21:18:16 fw kernel:  sdb: sdb1 sdb2
Mar  9 21:18:16 fw kernel: Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Mar  9 21:18:16 fw kernel:   Vendor: ATA       Model: SAMSUNG SP1614C   Rev: 1.00
Mar  9 21:18:16 fw kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Mar  9 21:18:16 fw kernel: SCSI device sdc: 312581808 512-byte hdwr sectors (160042 MB)
Mar  9 21:18:16 fw kernel: SCSI device sdc: drive cache: write through
Mar  9 21:18:16 fw kernel:  sdc: sdc1 sdc2
Mar  9 21:18:16 fw kernel: Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
Mar  9 21:18:16 fw kernel:   Vendor: ATA       Model: SAMSUNG SP1614C   Rev: 1.00
Mar  9 21:18:16 fw kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Mar  9 21:18:16 fw kernel: SCSI device sdd: 312581808 512-byte hdwr sectors (160042 MB)
Mar  9 21:18:16 fw kernel: SCSI device sdd: drive cache: write through
Mar  9 21:18:16 fw kernel:  sdd: sdd1 sdd2
Mar  9 21:18:16 fw kernel: Attached scsi disk sdd at scsi3, channel 0, id 0, lun 0

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="scanpci-2.6.3.lst"


pci bus 0x0000 cardnum 0x00 function 0x00: vendor 0x1106 device 0x3189
 VIA  Device unknown
 CardVendor 0x147b card 0x1408 (Card unknown)
  STATUS    0x2230  COMMAND 0x0006
  CLASS     0x06 0x00 0x00  REVISION 0x80
  BIST      0x00  HEADER 0x00  LATENCY 0x08  CACHE 0x00
  BASE0     0xd0000008  addr 0xd0000000  MEM PREFETCHABLE
  BYTE_0    0x80881900  BYTE_1  0x00  BYTE_2  0x00  BYTE_3  0x00

pci bus 0x0000 cardnum 0x01 function 0x00: vendor 0x1106 device 0xb198
 VIA  Device unknown
  STATUS    0x0230  COMMAND 0x0107
  CLASS     0x06 0x04 0x00  REVISION 0x00
  HEADER    0x01  LATENCY 0x00
  PRIBUS    0x00  SECBUS 0x01  SUBBUS 0x01  SECLT 0x00
  IOBASE    0xf000  IOLIM 0xfff  SECSTATUS 0x2220
  NOPREFETCH_MEMBASE 0xfff00000  MEMLIM 0x000fffff
  PREFETCH_MEMBASE   0xfff00000  MEMLIM 0x000fffff
  NO_FAST_B2B NO_SEC_BUS_RST NO_M_ABRT NO_VGA_EN ISA_EN NO_SERR_EN NO_PERR_EN

pci bus 0x0000 cardnum 0x08 function 0x00: vendor 0x105a device 0x3318
 Device unknown
 CardVendor 0x105a card 0x3318 (Card unknown)
  STATUS    0x0230  COMMAND 0x0007
  CLASS     0x01 0x80 0x00  REVISION 0x02
  BIST      0x00  HEADER 0x00  LATENCY 0x60  CACHE 0x90
  BASE0     0x00009001  addr 0x00009000  I/O
  BASE1     0x00009401  addr 0x00009400  I/O
  BASE2     0x00009801  addr 0x00009800  I/O
  BASE3     0xe0020000  addr 0xe0020000  MEM
  BASE4     0xe0000000  addr 0xe0000000  MEM
  MAX_LAT   0x12  MIN_GNT 0x04  INT_PIN 0x01  INT_LINE 0x0a
  BYTE_0    0x10000  BYTE_1  0x00  BYTE_2  0x00  BYTE_3  0x00

pci bus 0x0000 cardnum 0x0c function 0x00: vendor 0x5333 device 0x88f0
 S3 968
  STATUS    0x0200  COMMAND 0x0083
  CLASS     0x03 0x00 0x00  REVISION 0x00
  BASE0     0x10000000  addr 0x10000000  MEM
  MAX_LAT   0x00  MIN_GNT 0x00  INT_PIN 0x01  INT_LINE 0x0c

pci bus 0x0000 cardnum 0x0f function 0x00: vendor 0x1106 device 0x3149
 VIA  Device unknown
 CardVendor 0x147b card 0x1408 (Card unknown)
  STATUS    0x0290  COMMAND 0x0007
  CLASS     0x01 0x04 0x00  REVISION 0x80
  BIST      0x00  HEADER 0x80  LATENCY 0x20  CACHE 0x00
  BASE0     0x00009c01  addr 0x00009c00  I/O
  BASE1     0x0000a001  addr 0x0000a000  I/O
  BASE2     0x0000a401  addr 0x0000a400  I/O
  BASE3     0x0000a801  addr 0x0000a800  I/O
  BASE4     0x0000ac01  addr 0x0000ac00  I/O
  BASE5     0x0000b001  addr 0x0000b000  I/O
  MAX_LAT   0x00  MIN_GNT 0x00  INT_PIN 0x02  INT_LINE 0x0b
  BYTE_0    0x44f10313  BYTE_1  0x00  BYTE_2  0x8072ec0  BYTE_3  0xffffffff

pci bus 0x0000 cardnum 0x0f function 0x01: vendor 0x1106 device 0x0571
 VIA VT 82C586 MVP3 IDE Bridge
 CardVendor 0x147b card 0x1408 (Card unknown)
  STATUS    0x0290  COMMAND 0x0007
  CLASS     0x01 0x01 0x8a  REVISION 0x06
  BIST      0x00  HEADER 0x00  LATENCY 0x20  CACHE 0x00
  BASE4     0x0000b401  addr 0x0000b400  I/O
  MAX_LAT   0x00  MIN_GNT 0x00  INT_PIN 0x01  INT_LINE 0xff
  BYTE_0    0x509f21b  BYTE_1  0x00  BYTE_2  0x8073238  BYTE_3  0xffffffff

pci bus 0x0000 cardnum 0x11 function 0x00: vendor 0x1106 device 0x3227
 VIA  Device unknown
 CardVendor 0x147b card 0x1408 (Card unknown)
  STATUS    0x0210  COMMAND 0x0087
  CLASS     0x06 0x01 0x00  REVISION 0x00
  BIST      0x00  HEADER 0x80  LATENCY 0x00  CACHE 0x00
  BYTE_0    0xbf80044  BYTE_1  0x00  BYTE_2  0x80735b0  BYTE_3  0xffffffff

pci bus 0x0000 cardnum 0x12 function 0x00: vendor 0x1106 device 0x3065
 VIA  Device unknown
 CardVendor 0x147b card 0x1408 (Card unknown)
  STATUS    0x0210  COMMAND 0x0007
  CLASS     0x02 0x00 0x00  REVISION 0x78
  BIST      0x00  HEADER 0x00  LATENCY 0x20  CACHE 0x08
  BASE0     0x0000c801  addr 0x0000c800  I/O
  BASE1     0xe0022000  addr 0xe0022000  MEM
  MAX_LAT   0x08  MIN_GNT 0x03  INT_PIN 0x01  INT_LINE 0x17
  BYTE_0    0xfe020001  BYTE_1  0x00  BYTE_2  0x8073928  BYTE_3  0xffffffff

--gKMricLos+KVdGMg--
