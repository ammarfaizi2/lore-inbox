Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272548AbRIKTtf>; Tue, 11 Sep 2001 15:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272549AbRIKTtU>; Tue, 11 Sep 2001 15:49:20 -0400
Received: from [209.10.41.242] ([209.10.41.242]:52659 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S272548AbRIKTs6>;
	Tue, 11 Sep 2001 15:48:58 -0400
Date: Tue, 11 Sep 2001 18:04:44 +0200 (CEST)
From: nail <alessio@itapac.net>
To: linux-kernel@vger.kernel.org
Subject: Toshiba laptop problems with 2.4.9
Message-ID: <Pine.LNX.4.10.10109111738120.11515-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,
  I have a toshiba laptop model Satellite S1640.
  I installed slackware 8 with native kernel 2.4.5 on it and I upgraded
  to 2.4.9.
   I just started having problems experiencing random lockups..
   I investigated a few and i saw that keeping the laptopt idle for a
    while caused it to hangup. No oops, nothing, only pure hangup, 
  in any situation.
   So I traced the kernel boot and I noticed the problem was in the
   PCMCIA sockets driver.. (which differs for a few lines from 2.4.5)
   I tried to brutally copy linux-2.4.5/drivers/pcmcia/yenta.c in the
   2.4.9 kernel tree and the problem solved :)
   The other problem is the APM driver: by inserting the apm.o
   the laptopt hangs up.
   I don't know why of this because the 2.4.5 driver works 
   perfectly.
   Attached are some informations about my laptopt.
***NOTE***
   Please CC: me on your answer message because I'm NOT subscribed to 
   the list.
***NOTE***


Specs: AMD K6-3 475 Mhz, 64 mb of ram, integrated winmodem and
        dual-socket2 pcmcia slots.

A dmesg :
Linux version 2.4.9 (root@nebula) (gcc version 2.95.3 20010315 (release))
#1 Mon
 Sep 10 19:39:31 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000edc00 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000003ff0000 (usable)
 BIOS-e820: 0000000003ff0000 - 0000000003fffc00 (ACPI data)
 BIOS-e820: 0000000003fffc00 - 0000000004000000 (ACPI NVS)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
