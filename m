Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030251AbWEELf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbWEELf0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 07:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbWEELf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 07:35:26 -0400
Received: from mra05.ch.as12513.net ([82.153.254.73]:37787 "EHLO
	mra05.ch.as12513.net") by vger.kernel.org with ESMTP
	id S1750727AbWEELfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 07:35:25 -0400
Date: Fri, 5 May 2006 12:35:14 +0100
From: Martin Habets <errandir_news@mph.eclipse.co.uk>
To: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: sparc: cannot load any modules with 2.6.17-rc3
Message-ID: <20060505113514.GA28863@palantir8>
Mail-Followup-To: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to boot 2.6.17-rc3 on my SS20 I get this error for every
module it tries to load:
  module crc32: Unknown relocation: 17

This worked okay on 2.6.16-rc2. Is anyone looking into this problem yet?
It's comming from a new type R_SPARC_PC22 in the ELF header. Any idea
what could be causing this? Is it intentional or a bug?

I've attached my dmesg output and the config. Please CC me as I'm not
subscribed to linux-kernel.

Thanks,
Martin
-------------------------
PROMLIB: Sun Boot Prom Version 3 Revision 2
Linux version 2.6.17-rc3-mph3 (opendev@palantir9) (gcc version 3.4.4 20050314 (prerelease) (Debian 3.4.3-13)) #7 Tue May 2 23:55:47 BST 2006
ARCH: SUN4M
TYPE: Sun4m SparcStation10/20
Ethernet address: 8:0:20:7c:37:74
Boot time fixup v1.6. 4/Mar/98 Jakub Jelinek (jj@ultra.linux.cz). Patching kernel for srmmu[TI Viking]/iommu
31MB HIGHMEM available.
On node 0 totalpages: 15659
  DMA zone: 7656 pages, LIFO batch:0
  HighMem zone: 8003 pages, LIFO batch:0
Power off control detected.
Built 1 zonelists
Kernel command line: root=/dev/sdb5
PID hash table entries: 128 (order: 7, 512 bytes)
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 56440k/64780k available (1424k kernel code, 8340k reserved, 472k data, 100k init, 32012k highmem)
Calibrating delay loop... 49.86 BogoMIPS (lpj=249344)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
SCSI subsystem initialized
IOMMU: impl 1 vers 3 table 0xf0880000[262144 B] map [65536 b]
sbus0: Clock 25.0 MHz
dma0: Revision 2 
dma1: Revision 2 
ioremap: done with statics, switching to malloc
dma2: ESC Revision 1 
highmem bounce pool size: 64 pages
Initializing Cryptographic API
io scheduler noop registered
io scheduler deadline registered (default)
SunZilog: 2 chips.
zs2 at 0xfd015004 (irq = 44) is a SunZilog
zs3 at 0xfd015000 (irq = 44) is a SunZilog
ttyS0 at MMIO 0x0 (irq = 44) is a SunZilog
Console: ttyS0 (SunZilog zs0)
ttyS1 at MMIO 0x0 (irq = 44) is a SunZilog
esp0: IRQ 36 SCSI ID 7 Clk 40MHz CCYC=25000 CCF=8 TOut 167 NCR53C9XF(espfast)
esp1: IRQ 53 SCSI ID 7 Clk 40MHz CCYC=25000 CCF=8 TOut 167 NCR53C9XF(espfast)
ESP: Total of 2 ESP hosts found, 2 actually in use.
scsi0 : Sparc ESP100A-FAST
  Vendor: SEAGATE   Model: ST39173W SUN9.0G  Rev: 7063
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: ST32550W SUN2.1G  Rev: 0416
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi1 : Sparc ESP236-FAST
  Vendor: Quantum   Model: DLT4000           Rev: DA97
  Type:   Sequential-Access                  ANSI SCSI revision: 02
esp0: target 1 [period 100ns offset 15 10.00MHz FAST SCSI-II]
SCSI device sda: 17689267 512-byte hdwr sectors (9057 MB)
sda: Write Protect is off
sda: Mode Sense: cf 00 10 08
SCSI device sda: drive cache: write through w/ FUA
SCSI device sda: 17689267 512-byte hdwr sectors (9057 MB)
sda: Write Protect is off
sda: Mode Sense: cf 00 10 08
SCSI device sda: drive cache: write through w/ FUA
 sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8
sd 0:0:1:0: Attached scsi disk sda
esp0: target 3 [period 100ns offset 15 10.00MHz FAST SCSI-II]
SCSI device sdb: 4194995 512-byte hdwr sectors (2148 MB)
sdb: Write Protect is off
sdb: Mode Sense: ab 00 10 08
SCSI device sdb: drive cache: write through w/ FUA
SCSI device sdb: 4194995 512-byte hdwr sectors (2148 MB)
sdb: Write Protect is off
sdb: Mode Sense: ab 00 10 08
SCSI device sdb: drive cache: write through w/ FUA
 sdb: sdb1 sdb2 sdb3 sdb4 sdb5
sd 0:0:3:0: Attached scsi disk sdb
NET: Registered protocol family 2
IP route cache hash table entries: 512 (order: -1, 2048 bytes)
TCP established hash table entries: 2048 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 2048 bind 1024)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 100k freed
Adding 124632k swap on /dev/sdb2.  Priority:-1 extents:1 across:124632k
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on sdb5, internal journal
module crc32: Unknown relocation: 17
sunlance: Unknown symbol crc32_le
module soundcore: Unknown relocation: 17
snd: Unknown symbol sound_class
module openpromfs: Unknown relocation: 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on sdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
palantir9:~# modprobe st
module st: Unknown relocation: 17
FATAL: Error inserting st (/lib/modules/2.6.17-rc3-mph3/kernel/drivers/scsi/st.ko): Invalid module format

