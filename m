Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263518AbTDDKPe (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 05:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263522AbTDDKPe (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 05:15:34 -0500
Received: from ns2.i4gate.net ([195.95.38.150]:17392 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id S263518AbTDDKNj convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 05:13:39 -0500
From: DevilKin <devilkin-lkml@blindguardian.org>
To: linux-kernel@vger.kernel.org, Devilkin-lkml@blindguardian.org
Subject: [2.5.66] APM loses track of batteries
Date: Fri, 4 Apr 2003 12:16:55 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Description: clearsigned data
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200304041217.01030.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello List,

Hardware: Dell Latitude CPx J 650Mhz.

- From time to time, the klaptopdaemon that comes with KDE reports that no
batteries are present in my laptop, even when both are inserted:

devilkin@laptop:~$ cat /proc/apm
1.16ac 1.2 0x03 0x01 0xff 0x10 -1% -1 ?
devilkin@laptop:~$ apm
On-line

When removing one of the batteries and re-inserting it, apm seems to detect
that they are both there again:

devilkin@laptop:~$ cat /proc/apm
1.16ac 1.2 0x03 0x01 0x03 0x09 100% 478 min
devilkin@laptop:~$ apm
On-line, battery status high: 100% (7:58:00)

After a while, it seems to forget this again.

No messages can be found in the syslog.

The most annoying part is that the klaptopdaemon (which warns me if my battery
is to run out of juice) is also unable to warn me, and the laptop just dies
unexpectedly.

Any ideas?

Thanks!

- ---------------------------------------------------
PCI Listing:
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev
03)
	Flags: bus master, medium devsel, latency 32
	Memory at f4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev
03) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fc000000-feffffff

00:03.0 CardBus bridge: Texas Instruments PCI1225 (rev 01)
	Subsystem: Dell Computer Corporation: Unknown device 00bb
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00001000-000010ff
	I/O window 1: 00001400-000014ff
	16-bit legacy interface ports at 0001

00:03.1 CardBus bridge: Texas Instruments PCI1225 (rev 01)
	Subsystem: Dell Computer Corporation: Unknown device 00bb
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00001800-000018ff
	I/O window 1: 00001c00-00001cff
	16-bit legacy interface ports at 0001

00:07.0 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
	Flags: bus master, medium devsel, latency 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if
80 [Master])
	Flags: bus master, medium devsel, latency 32
	I/O ports at 0860 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if
00 [UHCI])
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at dce0 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
	Flags: medium devsel, IRQ 9

00:08.0 Multimedia audio controller: ESS Technology ES1983S Maestro-3i PCI
Audio Accelerator (rev 10)
	Subsystem: Dell Computer Corporation: Unknown device 00bb
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at d800 [size=256]
	Memory at faffe000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [c0] Power Management version 2

01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M AGP
2x (rev 64) (prog-if 00 [VGA])
	Subsystem: Dell Computer Corporation: Unknown device 00bb
	Flags: bus master, stepping, medium devsel, latency 32, IRQ 11
	Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	I/O ports at ec00 [size=256]
	Memory at fcfff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 1.0
	Capabilities: [5c] Power Management version 1

02:00.0 Ethernet controller: 3Com Corporation 3c575 [Megahertz] 10/100 LAN
CardBus (rev 01)
	Subsystem: 3Com Corporation 3C575 Megahertz 10/100 LAN Cardbus PC Card
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at 1000 [size=128]
	Memory at 10800000 (32-bit, non-prefetchable) [size=128]
	Memory at 10800080 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at 10400000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 1

- ---------------------------------------------------
Kernel configuration:

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

CONFIG_EXPERIMENTAL=y

CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14

CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y

CONFIG_X86_PC=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_PREFETCH=y
CONFIG_PREEMPT=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_I8K=y
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

CONFIG_PM=y

CONFIG_APM=m
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_RTC_IS_GMT=y

CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=y

CONFIG_X86_SPEEDSTEP=m

CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
CONFIG_HOTPLUG=y

CONFIG_PCMCIA=m
CONFIG_CARDBUS=y
CONFIG_I82092=m
CONFIG_I82365=m
CONFIG_TCIC=m

CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m

CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_1284=y

CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m

CONFIG_IDE=y

CONFIG_BLK_DEV_IDE=y

CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y

CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y

CONFIG_SCSI=m

CONFIG_BLK_DEV_SD=m

CONFIG_SCSI_REPORT_LUNS=y

CONFIG_NET=y

CONFIG_PACKET=y
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
CONFIG_XFRM_USER=y

CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_LOCAL=y
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m

CONFIG_IPV6_SCTP__=y

CONFIG_NETDEVICES=y

CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m

CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m

CONFIG_NET_PCMCIA=y

CONFIG_IRDA=m

CONFIG_IRLAN=m
CONFIG_IRNET=m
CONFIG_IRCOMM=m

CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
CONFIG_IRDA_DEBUG=y

CONFIG_IRTTY_SIR=m

CONFIG_IRPORT_SIR=m

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
CONFIG_MOUSE_SERIAL=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y

CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y

CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CS=m

CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_RTC=m

CONFIG_AGP=m
CONFIG_AGP_INTEL=m

CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
CONFIG_MINIX_FS=m

CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_UDF_FS=m

CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_NTFS_FS=m

CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y

CONFIG_NFS_FS=m
CONFIG_NFSD=m
CONFIG_LOCKD=m
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
CONFIG_SMB_FS=m

CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

CONFIG_NLS_DEFAULT="iso8859-15"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_UTF8=m

CONFIG_FB=y
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y

CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

CONFIG_SOUND=m

CONFIG_SOUND_PRIME=m
CONFIG_SOUND_MAESTRO3=m

CONFIG_USB=m

CONFIG_USB_DEVICEFS=y

CONFIG_USB_UHCI_HCD=m

CONFIG_USB_STORAGE=m

CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_VISOR=m

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_KALLSYMS=y

CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m

CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_X86_BIOS_REBOOT=y
- ---------------------------------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+jVuZpuyeqyCEh60RAkZlAJ943RiTHp0HDpiDlfAYB6uGvysusgCfbDwB
7jeeuV9xSLdCJB2GJfvZUSc=
=NOQE
-----END PGP SIGNATURE-----