On node 0 totalpages: 16368
zone(0): 4096 pages.
zone(1): 12272 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=linux249 ro root=302
Initializing CPU#0
Detected 474.915 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 946.99 BogoMIPS
Memory: 61824k/65472k available (1267k kernel code, 3260k reserved, 445k
data, 1
92k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 008021bf c08029bf 00000000, vendor = 2
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: L2 Cache: 128K (32 bytes/line)
CPU: After vendor init, caps: 008021bf c08029bf 00000000 00000002
CPU:     After generic, caps: 008021bf c08029bf 00000000 00000002
CPU:             Common caps: 008021bf c08029bf 00000000 00000002
CPU: AMD-K6(tm)-III Processor stepping 04
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: AMD K6
PCI: PCI BIOS revision 2.10 entry at 0xfd8ce, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router ALI [10b9/1533] at 00:07.0
PCI: Found IRQ 11 for device 00:04.0
PCI: Sharing IRQ 11 with 01:00.0
PCI: Found IRQ 11 for device 00:04.1
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
VFS: Diskquotas version dquot_6.4.0 initialized
devfs: v0.107 (20010709) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
pty: 512 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT
SHARE_I
RQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10d
block: 128 slots per queue, batch=16
RAMDISK driver initialized: 16 RAM disks of 7777K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 78
PCI: No IRQ known for interrupt pin A of device 00:0f.0. Please try using
pci=bi
osirq.
ALI15X3: chipset revision 32
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfcf0-0xfcf7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfcf8-0xfcff, BIOS settings: hdc:DMA, hdd:pio
hda: TOSHIBA MK6014MAP, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
hdc: SR242S, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 11733120 sectors (6007 MB), CHS=730/255/63, (U)DMA
hdc: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.97
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
ide-floppy driver 0.97
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
reiserfs: checking transaction log (device 03:02) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 192k freed
Adding Swap: 128516k swap-space (priority -1)
parport0: PC-style at 0x378 [PCSPP,TRISTATE,EPP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 00:04.0
PCI: Sharing IRQ 11 with 01:00.0
PCI: Found IRQ 11 for device 00:04.1
Yenta IRQ list 06b8, PCI irq11
Socket status: 30000059
Yenta IRQ list 06b8, PCI irq11
Socket status: 30000059
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x408-0x40f 0x480-0x48f
0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
eth0: NE2000 Compatible: io 0x300, irq 3, hw_addr 00:E0:98:42:1E:D6
ttyS01 at port 0x02f8 (irq = 5) is a 16550A

Here's an lspci -v
00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
        Subsystem: Acer Laboratories Inc. [ALi] ALI M1541 Aladdin V/V+ AGP
Syste
m Controller
        Flags: bus master, slow devsel, latency 32
        Memory at e0000000 (32-bit, non-prefetchable) [size=64M]
        Capabilities: [b0] AGP version 1.0

00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5243 (rev 04) (prog-if
00 [Nor
mal decode])
        Flags: bus master, slow devsel, latency 32
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fd000000-fecfffff

00:04.0 CardBus bridge: Texas Instruments PCI1420
        Subsystem: Toshiba America Info Systems: Unknown device ff00
        Flags: bus master, medium devsel, latency 168, IRQ 11
        Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=176
        Memory window 0: 10400000-107ff000 (prefetchable)
        Memory window 1: 10800000-10bff000
        I/O window 0: 00001000-000010ff
       I/O window 1: 00001400-000014ff
        16-bit legacy interface ports at 0001

00:04.1 CardBus bridge: Texas Instruments PCI1420
        Subsystem: Toshiba America Info Systems: Unknown device ff00
        Flags: bus master, medium devsel, latency 168, IRQ 11
        Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=06, subordinate=06, sec-latency=176
        Memory window 0: 10c00000-10fff000 (prefetchable)
        Memory window 1: 11000000-113ff000
        I/O window 0: 00001800-000018ff
        I/O window 1: 00001c00-00001cff
        16-bit legacy interface ports at 0001

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge
[Aladdi
n IV] (rev 0a)
        Subsystem: Toshiba America Info Systems: Unknown device ff00
        Flags: bus master, medium devsel, latency 0

00:08.0 Multimedia audio controller: Cirrus Logic Crystal CS4281 PCI Audio
(rev 
01)
        Subsystem: Toshiba America Info Systems: Unknown device ff00
        Flags: medium devsel, IRQ 11
        Memory at feddf000 (32-bit, non-prefetchable) [size=4K]
        Memory at fedf0000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [40] Power Management version 2

00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev 20)
(prog-if 
fa)
        Subsystem: Acer Laboratories Inc. [ALi] M5229 IDE
        Flags: bus master, medium devsel, latency 32
        I/O ports at fcf0 [size=16]

00:10.0 Communication controller: Rockwell International: Unknown device
2013 (r
ev 01)
        Subsystem: Toshiba America Info Systems: Unknown device ff00
        Flags: medium devsel, IRQ 10
        Memory at fede0000 (32-bit, non-prefetchable) [size=64K]
        I/O ports at fce8 [size=8]
        Capabilities: [40] Power Management version 2

00:11.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU (rev 09)
        Subsystem: Toshiba America Info Systems: Unknown device ff00
        Flags: medium devsel

00:13.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03)
(prog-if
 10 [OHCI])
        Flags: medium devsel, IRQ 9
        Memory at fedde000 (32-bit, non-prefetchable) [size=4K]

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage LT Pro
AGP-133 (
rev dc) (prog-if 00 [VGA])
        Subsystem: Toshiba America Info Systems: Unknown device ff00
        Flags: bus master, stepping, medium devsel, latency 66, IRQ 11
        Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        I/O ports at e800 [size=256]
        Memory at fecff000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [50] AGP version 1.0
        Capabilities: [5c] Power Management version 1


Here is my kernel configuration

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y

CONFIG_EXPERIMENTAL=y

CONFIG_MODULES=y

CONFIG_M586=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_STRING_486=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_TOSHIBA=m
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
CONFIG_MATH_EMULATION=y
CONFIG_MTRR=y

CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y

CONFIG_PCMCIA=m
CONFIG_CARDBUS=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_PM=y
CONFIG_APM=m


CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_1284=y