-------------------------
CONFIG_MMU=y
CONFIG_HIGHMEM=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_LOCALVERSION="-mph3"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_UID16=y
CONFIG_EMBEDDED=y
CONFIG_KALLSYMS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_BASE_SMALL=0
CONFIG_SLOB=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_KMOD=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_DEFAULT_DEADLINE=y
CONFIG_DEFAULT_IOSCHED="deadline"
CONFIG_SPARC=y
CONFIG_SPARC32=y
CONFIG_SBUS=y
CONFIG_SBUSCHAR=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_SUN_AUXIO=y
CONFIG_SUN_IO=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_GENERIC_FIND_NEXT_BIT=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_SUN_PM=y
CONFIG_SUN_OPENPROMFS=m
CONFIG_SPARC_LED=m
CONFIG_BINFMT_ELF=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_XFRM=y
CONFIG_XFRM_USER=m
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_FIB_HASH=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_TCP_CONG_BIC=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_ISCSI_TCP=m
CONFIG_SCSI_QLOGICPTI=m
CONFIG_SCSI_SUNESP=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
CONFIG_SUNLANCE=m
CONFIG_SERIO=y
CONFIG_SERIO_SERPORT=m
CONFIG_SERIO_RAW=m
CONFIG_SERIAL_SUNCORE=y
CONFIG_SERIAL_SUNZILOG=y
CONFIG_SERIAL_SUNZILOG_CONSOLE=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_SOUND=m
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_SUN_AMD7930=m
CONFIG_SND_SUN_CS4231=m
CONFIG_SND_SUN_DBRI=m
CONFIG_RTC_LIB=m
CONFIG_RTC_CLASS=m
CONFIG_RTC_INTF_SYSFS=m
CONFIG_RTC_INTF_PROC=m
CONFIG_RTC_INTF_DEV=m
CONFIG_SUN_OPENPROMIO=m
CONFIG_SUN_MOSTEK_RTC=m
CONFIG_UNIX98_PTY_COUNT=64
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_MINIX_FS=m
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_CRAMFS=m
CONFIG_UFS_FS=m
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=m
CONFIG_PARTITION_ADVANCED=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SUN_PARTITION=y
CONFIG_NLS=m
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_UNWIND_INFO=y
CONFIG_FORCED_INLINING=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_CRC32C=m
CONFIG_CRC_CCITT=m
CONFIG_CRC32=m
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
