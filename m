Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280889AbRKGSOS>; Wed, 7 Nov 2001 13:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280892AbRKGSON>; Wed, 7 Nov 2001 13:14:13 -0500
Received: from [209.195.52.30] ([209.195.52.30]:45320 "HELO [209.195.52.30]")
	by vger.kernel.org with SMTP id <S280889AbRKGSN5>;
	Wed, 7 Nov 2001 13:13:57 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Andreas Franck <Andreas.Franck@akustik.rwth-aachen.de>
Cc: linux-kernel@vger.kernel.org
Date: Wed, 7 Nov 2001 09:49:50 -0800 (PST)
Subject: Re: Linux-2.4.[10-13]-acX slows down to crawl...
In-Reply-To: <3BE95E9C.D62D372C@akustik.rwth-aachen.de>
Message-ID: <Pine.LNX.4.40.0111070948450.25917-200000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; boundary=------------DBCE66E0E0E7FCA73A7700A3
Content-ID: <Pine.LNX.4.40.0111070948451.25917@dlang.diginsite.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--------------DBCE66E0E0E7FCA73A7700A3
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-ID: <Pine.LNX.4.40.0111070948452.25917@dlang.diginsite.com>

are you useing iptables or ipchains on this box?

I see you have them compiled as modules

David Lang

On Wed, 7 Nov 2001, Andreas Franck wrote:

