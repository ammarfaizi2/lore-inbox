Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbTK3XUr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 18:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbTK3XUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 18:20:47 -0500
Received: from web40608.mail.yahoo.com ([66.218.78.145]:44956 "HELO
	web40608.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261889AbTK3XTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 18:19:49 -0500
Message-ID: <20031130231948.21382.qmail@web40608.mail.yahoo.com>
Date: Mon, 1 Dec 2003 00:19:48 +0100 (CET)
From: =?iso-8859-1?q?szonyi=20calin?= <caszonyi@yahoo.com>
Subject: Oops + crash in 2.6.0-test11
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-483187083-1070234388=:20640"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-483187083-1070234388=:20640
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi
I was watching tv with tvtime and reading lkml on yahoo mail
(with opera 
if matters). I decided to start xawtv instead of tvtime because
tvtime 
looked like it was skiping frames.
So i pressed the q key in tvtime and with the tvtime window
dissapeared 
also the xterm window from which it was started. I tryed to
start xterm 
but the xterm window mapped quickly and then dissapeared. I
switched to 
my syslog VT and noticed an oops. I couldn't start a new shell
nor from
console nor from X (starting a new shell gave me a segfault or
an oops)
I couldn't shutdown cleanly (i had to use sysrq)

Attached are the program versions, config, dmesg (from syslog)
and oopses.

Bye
Calin


=====
--
A mouse is a device used to point at 
the xterm you want to type in.
Kim Alm on a.s.r.

___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
--0-483187083-1070234388=:20640
Content-Type: text/plain; name="bug.txt"
Content-Description: bug.txt
Content-Disposition: inline; filename="bug.txt"


============ config =====================

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

CONFIG_EXPERIMENTAL=y
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
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y

CONFIG_X86_PC=y
CONFIG_MK7=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_PREEMPT=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

CONFIG_PM=y

CONFIG_APM=y
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_RTC_IS_GMT=y

CONFIG_PCI=y
CONFIG_PCI_GODIRECT=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y

CONFIG_BINFMT_ELF=y

CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_1284=y

CONFIG_PNP=y
CONFIG_PNP_DEBUG=y

CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y

CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y

CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_TASKFILE_IO=y

CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y

CONFIG_NET=y

CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_ARPD=y

CONFIG_NETFILTER=y

CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_IRC=y
CONFIG_IP_NF_TFTP=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
CONFIG_IP_NF_MATCH_IPRANGE=y
CONFIG_IP_NF_MATCH_MAC=y
CONFIG_IP_NF_MATCH_PKTTYPE=y
CONFIG_IP_NF_MATCH_MARK=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
CONFIG_IP_NF_MATCH_TOS=y
CONFIG_IP_NF_MATCH_RECENT=y
CONFIG_IP_NF_MATCH_ECN=y
CONFIG_IP_NF_MATCH_DSCP=y
CONFIG_IP_NF_MATCH_AH_ESP=y
CONFIG_IP_NF_MATCH_LENGTH=y
CONFIG_IP_NF_MATCH_TTL=y
CONFIG_IP_NF_MATCH_TCPMSS=y
CONFIG_IP_NF_MATCH_HELPER=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_MATCH_CONNTRACK=y
CONFIG_IP_NF_MATCH_OWNER=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_TARGET_NETMAP=y
CONFIG_IP_NF_TARGET_SAME=y
CONFIG_IP_NF_NAT_LOCAL=y
CONFIG_IP_NF_NAT_SNMP_BASIC=y
CONFIG_IP_NF_NAT_IRC=y
CONFIG_IP_NF_NAT_FTP=y
CONFIG_IP_NF_NAT_TFTP=y
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=y
CONFIG_IP_NF_TARGET_ECN=y
CONFIG_IP_NF_TARGET_DSCP=y
CONFIG_IP_NF_TARGET_MARK=y
CONFIG_IP_NF_TARGET_CLASSIFY=y
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IP_NF_TARGET_ULOG=y
CONFIG_IP_NF_TARGET_TCPMSS=y
CONFIG_IP_NF_ARPTABLES=y
CONFIG_IP_NF_ARPFILTER=y

CONFIG_IPV6_SCTP__=y

CONFIG_NETDEVICES=y

CONFIG_NET_ETHERNET=y
CONFIG_MII=y

CONFIG_NET_PCI=y
CONFIG_8139TOO=y

CONFIG_PPP=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=y
CONFIG_PPP_DEFLATE=y
CONFIG_PPP_BSDCOMP=y

CONFIG_SHAPER=y

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
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y

CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y

CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
CONFIG_SERIAL_8250_MULTIPORT=y
CONFIG_SERIAL_8250_RSA=y

CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=512
CONFIG_PRINTER=y
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=y

CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y

CONFIG_I2C_ALGOBIT=y

CONFIG_I2C_VIA=y
CONFIG_I2C_VIAPRO=y

CONFIG_I2C_SENSOR=y
CONFIG_SENSORS_EEPROM=y
CONFIG_SENSORS_VIA686A=y

CONFIG_NVRAM=y
CONFIG_RTC=y

CONFIG_AGP=y
CONFIG_AGP_VIA=y
CONFIG_DRM=y
CONFIG_DRM_RADEON=y

CONFIG_VIDEO_DEV=y

CONFIG_VIDEO_BT848=y

CONFIG_VIDEO_TUNER=y
CONFIG_VIDEO_BUF=y
CONFIG_VIDEO_BTCX=y

CONFIG_VIDEO_SELECT=y

CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y

CONFIG_SOUND=y

CONFIG_SOUND_PRIME=y
CONFIG_SOUND_BT878=y
CONFIG_SOUND_OSS=y
CONFIG_SOUND_TRACEINIT=y
CONFIG_SOUND_DMAP=y
CONFIG_SOUND_CS4232=y
CONFIG_SOUND_TVMIXER=y

CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_JFS_FS=y
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_DEBUG=y
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=y
CONFIG_XFS_POSIX_ACL=y

CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=y

CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y

CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y

CONFIG_UFS_FS=y

CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
CONFIG_SMB_FS=y
CONFIG_CODA_FS=y
CONFIG_CODA_FS_OLD_API=y

CONFIG_PARTITION_ADVANCED=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

CONFIG_NLS_DEFAULT="iso8859-2"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_UTF8=y

CONFIG_PROFILING=y
CONFIG_OPROFILE=y

CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y

CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y



==================== dmesg ==========================



Nov 30 20:17:11 grinch kernel: Linux version 2.6.0-test11 (root@grinch) (gcc version 3.2.3) #1 Fri Nov 28 23:46:00 EET 2003
Nov 30 20:17:11 grinch kernel: BIOS-provided physical RAM map:
Nov 30 20:17:11 grinch kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Nov 30 20:17:11 grinch kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Nov 30 20:17:11 grinch kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Nov 30 20:17:11 grinch kernel:  BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
Nov 30 20:17:11 grinch kernel:  BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
Nov 30 20:17:11 grinch kernel:  BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
Nov 30 20:17:11 grinch kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Nov 30 20:17:11 grinch kernel: 255MB LOWMEM available.
Nov 30 20:17:11 grinch kernel: On node 0 totalpages: 65520
Nov 30 20:17:11 grinch kernel:   DMA zone: 4096 pages, LIFO batch:1
Nov 30 20:17:11 grinch kernel:   Normal zone: 61424 pages, LIFO batch:14
Nov 30 20:17:11 grinch kernel:   HighMem zone: 0 pages, LIFO batch:1
Nov 30 20:17:11 grinch kernel: DMI not present.
Nov 30 20:17:11 grinch kernel: Building zonelist for node : 0
Nov 30 20:17:11 grinch kernel: Kernel command line: BOOT_IMAGE=k260test11 ro root=306 psmouse_noext
Nov 30 20:17:11 grinch kernel: Initializing CPU#0
Nov 30 20:17:11 grinch kernel: PID hash table entries: 1024 (order 10: 8192 bytes)
Nov 30 20:17:11 grinch kernel: Detected 700.411 MHz processor.
Nov 30 20:17:11 grinch kernel: Console: colour VGA+ 132x25
Nov 30 20:17:11 grinch kernel: Memory: 254188k/262080k available (3050k kernel code, 7164k reserved, 829k data, 344k init, 0k highmem)
Nov 30 20:17:11 grinch kernel: Calibrating delay loop... 1372.16 BogoMIPS
Nov 30 20:17:11 grinch kernel: Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Nov 30 20:17:11 grinch kernel: Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Nov 30 20:17:11 grinch kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Nov 30 20:17:11 grinch kernel: CPU:     After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
Nov 30 20:17:11 grinch kernel: CPU:     After vendor identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
Nov 30 20:17:11 grinch kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Nov 30 20:17:11 grinch kernel: CPU: L2 Cache: 64K (64 bytes/line)
Nov 30 20:17:11 grinch kernel: CPU:     After all inits, caps: 0183f9ff c1c7f9ff 00000000 00000020
Nov 30 20:17:11 grinch kernel: Intel machine check architecture supported.
Nov 30 20:17:11 grinch kernel: Intel machine check reporting enabled on CPU#0.
Nov 30 20:17:11 grinch kernel: CPU: AMD Duron(tm) Processor stepping 01
Nov 30 20:17:11 grinch kernel: Enabling fast FPU save and restore... done.
Nov 30 20:17:11 grinch kernel: Checking 'hlt' instruction... OK.
Nov 30 20:17:11 grinch kernel: POSIX conformance testing by UNIFIX
Nov 30 20:17:11 grinch kernel: NET: Registered protocol family 16
Nov 30 20:17:11 grinch kernel: PCI: Using configuration type 1
Nov 30 20:17:11 grinch kernel: mtrr: v2.0 (20020519)
Nov 30 20:17:11 grinch kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Nov 30 20:17:11 grinch kernel: pnp: the driver 'system' has been registered
Nov 30 20:17:11 grinch kernel: PnPBIOS: Scanning system for PnP BIOS support...
Nov 30 20:17:11 grinch kernel: PnPBIOS: Found PnP BIOS installation structure at 0xc00fbdf0
Nov 30 20:17:11 grinch kernel: PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbe20, dseg 0xf0000
Nov 30 20:17:11 grinch kernel: pnp: match found with the PnP device '00:07' and the driver 'system'
Nov 30 20:17:11 grinch kernel: pnp: match found with the PnP device '00:08' and the driver 'system'
Nov 30 20:17:11 grinch kernel: pnp: match found with the PnP device '00:0b' and the driver 'system'
Nov 30 20:17:11 grinch kernel: pnp: 00:0b: ioport range 0x208-0x20f has been reserved
Nov 30 20:17:11 grinch kernel: PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
Nov 30 20:17:11 grinch kernel: PCI: Probing PCI hardware
Nov 30 20:17:11 grinch kernel: PCI: Probing PCI hardware (bus 00)
Nov 30 20:17:11 grinch kernel: Disabling VIA memory write queue (PCI ID 0305, rev 02): [55] 81 & 1f -> 01
Nov 30 20:17:11 grinch kernel: PCI: Using IRQ router VIA [1106/0686] at 0000:00:07.0
Nov 30 20:17:11 grinch kernel: Machine check exception polling timer started.
Nov 30 20:17:11 grinch kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
Nov 30 20:17:11 grinch kernel: Coda Kernel/Venus communications, v6.0.0, coda@cs.cmu.edu
Nov 30 20:17:11 grinch kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Nov 30 20:17:11 grinch kernel: udf: registering filesystem
Nov 30 20:17:11 grinch kernel: SGI XFS for Linux with ACLs, no debug enabled
Nov 30 20:17:11 grinch kernel: isapnp: Scanning for PnP cards...
Nov 30 20:17:11 grinch kernel: isapnp: Card 'Crystal Codec'
Nov 30 20:17:11 grinch kernel: isapnp: 1 Plug & Play card detected total
Nov 30 20:17:11 grinch kernel: pty: 512 Unix98 ptys configured
Nov 30 20:17:11 grinch kernel: request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
Nov 30 20:17:11 grinch kernel: lp: driver loaded but no devices found
Nov 30 20:17:11 grinch kernel: Real Time Clock Driver v1.12
Nov 30 20:17:11 grinch kernel: Non-volatile memory driver v1.2
Nov 30 20:17:11 grinch kernel: ppdev: user-space parallel port driver
Nov 30 20:17:11 grinch kernel: Linux agpgart interface v0.100 (c) Dave Jones
Nov 30 20:17:11 grinch kernel: agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
Nov 30 20:17:11 grinch kernel: agpgart: Maximum main memory to use for agp memory: 203M
Nov 30 20:17:11 grinch kernel: agpgart: AGP aperture is 128M @ 0xd0000000
Nov 30 20:17:11 grinch kernel: [drm] Initialized radeon 1.9.0 20020828 on minor 0
Nov 30 20:17:11 grinch kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
Nov 30 20:17:11 grinch kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Nov 30 20:17:11 grinch kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Nov 30 20:17:11 grinch kernel: pnp: the driver 'serial' has been registered
Nov 30 20:17:11 grinch kernel: pnp: match found with the PnP device '00:0d' and the driver 'serial'
Nov 30 20:17:11 grinch kernel: pnp: match found with the PnP device '00:0e' and the driver 'serial'
Nov 30 20:17:11 grinch kernel: pnp: the driver 'parport_pc' has been registered
Nov 30 20:17:11 grinch kernel: pnp: match found with the PnP device '00:10' and the driver 'parport_pc'
Nov 30 20:17:11 grinch kernel: parport0: PC-style at 0x3bc (0x7bc) [PCSPP,TRISTATE]
Nov 30 20:17:11 grinch kernel: parport0: cpp_daisy: aa5500ff(38)
Nov 30 20:17:11 grinch kernel: parport0: assign_addrs: aa5500ff(38)
Nov 30 20:17:11 grinch kernel: parport0: cpp_daisy: aa5500ff(38)
Nov 30 20:17:11 grinch kernel: parport0: assign_addrs: aa5500ff(38)
Nov 30 20:17:11 grinch kernel: lp0: using parport0 (polling).
Nov 30 20:17:11 grinch kernel: lp0: console ready
Nov 30 20:17:11 grinch kernel: parport_pc: Via 686A parallel port: io=0x3BC
Nov 30 20:17:11 grinch kernel: Using anticipatory io scheduler
Nov 30 20:17:11 grinch kernel: Floppy drive(s): fd0 is 1.44M
Nov 30 20:17:11 grinch kernel: FDC 0 is a post-1991 82077
Nov 30 20:17:11 grinch kernel: loop: loaded (max 8 devices)
Nov 30 20:17:11 grinch kernel: PPP generic driver version 2.4.2
Nov 30 20:17:11 grinch kernel: PPP Deflate Compression module registered
Nov 30 20:17:11 grinch kernel: PPP BSD Compression module registered
Nov 30 20:17:11 grinch kernel: 8139too Fast Ethernet driver 0.9.26
Nov 30 20:17:11 grinch kernel: PCI: Found IRQ 10 for device 0000:00:08.0
Nov 30 20:17:11 grinch kernel: eth0: RealTek RTL8139 at 0xd0883000, 00:40:f4:72:99:b3, IRQ 10
Nov 30 20:17:11 grinch kernel: eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
Nov 30 20:17:11 grinch kernel: PCI: Found IRQ 11 for device 0000:00:0a.0
Nov 30 20:17:11 grinch kernel: eth1: RealTek RTL8139 at 0xd0885000, 00:40:f4:74:6d:fb, IRQ 11
Nov 30 20:17:11 grinch kernel: eth1:  Identified 8139 chip type 'RTL-8100B/8139D'
Nov 30 20:17:11 grinch kernel: Linux video capture interface: v1.00
Nov 30 20:17:11 grinch kernel: bttv: driver version 0.9.12 loaded
Nov 30 20:17:11 grinch kernel: bttv: using 8 buffers with 2080k (520 pages) each for capture
Nov 30 20:17:11 grinch kernel: bttv: Bt8xx card found (0).
Nov 30 20:17:11 grinch kernel: PCI: Found IRQ 9 for device 0000:00:09.0
Nov 30 20:17:11 grinch kernel: PCI: Sharing IRQ 9 with 0000:00:09.1
Nov 30 20:17:11 grinch kernel: bttv0: Bt878 (rev 2) at 0000:00:09.0, irq: 9, latency: 32, mmio: 0xe2001000
Nov 30 20:17:11 grinch kernel: bttv0: detected: AVermedia TVCapture 98 [card=13], PCI subsystem ID is 1461:0002
Nov 30 20:17:11 grinch kernel: bttv0: using: AVerMedia TVCapture 98 [card=13,autodetected]
Nov 30 20:17:11 grinch kernel: bttv0: Hauppauge/Voodoo msp34xx: reset line init [11]
Nov 30 20:17:11 grinch kernel: bttv0: Avermedia eeprom[0x4011]: tuner=5 radio:no remote control:yes
Nov 30 20:17:11 grinch kernel: bttv0: using tuner=5
Nov 30 20:17:11 grinch kernel: bttv0: i2c: checking for MSP34xx @ 0x80... not found
Nov 30 20:17:11 grinch kernel: bttv0: i2c: checking for MSP34xx (alternate address) @ 0x88... not found
Nov 30 20:17:11 grinch kernel: bttv0: i2c: checking for TDA9875 @ 0xb0... not found
Nov 30 20:17:11 grinch kernel: bttv0: i2c: checking for TDA7432 @ 0x8a... not found
Nov 30 20:17:11 grinch kernel: bttv0: registered device video0
Nov 30 20:17:11 grinch kernel: bttv0: registered device vbi0
Nov 30 20:17:11 grinch kernel: bttv0: PLL: 28636363 => 35468950 .. ok
Nov 30 20:17:11 grinch kernel: tvaudio: TV audio decoder + audio/video mux driver
Nov 30 20:17:11 grinch kernel: tvaudio: known chips: tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 (PV951),ta8874z
Nov 30 20:17:11 grinch kernel: tuner: chip found @ 0xc2
Nov 30 20:17:11 grinch kernel: tuner: type set to 5 (Philips PAL_BG (FI1216 and compatibles))
Nov 30 20:17:11 grinch kernel: registering 0-0061
Nov 30 20:17:11 grinch kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Nov 30 20:17:11 grinch kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Nov 30 20:17:11 grinch kernel: VP_IDE: IDE controller at PCI slot 0000:00:07.1
Nov 30 20:17:11 grinch kernel: VP_IDE: chipset revision 16
Nov 30 20:17:11 grinch kernel: VP_IDE: not 100%% native mode: will probe irqs later
Nov 30 20:17:11 grinch kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Nov 30 20:17:11 grinch kernel: VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci0000:00:07.1
Nov 30 20:17:11 grinch kernel:     ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
Nov 30 20:17:11 grinch kernel:     ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
Nov 30 20:17:11 grinch kernel: hda: Maxtor 2F040J0, ATA DISK drive
Nov 30 20:17:11 grinch kernel: hdb: SONY CDU4811, ATAPI CD/DVD-ROM drive
Nov 30 20:17:11 grinch kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Nov 30 20:17:11 grinch kernel: hdc: TEAC CD-W552E, ATAPI CD/DVD-ROM drive
Nov 30 20:17:11 grinch kernel: ide1 at 0x170-0x177,0x376 on irq 15
Nov 30 20:17:11 grinch kernel: hda: max request size: 128KiB
Nov 30 20:17:11 grinch kernel: hda: 80293248 sectors (41110 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(66)
Nov 30 20:17:11 grinch kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >
Nov 30 20:17:11 grinch kernel: end_request: I/O error, dev hdb, sector 0
Nov 30 20:17:11 grinch kernel: hdb: ATAPI 48X CD-ROM drive, 120kB Cache, UDMA(33)
Nov 30 20:17:11 grinch kernel: Uniform CD-ROM driver Revision: 3.12
Nov 30 20:17:11 grinch kernel: end_request: I/O error, dev hdc, sector 0
Nov 30 20:17:11 grinch kernel: hdc: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Nov 30 20:17:11 grinch kernel: mice: PS/2 mouse device common for all mice
Nov 30 20:17:11 grinch kernel: input: PC Speaker
Nov 30 20:17:11 grinch kernel: input: PS/2 Generic Mouse on isa0060/serio1
Nov 30 20:17:11 grinch kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Nov 30 20:17:11 grinch kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Nov 30 20:17:11 grinch kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Nov 30 20:17:11 grinch kernel: i2c /dev entries driver
Nov 30 20:17:11 grinch kernel: tuner: type already set (5)
Nov 30 20:17:11 grinch kernel: registering 0-0050
Nov 30 20:17:11 grinch kernel: tuner: type already set (5)
Nov 30 20:17:11 grinch kernel: registering 0-0051
Nov 30 20:17:11 grinch kernel: tuner: type already set (5)
Nov 30 20:17:11 grinch kernel: registering 0-0052
Nov 30 20:17:11 grinch kernel: tuner: type already set (5)
Nov 30 20:17:11 grinch kernel: registering 0-0053
Nov 30 20:17:11 grinch kernel: tuner: type already set (5)
Nov 30 20:17:11 grinch kernel: registering 0-0054
Nov 30 20:17:11 grinch kernel: tuner: type already set (5)
Nov 30 20:17:11 grinch kernel: registering 0-0055
Nov 30 20:17:11 grinch kernel: tuner: type already set (5)
Nov 30 20:17:11 grinch kernel: registering 0-0056
Nov 30 20:17:11 grinch kernel: tuner: type already set (5)
Nov 30 20:17:11 grinch kernel: registering 0-0057
Nov 30 20:17:11 grinch kernel: registering 1-0050
Nov 30 20:17:11 grinch kernel: registering 1-0051
Nov 30 20:17:11 grinch kernel: pnp: the driver 'cs4232' has been registered
Nov 30 20:17:11 grinch kernel: pnp: match found with the PnP device '01:01.00' and the driver 'cs4232'
Nov 30 20:17:11 grinch kernel: pnp: Device 01:01.00 activated.
Nov 30 20:17:11 grinch kernel: <Crystal audio controller (CS4239)> at 0x534 irq 5 dma 1,0
Nov 30 20:17:11 grinch kernel: ad1848: Interrupt test failed (IRQ5)
Nov 30 20:17:11 grinch kernel: ad1848/cs4248 codec driver Copyright (C) by Hannu Savolainen 1993-1996
Nov 30 20:17:11 grinch kernel: ad1848: No ISAPnP cards found, trying standard ones...
Nov 30 20:17:11 grinch kernel: btaudio: driver version 0.7 loaded [digital+analog]
Nov 30 20:17:11 grinch kernel: PCI: Found IRQ 9 for device 0000:00:09.1
Nov 30 20:17:11 grinch kernel: PCI: Sharing IRQ 9 with 0000:00:09.0
Nov 30 20:17:11 grinch kernel: btaudio: Bt878 (rev 2) at 00:09.1, irq: 9, latency: 32, mmio: 0xe2002000
Nov 30 20:17:11 grinch kernel: btaudio: using card config "default"
Nov 30 20:17:11 grinch kernel: btaudio: registered device dsp1 [digital]
Nov 30 20:17:11 grinch kernel: btaudio: registered device dsp2 [analog]
Nov 30 20:17:11 grinch kernel: btaudio: registered device mixer1
Nov 30 20:17:11 grinch kernel: oprofile: using timer interrupt.
Nov 30 20:17:11 grinch kernel: NET: Registered protocol family 2
Nov 30 20:17:11 grinch kernel: IP: routing cache hash table of 2048 buckets, 16Kbytes
Nov 30 20:17:11 grinch kernel: TCP: Hash tables configured (established 16384 bind 32768)
Nov 30 20:17:11 grinch kernel: ip_conntrack version 2.1 (2047 buckets, 16376 max) - 300 bytes per conntrack
Nov 30 20:17:11 grinch kernel: ip_tables: (C) 2000-2002 Netfilter core team
Nov 30 20:17:11 grinch kernel: ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
Nov 30 20:17:11 grinch kernel: arp_tables: (C) 2002 David S. Miller
Nov 30 20:17:11 grinch kernel: NET: Registered protocol family 1
Nov 30 20:17:11 grinch kernel: NET: Registered protocol family 17
Nov 30 20:17:11 grinch kernel: You didn't specify the type of your ufs filesystem
Nov 30 20:17:11 grinch kernel: 
Nov 30 20:17:11 grinch kernel: mount -t ufs -o ufstype=sun|sunx86|44bsd|old|hp|nextstep|netxstep-cd|openstep ...
Nov 30 20:17:11 grinch kernel: 
Nov 30 20:17:11 grinch kernel: >>>WARNING<<< Wrong ufstype may corrupt your filesystem, default is ufstype=old
Nov 30 20:17:11 grinch kernel: ufs_read_super: bad magic number
Nov 30 20:17:11 grinch kernel: UDF-fs DEBUG fs/udf/lowlevel.c:65:udf_get_last_session: CDROMMULTISESSION not supported: rc=-22
Nov 30 20:17:11 grinch kernel: UDF-fs DEBUG fs/udf/super.c:1544:udf_fill_super: Multi-session=0
Nov 30 20:17:11 grinch kernel: UDF-fs DEBUG fs/udf/super.c:532:udf_vrs: Starting at sector 16 (2048 byte sectors)
Nov 30 20:17:11 grinch kernel: UDF-fs: No VRS found
Nov 30 20:17:11 grinch kernel: VFS: Mounted root (jfs filesystem) readonly.
Nov 30 20:17:11 grinch kernel: Freeing unused kernel memory: 344k freed
Nov 30 20:17:11 grinch kernel: Adding 530104k swap on /dev/hda7.  Priority:-1 extents:1







========================= oopses ===================








tuner: TV freq (268435455.93) out of range (44-958)
tuner: TV freq (268435455.93) out of range (44-958)
tuner: TV freq (268435455.93) out of range (44-958)
tuner: TV freq (268435455.93) out of range (44-958)
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: PLL: 28636363 => 35468950 .. ok
bttv0: skipped frame. no signal? high irq latency?
bttv0: skipped frame. no signal? high irq latency?
bttv0: skipped frame. no signal? high irq latency?
bttv0: skipped frame. no signal? high irq latency?
bttv0: skipped frame. no signal? high irq latency?
bttv0: skipped frame. no signal? high irq latency?
bttv0: skipped frame. no signal? high irq latency?
bttv0: skipped frame. no signal? high irq latency?
bttv0: skipped frame. no signal? high irq latency?
bttv0: skipped frame. no signal? high irq latency?
bttv0: skipped frame. no signal? high irq latency?
bttv0: skipped frame. no signal? high irq latency?
bttv0: skipped frame. no signal? high irq latency?
Unable to handle kernel paging request at virtual address 14000808
 printing eip:
c0168436
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c0168436>]    Not tainted
EFLAGS: 00010202
EIP is at prune_dcache+0x46/0x1f0
eax: c0467d54   ebx: c2556300   ecx: c254518c   edx: 14000808
esi: c258a140   edi: 00000071   ebp: c13f0000   esp: c13f1e68
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 8, threadinfo=c13f0000 task=c13f6cc0)
Stack: c258a140 c13f1e7c c13f0000 c13f0000 c13f0000 c13f0000 00000080 c13f0000 
       000005bc cffeeb60 c0168a5f 00000080 00000080 c013ee72 00000080 000000d0 
       00005499 07592100 00000000 0000163c 00000000 000002c0 c0466a74 00000001 
