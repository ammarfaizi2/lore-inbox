Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264919AbUISXVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbUISXVb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 19:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264917AbUISXVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 19:21:31 -0400
Received: from smtp5.intermedia.net ([64.78.61.32]:13318 "EHLO
	smtp5.intermedia.net") by vger.kernel.org with ESMTP
	id S264903AbUISXU5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 19:20:57 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: 2.6.8-r1 mem issues
Date: Sun, 19 Sep 2004 16:20:48 -0700
Message-ID: <0FC82FC6709BE34CB9118EE0E252FD2307994E70@ehost007.exch005intermedia.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.8-r1 mem issues
Thread-Index: AcSen0wiFlrLa62iQD2cX1kfQ5cjCA==
From: "Max Michaels" <mmichaels@rightmedia.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Sep 2004 23:20:56.0831 (UTC) FILETIME=[50F308F0:01C49E9F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is my first post, so please be forgiving of any faux-pas. I am
having issues with 2.6.8-r1 with memory being eaten by the kernel. Top
reveals that only about 35% of the memory (3GB) is being used but the
actual count of free memory is only about 10MB. /proc/slabinfo shows no
odd numbers and /proc/meminfo shows the same 10MB as the top total. No
processes account for this memory, so I'm assuming it must be the
kernel. Eventually, I run out of memory and OOM-killer starts killing
processes until it has some memory. Is there some troubleshooting method
I am missing or is this a known issue?

Please personally CC me on any response.

.config:

CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_THERMAL=y
CONFIG_AUTOFS4_FS=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SVWKS=y
CONFIG_BONDING=m
CONFIG_CHR_DEV_SG=y
CONFIG_CLEAN_COMPILE=y
CONFIG_CRC32=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_MD5=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_EARLY_PRINTK=y
CONFIG_EPOLL=y
CONFIG_EXPERIMENTAL=y
CONFIG_EXPORTFS=y
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_FS_MBCACHE=y
CONFIG_FUSION=y
CONFIG_FUSION_MAX_SGE=40
CONFIG_FUTEX=y
CONFIG_FW_LOADER=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_HOTPLUG=y
CONFIG_HPET_TIMER=y
CONFIG_HW_CONSOLE=y
CONFIG_IDE=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_IDEDMA_AUTO=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_IDE_GENERIC=y
CONFIG_IDE_TASKFILE_IO=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_INET=y
CONFIG_INPUT=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_CFQ=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IP_MULTICAST=y
CONFIG_IRQBALANCE=y
CONFIG_ISA=y
CONFIG_ISO9660_FS=y
CONFIG_JBD=y
CONFIG_KALLSYMS=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KMOD=y
CONFIG_LBD=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_LOG_BUF_SHIFT=15
CONFIG_MMU=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODVERSIONS=y
CONFIG_MPENTIUM4=y
CONFIG_MSDOS_PARTITION=y
CONFIG_MTRR=y
CONFIG_NET=y
CONFIG_NETDEVICES=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
CONFIG_NLS=y
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_UTF8=y
CONFIG_NR_CPUS=4
CONFIG_OBSOLETE_MODPARM=y
CONFIG_PACKET=y
CONFIG_PC=y
CONFIG_PCI=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_NAMES=y
CONFIG_PCMCIA_PROBE=y
CONFIG_PM=y
CONFIG_PNP=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_RAMFS=y
CONFIG_REISERFS_FS=y
CONFIG_RPCSEC_GSS_KRB5=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_SCHED_SMT=y
CONFIG_SCSI=y
CONFIG_SCSI_MEGARAID=y
CONFIG_SCSI_PROC_FS=y
CONFIG_SCSI_QLA2XXX=y
CONFIG_SCSI_SPI_ATTRS=y
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_CORE=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SMP=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_SPEAKUP_DEFAULT="none"
CONFIG_STANDALONE=y
CONFIG_STOP_MACHINE=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_SWAP=y
CONFIG_SYSCTL=y
CONFIG_SYSFS=y
CONFIG_SYSVIPC=y
CONFIG_TIGON3=y
CONFIG_TMPFS=y
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y
CONFIG_UID16=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_USB_PRINTER=y
CONFIG_USB_STORAGE=y
CONFIG_USB_UHCI_HCD=y
CONFIG_VGA_CONSOLE=y
CONFIG_VLAN_8021Q=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_X86=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_BSWAP=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_HT=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_INVLPG=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
CONFIG_X86_MPPARSE=y
CONFIG_X86_PC=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_SMP=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_X86_TSC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_XADD=y

/proc/cpuinfo:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 9
cpu MHz         : 2793.138
cache size      : 512 KB
physical id     : 0
siblings        : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5505.02

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 9
cpu MHz         : 2793.138
cache size      : 512 KB
physical id     : 0
siblings        : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5570.56

/proc/meminfo:

MemTotal:      3115448 kB
MemFree:       2452844 kB
Buffers:         18404 kB
Cached:          74144 kB
SwapCached:          0 kB
Active:         612100 kB
Inactive:        10296 kB
HighTotal:     2228060 kB
HighFree:      1622720 kB
LowTotal:       887388 kB
LowFree:        830124 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:         536484 kB
Slab:            29800 kB
Committed_AS:   864432 kB
PageTables:       1612 kB
VmallocTotal:   114680 kB
VmallocUsed:       900 kB
VmallocChunk:   113780 kB

/proc/slabinfo:

rpc_buffers            8      8   2048    2    1 : tunables   24   12
8 : slabdata      4      4      0
rpc_tasks              8     15    256   15    1 : tunables  120   60
8 : slabdata      1      1      0
rpc_inode_cache       10     14    512    7    1 : tunables   54   27
8 : slabdata      2      2      0
unix_sock             20     42    512    7    1 : tunables   54   27
8 : slabdata      5      6      0
tcp_tw_bucket       1581   1581    128   31    1 : tunables  120   60
8 : slabdata     51     51    120
tcp_bind_bucket      109    226     16  226    1 : tunables  120   60
8 : slabdata      1      1      0
tcp_open_request     111    183     64   61    1 : tunables  120   60
8 : slabdata      3      3      0
inet_peer_cache        6     61     64   61    1 : tunables  120   60
8 : slabdata      1      1      0
ip_fib_hash           10    226     16  226    1 : tunables  120   60
8 : slabdata      1      1      0
ip_dst_cache       54300  54300    256   15    1 : tunables  120   60
8 : slabdata   3620   3620      0
arp_cache             12     15    256   15    1 : tunables  120   60
8 : slabdata      1      1      0
raw4_sock              0      0    512    7    1 : tunables   54   27
8 : slabdata      0      0      0
udp_sock               2      8    512    8    1 : tunables   54   27
8 : slabdata      1      1      0
tcp_sock             806    854   1152    7    2 : tunables   24   12
8 : slabdata    122    122     96
flow_cache             0      0    128   31    1 : tunables  120   60
8 : slabdata      0      0      0
uhci_urb_priv          0      0     44   88    1 : tunables  120   60
8 : slabdata      0      0      0
scsi_cmd_cache         1     10    384   10    1 : tunables   54   27
8 : slabdata      1      1      0
udf_inode_cache        0      0    384   10    1 : tunables   54   27
8 : slabdata      0      0      0
nfs_write_data        36     42    512    7    1 : tunables   54   27
8 : slabdata      6      6      0
nfs_read_data         32     35    512    7    1 : tunables   54   27
8 : slabdata      5      5      0
nfs_inode_cache        2     12    640    6    1 : tunables   54   27
8 : slabdata      2      2      0
nfs_page               0      0    128   31    1 : tunables  120   60
8 : slabdata      0      0      0
isofs_inode_cache      0      0    384   10    1 : tunables   54   27
8 : slabdata      0      0      0
ext2_inode_cache       0      0    512    7    1 : tunables   54   27
8 : slabdata      0      0      0
journal_handle         0      0     28  135    1 : tunables  120   60
8 : slabdata      0      0      0
journal_head           7     81     48   81    1 : tunables  120   60
8 : slabdata      1      1      0
revoke_table           2    290     12  290    1 : tunables  120   60
8 : slabdata      1      1      0
revoke_record          0      0     16  226    1 : tunables  120   60
8 : slabdata      0      0      0
ext3_inode_cache    3654   3675    512    7    1 : tunables   54   27
8 : slabdata    525    525      0
ext3_xattr             0      0     48   81    1 : tunables  120   60
8 : slabdata      0      0      0
reiser_inode_cache     88     98    512    7    1 : tunables   54   27
8 : slabdata     14     14      0
eventpoll_pwq        693    749     36  107    1 : tunables  120   60
8 : slabdata      7      7      0
eventpoll_epi        701    744    128   31    1 : tunables  120   60
8 : slabdata     24     24     60
kioctx                 0      0    256   15    1 : tunables  120   60
8 : slabdata      0      0      0
kiocb                  0      0    128   31    1 : tunables  120   60
8 : slabdata      0      0      0
dnotify_cache          0      0     20  185    1 : tunables  120   60
8 : slabdata      0      0      0
file_lock_cache        4     41     96   41    1 : tunables  120   60
8 : slabdata      1      1      0
fasync_cache           0      0     16  226    1 : tunables  120   60
8 : slabdata      0      0      0
shmem_inode_cache      8     14    512    7    1 : tunables   54   27
8 : slabdata      2      2      0
posix_timers_cache      0      0    104   38    1 : tunables  120   60
8 : slabdata      0      0      0
uid_cache              5    119     32  119    1 : tunables  120   60
8 : slabdata      1      1      0
sgpool-128            32     32   2048    2    1 : tunables   24   12
8 : slabdata     16     16      0
sgpool-64             32     32   1024    4    1 : tunables   54   27
8 : slabdata      8      8      0
sgpool-32             32     32    512    8    1 : tunables   54   27
8 : slabdata      4      4      0
sgpool-16             32     45    256   15    1 : tunables  120   60
8 : slabdata      3      3      0
sgpool-8              32     62    128   31    1 : tunables  120   60
8 : slabdata      2      2      0
cfq_pool              64    119     32  119    1 : tunables  120   60
8 : slabdata      1      1      0
crq_pool               0      0     40   96    1 : tunables  120   60
8 : slabdata      0      0      0
deadline_drq           0      0     52   75    1 : tunables  120   60
8 : slabdata      0      0      0
as_arq                16     61     64   61    1 : tunables  120   60
8 : slabdata      1      1      0
blkdev_ioc            18    185     20  185    1 : tunables  120   60
8 : slabdata      1      1      0
blkdev_queue          20     32    464    8    1 : tunables   54   27
8 : slabdata      4      4      0
blkdev_requests       16     25    160   25    1 : tunables  120   60
8 : slabdata      1      1      0
biovec-(256)         256    256   3072    2    2 : tunables   24   12
8 : slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12
8 : slabdata     52     52      0
biovec-64            256    260    768    5    1 : tunables   54   27
8 : slabdata     52     52      0
biovec-16            256    270    256   15    1 : tunables  120   60
8 : slabdata     18     18      0
biovec-4             256    305     64   61    1 : tunables  120   60
8 : slabdata      5      5      0
biovec-1             256    452     16  226    1 : tunables  120   60
8 : slabdata      2      2      0
bio                  256    279    128   31    1 : tunables  120   60
8 : slabdata      9      9      0
sock_inode_cache     768    810    384   10    1 : tunables   54   27
8 : slabdata     81     81     54
skbuff_head_cache   1470   1710    256   15    1 : tunables  120   60
8 : slabdata    114    114    224
sock                   2     10    384   10    1 : tunables   54   27
8 : slabdata      1      1      0
proc_inode_cache    1293   1340    384   10    1 : tunables   54   27
8 : slabdata    134    134     13
sigqueue             135    135    148   27    1 : tunables  120   60
8 : slabdata      5      5      0
radix_tree_node     5313   5334    276   14    1 : tunables   54   27
8 : slabdata    381    381      0
bdev_cache             5     14    512    7    1 : tunables   54   27
8 : slabdata      2      2      0
mnt_cache             20     31    128   31    1 : tunables  120   60
8 : slabdata      1      1      0
inode_cache         1265   1300    384   10    1 : tunables   54   27
8 : slabdata    130    130      0
dentry_cache        7947   7992    144   27    1 : tunables  120   60
8 : slabdata    296    296     15
filp                1275   1275    256   15    1 : tunables  120   60
8 : slabdata     85     85     60
names_cache           25     25   4096    1    1 : tunables   24   12
8 : slabdata     25     25      0
idr_layer_cache       62     87    136   29    1 : tunables  120   60
8 : slabdata      3      3      0
buffer_head        13859  15300     52   75    1 : tunables  120   60
8 : slabdata    204    204      0
mm_struct            103    120    640    6    1 : tunables   54   27
8 : slabdata     20     20      0
vm_area_struct      1436   1645     84   47    1 : tunables  120   60
8 : slabdata     35     35      0
fs_cache              30    183     64   61    1 : tunables  120   60
8 : slabdata      3      3      0
files_cache           41     70    512    7    1 : tunables   54   27
8 : slabdata     10     10      0
signal_cache          53    155    128   31    1 : tunables  120   60
8 : slabdata      5      5      0
sighand_cache         62     90   1408    5    2 : tunables   24   12
8 : slabdata     18     18      0
task_struct           71    100   1440    5    2 : tunables   24   12
8 : slabdata     20     20      0
anon_vma             790    870     12  290    1 : tunables  120   60
8 : slabdata      3      3      0
pgd                   92     92   4096    1    1 : tunables   24   12
8 : slabdata     92     92      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4
0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4
0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4
0 : slabdata      0      0      0
size-65536             0      0  65536    1   16 : tunables    8    4
0 : slabdata      0      0      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4
0 : slabdata      0      0      0
size-32768             1      1  32768    1    8 : tunables    8    4
0 : slabdata      1      1      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4
0 : slabdata      0      0      0
size-16384             0      0  16384    1    4 : tunables    8    4
0 : slabdata      0      0      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4
0 : slabdata      0      0      0
size-8192             64     67   8192    1    2 : tunables    8    4
0 : slabdata     64     67      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12
8 : slabdata      0      0      0
size-4096             49     49   4096    1    1 : tunables   24   12
8 : slabdata     49     49      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12
8 : slabdata      0      0      0
size-2048            536    634   2048    2    1 : tunables   24   12
8 : slabdata    317    317     96
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27
8 : slabdata      0      0      0
size-1024            206    220   1024    4    1 : tunables   54   27
8 : slabdata     55     55     13
size-512(DMA)          0      0    512    8    1 : tunables   54   27
8 : slabdata      0      0      0
size-512            1116   1440    512    8    1 : tunables   54   27
8 : slabdata    180    180    108
size-256(DMA)          0      0    256   15    1 : tunables  120   60
8 : slabdata      0      0      0
size-256             156    900    256   15    1 : tunables  120   60
8 : slabdata     60     60      0
size-128(DMA)          0      0    128   31    1 : tunables  120   60
8 : slabdata      0      0      0
size-128             798   1302    128   31    1 : tunables  120   60
8 : slabdata     42     42      0
size-64(DMA)           0      0     64   61    1 : tunables  120   60
8 : slabdata      0      0      0
size-64             1460   4880     64   61    1 : tunables  120   60
8 : slabdata     80     80      0
size-32(DMA)           0      0     32  119    1 : tunables  120   60
8 : slabdata      0      0      0
size-32             1764   1904     32  119    1 : tunables  120   60
8 : slabdata     16     16     30
kmem_cache           135    135    256   15    1 : tunables  120   60
8 : slabdata      9      9      0