CONFIG_PNP=m
CONFIG_ISAPNP=m

CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_NBD=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=7777
CONFIG_BLK_DEV_INITRD=y


CONFIG_PACKET=y
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_SYN_COOKIES=y

CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_COMPAT_IPCHAINS=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_COMPAT_IPFWADM=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IPV6=m

CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
CONFIG_IPX=m
CONFIG_ATALK=m
CONFIG_DECNET=m
CONFIG_BRIDGE=m
CONFIG_X25=m
CONFIG_LAPB=m
CONFIG_ECONET=m
CONFIG_WAN_ROUTER=m



CONFIG_IDE=y

CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_AEC62XX=y
CONFIG_AEC62XX_TUNING=y
CONFIG_BLK_DEV_ALI15X3=y
CONFIG_BLK_DEV_CMD64X=y
CONFIG_BLK_DEV_CS5530=y
CONFIG_BLK_DEV_HPT34X=y
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_BLK_DEV_SLC90E66=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDE_CHIPSETS=y
CONFIG_BLK_DEV_4DRIVES=y
CONFIG_BLK_DEV_ALI14XX=y
CONFIG_BLK_DEV_DTC2278=y
CONFIG_BLK_DEV_HT6560B=y
CONFIG_BLK_DEV_PDC4030=y
CONFIG_BLK_DEV_QD6580=y
CONFIG_BLK_DEV_UMC8672=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y



CONFIG_IEEE1394=m
CONFIG_IEEE1394_PCILYNX=m
CONFIG_IEEE1394_OHCI1394=m
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_RAWIO=m


CONFIG_NETDEVICES=y

CONFIG_ARCNET=m
CONFIG_ARCNET_1201=m
CONFIG_ARCNET_1051=m
CONFIG_ARCNET_RAW=m
CONFIG_ARCNET_COM90xx=m
CONFIG_ARCNET_COM90xxIO=m
CONFIG_ARCNET_RIM_I=m
CONFIG_ARCNET_COM20020=m
CONFIG_ARCNET_COM20020_ISA=m
CONFIG_ARCNET_COM20020_PCI=m

CONFIG_DUMMY=y

CONFIG_NET_ETHERNET=y
CONFIG_HAPPYMEAL=m
CONFIG_NET_VENDOR_3COM=y
CONFIG_EL1=m
CONFIG_EL2=m
CONFIG_ELPLUS=m
CONFIG_EL16=m
CONFIG_EL3=m
CONFIG_3C515=m
CONFIG_VORTEX=m
CONFIG_LANCE=m
CONFIG_NET_VENDOR_SMC=y
CONFIG_WD80x3=m
CONFIG_ULTRA=m
CONFIG_SMC9194=m
CONFIG_NET_VENDOR_RACAL=y
CONFIG_NI5010=m
CONFIG_NI52=m
CONFIG_NI65=m
CONFIG_AT1700=m
CONFIG_DEPCA=m
CONFIG_HP100=m
CONFIG_NET_ISA=y
CONFIG_E2100=m
CONFIG_EWRK3=m
CONFIG_EEXPRESS=m
CONFIG_EEXPRESS_PRO=m
CONFIG_HPLAN_PLUS=m
CONFIG_HPLAN=m
CONFIG_ETH16I=m
CONFIG_NE2000=m
CONFIG_NET_PCI=y
CONFIG_PCNET32=m
CONFIG_ADAPTEC_STARFIRE=m
CONFIG_AC3200=m
CONFIG_APRICOT=m
CONFIG_CS89x0=m
CONFIG_TULIP=m
CONFIG_DE4X5=m
CONFIG_DGRS=m
CONFIG_DM9102=m
CONFIG_EEPRO100=m
CONFIG_FEALNX=m
CONFIG_NATSEMI=m
CONFIG_NE2K_PCI=m
CONFIG_8139TOO=m
CONFIG_SIS900=m
CONFIG_EPIC100=m
CONFIG_SUNDANCE=m
CONFIG_TLAN=m
CONFIG_VIA_RHINE=m
CONFIG_WINBOND_840=m
CONFIG_NET_POCKET=y
CONFIG_ATP=m
CONFIG_DE600=m
CONFIG_DE620=m