Call Trace:
 [<c0168a5f>] shrink_dcache_memory+0x3f/0x50
 [<c013ee72>] shrink_slab+0x112/0x160
 [<c01402b2>] balance_pgdat+0x1d2/0x200
 [<c0140423>] kswapd+0x143/0x150
 [<c011aad0>] autoremove_wake_function+0x0/0x50
 [<c010923e>] ret_from_fork+0x6/0x14
 [<c011aad0>] autoremove_wake_function+0x0/0x50
 [<c01402e0>] kswapd+0x0/0x150
 [<c0107189>] kernel_thread_helper+0x5/0xc

Code: 89 02 89 49 04 89 09 a1 58 7d 46 c0 8d 44 20 00 ff 0d 60 7d 
 <6>note: kswapd0[8] exited with preempt_count 1
bttv0: skipped frame. no signal? high irq latency?
bttv0: skipped frame. no signal? high irq latency?
bttv0: skipped frame. no signal? high irq latency?
bttv0: skipped frame. no signal? high irq latency?
bttv0: skipped frame. no signal? high irq latency?
bttv0: skipped frame. no signal? high irq latency?
bttv0: skipped frame. no signal? high irq latency?
bttv0: skipped frame. no signal? high irq latency?
bttv0: skipped frame. no signal? high irq latency?
bttv0: skipped frame. no signal? high irq latency?
Unable to handle kernel paging request at virtual address 14000808
 printing eip:
