Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266616AbUITOes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266616AbUITOes (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 10:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266619AbUITOes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 10:34:48 -0400
Received: from smtp5.intermedia.net ([64.78.61.32]:15700 "EHLO
	smtp5.intermedia.net") by vger.kernel.org with ESMTP
	id S266616AbUITOdx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 10:33:53 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: 2.6.8.1 memory issues
Date: Mon, 20 Sep 2004 07:33:48 -0700
Message-ID: <0FC82FC6709BE34CB9118EE0E252FD2307994F2E@ehost007.exch005intermedia.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.8.1 memory issues
Thread-Index: AcSfHtdQPkZCbAaKST+yUk1DrtI44Q==
From: "Max Michaels" <mmichaels@rightmedia.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 Sep 2004 14:33:52.0136 (UTC) FILETIME=[D9934880:01C49F1E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I posted this issue yesterday but now I've seen it happen on 4 servers
in exactly the same manor. Just curious if anyone else has seen it.

I am having issues with 2.6.8-r1 with memory being eaten by the kernel.
Top reveals that only about 35% of the memory (3GB) is being used but
the actual count of free memory is only about 10MB. /proc/slabinfo shows
no odd numbers and /proc/meminfo shows the same 10MB as the top total.
No processes account for this memory, so I'm assuming it must be the
kernel. Eventually, I run out of memory and OOM-killer starts killing
processes until it frees up some memory (about 250MB each time) and then
gets in an endless cycle of doing this until rebooted. Is there some
troubleshooting method I am missing or is this a known issue?

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

Dmesg:

Calibrating delay loop... 5505.02 BogoMIPS Mount-cache hash table
entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09 per-CPU timeslice
cutoff: 1462.56 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000040 ESR value after enabling
vector: 00000000 Booting processor 1/6 eip 2000 Initializing CPU#1
masked ExtINT on CPU#1 ESR value before enabling vector: 00000000 ESR
value after enabling vector: 00000000 Calibrating delay loop... 5570.56
BogoMIPS
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09 Total of 2 processors
activated (11075.58 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 9-0, 9-1, 9-2, 9-3, 9-4, 9-5, 9-6, 9-7, 9-8, 9-9,
9-10, 9-11, 9-12, 9-13, 9-14, 9-15, 10-0, 10-1, 10-2, 10-3, 10-4, 10-5,
10-6, 10-7, 10-8, 10-9, 10-10, 10-11, 10-12, 10-13, 10-14, 10-15 not
connected.
..TIMER: vector=0x31 pin1=0 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2791.0474 MHz.
..... host bus clock speed is 132.0927 MHz.
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
CPU0:  online
 domain 0: span 1
  groups: 1
  domain 1: span 3
   groups: 1 2
CPU1:  online
 domain 0: span 2
  groups: 2
  domain 1: span 3
   groups: 2 1
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfc91e, last bus=4
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:0f.1
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Root Bridge [PCI4] (00:04)
PCI: Probing PCI hardware (bus 04)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI4._PRT]
ACPI: PCI Root Bridge [PCI3] (00:03)
PCI: Probing PCI hardware (bus 03)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI3._PRT]
ACPI: PCI Root Bridge [PCI2] (00:02)
PCI: Probing PCI hardware (bus 02)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI2._PRT]
ACPI: PCI Root Bridge [PCI1] (00:01)
PCI: Probing PCI hardware (bus 01)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI1._PRT]
ACPI: PCI Interrupt Link [LNK0] (IRQs 4 5 6 *7 9 10 11 12)
ACPI: PCI Interrupt Link [LNK1] (IRQs 4 *5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNK2] (IRQs 4 5 6 *7 9 10 11 12)
ACPI: PCI Interrupt Link [LNK3] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNK6] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNK7] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNK8] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNK9] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKA] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LN10] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LN11] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LN12] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LN13] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LN14] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LN15] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LN16] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LN17] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LN18] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LN19] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LN1A] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LN1B] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LN1C] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LN1D] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LN1E] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LN1F] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LUSB] (IRQs 4 5 6 7 10 *11 12) Linux Plug and
Play Support v0.97 (c) Adam Belay SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LUSB] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:0f.2[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:04:03.0[A] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI interrupt 0000:02:00.1[B] -> GSI 17 (level, low) -> IRQ 17
number of MP IRQ sources: 16.
number of IO-APIC #8 registers: 16.
number of IO-APIC #9 registers: 16.
number of IO-APIC #10 registers: 16.
testing the IO APIC.......................
IO APIC #8......
.... register #00: 08000000
.......    : physical APIC id: 08
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 08000000
.......     : arbitration: 08
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 003 03  0    0    0   0   0    1    1    31
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  1    0    0   0   0    1    1    41
 03 003 03  0    0    0   0   0    1    1    49
 04 003 03  0    0    0   0   0    1    1    51
 05 003 03  0    0    0   0   0    1    1    59
 06 003 03  0    0    0   0   0    1    1    61
 07 003 03  0    0    0   0   0    1    1    69
 08 003 03  0    0    0   0   0    1    1    71
 09 003 03  0    1    0   1   0    1    1    79
 0a 003 03  0    0    0   0   0    1    1    81
 0b 003 03  1    1    0   1   0    1    1    89
 0c 003 03  0    0    0   0   0    1    1    91
 0d 003 03  0    0    0   0   0    1    1    99
 0e 003 03  0    0    0   0   0    1    1    A1
 0f 003 03  0    0    0   0   0    1    1    A9
IO APIC #9......
.... register #00: 09000000
.......    : physical APIC id: 09
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 09000000
.......     : arbitration: 09
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 003 03  1    1    0   1   0    1    1    B9
 01 003 03  1    1    0   1   0    1    1    C1
 02 003 03  1    1    0   1   0    1    1    B1
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
IO APIC #10......
.... register #00: 0A000000
.......    : physical APIC id: 0A
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 0A000000
.......     : arbitration: 0A
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ2 -> 0:2
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 1:0
IRQ17 -> 1:1
IRQ18 -> 1:2
.................................... done.
Machine check exception polling timer started.
Starting balanced_irq
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
ACPI: Processor [CPU1] (supports C1)
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing
disabled ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A Using anticipatory io
scheduler Floppy drive(s): fd0 is 1.44M FDC 0 is a National
Semiconductor PC87306 RAMDISK driver initialized: 16 RAM disks of 4096K
size 1024 blocksize
tg3.c:v3.8 (July 14, 2004)
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
eth0: Tigon3 [partno(BCM95704A6) rev 2002 PHY(5704)]
(PCIX:133MHz:64-bit) 10/100/1000BaseT Ethernet 00:0b:db:94:e4:e1
eth0: HostTXDS[1] RXcsums[1] LinkChgREG[1] MIirq[1] ASF[0] Split[0]
WireSpeed[1] TSOcap[1]
ACPI: PCI interrupt 0000:02:00.1[B] -> GSI 17 (level, low) -> IRQ 17
eth1: Tigon3 [partno(BCM95704A6) rev 2002 PHY(5704)]
(PCIX:133MHz:64-bit) 10/100/1000BaseT Ethernet 00:0b:db:94:e4:e2
eth1: HostTXDS[1] RXcsums[1] LinkChgREG[1] MIirq[1] ASF[0] Split[0]
WireSpeed[1] TSOcap[1] Uniform Multi-Platform E-IDE driver Revision:
7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx SvrWks CSB5: IDE controller at PCI slot 0000:00:0f.1 SvrWks
CSB5: chipset revision 147 SvrWks CSB5: not 100% native mode: will probe
irqs later SvrWks CSB5: simplex device: DMA forced
    ide0: BM-DMA at 0x08b0-0x08b7, BIOS settings: hda:pio, hdb:pio
SvrWks CSB5: simplex device: DMA forced
    ide1: BM-DMA at 0x08b8-0x08bf, BIOS settings: hdc:DMA, hdd:pio
hdc: SAMSUNG CD-ROM SN-124, ATAPI CD/DVD-ROM drive
hdc: Disabling (U)DMA for SAMSUNG CD-ROM SN-124 (blacklisted)
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 24X CD-ROM drive, 128kB Cache Uniform CD-ROM driver Revision:
3.20
ACPI: PCI interrupt 0000:04:03.0[A] -> GSI 18 (level, low) -> IRQ 18
megaraid: found 0x1028:0x000f:bus 4:slot 3:func 0 scsi0:Found MegaRAID
controller at 0xf8829000, IRQ:18
megaraid: [4.10:B111] detected 1 logical drives.
megaraid: supports extended CDBs.
megaraid: channel[0] is raid.
megaraid: channel[1] is raid.
scsi0 : LSI Logic MegaRAID 4.10 254 commands 16 targs 5 chans 7 luns
scsi0: scanning scsi channel 0 for logical drives.
  Vendor: MegaRAID  Model: LD 0 RAID5  139G  Rev: 4.10
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0: scanning scsi channel 1 for logical drives.
scsi0: scanning scsi channel 2 for logical drives.
scsi0: scanning scsi channel 4 [P0] for physical devices.
  Vendor: PE/PV     Model: 1x3 SCSI BP       Rev: 1.1 
  Type:   Processor                          ANSI SCSI revision: 02
scsi0: scanning scsi channel 5 [P1] for physical devices.
SCSI device sda: 285728768 512-byte hdwr sectors (146293 MB)
sda: asking for cache data failed
sda: assuming drive cache: write through
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0 Attached scsi
generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0 Attached scsi
generic sg1 at scsi0, channel 4, id 6, lun 0,  type 3 Fusion MPT base
driver 3.01.09 Copyright (c) 1999-2004 LSI Logic Corporation Fusion MPT
SCSI Host driver 3.01.09 USB Universal Host Controller Interface driver
v2.2
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage USB Mass Storage support
registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
NET: Registered protocol family 2
IP: routing cache hash table of 32768 buckets, 256Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com> All bugs
added by David S. Miller <davem@redhat.com>
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: sda2: orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 99228
EXT3-fs: sda2: 1 orphan inode deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 164k freed
EXT3 FS on sda2, internal journal
ReiserFS: sda3: found reiserfs format "3.6" with standard journal
ReiserFS: sda3: using ordered data mode
ReiserFS: sda3: journal params: device sda3, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: sda3: checking transaction log (sda3)
ReiserFS: sda3: Using r5 hash to sort names
tg3: eth0: Link is up at 1000 Mbps, full duplex.
tg3: eth0: Flow control is off for TX and off for RX.
nfs warning: mount version older than kernel nfs warning: mount version
older than kernel

lspci -v

0000:00:00.0 Host bridge: ServerWorks CMIC-LE Host Bridge (GC-LE
chipset) (rev 33)
        Flags: fast devsel

0000:00:00.1 Host bridge: ServerWorks CMIC-LE Host Bridge (GC-LE
chipset)
        Flags: fast devsel

0000:00:00.2 Host bridge: ServerWorks CMIC-LE Host Bridge (GC-LE
chipset)
        Flags: fast devsel

0000:00:0e.0 VGA compatible controller: ATI Technologies Inc Rage XL
(rev 27) (prog-if 00 [VGA])
        Subsystem: Dell: Unknown device 014a
        Flags: bus master, VGA palette snoop, stepping, medium devsel,
latency 32
        Memory at fd000000 (32-bit, non-prefetchable)
        I/O ports at ec00 [size=256]
        Memory at fe101000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [5c] Power Management version 2

0000:00:0f.0 Host bridge: ServerWorks CSB5 South Bridge (rev 93)
        Subsystem: ServerWorks CSB5 South Bridge
        Flags: bus master, medium devsel, latency 32

0000:00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93)
(prog-if 8a [Master SecP PriP])
        Subsystem: Dell: Unknown device 014a
        Flags: bus master, medium devsel, latency 64
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at 08b0 [size=16]