CONFIG_ACENIC=m
CONFIG_HAMACHI=m
CONFIG_YELLOWFIN=m
CONFIG_SK98LIN=m
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m


CONFIG_TR=y
CONFIG_IBMTR=m
CONFIG_IBMOL=m
CONFIG_IBMLS=m
CONFIG_TMS380TR=m
CONFIG_TMSPCI=m
CONFIG_TMSISA=m
CONFIG_ABYSS=m
CONFIG_SMCTR=m


CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_PCNET=m
CONFIG_NET_PCMCIA_RADIO=y
CONFIG_PCMCIA_RAYCS=m


CONFIG_IRDA=m
CONFIG_IRLAN=m
CONFIG_IRNET=m
CONFIG_IRCOMM=m

CONFIG_IRTTY_SIR=m
CONFIG_IRPORT_SIR=m
CONFIG_DONGLE=y
CONFIG_ESI_DONGLE=m
CONFIG_ACTISYS_DONGLE=m
CONFIG_TEKRAM_DONGLE=m
CONFIG_GIRBIL_DONGLE=m
CONFIG_LITELINK_DONGLE=m
CONFIG_OLD_BELKIN_DONGLE=m
CONFIG_NSC_FIR=m
CONFIG_WINBOND_FIR=m
CONFIG_TOSHIBA_FIR=m
CONFIG_SMC_IRCC_FIR=m



CONFIG_INPUT=m
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m

CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_SERIAL_EXTENDED=y
CONFIG_SERIAL_MANY_PORTS=y
CONFIG_SERIAL_SHARE_IRQ=y
CONFIG_SERIAL_MULTIPORT=y
CONFIG_HUB6=y
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=512
CONFIG_PRINTER=m


CONFIG_BUSMOUSE=m
CONFIG_ATIXL_BUSMOUSE=m
CONFIG_LOGIBUSMOUSE=m
CONFIG_MS_BUSMOUSE=m
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_82C710_MOUSE=m
CONFIG_PC110_PAD=m


CONFIG_WATCHDOG=y
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDT=m
CONFIG_WDTPCI=m
CONFIG_WDT_501=y
CONFIG_WDT_501_FAN=y
CONFIG_PCWATCHDOG=m
CONFIG_ACQUIRE_WDT=m
CONFIG_ADVANTECH_WDT=m
CONFIG_60XX_WDT=m
CONFIG_MIXCOMWD=m
CONFIG_I810_TCO=m
CONFIG_MACHZ_WDT=m
CONFIG_RTC=y

CONFIG_FTAPE=m
CONFIG_ZFTAPE=m
CONFIG_ZFT_DFLT_BLK_SZ=10240
CONFIG_ZFT_COMPRESSOR=m
CONFIG_FT_NR_BUFFERS=3
CONFIG_FT_NORMAL_DEBUG=y
CONFIG_FT_STD_FDC=y
CONFIG_FT_FDC_THR=8
CONFIG_FT_FDC_MAX_RATE=2000
CONFIG_FT_ALPHA_CLOCK=0
CONFIG_AGP=m
CONFIG_AGP_VIA=y
CONFIG_AGP_SIS=y
CONFIG_AGP_ALI=y
CONFIG_DRM=y
CONFIG_DRM_R128=m
CONFIG_DRM_RADEON=m

CONFIG_PCMCIA_SERIAL_CS=m


CONFIG_QUOTA=y
CONFIG_AUTOFS4_FS=y
CONFIG_REISERFS_FS=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_UMSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=m
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_MINIX_FS=y
CONFIG_NTFS_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y

CONFIG_CODA_FS=m
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
CONFIG_NCP_FS=m
CONFIG_NCPFS_STRONG=y
CONFIG_NCPFS_NFS_NS=y
CONFIG_NCPFS_OS2_NS=y

CONFIG_PARTITION_ADVANCED=y
CONFIG_AMIGA_PARTITION=y
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_SGI_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

CONFIG_NLS_DEFAULT="cp437"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_ISO8859_1=y

CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y


CONFIG_SOUND=m
CONFIG_SOUND_CS4281=m

CONFIG_USB=m
CONFIG_USB_DEVICEFS=y
CONFIG_USB_OHCI=m



CONFIG_MAGIC_SYSRQ=y


Hi all,
	Alessio


