Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbULRQ4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbULRQ4v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 11:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbULRQ4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 11:56:50 -0500
Received: from FW-30-241.go.retevision.es ([62.174.241.30]:46243 "EHLO
	puil.ghetto") by vger.kernel.org with ESMTP id S261195AbULRQyR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 11:54:17 -0500
Date: Sat, 18 Dec 2004 17:53:37 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.9 with some fs corruption: EIP is at _spin_lock_irqsave+0xf/0x30  [Ignore by now]
Message-ID: <20041218165337.GA4871@larroy.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20041218155912.GA4635@larroy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041218155912.GA4635@larroy.com>
User-Agent: Mutt/1.5.6+20040907i
From: piotr@larroy.com (Pedro Larroy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2004 at 04:59:12PM +0100, Pedro Larroy wrote:


One of my cpus could be broken, I'm getting MCEs, ignore this oops by
now.

Thanks.






> Unable to handle kernel paging request at virtual address fffffd68
>  printing eip:
> c0313dff
> *pde = 00004067
> *pte = 00000000
> Oops: 0002 [#1]
> PREEMPT SMP
> Modules linked in: parport_pc lp parport snd_ens1371 snd_rawmidi snd_seq_devicepCPU:    1ss snd_mixer_oss snd_pcm snd_timer
> EIP:    0060:[<c0313dff>]    Not tainted VLI
> EFLAGS: 00210002   (2.6.9)
> EIP is at _spin_lock_irqsave+0xf/0x30
> eax: 00200296   ebx: c01197a0   ecx: fffffd68   edx: d9e5e000
> esi: daed8008   edi: fffffd68   ebp: 00000005   esp: d9e5fed4
> ds: 007b   es: 007b   ss: 0068
> Process xmms (pid: 931, threadinfo=d9e5e000 task=d9a1a8f0)
> Stack: c011c817 c011979c daed8008 daed8000 c0167804 00000000 00000000 00000005
>        c0167b9d 00000000 00000000 00000010 00000000 00000000 00000000 00000304
>        00000010 d9e5e000 f6f037ac f6f037a8 f6f037a4 f6f037b8 f6f037b4 f6f037b0
> Call Trace:
>  [<c011c817>] remove_wait_queue+0x17/0x50
>  [<c011979c>] activate_task+0x6c/0xa0
>  [<c0167804>] poll_freewait+0x24/0x50
>  [<c0167b9d>] do_select+0x1bd/0x2c0 
>  [<c0167830>] __pollwait+0x0/0xd0NOR 
>  [<c0167f6e>] sys_select+0x2ae/0x4a0
>  [<c01060ab>] syscall_call+0x7/0xb
> Code: 00 e0 ff ff 21 e0 ff 48 14 8b 40 08 a8 08 75 02 90 c3 e9 b5 f5 ff ff 90 8d 74 26 00 89 c1 9c 58 fa ba 00 e0 ff ff 21 e
>  <6>note: xmms[931] exited with preempt_count 1
> Unable to handle kernel NULL pointer dereference at virtual address 00000081
>  printing eip:
> c02b3394
> *pde = 00000000
> Oops: 0002 [#2]
> PREEMPT SMP
> Modules linked in: parport_pc lp parport snd_ens1371 snd_rawmidi snd_seq_devicesnd_pcm_oss snd_mixer_oss snd_pcm snd_timer                                    p
> CPU:    1
> EIP:    0060:[<c02b3394>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.9)
> EIP is at alloc_skb+0x74/0xd0
> eax: 00000081   ebx: f5921ec0   ecx: 00000000   edx: 00000001
> esi: 00000080   edi: f5921f60   ebp: 000000d0   esp: f7325de8
> ds: 007b   es: 007b   ss: 0068
> Process klogd (pid: 444, threadinfo=f7324000 task=f6c04190)
> Stack: ffffffe0 f72d2ba0 00000000 0000005e c02b25f8 00000001 00000000 f7325e44
>        f72d2d40 f7325e44 f73a1200 c02b2719 00000000 f7325e44 f7325ea4 c030eab3
>        f7325e44 f72f1d2c f7325e4c 00000000 00000000 f72d2ba0 f7325e84 ffffffa6
> Call Trace:
>  [<c02b25f8>] sock_alloc_send_pskb+0xb8/0x1c0
>  [<c02b2719>] sock_alloc_send_skb+0x19/0x30
>  [<c030eab3>] unix_dgram_sendmsg+0x123/0x4a0
>  [<c02afcad>] sock_aio_write+0xdd/0x110
>  [<c0126c29>] update_wall_time+0x9/0x40
>  [<c0126ff3>] do_timer+0xb3/0xc0
>  [<c0155d01>] do_sync_write+0xa1/0xe0
>  [<c011c9a0>] autoremove_wake_function+0x0/0x50
>  [<c011c9a0>] autoremove_wake_function+0x0/0x50
>  [<c011c9a0>] autoremove_wake_function+0x0/0x50
>  [<c0155e17>] vfs_write+0xd7/0x100
>  [<c0155f07>] sys_write+0x47/0x80
>  [<c01060ab>] syscall_call+0x7/0xb
> Code: 89 93 ac 00 00 00 8d 86 b8 00 00 00 c7 83 a4 00 00 00 01 00 00 00 89 93 a8 00 00 00 89 83 a0 00 00 00 8d 04 16 89 83 b
>  <0>journal_get_undo_access: No memory for committed data
> ext3_try_to_allocate: aborting transaction: Out of memory in __ext3_journal_get_undo_access<2>EXT3-fs error (device hda1) in                                   y
> Remounting filesystem read-only
> EXT3-fs error (device hda1) in ext3_prepare_write: Out of memory
> EXT3-fs error (device hda1) in start_transaction: Readonly filesystem
> eth0: memory shortage
> 
> -- 
> Pedro Larroy Tovar | Linux & Network consultant |  pedro%larroy.com 
> Make debian mirrors with debian-multimirror: http://pedro.larroy.com/deb_mm/
> 	* Las patentes de programación son nocivas para la innovación * 
> 				http://proinnova.hispalinux.es/

> #
> # Automatically generated make config: don't edit
> # Linux kernel version: 2.6.9
> # Thu Dec  2 00:54:59 2004
> #
> CONFIG_X86=y
> CONFIG_MMU=y
> CONFIG_UID16=y
> CONFIG_GENERIC_ISA_DMA=y
> CONFIG_GENERIC_IOMAP=y
> 
> #
> # Code maturity level options
> #
> CONFIG_EXPERIMENTAL=y
> # CONFIG_CLEAN_COMPILE is not set
> CONFIG_BROKEN=y
> CONFIG_BROKEN_ON_SMP=y
> 
> #
> # General setup
> #
> CONFIG_LOCALVERSION=""
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> CONFIG_POSIX_MQUEUE=y
> CONFIG_BSD_PROCESS_ACCT=y
> CONFIG_BSD_PROCESS_ACCT_V3=y
> CONFIG_SYSCTL=y
> # CONFIG_AUDIT is not set
> CONFIG_LOG_BUF_SHIFT=15
> # CONFIG_HOTPLUG is not set
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
> # CONFIG_EMBEDDED is not set
> CONFIG_KALLSYMS=y
> # CONFIG_KALLSYMS_ALL is not set
> # CONFIG_KALLSYMS_EXTRA_PASS is not set
> CONFIG_FUTEX=y
> CONFIG_EPOLL=y
> CONFIG_IOSCHED_NOOP=y
> CONFIG_IOSCHED_AS=y
> CONFIG_IOSCHED_DEADLINE=y
> CONFIG_IOSCHED_CFQ=y
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> CONFIG_SHMEM=y
> # CONFIG_TINY_SHMEM is not set
> 
> #
> # Loadable module support
> #
> CONFIG_MODULES=y
> CONFIG_MODULE_UNLOAD=y
> CONFIG_MODULE_FORCE_UNLOAD=y
> CONFIG_OBSOLETE_MODPARM=y
> CONFIG_MODVERSIONS=y
> CONFIG_KMOD=y
> CONFIG_STOP_MACHINE=y
> 
> #
> # Processor type and features
> #
> CONFIG_X86_PC=y
> # CONFIG_X86_ELAN is not set
> # CONFIG_X86_VOYAGER is not set
> # CONFIG_X86_NUMAQ is not set
> # CONFIG_X86_SUMMIT is not set
> # CONFIG_X86_BIGSMP is not set
> # CONFIG_X86_VISWS is not set
> # CONFIG_X86_GENERICARCH is not set
> # CONFIG_X86_ES7000 is not set
> # CONFIG_M386 is not set
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> # CONFIG_M586MMX is not set
> # CONFIG_M686 is not set
> # CONFIG_MPENTIUMII is not set
> # CONFIG_MPENTIUMIII is not set
> # CONFIG_MPENTIUMM is not set
> # CONFIG_MPENTIUM4 is not set
> # CONFIG_MK6 is not set
> CONFIG_MK7=y
> # CONFIG_MK8 is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP2 is not set
> # CONFIG_MWINCHIP3D is not set
> # CONFIG_MCYRIXIII is not set
> # CONFIG_MVIAC3_2 is not set
> # CONFIG_X86_GENERIC is not set
> CONFIG_X86_CMPXCHG=y
> CONFIG_X86_XADD=y
> CONFIG_X86_L1_CACHE_SHIFT=6
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_X86_WP_WORKS_OK=y
> CONFIG_X86_INVLPG=y
> CONFIG_X86_BSWAP=y
> CONFIG_X86_POPAD_OK=y
> CONFIG_X86_GOOD_APIC=y
> CONFIG_X86_INTEL_USERCOPY=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> CONFIG_X86_USE_3DNOW=y
> CONFIG_HPET_TIMER=y
> CONFIG_HPET_EMULATE_RTC=y
> CONFIG_SMP=y
> CONFIG_NR_CPUS=2
> # CONFIG_SCHED_SMT is not set
> CONFIG_PREEMPT=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_TSC=y
> CONFIG_X86_MCE=y
> CONFIG_X86_MCE_NONFATAL=y
> # CONFIG_X86_MCE_P4THERMAL is not set
> # CONFIG_TOSHIBA is not set
> # CONFIG_I8K is not set
> CONFIG_MICROCODE=m
> CONFIG_X86_MSR=m
> CONFIG_X86_CPUID=m
> 
> #
> # Firmware Drivers
> #
> # CONFIG_EDD is not set
> # CONFIG_NOHIGHMEM is not set
> CONFIG_HIGHMEM4G=y
> # CONFIG_HIGHMEM64G is not set
> CONFIG_HIGHMEM=y
> # CONFIG_HIGHPTE is not set
> # CONFIG_MATH_EMULATION is not set
> CONFIG_MTRR=y
> # CONFIG_EFI is not set
> CONFIG_IRQBALANCE=y
> CONFIG_HAVE_DEC_LOCK=y
> CONFIG_REGPARM=y
> 
> #
> # Power management options (ACPI, APM)
> #
> CONFIG_PM=y
> CONFIG_PM_DEBUG=y
> CONFIG_SOFTWARE_SUSPEND=y
> CONFIG_PM_STD_PARTITION="/dev/sda2"
> 
> #
> # ACPI (Advanced Configuration and Power Interface) Support
> #
> CONFIG_ACPI=y
> CONFIG_ACPI_BOOT=y
> CONFIG_ACPI_INTERPRETER=y
> CONFIG_ACPI_SLEEP=y
> CONFIG_ACPI_SLEEP_PROC_FS=y
> CONFIG_ACPI_AC=y
> CONFIG_ACPI_BATTERY=y
> CONFIG_ACPI_BUTTON=y
> CONFIG_ACPI_FAN=y
> CONFIG_ACPI_PROCESSOR=y
> CONFIG_ACPI_THERMAL=y
> # CONFIG_ACPI_ASUS is not set
> # CONFIG_ACPI_TOSHIBA is not set
> # CONFIG_ACPI_CUSTOM_DSDT is not set
> CONFIG_ACPI_BLACKLIST_YEAR=0
> CONFIG_ACPI_DEBUG=y
> CONFIG_ACPI_BUS=y
> CONFIG_ACPI_EC=y
> CONFIG_ACPI_POWER=y
> CONFIG_ACPI_PCI=y
> CONFIG_ACPI_SYSTEM=y
> CONFIG_X86_PM_TIMER=y
> 
> #
> # APM (Advanced Power Management) BIOS Support
> #
> # CONFIG_APM is not set
> 
> #
> # CPU Frequency scaling
> #
> # CONFIG_CPU_FREQ is not set
> 
> #
> # Bus options (PCI, PCMCIA, EISA, MCA, ISA)
> #
> CONFIG_PCI=y
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GOMMCONFIG is not set
> # CONFIG_PCI_GODIRECT is not set
> CONFIG_PCI_GOANY=y
> CONFIG_PCI_BIOS=y
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_MMCONFIG=y
> # CONFIG_PCI_MSI is not set
> # CONFIG_PCI_LEGACY_PROC is not set
> CONFIG_PCI_NAMES=y
> # CONFIG_ISA is not set
> # CONFIG_MCA is not set
> # CONFIG_SCx200 is not set
> 
> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=y
> CONFIG_BINFMT_AOUT=m
> CONFIG_BINFMT_MISC=m
> 
> #
> # Device Drivers
> #
> 
> #
> # Generic Driver Options
> #
> # CONFIG_STANDALONE is not set
> # CONFIG_PREVENT_FIRMWARE_BUILD is not set
> CONFIG_FW_LOADER=m
> # CONFIG_DEBUG_DRIVER is not set
> 
> #
> # Memory Technology Devices (MTD)
> #
> # CONFIG_MTD is not set
> 
> #
> # Parallel port support
> #
> CONFIG_PARPORT=m
> CONFIG_PARPORT_PC=m
> CONFIG_PARPORT_PC_CML1=m
> # CONFIG_PARPORT_SERIAL is not set
> CONFIG_PARPORT_PC_FIFO=y
> CONFIG_PARPORT_PC_SUPERIO=y
> # CONFIG_PARPORT_OTHER is not set
> CONFIG_PARPORT_1284=y
> 
> #
> # Plug and Play support
> #
> 
> #
> # Block devices
> #
> CONFIG_BLK_DEV_FD=m
> # CONFIG_PARIDE is not set
> # CONFIG_BLK_CPQ_DA is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> # CONFIG_BLK_DEV_UMEM is not set
> CONFIG_BLK_DEV_LOOP=m
> CONFIG_BLK_DEV_CRYPTOLOOP=m
> # CONFIG_BLK_DEV_NBD is not set
> # CONFIG_BLK_DEV_SX8 is not set
> # CONFIG_BLK_DEV_UB is not set
> CONFIG_BLK_DEV_RAM=y
> CONFIG_BLK_DEV_RAM_SIZE=4096
> CONFIG_BLK_DEV_INITRD=y
> # CONFIG_LBD is not set
> 
> #
> # ATA/ATAPI/MFM/RLL support
> #
> CONFIG_IDE=y
> CONFIG_BLK_DEV_IDE=y
> 
> #
> # Please see Documentation/ide.txt for help/info on IDE drives
> #
> # CONFIG_BLK_DEV_IDE_SATA is not set
> # CONFIG_BLK_DEV_HD_IDE is not set
> CONFIG_BLK_DEV_IDEDISK=y
> # CONFIG_IDEDISK_MULTI_MODE is not set
> CONFIG_BLK_DEV_IDECD=m
> # CONFIG_BLK_DEV_IDETAPE is not set
> # CONFIG_BLK_DEV_IDEFLOPPY is not set
> # CONFIG_BLK_DEV_IDESCSI is not set
> CONFIG_IDE_TASK_IOCTL=y
> CONFIG_IDE_TASKFILE_IO=y
> 
> #
> # IDE chipset support/bugfixes
> #
> CONFIG_IDE_GENERIC=y
> # CONFIG_BLK_DEV_CMD640 is not set
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> # CONFIG_BLK_DEV_OFFBOARD is not set
> # CONFIG_BLK_DEV_GENERIC is not set
> # CONFIG_BLK_DEV_OPTI621 is not set
> # CONFIG_BLK_DEV_RZ1000 is not set
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> CONFIG_IDEDMA_PCI_AUTO=y
> # CONFIG_IDEDMA_ONLYDISK is not set
> # CONFIG_BLK_DEV_AEC62XX is not set
> # CONFIG_BLK_DEV_ALI15X3 is not set
> CONFIG_BLK_DEV_AMD74XX=y
> # CONFIG_BLK_DEV_ATIIXP is not set
> # CONFIG_BLK_DEV_CMD64X is not set
> # CONFIG_BLK_DEV_TRIFLEX is not set
> # CONFIG_BLK_DEV_CY82C693 is not set
> # CONFIG_BLK_DEV_CS5520 is not set
> # CONFIG_BLK_DEV_CS5530 is not set
> # CONFIG_BLK_DEV_HPT34X is not set
> # CONFIG_BLK_DEV_HPT366 is not set
> # CONFIG_BLK_DEV_SC1200 is not set
> # CONFIG_BLK_DEV_PIIX is not set
> # CONFIG_BLK_DEV_NS87415 is not set
> # CONFIG_BLK_DEV_PDC202XX_OLD is not set
> # CONFIG_BLK_DEV_PDC202XX_NEW is not set
> # CONFIG_BLK_DEV_SVWKS is not set
> # CONFIG_BLK_DEV_SIIMAGE is not set
> # CONFIG_BLK_DEV_SIS5513 is not set
> # CONFIG_BLK_DEV_SLC90E66 is not set
> # CONFIG_BLK_DEV_TRM290 is not set
> # CONFIG_BLK_DEV_VIA82CXXX is not set
> # CONFIG_IDE_ARM is not set
> CONFIG_BLK_DEV_IDEDMA=y
> # CONFIG_IDEDMA_IVB is not set
> CONFIG_IDEDMA_AUTO=y
> # CONFIG_BLK_DEV_HD is not set
> 
> #
> # SCSI device support
> #
> CONFIG_SCSI=y
> CONFIG_SCSI_PROC_FS=y
> 
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=y
> CONFIG_CHR_DEV_ST=m
> CONFIG_CHR_DEV_OSST=m
> CONFIG_BLK_DEV_SR=m
> # CONFIG_BLK_DEV_SR_VENDOR is not set
> CONFIG_CHR_DEV_SG=m
> 
> #
> # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
> #
> CONFIG_SCSI_MULTI_LUN=y
> # CONFIG_SCSI_CONSTANTS is not set
> # CONFIG_SCSI_LOGGING is not set
> 
> #
> # SCSI Transport Attributes
> #
> CONFIG_SCSI_SPI_ATTRS=y
> # CONFIG_SCSI_FC_ATTRS is not set
> 
> #
> # SCSI low-level drivers
> #
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_3W_9XXX is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AACRAID is not set
> CONFIG_SCSI_AIC7XXX=y
> CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
> CONFIG_AIC7XXX_RESET_DELAY_MS=7000
> # CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
> CONFIG_AIC7XXX_DEBUG_ENABLE=y
> CONFIG_AIC7XXX_DEBUG_MASK=0
> CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
> CONFIG_SCSI_AIC7XXX_OLD=m
> # CONFIG_SCSI_AIC79XX is not set
> # CONFIG_SCSI_DPT_I2O is not set
> # CONFIG_SCSI_ADVANSYS is not set
> # CONFIG_MEGARAID_NEWGEN is not set
> # CONFIG_MEGARAID_LEGACY is not set
> # CONFIG_SCSI_SATA is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_CPQFCTS is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_EATA is not set
> # CONFIG_SCSI_EATA_PIO is not set
> # CONFIG_SCSI_FUTURE_DOMAIN is not set
> # CONFIG_SCSI_GDTH is not set
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_PPA is not set
> # CONFIG_SCSI_IMM is not set
> # CONFIG_SCSI_SYM53C8XX_2 is not set
> # CONFIG_SCSI_IPR is not set
> # CONFIG_SCSI_PCI2000 is not set
> # CONFIG_SCSI_PCI2220I is not set
> # CONFIG_SCSI_QLOGIC_ISP is not set
> # CONFIG_SCSI_QLOGIC_FC is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> CONFIG_SCSI_QLA2XXX=y
> # CONFIG_SCSI_QLA21XX is not set
> # CONFIG_SCSI_QLA22XX is not set
> # CONFIG_SCSI_QLA2300 is not set
> # CONFIG_SCSI_QLA2322 is not set
> # CONFIG_SCSI_QLA6312 is not set
> # CONFIG_SCSI_QLA6322 is not set
> # CONFIG_SCSI_DC395x is not set
> # CONFIG_SCSI_DC390T is not set
> # CONFIG_SCSI_NSP32 is not set
> # CONFIG_SCSI_DEBUG is not set
> 
> #
> # Multi-device support (RAID and LVM)
> #
> CONFIG_MD=y
> CONFIG_BLK_DEV_MD=m
> CONFIG_MD_LINEAR=m
> CONFIG_MD_RAID0=m
> CONFIG_MD_RAID1=m
> # CONFIG_MD_RAID10 is not set
> CONFIG_MD_RAID5=m
> CONFIG_MD_RAID6=m
> CONFIG_MD_MULTIPATH=m
> # CONFIG_BLK_DEV_DM is not set
> 
> #
> # Fusion MPT device support
> #
> # CONFIG_FUSION is not set
> 
> #
> # IEEE 1394 (FireWire) support
> #
> # CONFIG_IEEE1394 is not set
> 
> #
> # I2O device support
> #
> CONFIG_I2O=y
> # CONFIG_I2O_CONFIG is not set
> CONFIG_I2O_BLOCK=m
> CONFIG_I2O_SCSI=y
> CONFIG_I2O_PROC=m
> 
> #
> # Networking support
> #
> CONFIG_NET=y
> 
> #
> # Networking options
> #
> CONFIG_PACKET=y
> CONFIG_PACKET_MMAP=y
> CONFIG_NETLINK_DEV=m
> CONFIG_UNIX=y
> CONFIG_NET_KEY=m
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> CONFIG_IP_ADVANCED_ROUTER=y
> CONFIG_IP_MULTIPLE_TABLES=y
> CONFIG_IP_ROUTE_FWMARK=y
> CONFIG_IP_ROUTE_MULTIPATH=y
> CONFIG_IP_ROUTE_VERBOSE=y
> # CONFIG_IP_PNP is not set
> CONFIG_NET_IPIP=m
> CONFIG_NET_IPGRE=m
> # CONFIG_NET_IPGRE_BROADCAST is not set
> # CONFIG_IP_MROUTE is not set
> # CONFIG_ARPD is not set
> CONFIG_SYN_COOKIES=y
> CONFIG_INET_AH=m
> CONFIG_INET_ESP=m
> CONFIG_INET_IPCOMP=m
> CONFIG_INET_TUNNEL=m
> 
> #
> # IP: Virtual Server Configuration
> #
> # CONFIG_IP_VS is not set
> CONFIG_IPV6=m
> CONFIG_IPV6_PRIVACY=y
> CONFIG_INET6_AH=m
> CONFIG_INET6_ESP=m
> CONFIG_INET6_IPCOMP=m
> CONFIG_INET6_TUNNEL=m
> CONFIG_IPV6_TUNNEL=m
> CONFIG_NETFILTER=y
> # CONFIG_NETFILTER_DEBUG is not set
> CONFIG_BRIDGE_NETFILTER=y
> 
> #
> # IP: Netfilter Configuration
> #
> CONFIG_IP_NF_CONNTRACK=m
> CONFIG_IP_NF_CT_ACCT=y
> CONFIG_IP_NF_CT_PROTO_SCTP=m
> CONFIG_IP_NF_FTP=m
> CONFIG_IP_NF_IRC=m
> CONFIG_IP_NF_TFTP=m
> CONFIG_IP_NF_AMANDA=m
> CONFIG_IP_NF_QUEUE=m
> CONFIG_IP_NF_IPTABLES=y
> CONFIG_IP_NF_MATCH_LIMIT=m
> CONFIG_IP_NF_MATCH_IPRANGE=m
> CONFIG_IP_NF_MATCH_MAC=m
> CONFIG_IP_NF_MATCH_PKTTYPE=m
> CONFIG_IP_NF_MATCH_MARK=m
> CONFIG_IP_NF_MATCH_MULTIPORT=m
> CONFIG_IP_NF_MATCH_TOS=m
> CONFIG_IP_NF_MATCH_RECENT=m
> CONFIG_IP_NF_MATCH_ECN=m
> CONFIG_IP_NF_MATCH_DSCP=m
> CONFIG_IP_NF_MATCH_AH_ESP=m
> CONFIG_IP_NF_MATCH_LENGTH=m
> CONFIG_IP_NF_MATCH_TTL=m
> CONFIG_IP_NF_MATCH_TCPMSS=m
> CONFIG_IP_NF_MATCH_HELPER=m
> CONFIG_IP_NF_MATCH_STATE=m
> CONFIG_IP_NF_MATCH_CONNTRACK=m
> CONFIG_IP_NF_MATCH_OWNER=m
> CONFIG_IP_NF_MATCH_PHYSDEV=m
> # CONFIG_IP_NF_MATCH_ADDRTYPE is not set
> # CONFIG_IP_NF_MATCH_REALM is not set
> CONFIG_IP_NF_MATCH_SCTP=m
> CONFIG_IP_NF_MATCH_COMMENT=m
> CONFIG_IP_NF_FILTER=m
> CONFIG_IP_NF_TARGET_REJECT=m
> CONFIG_IP_NF_TARGET_LOG=m
> CONFIG_IP_NF_TARGET_ULOG=m
> CONFIG_IP_NF_TARGET_TCPMSS=m
> CONFIG_IP_NF_NAT=m
> CONFIG_IP_NF_NAT_NEEDED=y
> CONFIG_IP_NF_TARGET_MASQUERADE=m
> CONFIG_IP_NF_TARGET_REDIRECT=m
> CONFIG_IP_NF_TARGET_NETMAP=m
> CONFIG_IP_NF_TARGET_SAME=m
> CONFIG_IP_NF_NAT_LOCAL=y
> CONFIG_IP_NF_NAT_SNMP_BASIC=m
> CONFIG_IP_NF_NAT_IRC=m
> CONFIG_IP_NF_NAT_FTP=m
> CONFIG_IP_NF_NAT_TFTP=m
> CONFIG_IP_NF_NAT_AMANDA=m
> CONFIG_IP_NF_MANGLE=m
> CONFIG_IP_NF_TARGET_TOS=m
> CONFIG_IP_NF_TARGET_ECN=m
> CONFIG_IP_NF_TARGET_DSCP=m
> CONFIG_IP_NF_TARGET_MARK=m
> CONFIG_IP_NF_TARGET_CLASSIFY=m
> # CONFIG_IP_NF_RAW is not set
> CONFIG_IP_NF_ARPTABLES=m
> CONFIG_IP_NF_ARPFILTER=m
> CONFIG_IP_NF_ARP_MANGLE=m
> 
> #
> # IPv6: Netfilter Configuration
> #
> CONFIG_IP6_NF_QUEUE=m
> CONFIG_IP6_NF_IPTABLES=m
> CONFIG_IP6_NF_MATCH_LIMIT=m
> CONFIG_IP6_NF_MATCH_MAC=m
> CONFIG_IP6_NF_MATCH_RT=m
> CONFIG_IP6_NF_MATCH_OPTS=m
> CONFIG_IP6_NF_MATCH_FRAG=m
> CONFIG_IP6_NF_MATCH_HL=m
> CONFIG_IP6_NF_MATCH_MULTIPORT=m
> CONFIG_IP6_NF_MATCH_OWNER=m
> CONFIG_IP6_NF_MATCH_MARK=m
> CONFIG_IP6_NF_MATCH_IPV6HEADER=m
> CONFIG_IP6_NF_MATCH_AHESP=m
> CONFIG_IP6_NF_MATCH_LENGTH=m
> CONFIG_IP6_NF_MATCH_EUI64=m
> CONFIG_IP6_NF_MATCH_PHYSDEV=m
> CONFIG_IP6_NF_FILTER=m
> CONFIG_IP6_NF_TARGET_LOG=m
> CONFIG_IP6_NF_MANGLE=m
> CONFIG_IP6_NF_TARGET_MARK=m
> # CONFIG_IP6_NF_RAW is not set
> 
> #
> # Bridge: Netfilter Configuration
> #
> CONFIG_BRIDGE_NF_EBTABLES=m
> CONFIG_BRIDGE_EBT_BROUTE=m
> CONFIG_BRIDGE_EBT_T_FILTER=m
> CONFIG_BRIDGE_EBT_T_NAT=m
> CONFIG_BRIDGE_EBT_802_3=m
> # CONFIG_BRIDGE_EBT_AMONG is not set
> CONFIG_BRIDGE_EBT_ARP=m
> CONFIG_BRIDGE_EBT_IP=m
> # CONFIG_BRIDGE_EBT_LIMIT is not set
> CONFIG_BRIDGE_EBT_MARK=m
> CONFIG_BRIDGE_EBT_PKTTYPE=m
> CONFIG_BRIDGE_EBT_STP=m
> CONFIG_BRIDGE_EBT_VLAN=m
> CONFIG_BRIDGE_EBT_ARPREPLY=m
> CONFIG_BRIDGE_EBT_DNAT=m
> CONFIG_BRIDGE_EBT_MARK_T=m
> CONFIG_BRIDGE_EBT_REDIRECT=m
> CONFIG_BRIDGE_EBT_SNAT=m
> CONFIG_BRIDGE_EBT_LOG=m
> CONFIG_XFRM=y
> CONFIG_XFRM_USER=m
> 
> #
> # SCTP Configuration (EXPERIMENTAL)
> #
> CONFIG_IP_SCTP=m
> CONFIG_SCTP_DBG_MSG=y
> CONFIG_SCTP_DBG_OBJCNT=y
> CONFIG_SCTP_HMAC_NONE=y
> # CONFIG_SCTP_HMAC_SHA1 is not set
> # CONFIG_SCTP_HMAC_MD5 is not set
> # CONFIG_ATM is not set
> CONFIG_BRIDGE=m
> # CONFIG_VLAN_8021Q is not set
> # CONFIG_DECNET is not set
> # CONFIG_LLC2 is not set
> # CONFIG_IPX is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_NET_DIVERT is not set
> # CONFIG_ECONET is not set
> # CONFIG_WAN_ROUTER is not set
> # CONFIG_NET_HW_FLOWCONTROL is not set
> 
> #
> # QoS and/or fair queueing
> #
> CONFIG_NET_SCHED=y
> # CONFIG_NET_SCH_CLK_JIFFIES is not set
> # CONFIG_NET_SCH_CLK_GETTIMEOFDAY is not set
> CONFIG_NET_SCH_CLK_CPU=y
> # CONFIG_NET_SCH_CBQ is not set
> CONFIG_NET_SCH_HTB=m
> CONFIG_NET_SCH_HFSC=m
> CONFIG_NET_SCH_PRIO=m
> CONFIG_NET_SCH_RED=m
> CONFIG_NET_SCH_SFQ=m
> CONFIG_NET_SCH_TEQL=m
> CONFIG_NET_SCH_TBF=m
> CONFIG_NET_SCH_GRED=m
> CONFIG_NET_SCH_DSMARK=m
> # CONFIG_NET_SCH_NETEM is not set
> CONFIG_NET_SCH_INGRESS=m
> CONFIG_NET_QOS=y
> CONFIG_NET_ESTIMATOR=y
> CONFIG_NET_CLS=y
> CONFIG_NET_CLS_TCINDEX=m
> CONFIG_NET_CLS_ROUTE4=m
> CONFIG_NET_CLS_ROUTE=y
> CONFIG_NET_CLS_FW=m
> CONFIG_NET_CLS_U32=m
> CONFIG_CLS_U32_PERF=y
> CONFIG_NET_CLS_IND=y
> CONFIG_NET_CLS_RSVP=m
> CONFIG_NET_CLS_RSVP6=m
> CONFIG_NET_CLS_ACT=y
> CONFIG_NET_ACT_POLICE=m
> CONFIG_NET_ACT_GACT=m
> CONFIG_GACT_PROB=y
> 
> #
> # Network testing
> #
> CONFIG_NET_PKTGEN=m
> CONFIG_NETPOLL=y
> CONFIG_NETPOLL_RX=y
> CONFIG_NETPOLL_TRAP=y
> CONFIG_NET_POLL_CONTROLLER=y
> # CONFIG_HAMRADIO is not set
> # CONFIG_IRDA is not set
> # CONFIG_BT is not set
> CONFIG_NETDEVICES=y
> CONFIG_DUMMY=m
> CONFIG_BONDING=m
> CONFIG_EQUALIZER=m
> CONFIG_TUN=m
> CONFIG_ETHERTAP=m
> 
> #
> # ARCnet devices
> #
> CONFIG_ARCNET=m
> # CONFIG_ARCNET_1201 is not set
> CONFIG_ARCNET_1051=m
> # CONFIG_ARCNET_RAW is not set
> CONFIG_ARCNET_COM90xx=m
> CONFIG_ARCNET_COM90xxIO=m
> CONFIG_ARCNET_RIM_I=m
> CONFIG_ARCNET_COM20020=m
> CONFIG_ARCNET_COM20020_PCI=m
> 
> #
> # Ethernet (10 or 100Mbit)
> #
> CONFIG_NET_ETHERNET=y
> CONFIG_MII=y
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNGEM is not set
> CONFIG_NET_VENDOR_3COM=y
> CONFIG_VORTEX=y
> CONFIG_TYPHOON=m
> 
> #
> # Tulip family network device support
> #
> # CONFIG_NET_TULIP is not set
> # CONFIG_HP100 is not set
> # CONFIG_NET_PCI is not set
> 
> #
> # Ethernet (1000 Mbit)
> #
> # CONFIG_ACENIC is not set
> # CONFIG_DL2K is not set
> # CONFIG_E1000 is not set
> # CONFIG_NS83820 is not set
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> # CONFIG_R8169 is not set
> # CONFIG_SK98LIN is not set
> # CONFIG_TIGON3 is not set
> 
> #
> # Ethernet (10000 Mbit)
> #
> # CONFIG_IXGB is not set
> # CONFIG_S2IO is not set
> 
> #
> # Token Ring devices
> #
> # CONFIG_TR is not set
> 
> #
> # Wireless LAN (non-hamradio)
> #
> CONFIG_NET_RADIO=y
> 
> #
> # Obsolete Wireless cards support (pre-802.11)
> #
> # CONFIG_STRIP is not set
> 
> #
> # Wireless 802.11b ISA/PCI cards support
> #
> CONFIG_HERMES=m
> CONFIG_PLX_HERMES=m
> CONFIG_TMD_HERMES=m
> CONFIG_PCI_HERMES=m
> CONFIG_ATMEL=m
> CONFIG_PCI_ATMEL=m
> 
> #
> # Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
> #
> CONFIG_NET_WIRELESS=y
> 
> #
> # Wan interfaces
> #
> # CONFIG_WAN is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_PLIP is not set
> CONFIG_PPP=m
> # CONFIG_PPP_MULTILINK is not set
> CONFIG_PPP_FILTER=y
> CONFIG_PPP_ASYNC=m
> CONFIG_PPP_SYNC_TTY=m
> CONFIG_PPP_DEFLATE=m
> CONFIG_PPP_BSDCOMP=m
> CONFIG_PPPOE=m
> CONFIG_SLIP=m
> # CONFIG_SLIP_COMPRESSED is not set
> # CONFIG_SLIP_SMART is not set
> # CONFIG_SLIP_MODE_SLIP6 is not set
> # CONFIG_NET_FC is not set
> # CONFIG_SHAPER is not set
> CONFIG_NETCONSOLE=m
> 
> #
> # ISDN subsystem
> #
> CONFIG_ISDN=m
> 
> #
> # Old ISDN4Linux
> #
> # CONFIG_ISDN_I4L is not set
> 
> #
> # CAPI subsystem
> #
> # CONFIG_ISDN_CAPI is not set
> 
> #
> # Telephony Support
> #
> # CONFIG_PHONE is not set
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> 
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=y
> CONFIG_INPUT_MOUSEDEV_PSAUX=y
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> CONFIG_INPUT_JOYDEV=m
> # CONFIG_INPUT_TSDEV is not set
> CONFIG_INPUT_EVDEV=m
> # CONFIG_INPUT_EVBUG is not set
> 
> #
> # Input I/O drivers
> #
> # CONFIG_GAMEPORT is not set
> CONFIG_SOUND_GAMEPORT=y
> CONFIG_SERIO=y
> CONFIG_SERIO_I8042=y
> CONFIG_SERIO_SERPORT=y
> # CONFIG_SERIO_CT82C710 is not set
> # CONFIG_SERIO_PARKBD is not set
> # CONFIG_SERIO_PCIPS2 is not set
> # CONFIG_SERIO_RAW is not set
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ATKBD=y
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_LKKBD is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> # CONFIG_MOUSE_SERIAL is not set
> # CONFIG_MOUSE_VSXXXAA is not set
> CONFIG_INPUT_JOYSTICK=y
> # CONFIG_JOYSTICK_IFORCE is not set
> CONFIG_JOYSTICK_WARRIOR=m
> # CONFIG_JOYSTICK_MAGELLAN is not set
> # CONFIG_JOYSTICK_SPACEORB is not set
> # CONFIG_JOYSTICK_SPACEBALL is not set
> # CONFIG_JOYSTICK_STINGER is not set
> # CONFIG_JOYSTICK_TWIDDLER is not set
> # CONFIG_JOYSTICK_DB9 is not set
> # CONFIG_JOYSTICK_GAMECON is not set
> # CONFIG_JOYSTICK_TURBOGRAFX is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> # CONFIG_INPUT_MISC is not set
> 
> #
> # Character devices
> #
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_HW_CONSOLE=y
> CONFIG_SERIAL_NONSTANDARD=y
> # CONFIG_COMPUTONE is not set
> # CONFIG_ROCKETPORT is not set
> # CONFIG_CYCLADES is not set
> # CONFIG_DIGIEPCA is not set
> # CONFIG_DIGI is not set
> # CONFIG_MOXA_INTELLIO is not set
> # CONFIG_MOXA_SMARTIO is not set
> # CONFIG_ISI is not set
> # CONFIG_SYNCLINK is not set
> # CONFIG_SYNCLINKMP is not set
> # CONFIG_N_HDLC is not set
> # CONFIG_RISCOM8 is not set
> # CONFIG_SPECIALIX is not set
> # CONFIG_SX is not set
> # CONFIG_RIO is not set
> # CONFIG_STALDRV is not set
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_CONSOLE=y
> # CONFIG_SERIAL_8250_ACPI is not set
> CONFIG_SERIAL_8250_NR_UARTS=4
> # CONFIG_SERIAL_8250_EXTENDED is not set
> 
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> CONFIG_UNIX98_PTYS=y
> CONFIG_LEGACY_PTYS=y
> CONFIG_LEGACY_PTY_COUNT=256
> CONFIG_PRINTER=m
> # CONFIG_LP_CONSOLE is not set
> CONFIG_PPDEV=m
> # CONFIG_TIPAR is not set
> 
> #
> # IPMI
> #
> CONFIG_IPMI_HANDLER=m
> CONFIG_IPMI_PANIC_EVENT=y
> # CONFIG_IPMI_PANIC_STRING is not set
> CONFIG_IPMI_DEVICE_INTERFACE=m
> # CONFIG_IPMI_SI is not set
> CONFIG_IPMI_WATCHDOG=m
> # CONFIG_IPMI_POWEROFF is not set
> 
> #
> # Watchdog Cards
> #
> CONFIG_WATCHDOG=y
> # CONFIG_WATCHDOG_NOWAYOUT is not set
> 
> #
> # Watchdog Device Drivers
> #
> # CONFIG_SOFT_WATCHDOG is not set
> # CONFIG_ACQUIRE_WDT is not set
> # CONFIG_ADVANTECH_WDT is not set
> # CONFIG_ALIM1535_WDT is not set
> # CONFIG_ALIM7101_WDT is not set
> # CONFIG_SC520_WDT is not set
> # CONFIG_EUROTECH_WDT is not set
> # CONFIG_IB700_WDT is not set
> # CONFIG_WAFER_WDT is not set
> # CONFIG_I8XX_TCO is not set
> # CONFIG_SC1200_WDT is not set
> # CONFIG_SCx200_WDT is not set
> # CONFIG_60XX_WDT is not set
> # CONFIG_CPU5_WDT is not set
> CONFIG_W83627HF_WDT=m
> # CONFIG_W83877F_WDT is not set
> # CONFIG_MACHZ_WDT is not set
> 
> #
> # PCI-based Watchdog Cards
> #
> # CONFIG_PCIPCWATCHDOG is not set
> # CONFIG_WDTPCI is not set
> 
> #
> # USB-based Watchdog Cards
> #
> # CONFIG_USBPCWATCHDOG is not set
> CONFIG_HW_RANDOM=y
> # CONFIG_NVRAM is not set
> CONFIG_RTC=y
> # CONFIG_DTLK is not set
> # CONFIG_R3964 is not set
> # CONFIG_APPLICOM is not set
> # CONFIG_SONYPI is not set
> 
> #
> # Ftape, the floppy tape device driver
> #
> # CONFIG_FTAPE is not set
> CONFIG_AGP=y
> # CONFIG_AGP_ALI is not set
> # CONFIG_AGP_ATI is not set
> CONFIG_AGP_AMD=y
> # CONFIG_AGP_AMD64 is not set
> # CONFIG_AGP_INTEL is not set
> # CONFIG_AGP_INTEL_MCH is not set
> # CONFIG_AGP_NVIDIA is not set
> # CONFIG_AGP_SIS is not set
> # CONFIG_AGP_SWORKS is not set
> # CONFIG_AGP_VIA is not set
> # CONFIG_AGP_EFFICEON is not set
> CONFIG_DRM=y
> # CONFIG_DRM_TDFX is not set
> # CONFIG_DRM_GAMMA is not set
> # CONFIG_DRM_R128 is not set
> CONFIG_DRM_RADEON=y
> # CONFIG_DRM_MGA is not set
> # CONFIG_DRM_SIS is not set
> # CONFIG_MWAVE is not set
> # CONFIG_RAW_DRIVER is not set
> # CONFIG_HPET is not set
> CONFIG_HANGCHECK_TIMER=m
> 
> #
> # I2C support
> #
> CONFIG_I2C=m
> CONFIG_I2C_CHARDEV=m
> 
> #
> # I2C Algorithms
> #
> CONFIG_I2C_ALGOBIT=m
> CONFIG_I2C_ALGOPCF=m
> # CONFIG_I2C_ALGOPCA is not set
> 
> #
> # I2C Hardware Bus support
> #
> # CONFIG_I2C_ALI1535 is not set
> # CONFIG_I2C_ALI1563 is not set
> # CONFIG_I2C_ALI15X3 is not set
> CONFIG_I2C_AMD756=m
> # CONFIG_I2C_AMD8111 is not set
> # CONFIG_I2C_I801 is not set
> # CONFIG_I2C_I810 is not set
> # CONFIG_I2C_ISA is not set
> # CONFIG_I2C_NFORCE2 is not set
> # CONFIG_I2C_PARPORT is not set
> # CONFIG_I2C_PARPORT_LIGHT is not set
> # CONFIG_I2C_PIIX4 is not set
> # CONFIG_I2C_PROSAVAGE is not set
> # CONFIG_I2C_SAVAGE4 is not set
> # CONFIG_SCx200_ACB is not set
> # CONFIG_I2C_SIS5595 is not set
> # CONFIG_I2C_SIS630 is not set
> # CONFIG_I2C_SIS96X is not set
> # CONFIG_I2C_VIA is not set
> # CONFIG_I2C_VIAPRO is not set
> # CONFIG_I2C_VOODOO3 is not set
> # CONFIG_I2C_PCA_ISA is not set
> 
> #
> # Hardware Sensors Chip support
> #
> CONFIG_I2C_SENSOR=m
> # CONFIG_SENSORS_ADM1021 is not set
> # CONFIG_SENSORS_ADM1025 is not set
> # CONFIG_SENSORS_ADM1031 is not set
> # CONFIG_SENSORS_ASB100 is not set
> # CONFIG_SENSORS_DS1621 is not set
> # CONFIG_SENSORS_FSCHER is not set
> # CONFIG_SENSORS_GL518SM is not set
> # CONFIG_SENSORS_IT87 is not set
> # CONFIG_SENSORS_LM75 is not set
> # CONFIG_SENSORS_LM77 is not set
> # CONFIG_SENSORS_LM78 is not set
> # CONFIG_SENSORS_LM80 is not set
> # CONFIG_SENSORS_LM83 is not set
> # CONFIG_SENSORS_LM85 is not set
> # CONFIG_SENSORS_LM90 is not set
> # CONFIG_SENSORS_MAX1619 is not set
> # CONFIG_SENSORS_SMSC47M1 is not set
> # CONFIG_SENSORS_VIA686A is not set
> CONFIG_SENSORS_W83781D=m
> # CONFIG_SENSORS_W83L785TS is not set
> # CONFIG_SENSORS_W83627HF is not set
> 
> #
> # Other I2C Chip support
> #
> # CONFIG_SENSORS_EEPROM is not set
> # CONFIG_SENSORS_PCF8574 is not set
> # CONFIG_SENSORS_PCF8591 is not set
> # CONFIG_SENSORS_RTC8564 is not set
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> # CONFIG_I2C_DEBUG_CHIP is not set
> 
> #
> # Dallas's 1-wire bus
> #
> # CONFIG_W1 is not set
> 
> #
> # Misc devices
> #
> # CONFIG_IBM_ASM is not set
> 
> #
> # Multimedia devices
> #
> # CONFIG_VIDEO_DEV is not set
> 
> #
> # Digital Video Broadcasting Devices
> #
> # CONFIG_DVB is not set
> 
> #
> # Graphics support
> #
> CONFIG_FB=y
> CONFIG_FB_MODE_HELPERS=y
> # CONFIG_FB_CIRRUS is not set
> # CONFIG_FB_PM2 is not set
> # CONFIG_FB_CYBER2000 is not set
> # CONFIG_FB_ASILIANT is not set
> # CONFIG_FB_IMSTT is not set
> # CONFIG_FB_VGA16 is not set
> # CONFIG_FB_VESA is not set
> CONFIG_VIDEO_SELECT=y
> # CONFIG_FB_HGA is not set
> # CONFIG_FB_RIVA is not set
> # CONFIG_FB_I810 is not set
> # CONFIG_FB_MATROX is not set
> # CONFIG_FB_RADEON_OLD is not set
> CONFIG_FB_RADEON=m
> CONFIG_FB_RADEON_I2C=y
> # CONFIG_FB_RADEON_DEBUG is not set
> CONFIG_FB_ATY128=m
> # CONFIG_FB_ATY is not set
> # CONFIG_FB_SIS is not set
> # CONFIG_FB_NEOMAGIC is not set
> # CONFIG_FB_KYRO is not set
> # CONFIG_FB_3DFX is not set
> # CONFIG_FB_VOODOO1 is not set
> # CONFIG_FB_TRIDENT is not set
> # CONFIG_FB_PM3 is not set
> # CONFIG_FB_VIRTUAL is not set
> 
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=y
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_FRAMEBUFFER_CONSOLE=m
> # CONFIG_FONTS is not set
> CONFIG_FONT_8x8=y
> CONFIG_FONT_8x16=y
> 
> #
> # Logo configuration
> #
> CONFIG_LOGO=y
> CONFIG_LOGO_LINUX_MONO=y
> CONFIG_LOGO_LINUX_VGA16=y
> CONFIG_LOGO_LINUX_CLUT224=y
> 
> #
> # Sound
> #
> CONFIG_SOUND=y
> 
> #
> # Advanced Linux Sound Architecture
> #
> CONFIG_SND=y
> CONFIG_SND_TIMER=m
> CONFIG_SND_PCM=m
> CONFIG_SND_RAWMIDI=m
> CONFIG_SND_SEQUENCER=m
> # CONFIG_SND_SEQ_DUMMY is not set
> CONFIG_SND_OSSEMUL=y
> CONFIG_SND_MIXER_OSS=m
> CONFIG_SND_PCM_OSS=m
> # CONFIG_SND_SEQUENCER_OSS is not set
> CONFIG_SND_RTCTIMER=m
> # CONFIG_SND_VERBOSE_PRINTK is not set
> # CONFIG_SND_DEBUG is not set
> 
> #
> # Generic devices
> #
> # CONFIG_SND_DUMMY is not set
> # CONFIG_SND_VIRMIDI is not set
> # CONFIG_SND_MTPAV is not set
> # CONFIG_SND_SERIAL_U16550 is not set
> # CONFIG_SND_MPU401 is not set
> 
> #
> # PCI devices
> #
> CONFIG_SND_AC97_CODEC=m
> # CONFIG_SND_ALI5451 is not set
> # CONFIG_SND_ATIIXP is not set
> # CONFIG_SND_ATIIXP_MODEM is not set
> # CONFIG_SND_AU8810 is not set
> # CONFIG_SND_AU8820 is not set
> # CONFIG_SND_AU8830 is not set
> # CONFIG_SND_AZT3328 is not set
> # CONFIG_SND_BT87X is not set
> # CONFIG_SND_CS46XX is not set
> # CONFIG_SND_CS4281 is not set
> # CONFIG_SND_EMU10K1 is not set
> # CONFIG_SND_KORG1212 is not set
> # CONFIG_SND_MIXART is not set
> # CONFIG_SND_NM256 is not set
> # CONFIG_SND_RME32 is not set
> # CONFIG_SND_RME96 is not set
> # CONFIG_SND_RME9652 is not set
> # CONFIG_SND_HDSP is not set
> # CONFIG_SND_TRIDENT is not set
> # CONFIG_SND_YMFPCI is not set
> # CONFIG_SND_ALS4000 is not set
> # CONFIG_SND_CMIPCI is not set
> CONFIG_SND_ENS1370=m
> CONFIG_SND_ENS1371=m
> # CONFIG_SND_ES1938 is not set
> # CONFIG_SND_ES1968 is not set
> # CONFIG_SND_MAESTRO3 is not set
> # CONFIG_SND_FM801 is not set
> # CONFIG_SND_ICE1712 is not set
> # CONFIG_SND_ICE1724 is not set
> # CONFIG_SND_INTEL8X0 is not set
> # CONFIG_SND_INTEL8X0M is not set
> # CONFIG_SND_SONICVIBES is not set
> # CONFIG_SND_VIA82XX is not set
> # CONFIG_SND_VX222 is not set
> 
> #
> # ALSA USB devices
> #
> # CONFIG_SND_USB_AUDIO is not set
> # CONFIG_SND_USB_USX2Y is not set
> 
> #
> # Open Sound System
> #
> # CONFIG_SOUND_PRIME is not set
> 
> #
> # USB support
> #
> CONFIG_USB=y
> # CONFIG_USB_DEBUG is not set
> 
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEVICEFS=y
> CONFIG_USB_BANDWIDTH=y
> # CONFIG_USB_DYNAMIC_MINORS is not set
> CONFIG_USB_SUSPEND=y
> # CONFIG_USB_OTG is not set
> 
> #
> # USB Host Controller Drivers
> #
> CONFIG_USB_EHCI_HCD=y
> # CONFIG_USB_EHCI_SPLIT_ISO is not set
> # CONFIG_USB_EHCI_ROOT_HUB_TT is not set
> CONFIG_USB_OHCI_HCD=y
> CONFIG_USB_UHCI_HCD=y
> 
> #
> # USB Device Class drivers
> #
> # CONFIG_USB_AUDIO is not set
> # CONFIG_USB_BLUETOOTH_TTY is not set
> # CONFIG_USB_MIDI is not set
> # CONFIG_USB_ACM is not set
> CONFIG_USB_PRINTER=m
> CONFIG_USB_STORAGE=y
> # CONFIG_USB_STORAGE_DEBUG is not set
> # CONFIG_USB_STORAGE_RW_DETECT is not set
> # CONFIG_USB_STORAGE_DATAFAB is not set
> # CONFIG_USB_STORAGE_FREECOM is not set
> CONFIG_USB_STORAGE_ISD200=y
> # CONFIG_USB_STORAGE_DPCM is not set
> # CONFIG_USB_STORAGE_HP8200e is not set
> # CONFIG_USB_STORAGE_SDDR09 is not set
> # CONFIG_USB_STORAGE_SDDR55 is not set
> # CONFIG_USB_STORAGE_JUMPSHOT is not set
> 
> #
> # USB Human Interface Devices (HID)
> #
> CONFIG_USB_HID=y
> CONFIG_USB_HIDINPUT=y
> # CONFIG_HID_FF is not set
> CONFIG_USB_HIDDEV=y
> # CONFIG_USB_AIPTEK is not set
> # CONFIG_USB_WACOM is not set
> # CONFIG_USB_KBTAB is not set
> # CONFIG_USB_POWERMATE is not set
> # CONFIG_USB_MTOUCH is not set
> # CONFIG_USB_EGALAX is not set
> # CONFIG_USB_XPAD is not set
> # CONFIG_USB_ATI_REMOTE is not set
> 
> #
> # USB Imaging devices
> #
> # CONFIG_USB_MDC800 is not set
> # CONFIG_USB_MICROTEK is not set
> # CONFIG_USB_HPUSBSCSI is not set
> 
> #
> # USB Multimedia devices
> #
> # CONFIG_USB_DABUSB is not set
> 
> #
> # Video4Linux support is needed for USB Multimedia device support
> #
> 
> #
> # USB Network adaptors
> #
> # CONFIG_USB_CATC is not set
> # CONFIG_USB_KAWETH is not set
> # CONFIG_USB_PEGASUS is not set
> # CONFIG_USB_RTL8150 is not set
> # CONFIG_USB_USBNET is not set
> 
> #
> # USB port drivers
> #
> # CONFIG_USB_USS720 is not set
> 
> #
> # USB Serial Converter support
> #
> CONFIG_USB_SERIAL=m
> CONFIG_USB_SERIAL_GENERIC=y
> CONFIG_USB_SERIAL_BELKIN=m
> CONFIG_USB_SERIAL_WHITEHEAT=m
> CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
> # CONFIG_USB_SERIAL_EMPEG is not set
> CONFIG_USB_SERIAL_FTDI_SIO=m
> CONFIG_USB_SERIAL_VISOR=m
> CONFIG_USB_SERIAL_IPAQ=m
> CONFIG_USB_SERIAL_IR=m
> CONFIG_USB_SERIAL_EDGEPORT=m
> # CONFIG_USB_SERIAL_EDGEPORT_TI is not set
> # CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
> CONFIG_USB_SERIAL_KEYSPAN=m
> # CONFIG_USB_SERIAL_KEYSPAN_MPR is not set
> # CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
> # CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
> # CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
> # CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
> # CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
> # CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
> # CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
> # CONFIG_USB_SERIAL_KEYSPAN_USA19QW is not set
> # CONFIG_USB_SERIAL_KEYSPAN_USA19QI is not set
> # CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
> # CONFIG_USB_SERIAL_KEYSPAN_USA49WLC is not set
> CONFIG_USB_SERIAL_KLSI=m
> # CONFIG_USB_SERIAL_KOBIL_SCT is not set
> CONFIG_USB_SERIAL_MCT_U232=m
> CONFIG_USB_SERIAL_PL2303=m
> # CONFIG_USB_SERIAL_SAFE is not set
> # CONFIG_USB_SERIAL_CYBERJACK is not set
> CONFIG_USB_SERIAL_XIRCOM=m
> CONFIG_USB_SERIAL_OMNINET=m
> CONFIG_USB_EZUSB=y
> 
> #
> # USB Miscellaneous drivers
> #
> # CONFIG_USB_EMI62 is not set
> # CONFIG_USB_EMI26 is not set
> # CONFIG_USB_TIGL is not set
> # CONFIG_USB_AUERSWALD is not set
> # CONFIG_USB_RIO500 is not set
> # CONFIG_USB_LEGOTOWER is not set
> # CONFIG_USB_LCD is not set
> # CONFIG_USB_LED is not set
> # CONFIG_USB_CYTHERM is not set
> # CONFIG_USB_PHIDGETSERVO is not set
> # CONFIG_USB_TEST is not set
> 
> #
> # USB Gadget Support
> #
> # CONFIG_USB_GADGET is not set
> 
> #
> # File systems
> #
> CONFIG_EXT2_FS=y
> CONFIG_EXT2_FS_XATTR=y
> CONFIG_EXT2_FS_POSIX_ACL=y
> CONFIG_EXT2_FS_SECURITY=y
> CONFIG_EXT3_FS=y
> CONFIG_EXT3_FS_XATTR=y
> CONFIG_EXT3_FS_POSIX_ACL=y
> # CONFIG_EXT3_FS_SECURITY is not set
> CONFIG_JBD=y
> # CONFIG_JBD_DEBUG is not set
> CONFIG_FS_MBCACHE=y
> CONFIG_REISERFS_FS=m
> # CONFIG_REISERFS_CHECK is not set
> CONFIG_REISERFS_PROC_INFO=y
> # CONFIG_REISERFS_FS_XATTR is not set
> CONFIG_JFS_FS=m
> CONFIG_JFS_POSIX_ACL=y
> CONFIG_JFS_DEBUG=y
> CONFIG_JFS_STATISTICS=y
> CONFIG_FS_POSIX_ACL=y
> CONFIG_XFS_FS=m
> # CONFIG_XFS_RT is not set
> CONFIG_XFS_QUOTA=y
> # CONFIG_XFS_SECURITY is not set
> # CONFIG_XFS_POSIX_ACL is not set
> CONFIG_MINIX_FS=m
> CONFIG_ROMFS_FS=m
> CONFIG_QUOTA=y
> CONFIG_QFMT_V1=m
> CONFIG_QFMT_V2=m
> CONFIG_QUOTACTL=y
> CONFIG_AUTOFS_FS=m
> CONFIG_AUTOFS4_FS=y
> 
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=m
> CONFIG_JOLIET=y
> CONFIG_ZISOFS=y
> CONFIG_ZISOFS_FS=m
> CONFIG_UDF_FS=m
> CONFIG_UDF_NLS=y
> 
> #
> # DOS/FAT/NT Filesystems
> #
> CONFIG_FAT_FS=m
> CONFIG_MSDOS_FS=m
> CONFIG_VFAT_FS=m
> CONFIG_FAT_DEFAULT_CODEPAGE=437
> CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
> CONFIG_NTFS_FS=m
> CONFIG_NTFS_DEBUG=y
> CONFIG_NTFS_RW=y
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> CONFIG_PROC_KCORE=y
> CONFIG_SYSFS=y
> # CONFIG_DEVFS_FS is not set
> # CONFIG_DEVPTS_FS_XATTR is not set
> CONFIG_TMPFS=y
> # CONFIG_HUGETLBFS is not set
> # CONFIG_HUGETLB_PAGE is not set
> CONFIG_RAMFS=y
> 
> #
> # Miscellaneous filesystems
> #
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_HFS_FS is not set
> # CONFIG_HFSPLUS_FS is not set
> # CONFIG_BEFS_FS is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_EFS_FS is not set
> CONFIG_CRAMFS=m
> # CONFIG_VXFS_FS is not set
> # CONFIG_HPFS_FS is not set
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_SYSV_FS is not set
> CONFIG_UFS_FS=m
> CONFIG_UFS_FS_WRITE=y
> 
> #
> # Network File Systems
> #
> CONFIG_NFS_FS=m
> CONFIG_NFS_V3=y
> CONFIG_NFS_V4=y
> # CONFIG_NFS_DIRECTIO is not set
> CONFIG_NFSD=m
> CONFIG_NFSD_V3=y
> CONFIG_NFSD_V4=y
> CONFIG_NFSD_TCP=y
> CONFIG_LOCKD=m
> CONFIG_LOCKD_V4=y
> CONFIG_EXPORTFS=m
> CONFIG_SUNRPC=m
> CONFIG_SUNRPC_GSS=m
> CONFIG_RPCSEC_GSS_KRB5=m
> # CONFIG_RPCSEC_GSS_SPKM3 is not set
> CONFIG_SMB_FS=m
> # CONFIG_SMB_NLS_DEFAULT is not set
> CONFIG_CIFS=m
> # CONFIG_CIFS_STATS is not set
> # CONFIG_CIFS_XATTR is not set
> # CONFIG_CIFS_POSIX is not set
> # CONFIG_NCP_FS is not set
> # CONFIG_CODA_FS is not set
> # CONFIG_AFS_FS is not set
> 
> #
> # Partition Types
> #
> # CONFIG_PARTITION_ADVANCED is not set
> CONFIG_MSDOS_PARTITION=y
> 
> #
> # Native Language Support
> #
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="cp850"
> CONFIG_NLS_CODEPAGE_437=m
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> CONFIG_NLS_CODEPAGE_850=m
> # CONFIG_NLS_CODEPAGE_852 is not set
> # CONFIG_NLS_CODEPAGE_855 is not set
> # CONFIG_NLS_CODEPAGE_857 is not set
> # CONFIG_NLS_CODEPAGE_860 is not set
> # CONFIG_NLS_CODEPAGE_861 is not set
> # CONFIG_NLS_CODEPAGE_862 is not set
> # CONFIG_NLS_CODEPAGE_863 is not set
> # CONFIG_NLS_CODEPAGE_864 is not set
> # CONFIG_NLS_CODEPAGE_865 is not set
> # CONFIG_NLS_CODEPAGE_866 is not set
> # CONFIG_NLS_CODEPAGE_869 is not set
> # CONFIG_NLS_CODEPAGE_936 is not set
> # CONFIG_NLS_CODEPAGE_950 is not set
> # CONFIG_NLS_CODEPAGE_932 is not set
> # CONFIG_NLS_CODEPAGE_949 is not set
> # CONFIG_NLS_CODEPAGE_874 is not set
> # CONFIG_NLS_ISO8859_8 is not set
> # CONFIG_NLS_CODEPAGE_1250 is not set
> # CONFIG_NLS_CODEPAGE_1251 is not set
> # CONFIG_NLS_ASCII is not set
> CONFIG_NLS_ISO8859_1=m
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_13 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> # CONFIG_NLS_ISO8859_15 is not set
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_KOI8_U is not set
> # CONFIG_NLS_UTF8 is not set
> 
> #
> # Profiling support
> #
> CONFIG_PROFILING=y
> CONFIG_OPROFILE=m
> 
> #
> # Kernel hacking
> #
> CONFIG_DEBUG_KERNEL=y
> CONFIG_MAGIC_SYSRQ=y
> # CONFIG_DEBUG_SLAB is not set
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
> # CONFIG_DEBUG_HIGHMEM is not set
> # CONFIG_DEBUG_INFO is not set
> # CONFIG_FRAME_POINTER is not set
> CONFIG_EARLY_PRINTK=y
> # CONFIG_DEBUG_STACKOVERFLOW is not set
> # CONFIG_KPROBES is not set
> # CONFIG_DEBUG_STACK_USAGE is not set
> # CONFIG_DEBUG_PAGEALLOC is not set
> # CONFIG_4KSTACKS is not set
> # CONFIG_SCHEDSTATS is not set
> CONFIG_X86_FIND_SMP_CONFIG=y
> CONFIG_X86_MPPARSE=y
> 
> #
> # Security options
> #
> # CONFIG_SECURITY is not set
> 
> #
> # Cryptographic options
> #
> CONFIG_CRYPTO=y
> CONFIG_CRYPTO_HMAC=y
> CONFIG_CRYPTO_NULL=m
> CONFIG_CRYPTO_MD4=m
> CONFIG_CRYPTO_MD5=m
> CONFIG_CRYPTO_SHA1=m
> CONFIG_CRYPTO_SHA256=m
> CONFIG_CRYPTO_SHA512=m
> CONFIG_CRYPTO_WP512=m
> CONFIG_CRYPTO_DES=m
> CONFIG_CRYPTO_BLOWFISH=m
> CONFIG_CRYPTO_TWOFISH=m
> CONFIG_CRYPTO_SERPENT=m
> CONFIG_CRYPTO_AES_586=m
> CONFIG_CRYPTO_CAST5=m
> CONFIG_CRYPTO_CAST6=m
> CONFIG_CRYPTO_TEA=m
> CONFIG_CRYPTO_ARC4=m
> CONFIG_CRYPTO_KHAZAD=m
> CONFIG_CRYPTO_DEFLATE=m
> CONFIG_CRYPTO_MICHAEL_MIC=m
> CONFIG_CRYPTO_CRC32C=m
> CONFIG_CRYPTO_TEST=m
> 
> #
> # Library routines
> #
> CONFIG_CRC_CCITT=m
> CONFIG_CRC32=m
> CONFIG_LIBCRC32C=m
> CONFIG_ZLIB_INFLATE=m
> CONFIG_ZLIB_DEFLATE=m
> CONFIG_X86_SMP=y
> CONFIG_X86_HT=y
> CONFIG_X86_BIOS_REBOOT=y
> CONFIG_X86_TRAMPOLINE=y
> CONFIG_PC=y


-- 
Pedro Larroy Tovar | Linux & Network consultant |  pedro%larroy.com 
Make debian mirrors with debian-multimirror: http://pedro.larroy.com/deb_mm/
	* Las patentes de programación son nocivas para la innovación * 
				http://proinnova.hispalinux.es/