c01688e5
*pde = 00000000
Oops: 0000 [#2]
CPU:    0
EIP:    0060:[<c01688e5>]    Not tainted
EFLAGS: 00010246
EIP is at select_parent+0x55/0xc0
eax: 14000808   ebx: cbff9cc0   ecx: cbff9ccc   edx: cbff990c
esi: cc0d0c94   edi: cc0d0d40   ebp: cc0d0d5c   esp: c643dee8
ds: 007b   es: 007b   ss: 0068
Process bash (pid: 424, threadinfo=c643c000 task=c64932a0)
Stack: 00000000 cc0d0d40 ccd952a0 cc0d0d40 00000000 c0168960 cc0d0d40 cc0d0d40 
       c017dfd7 cc0d0d40 c643c000 c011ddee cc0d0d40 000004ca ccd952a0 bffff808 
       00000286 c011f6be ccd952a0 00003fa4 d05c88f0 000004ca c64932a0 ccd95350 
Call Trace:
 [<c0168960>] shrink_dcache_parent+0x10/0x30
 [<c017dfd7>] proc_pid_flush+0x17/0x30
 [<c011ddee>] release_task+0x14e/0x1d0
 [<c011f6be>] wait_task_zombie+0x14e/0x1e0
 [<c011fb2a>] sys_wait4+0x23a/0x290
 [<c01193f0>] default_wake_function+0x0/0x20
 [<c01193f0>] default_wake_function+0x0/0x20
 [<c0109367>] syscall_call+0x7/0xb

Code: 8b 10 89 4a 04 89 53 0c 89 41 04 89 08 ff 04 24 ff 05 60 7d 
 <6>note: bash[424] exited with preempt_count 1
Unable to handle kernel paging request at virtual address 14000808
 printing eip:
c01688e5
*pde = 00000000
Oops: 0000 [#3]
CPU:    0
EIP:    0060:[<c01688e5>]    Not tainted
EFLAGS: 00010246
EIP is at select_parent+0x55/0xc0
eax: 14000808   ebx: c352cc80   ecx: c352cc8c   edx: c0467d54
esi: c352cd5c   edi: c352cd40   ebp: c352cd5c   esp: c6571ee8
ds: 007b   es: 007b   ss: 0068
Process bash (pid: 711, threadinfo=c6570000 task=c64938c0)
Stack: 00000000 c352ce00 c13f6cc0 c352ce00 00000000 c0168960 c352ce00 c352ce00 
       c017dfd7 c352ce00 c6570000 c011ddee c352ce00 00000001 c13f6cc0 bffff24c 
       000002ce c011f6be c13f6cc0 00000064 00000001 00000001 00000001 c13f6d70 
Call Trace:
 [<c0168960>] shrink_dcache_parent+0x10/0x30
 [<c017dfd7>] proc_pid_flush+0x17/0x30
 [<c011ddee>] release_task+0x14e/0x1d0
 [<c011f6be>] wait_task_zombie+0x14e/0x1e0
 [<c011fb2a>] sys_wait4+0x23a/0x290
 [<c01193f0>] default_wake_function+0x0/0x20
 [<c01193f0>] default_wake_function+0x0/0x20
 [<c0109367>] syscall_call+0x7/0xb

Code: 8b 10 89 4a 04 89 53 0c 89 41 04 89 08 ff 04 24 ff 05 60 7d 
 <6>note: bash[711] exited with preempt_count 1
bad: scheduling while atomic!
Call Trace:
 [<c0119384>] schedule+0x564/0x570
 [<c0141bb3>] unmap_page_range+0x43/0x70
 [<c0141da8>] unmap_vmas+0x1c8/0x220
 [<c0145ce3>] exit_mmap+0x83/0x1a0
 [<c011ad85>] mmput+0x65/0xc0
 [<c011f0dd>] do_exit+0x12d/0x3b0
 [<c0109bb1>] die+0xe1/0xf0
 [<c0117564>] do_page_fault+0x1e4/0x4f6
 [<c013981f>] __alloc_pages+0xaf/0x350
 [<c010ff66>] convert_fxsr_to_user+0xc6/0x160
 [<c01101be>] save_i387_fxsave+0xce/0x100
 [<c0117380>] do_page_fault+0x0/0x4f6
 [<c0109511>] error_code+0x2d/0x38
 [<c01688e5>] select_parent+0x55/0xc0
 [<c0168960>] shrink_dcache_parent+0x10/0x30
 [<c017dfd7>] proc_pid_flush+0x17/0x30
 [<c011ddee>] release_task+0x14e/0x1d0
 [<c011f6be>] wait_task_zombie+0x14e/0x1e0
 [<c011fb2a>] sys_wait4+0x23a/0x290
 [<c01193f0>] default_wake_function+0x0/0x20
 [<c01193f0>] default_wake_function+0x0/0x20
 [<c0109367>] syscall_call+0x7/0xb

Unable to handle kernel paging request at virtual address 14000808
 printing eip:
c01688e5
*pde = 00000000
Oops: 0000 [#4]
CPU:    0
EIP:    0060:[<c01688e5>]    Not tainted
EFLAGS: 00010246
EIP is at select_parent+0x55/0xc0
eax: 14000808   ebx: c352c980   ecx: c352c98c   edx: c0467d54
esi: c352c8dc   edi: c352c8c0   ebp: c352c8dc   esp: c6571ee8
ds: 007b   es: 007b   ss: 0068
Process bash (pid: 720, threadinfo=c6570000 task=c64938c0)
Stack: 00000000 c352c800 cdc4a0c0 c352c800 00000000 c0168960 c352c800 c352c800 
       c017dfd7 c352c800 c6570000 c011ddee c352c800 00000001 cdc4a0c0 bffff24c 
       000002d7 c011f6be cdc4a0c0 00000064 00000001 00000001 00000001 cdc4a170 
Call Trace:
 [<c0168960>] shrink_dcache_parent+0x10/0x30
 [<c017dfd7>] proc_pid_flush+0x17/0x30
 [<c011ddee>] release_task+0x14e/0x1d0
 [<c011f6be>] wait_task_zombie+0x14e/0x1e0
 [<c011fb2a>] sys_wait4+0x23a/0x290
 [<c01193f0>] default_wake_function+0x0/0x20
 [<c01193f0>] default_wake_function+0x0/0x20
 [<c0109367>] syscall_call+0x7/0xb

Code: 8b 10 89 4a 04 89 53 0c 89 41 04 89 08 ff 04 24 ff 05 60 7d 
 <6>note: bash[720] exited with preempt_count 1
bad: scheduling while atomic!
Call Trace:
 [<c0119384>] schedule+0x564/0x570
 [<c0141bb3>] unmap_page_range+0x43/0x70
 [<c0141da8>] unmap_vmas+0x1c8/0x220
 [<c0145ce3>] exit_mmap+0x83/0x1a0
 [<c011ad85>] mmput+0x65/0xc0
 [<c011f0dd>] do_exit+0x12d/0x3b0
 [<c0109bb1>] die+0xe1/0xf0
 [<c0117564>] do_page_fault+0x1e4/0x4f6
 [<c013981f>] __alloc_pages+0xaf/0x350
 [<c010ff66>] convert_fxsr_to_user+0xc6/0x160
 [<c01101be>] save_i387_fxsave+0xce/0x100
 [<c0117380>] do_page_fault+0x0/0x4f6
 [<c0109511>] error_code+0x2d/0x38
 [<c01688e5>] select_parent+0x55/0xc0
 [<c0168960>] shrink_dcache_parent+0x10/0x30
 [<c017dfd7>] proc_pid_flush+0x17/0x30
 [<c011ddee>] release_task+0x14e/0x1d0
 [<c011f6be>] wait_task_zombie+0x14e/0x1e0
 [<c011fb2a>] sys_wait4+0x23a/0x290
 [<c01193f0>] default_wake_function+0x0/0x20
 [<c01193f0>] default_wake_function+0x0/0x20
 [<c0109367>] syscall_call+0x7/0xb

Unable to handle kernel paging request at virtual address 14000808
 printing eip:
c01688e5
*pde = 00000000
Oops: 0000 [#5]
CPU:    0
EIP:    0060:[<c01688e5>]    Not tainted
EFLAGS: 00010246
EIP is at select_parent+0x55/0xc0
eax: 14000808   ebx: c352c680   ecx: c352c68c   edx: c0467d54
esi: c352c51c   edi: c352c500   ebp: c352c51c   esp: c6571ee8
ds: 007b   es: 007b   ss: 0068
Process bash (pid: 729, threadinfo=c6570000 task=c64938c0)
Stack: 00000000 c352c5c0 cdc4ad00 c352c5c0 00000000 c0168960 c352c5c0 c352c5c0 
       c017dfd7 c352c5c0 c6570000 c011ddee c352c5c0 00000001 cdc4ad00 bffff24c 
       000002e0 c011f6be cdc4ad00 00000064 00000001 00000000 00000002 cdc4adb0 
Call Trace:
 [<c0168960>] shrink_dcache_parent+0x10/0x30
 [<c017dfd7>] proc_pid_flush+0x17/0x30
 [<c011ddee>] release_task+0x14e/0x1d0
 [<c011f6be>] wait_task_zombie+0x14e/0x1e0
 [<c011fb2a>] sys_wait4+0x23a/0x290
 [<c01193f0>] default_wake_function+0x0/0x20
 [<c01193f0>] default_wake_function+0x0/0x20
 [<c0109367>] syscall_call+0x7/0xb

Code: 8b 10 89 4a 04 89 53 0c 89 41 04 89 08 ff 04 24 ff 05 60 7d 
 <6>note: bash[729] exited with preempt_count 1
bad: scheduling while atomic!
Call Trace:
 [<c0119384>] schedule+0x564/0x570
 [<c0141bb3>] unmap_page_range+0x43/0x70
 [<c0141da8>] unmap_vmas+0x1c8/0x220
 [<c0145ce3>] exit_mmap+0x83/0x1a0
 [<c011ad85>] mmput+0x65/0xc0
 [<c011f0dd>] do_exit+0x12d/0x3b0
 [<c0109bb1>] die+0xe1/0xf0
 [<c0117564>] do_page_fault+0x1e4/0x4f6
 [<c01247dc>] __mod_timer+0xfc/0x170
 [<c011fdb0>] it_real_fn+0x0/0x70
 [<c011fe11>] it_real_fn+0x61/0x70
 [<c010ff66>] convert_fxsr_to_user+0xc6/0x160
 [<c01101be>] save_i387_fxsave+0xce/0x100
 [<c0117380>] do_page_fault+0x0/0x4f6
 [<c0109511>] error_code+0x2d/0x38
 [<c01688e5>] select_parent+0x55/0xc0
 [<c0168960>] shrink_dcache_parent+0x10/0x30
 [<c017dfd7>] proc_pid_flush+0x17/0x30
 [<c011ddee>] release_task+0x14e/0x1d0
 [<c011f6be>] wait_task_zombie+0x14e/0x1e0
 [<c011fb2a>] sys_wait4+0x23a/0x290
 [<c01193f0>] default_wake_function+0x0/0x20
 [<c01193f0>] default_wake_function+0x0/0x20
 [<c0109367>] syscall_call+0x7/0xb






===================== programs ===============







If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux grinch 2.6.0-test11 #1 Fri Nov 28 23:46:00 EET 2003 i686 unknown
 
Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
module-init-tools      0.9.9
e2fsprogs              1.32
jfsutils               1.1.4
reiserfsprogs          3.6.4
xfsprogs               2.3.5
quota-tools            3.08.
PPP                    2.4.1
nfs-utils              1.0.4
Dynamic linker (ldd)   2.3.1
Linux C++ Library      5.0.3
Procps                 3.1.8



--0-483187083-1070234388=:20640--