> Date: Wed, 07 Nov 2001 17:17:32 +0100
> From: Andreas Franck <Andreas.Franck@akustik.rwth-aachen.de>
> To: linux-kernel@vger.kernel.org
> Subject: Linux-2.4.[10-13]-acX slows down to crawl...
>
> Hello folks,
>
> since quite a time (it happens at least since 2.4.10-ac, and also
> happens with the newest -ac kernel 2.4.13-ac8), Linux gets slower
> and slower, to a state where it is basically unusable after some days.
> I suspect it is a VM issue, because it starts swapping without any
> need, not freeing buffers? The buffer sizes are about the size of RAM
> when it is worst. For anything done, the load goes up extremely, network
> access basically halts the machine then, leading to a load of about 20
> :-(
>
> It could be related to massive file access, because the machine
> mentioned here is a file server which is backed up by a TSM backup
> system every night.
>
> The configuration is attached.
>
> The machine is an AMD Athlon 1200 with 768 MB memory and 6 GB swap (2x2
> GB on IDE,
> 5x500 MB on SCSI.)
>
> In the state of worst performance, after about 4 to 5 days,
> /proc/slabinfo reports
> the following (hope that helps):
>
> slabinfo - version: 1.1 (statistics)
> kmem_cache            64     84    136    3    3    1 :     64
> 64     3    0    0
> ip_conntrack           0      0    356    0    0    1 :      0
> 0     0    0    0
> nfs_read_data          0      0    364    0    0    1 :      8
> 2678    14   14    0
> nfs_inode_cache        0     19    204    0    1    1 :     46
> 1131    17   16    0
> nfs_write_data         0      0    380    0    0    1 :      0
> 0     0    0    0
> nfs_page               0     43     88    0    1    1 :     16
> 4963     9    8    0
> tcp_tw_bucket         37     90    128    2    3    1 :    274
> 36207    69   66    0
> tcp_bind_bucket       94    144     24    1    1    1 :    150
> 67152     2    1    0
> tcp_open_request       0     42     92    0    1    1 :     17
> 54100    13   12    0
> inet_peer_cache       21     77     48    1    1    1 :     43
> 3475     1    0    0
> ip_fib_hash           14    144     24    1    1    1 :     14
> 32     1    0    0
> ip_dst_cache         268    288    164   12   12    1 :    330
> 38687    47   35    0
> arp_cache             19     32    120    1    1    1 :     66
> 2691     7    6    0
> blkdev_requests    13824  13840     96  346  346    1 :  15360   16896
> 384   38    0
> journal_head           0      0     56    0    0    1 :      0
> 0     0    0    0
> revoke_table           0      0     20    0    0    1 :      0
> 0     0    0    0
> revoke_record          0      0     24    0    0    1 :      0
> 0     0    0    0
> dnotify cache          0      0     28    0    0    1 :      0
> 0     0    0    0
> file lock cache      149    195    100    5    5    1 :    187
> 11840518    11    6    0
> fasync cache           1    144     24    1    1    1 :      1
> 4     1    0    0
> uid_cache             12    112     32    1    1    1 :     14
> 3635     1    0    0
> skbuff_head_cache    249    414    172   18   18    1 :    424
> 7653    22    4    0
> sock                 290    297   1280   98   99    1 :    303  500247
> 273  174    0
> sigqueue               2     27    140    1    1    1 :     14
> 1826655747     5    4    0
> kiobuf                 0      0   8768    0    0    4 :      0
> 0     0    0    0
> cdev_cache            22    154     48    2    2    1 :   1321   40937
> 144  142    0
> bdev_cache            46     62     60    1    1    1 :     46
> 56     1    0    0
> mnt_cache             35     56     68    1    1    1 :     46
> 1669     1    0    0
> inode_cache        14342  15201    436 1616 1689    1 : 363042 13753900
> 519587    0    0
> dentry_cache        9974   9999    116  303  303    1 : 366153 14162633
> 283038    0    0
> dquot                  0      0    128    0    0    1 :      0
> 0     0    0    0
> filp                1785   1813    104   49   49    1 :   1785
> 1785    49    0    0
> names_cache            0      4   4096    0    4    1 :      7
> 23027673    24   20    0
> buffer_head       133028 158804    104 4281 4292    1 : 165666 3638425
> 5772 1480    0
> mm_struct            100    135    144    4    5    1 :    112
> 237718     7    2    0
> vm_area_struct      4426   4929     72   89   93    1 :   7999
> 10699944   426  333    0
> fs_cache              99    168     44    2    2    1 :    112
> 237733     4    2    0
> files_cache           99    117    424   12   13    1 :    112
> 237733    26   13    0
> signal_act           118    129   1344   40   43    1 :    131
> 237736    89   46    0
> size-131072(DMA)       0      0 131072    0    0   32 :      0
> 0     0    0    0
> size-131072            0      0 131072    0    0   32 :      0
> 0     0    0    0
> size-65536(DMA)        0      0  65536    0    0   16 :      0
> 0     0    0    0
> size-65536             0      0  65536    0    0   16 :      2
> 2     2    2    0
> size-32768(DMA)        0      0  32768    0    0    8 :      0
> 0     0    0    0
> size-32768             0      4  32768    0    4    8 :      4
> 62219    45   41    0
> size-16384(DMA)        0      0  16384    0    0    4 :      0
> 0     0    0    0
> size-16384            10     14  16384   10   14    4 :     22
> 96805    81   67    0
> size-8192(DMA)         0      0   8192    0    0    2 :      0
> 0     0    0    0
> size-8192              2      9   8192    2    9    2 :     15
> 241476    64   55    0
> size-4096(DMA)         0      0   4096    0    0    1 :      0
> 0     0    0    0
> size-4096            113    126   4096  113  126    1 :    165  949399
> 366  240    0
> size-2048(DMA)         0      0   2048    0    0    1 :      0
> 0     0    0    0
> size-2048             91    128   2048   48   64    1 :    303
> 10333059   649  585    0
> size-1024(DMA)         0      0   1024    0    0    1 :      0
> 0     0    0    0
> size-1024            593    612   1024  149  153    1 :    711 4143987
> 278  125    0
> size-512(DMA)          0      0    512    0    0    1 :      0
> 0     0    0    0
> size-512             240    272    512   31   34    1 :    362
> 3942755    52   18    0
> size-256(DMA)          0      0    264    0    0    1 :      0
> 0     0    0    0
> size-256             123    240    264   13   16    1 :    470
> 16220336    85   69    0
> size-128(DMA)          0      0    136    0    0    1 :      0
> 0     0    0    0
> size-128            4295   4424    136  154  158    1 :   9596 7016611
> 913  755    0
> size-64(DMA)           0      0     72    0    0    1 :      0
> 0     0    0    0
> size-64            35785  35828     72  676  676    1 :  35785
> 21089808   969  293    0
> size-32(DMA)           0      0     40    0    0    1 :      0
> 0     0    0    0
> size-32             1625   1820     40   19   20    1 :  45706 52785063
> 1460 1440    0
>
>
> Any hints on this?
>
> Greetings,
> Andreas
>
>


--------------DBCE66E0E0E7FCA73A7700A3
Content-Type: TEXT/PLAIN; charset=us-ascii; name=config
Content-ID: <Pine.LNX.4.40.0111070948453.25917@dlang.diginsite.com>
Content-Description: 
Content-Disposition: inline; filename=config

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y
# CONFIG_GENERIC_BUST_SPINLOCK is not set
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_TOSHIBA is not set
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
# CONFIG_HOTPLUG_PCI is not set
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
# CONFIG_PM is not set
# CONFIG_ACPI is not set
# CONFIG_APM is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
CONFIG_PNP=y
# CONFIG_ISAPNP is not set
CONFIG_PNPBIOS=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=y
# CONFIG_MD_MULTIPATH is not set
CONFIG_BLK_DEV_LVM=y

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK_DEV=m
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=y
CONFIG_UNIX=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK=y
# CONFIG_IP_MULTIPLE_TABLES is not set
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_LARGE_TABLES=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
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

#
#   IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
CONFIG_KHTTPD=m
# CONFIG_ATM is not set

#
#  
#
CONFIG_IPX=m
# CONFIG_IPX_INTERN is not set
CONFIG_ATALK=y
CONFIG_DECNET=m
# CONFIG_DECNET_SIOCGIFCONF is not set
# CONFIG_DECNET_ROUTER is not set
CONFIG_BRIDGE=m
CONFIG_X25=m
CONFIG_LAPB=m
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
CONFIG_ECONET=m
CONFIG_ECONET_AUNUDP=y
CONFIG_ECONET_NATIVE=y
CONFIG_WAN_ROUTER=m
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_CSZ=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_INGRESS=m
# CONFIG_NET_QOS is not set
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDETAPE=y
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDESCSI=y
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_IDEDMA_TIMEOUT is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_PIIX_TUNING is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set

#
# SCSI support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=y
CONFIG_CHR_DEV_OSST=y
CONFIG_BLK_DEV_SR=y
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_DEBUG_QUEUES is not set
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=31
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_DEBUG is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Appletalk devices
#
# CONFIG_APPLETALK is not set
# CONFIG_LTPC is not set
# CONFIG_COPS is not set
# CONFIG_IPDDP is not set
CONFIG_DUMMY=m
CONFIG_BONDING=m
CONFIG_EQUALIZER=m
CONFIG_TUN=m
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
CONFIG_HAPPYMEAL=m
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNLANCE is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
CONFIG_EL1=m
CONFIG_EL2=m
CONFIG_ELPLUS=m
CONFIG_EL16=m
CONFIG_EL3=m
CONFIG_3C515=m
# CONFIG_ELMC is not set
# CONFIG_ELMC_II is not set
CONFIG_VORTEX=m
CONFIG_LANCE=m
CONFIG_NET_VENDOR_SMC=y
CONFIG_WD80x3=m
# CONFIG_ULTRAMCA is not set
CONFIG_ULTRA=m
# CONFIG_ULTRA32 is not set
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
# CONFIG_LP486E is not set
CONFIG_ETH16I=m
CONFIG_NE2000=m
CONFIG_NET_PCI=y
CONFIG_PCNET32=m
CONFIG_ADAPTEC_STARFIRE=m
CONFIG_AC3200=m
CONFIG_APRICOT=m
CONFIG_CS89x0=m
CONFIG_TULIP=m
# CONFIG_TULIP_MWI is not set
# CONFIG_TULIP_MMIO is not set
CONFIG_DE4X5=m
CONFIG_DGRS=m
CONFIG_DM9102=m
CONFIG_EEPRO100=m
# CONFIG_LNE390 is not set
CONFIG_FEALNX=m
CONFIG_NATSEMI=m
CONFIG_NE2K_PCI=m
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
# CONFIG_8139CP is not set
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
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

#
# Ethernet (1000 Mbit)
#
CONFIG_ACENIC=m
# CONFIG_ACENIC_OMIT_TIGON_I is not set
# CONFIG_DL2K is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
CONFIG_HAMACHI=m
CONFIG_YELLOWFIN=m
CONFIG_SK98LIN=m
CONFIG_FDDI=y
CONFIG_DEFXX=m
CONFIG_SKFP=m
CONFIG_HIPPI=y
CONFIG_ROADRUNNER=m
# CONFIG_ROADRUNNER_LARGE_RINGS is not set
CONFIG_PLIP=m
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y
CONFIG_STRIP=m
CONFIG_WAVELAN=m
CONFIG_ARLAN=m
CONFIG_AIRONET4500=m
CONFIG_AIRONET4500_NONCS=m
CONFIG_AIRONET4500_PNP=y
CONFIG_AIRONET4500_PCI=y
# CONFIG_AIRONET4500_ISA is not set
# CONFIG_AIRONET4500_I365 is not set
CONFIG_AIRONET4500_PROC=m
# CONFIG_AIRO is not set
# CONFIG_HERMES is not set
# CONFIG_PLX_HERMES is not set
CONFIG_NET_WIRELESS=y

#
# Token Ring devices
#
CONFIG_TR=y
CONFIG_IBMTR=m
CONFIG_IBMOL=m
CONFIG_IBMLS=m
CONFIG_TMS380TR=m
CONFIG_TMSPCI=m
CONFIG_TMSISA=m
CONFIG_ABYSS=m
# CONFIG_MADGEMC is not set
CONFIG_SMCTR=m
CONFIG_NET_FC=y
CONFIG_IPHASE5526=m
CONFIG_RCPCI=m
CONFIG_SHAPER=m

#
# Wan interfaces
#
CONFIG_WAN=y
CONFIG_HOSTESS_SV11=m
CONFIG_COSA=m
CONFIG_COMX=m
CONFIG_COMX_HW_COMX=m
CONFIG_COMX_HW_LOCOMX=m
CONFIG_COMX_HW_MIXCOM=m
CONFIG_COMX_PROTO_PPP=m
CONFIG_COMX_PROTO_LAPB=m
CONFIG_COMX_PROTO_FR=m
CONFIG_DSCC4=m
# CONFIG_FARSYNC is not set
CONFIG_LANMEDIA=m
CONFIG_SEALEVEL_4021=m
CONFIG_SYNCLINK_SYNCPPP=m
CONFIG_HDLC=m
CONFIG_HDLC_PPP=y
CONFIG_HDLC_X25=y
CONFIG_N2=m
CONFIG_C101=m
CONFIG_DLCI=m
CONFIG_DLCI_COUNT=24
CONFIG_DLCI_MAX=8
CONFIG_SDLA=m
CONFIG_WAN_ROUTER_DRIVERS=y
CONFIG_VENDOR_SANGOMA=m
CONFIG_WANPIPE_CHDLC=y
CONFIG_WANPIPE_FR=y
CONFIG_WANPIPE_X25=y
CONFIG_WANPIPE_PPP=y
CONFIG_WANPIPE_MULTPPP=y
CONFIG_CYCLADES_SYNC=m
CONFIG_CYCLOMX_X25=y
CONFIG_LAPBETHER=m
CONFIG_X25_ASY=m
CONFIG_SBNI=m
# CONFIG_SBNI_MULTILINE is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
CONFIG_INPUT=m
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_SERIAL_EXTENDED=y
CONFIG_SERIAL_MANY_PORTS=y
CONFIG_SERIAL_SHARE_IRQ=y
# CONFIG_SERIAL_DETECT_IRQ is not set
CONFIG_SERIAL_MULTIPORT=y
CONFIG_HUB6=y
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_PHILIPSPAR=m
CONFIG_I2C_ELV=m
CONFIG_I2C_VELLEMAN=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_PROC=m

#
# Mice
#
CONFIG_BUSMOUSE=m
CONFIG_ATIXL_BUSMOUSE=m
CONFIG_LOGIBUSMOUSE=m
CONFIG_MS_BUSMOUSE=m
CONFIG_MOUSE=m
CONFIG_PSMOUSE=y
CONFIG_82C710_MOUSE=m
CONFIG_PC110_PAD=m

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set
# CONFIG_INPUT_NS558 is not set
# CONFIG_INPUT_LIGHTNING is not set
# CONFIG_INPUT_PCIGAME is not set
# CONFIG_INPUT_CS461X is not set
# CONFIG_INPUT_EMU10K1 is not set
# CONFIG_INPUT_SERIO is not set
# CONFIG_INPUT_SERPORT is not set

#
# Joysticks
#
# CONFIG_INPUT_ANALOG is not set
# CONFIG_INPUT_A3D is not set
# CONFIG_INPUT_ADI is not set
# CONFIG_INPUT_COBRA is not set
# CONFIG_INPUT_GF2K is not set
# CONFIG_INPUT_GRIP is not set
# CONFIG_INPUT_INTERACT is not set
# CONFIG_INPUT_TMDC is not set
# CONFIG_INPUT_SIDEWINDER is not set
# CONFIG_INPUT_IFORCE_USB is not set
# CONFIG_INPUT_IFORCE_232 is not set
# CONFIG_INPUT_WARRIOR is not set
# CONFIG_INPUT_MAGELLAN is not set
# CONFIG_INPUT_SPACEORB is not set
# CONFIG_INPUT_SPACEBALL is not set
# CONFIG_INPUT_STINGER is not set
CONFIG_INPUT_DB9=m
CONFIG_INPUT_GAMECON=m
CONFIG_INPUT_TURBOGRAFX=m
CONFIG_QIC02_TAPE=m
CONFIG_QIC02_DYNCONF=y

#
#   Setting runtime QIC-02 configuration is done with qic02conf
#

#
#   from the tpqic02-support package.  It is available at
#

#
#   metalab.unc.edu or ftp://titus.cfw.com/pub/Linux/util/
#

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDT=m
CONFIG_WDTPCI=m
CONFIG_WDT_501=y
# CONFIG_WDT_501_FAN is not set
CONFIG_PCWATCHDOG=m
CONFIG_ACQUIRE_WDT=m
CONFIG_ADVANTECH_WDT=m
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
CONFIG_I810_TCO=m
CONFIG_MIXCOMWD=m
CONFIG_60XX_WDT=m
# CONFIG_W83877F_WDT is not set
CONFIG_MACHZ_WDT=m
CONFIG_INTEL_RNG=m
CONFIG_NVRAM=m
CONFIG_RTC=m
CONFIG_DTLK=m
CONFIG_R3964=m
CONFIG_APPLICOM=m
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
CONFIG_FTAPE=m
CONFIG_ZFTAPE=m
CONFIG_ZFT_DFLT_BLK_SZ=10240

#
#   The compressor will be built as a module only!
#
CONFIG_ZFT_COMPRESSOR=m
CONFIG_FT_NR_BUFFERS=3
CONFIG_FT_PROC_FS=y
CONFIG_FT_NORMAL_DEBUG=y
# CONFIG_FT_FULL_DEBUG is not set
# CONFIG_FT_NO_TRACE is not set
# CONFIG_FT_NO_TRACE_AT_ALL is not set

#
# Hardware configuration
#
CONFIG_FT_STD_FDC=y
# CONFIG_FT_MACH2 is not set
# CONFIG_FT_PROBE_FC10 is not set
# CONFIG_FT_ALT_FDC is not set
CONFIG_FT_FDC_THR=8
CONFIG_FT_FDC_MAX_RATE=2000
CONFIG_FT_ALPHA_CLOCK=0
CONFIG_AGP=m
CONFIG_AGP_ALI=y
CONFIG_AGP_AMD=y
CONFIG_AGP_SIS=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_I810=y
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_VIA=y
CONFIG_DRM=y
CONFIG_DRM_NEW=y

#
# DRM 4.1 drivers
#
CONFIG_DRM_TDFX=m
CONFIG_DRM_GAMMA=m
CONFIG_DRM_R128=m
CONFIG_DRM_RADEON=m
CONFIG_DRM_I810=m
CONFIG_DRM_MGA=m
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
CONFIG_QUOTA=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=m
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
CONFIG_HFS_FS=m
# CONFIG_BFS_FS is not set
# CONFIG_CMS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_UMSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_EFS_FS=m
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
CONFIG_CRAMFS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=m
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
CONFIG_MINIX_FS=m
# CONFIG_FREEVXFS_FS is not set
CONFIG_NTFS_FS=m
# CONFIG_NTFS_RW is not set
CONFIG_HPFS_FS=m
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
CONFIG_QNX4FS_FS=m
# CONFIG_QNX4FS_RW is not set
CONFIG_ROMFS_FS=m
CONFIG_EXT2_FS=y
CONFIG_SYSV_FS=m
CONFIG_UDF_FS=m
# CONFIG_UDF_RW is not set
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
CONFIG_CODA_FS=m
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_NCP_FS=m
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
CONFIG_NCPFS_NFS_NS=y
CONFIG_NCPFS_OS2_NS=y
# CONFIG_NCPFS_SMALLDOS is not set
CONFIG_NCPFS_NLS=y
CONFIG_NCPFS_EXTRAS=y
# CONFIG_ZISOFS_FS is not set
CONFIG_ZLIB_FS_INFLATE=y

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="cp437"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
CONFIG_SOUND=m
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_MIDI_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_MIDI_VIA82CXXX is not set
# CONFIG_SOUND_VIA82CXXX_PROCFS is not set
# CONFIG_SOUND_OSS is not set
# CONFIG_SOUND_TVMIXER is not set

#
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_LONG_TIMEOUT is not set

#
# USB Controllers
#
CONFIG_USB_UHCI=m
CONFIG_USB_UHCI_ALT=m
CONFIG_USB_OHCI=m

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=m
CONFIG_USB_BLUETOOTH=m
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_HP8200e=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_JUMPSHOT=y
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=m
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
CONFIG_USB_WACOM=m
# CONFIG_USB_AIPTEK is not set

#
# USB Imaging devices
#
CONFIG_USB_DC2XX=m
CONFIG_USB_MDC800=m
CONFIG_USB_SCANNER=m
CONFIG_USB_MICROTEK=m
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#

#
#   Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
CONFIG_USB_PEGASUS=m
CONFIG_USB_KAWETH=m
CONFIG_USB_CATC=m
CONFIG_USB_CDCETHER=m
CONFIG_USB_USBNET=m

#
# USB port drivers
#
CONFIG_USB_USS720=m

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
# CONFIG_USB_SERIAL_IR is not set
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_OMNINET=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_RIO500=m
CONFIG_USB_ID75=m

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_HIGHMEM=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_BUGVERBOSE=y

--------------DBCE66E0E0E7FCA73A7700A3--