0000:00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller
(rev 05) (prog-if 10 [OHCI])
        Subsystem: ServerWorks OSB4/CSB5 OHCI USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 11
        Memory at fe100000 (32-bit, non-prefetchable)

0000:00:0f.3 ISA bridge: ServerWorks CSB5 LPC bridge
        Subsystem: ServerWorks: Unknown device 0230
        Flags: bus master, medium devsel, latency 0

0000:00:10.0 Host bridge: ServerWorks CIOB-E I/O Bridge with Gigabit
Ethernet (rev 12)
        Flags: 66Mhz, medium devsel
        Capabilities: [60]
0000:00:10.2 Host bridge: ServerWorks CIOB-E I/O Bridge with Gigabit
Ethernet (rev 12)
        Flags: 66Mhz, medium devsel
        Capabilities: [60]
0000:00:11.0 Host bridge: ServerWorks CIOB-X2 PCI-X I/O Bridge (rev 05)
        Flags: 66Mhz, medium devsel
        Capabilities: [60]
0000:00:11.2 Host bridge: ServerWorks CIOB-X2 PCI-X I/O Bridge (rev 05)
        Flags: 66Mhz, medium devsel
        Capabilities: [60]
0000:02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704
Gigabit Ethernet (rev 02)
        Subsystem: Dell: Unknown device 014a
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 16
        Memory at fcf30000 (64-bit, non-prefetchable)
        Memory at fcf20000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40]      Capabilities: [48] Power Management
version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+
Queue=0/3 Enable-

0000:02:00.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704
Gigabit Ethernet (rev 02)
        Subsystem: Dell: Unknown device 014a
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 17
        Memory at fcf10000 (64-bit, non-prefetchable)
        Memory at fcf00000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40]      Capabilities: [48] Power Management
version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+
Queue=0/3 Enable-

0000:04:03.0 RAID bus controller: Dell PowerEdge Expandable RAID
controller 4/Di (rev 02)
        Subsystem: Dell: Unknown device 014a
        Flags: bus master, stepping, 66Mhz, medium devsel, latency 32,
IRQ 18
        Memory at f0000000 (32-bit, prefetchable) [size=fcc00000]
        Memory at fcd00000 (32-bit, non-prefetchable) [size=256K]
        Expansion ROM at 00008000 [disabled]
        Capabilities: [c0] Power Management version 2
        Capabilities: [d0] Message Signalled Interrupts: 64bit+
Queue=0/1 Enable-
        Capabilities: [e0] PCI-X non-bridge device.
