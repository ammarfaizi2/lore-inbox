Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264797AbTFYRtV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 13:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264844AbTFYRtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 13:49:20 -0400
Received: from 65-124-64-15.rdsl.ktc.com ([65.124.64.15]:29824 "EHLO
	csi.csimillwork.com") by vger.kernel.org with ESMTP id S264797AbTFYRsl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 13:48:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: joe briggs <jbriggs@briggsmedia.com>
Organization: BMS
To: Artur Jasowicz <kernel@mousebusiness.com>,
       Brian Jackson <brian@brianandsara.net>,
       Bart SCHELSTRAETE <Bart.SCHELSTRAETE@dhl.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: AMD MP, SMP, Tyan 2466
Date: Wed, 25 Jun 2003 15:01:14 -0400
User-Agent: KMail/1.4.3
References: <BB1F47F5.17533%kernel@mousebusiness.com>
In-Reply-To: <BB1F47F5.17533%kernel@mousebusiness.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200306251501.14207.jbriggs@briggsmedia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to mention - 
I tried this board with PC2100 bought from the local computer store (don't 
know the name) and I got all kinds of weird problems like boot failure, file 
system corruption, everything except a memory error.  I then tried a 512 mb 
stick of kingston pc2100 and it completely solved the problems.


On Wednesday 25 June 2003 01:37 pm, Artur Jasowicz wrote:
> To make sure that I have a clean environment I've reinstalled RedHat 9
> workstation. This is supposed to give a complete set of tools for software
> development. It did not install kernel sources though, so I've installed
> that RPM. It installed sources for 2.4.20.
>
> Then I've downloaded kernel 2.4.21 from vger. I placed the decompressed
> source in /home/linux2.4.21/. I based my configuration on RedHat's config
> for AMD SMP (included in kernel source RPM) and on
> linux-2.4.21/arch/i386/defconfig. Recompiled the kernel.
>
> On first attempt to boot from that new kernel the machine started acting up
> and eventually froze. I've tried rebooting from RedHat installed non-SMP
> kernel a couple of times and kept getting stuck in various places during
> the boot.
>
> I started suspecting the RAM. I replaced the Corsair PC2100 1GB module with
> a 512M module. The machine started working fine under RedHat kernel.
> Switched to my SMP kernel - it ran fine except for one time when it simply
> logged me out while I was in the middle of typing a bash command.
>
> I've logged back in, recompiled Promise driver while running in SMP. This
> was the first time I was able to do that in SMP. I've loaded the driver,
> left machine running overnight. Came in this morning - machine was still
> up. I attempted to copy some files to Promise Raid volume. The machine
> locked up in the middle of transfer. I tried to reboot in SMP and it failed
> each time. I rebooted with RedHat's 2.4.20-8smp kernel but with nosmp boot
> parameter and it came up ok. Rebooted the same kernel without the nosmp
> parameter and it did this:
>
> Checking root filesystem
> /:clean, 24049/131328 files, 45328/262144 blocks
> Remounting root filesystem in read-write mode   [OK]
> Activation swap partitions:    [OK]
> /etc/rc.d/rc.sysinit: line 349: [: command not found
> //the above message repeated for 12 more lines, not subsequent
> //though, e.g. 350, 356, 360.
>
> mounting local filesystems: [OK]
> Enabling local filesystem quotas:   [OK]
> malloc: make_cmd.c: 96: assertion blotched
> malloc: block on free list clobbered
>                                             Stopping myself...
>
> // FROZEN, rebooted from RH 2.4.20-8smp
> checking for new hardware/etc/rc3.d/S05kudzu: line 93 211 segmentation
> fault /usr/sbin/kudzu $KUDZU_ARGS -t 30   [FAILED]
> Updating /etc/fstab [OK]
> Setting network parameters  [OK]
> Bringing up loopback interface
> //FROZEN, rebooted from RH 2.4.20-8smp with nosmp parameter - booted fine.
>
> In my .config I tried to strip as much as possible, although I left some
> things in that I was not sure about.
>
> Brian:
> > .config please
>
> See below
>
> Bart:
> > Did you compile this kernel yourself?
> > I think so, and I think there's something wrong with your compiler.
>
> Yes I did. To avoid possibility of poorly configured compiler, I've
> reinstalled a clean Red Hat 9 in workstation flavor. This is supposed to
> install all tools necessary for software development. As long as RedHat's
> installer didn't mess anything up, my compiler should be fine now, right?
>
> > And here's something wrong with your glibc.........
>
> Whatever glibc was used was installed from RH's distro. How can I make sure
> that I am using a good copy of it?
>
> Any suggestions on what to try next?
>
> Artur
>
>
> CONFIG_X86=y
> CONFIG_UID16=y
> CONFIG_EXPERIMENTAL=y
> CONFIG_MODULES=y
> CONFIG_MODVERSIONS=y
> CONFIG_KMOD=y
> CONFIG_MK7=y
> CONFIG_X86_WP_WORKS_OK=y
> CONFIG_X86_INVLPG=y
> CONFIG_X86_CMPXCHG=y
> CONFIG_X86_XADD=y
> CONFIG_X86_BSWAP=y
> CONFIG_X86_POPAD_OK=y
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_X86_L1_CACHE_SHIFT=6
> CONFIG_X86_HAS_TSC=y
> CONFIG_X86_GOOD_APIC=y
> CONFIG_X86_USE_3DNOW=y
> CONFIG_X86_PGE=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> CONFIG_X86_F00F_WORKS_OK=y
> CONFIG_X86_MCE=y
> CONFIG_MICROCODE=m
> CONFIG_X86_MSR=m
> CONFIG_X86_CPUID=m
> CONFIG_NOHIGHMEM=y
> CONFIG_MTRR=y
> CONFIG_SMP=y
> CONFIG_X86_TSC=y
> CONFIG_HAVE_DEC_LOCK=y
> CONFIG_NET=y
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_PCI=y
> CONFIG_PCI_GOANY=y
> CONFIG_PCI_BIOS=y
> CONFIG_PCI_DIRECT=y
> CONFIG_ISA=y
> CONFIG_PCI_NAMES=y
> CONFIG_SYSVIPC=y
> CONFIG_BSD_PROCESS_ACCT=y
> CONFIG_SYSCTL=y
> CONFIG_KCORE_ELF=y
> CONFIG_BINFMT_AOUT=m
> CONFIG_BINFMT_ELF=y
> CONFIG_BINFMT_MISC=m
> CONFIG_PARPORT=m
> CONFIG_PARPORT_PC=m
> CONFIG_PARPORT_PC_CML1=m
> CONFIG_PARPORT_SERIAL=m
> CONFIG_PARPORT_PC_FIFO=y
> CONFIG_PARPORT_1284=y
> CONFIG_PNP=y
> CONFIG_ISAPNP=y
> CONFIG_BLK_DEV_FD=y
> CONFIG_BLK_DEV_LOOP=y
> CONFIG_BLK_DEV_RAM=y
> CONFIG_BLK_DEV_RAM_SIZE=4096
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_MD=y
> CONFIG_BLK_DEV_MD=m
> CONFIG_MD_RAID0=m
> CONFIG_MD_RAID1=m
> CONFIG_MD_RAID5=m
> CONFIG_BLK_DEV_LVM=m
> CONFIG_PACKET=m
> CONFIG_PACKET_MMAP=y
> CONFIG_NETLINK_DEV=m
> CONFIG_UNIX=y
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> CONFIG_VLAN_8021Q=m
> CONFIG_ATALK=m
> CONFIG_IDE=y
> CONFIG_BLK_DEV_IDE=y
> CONFIG_BLK_DEV_IDEDISK=y
> CONFIG_IDEDISK_MULTI_MODE=y
> CONFIG_BLK_DEV_IDECD=y
> CONFIG_BLK_DEV_IDETAPE=m
> CONFIG_BLK_DEV_IDESCSI=m
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_BLK_DEV_GENERIC=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> CONFIG_IDEDMA_PCI_AUTO=y
> CONFIG_BLK_DEV_IDEDMA=y
> CONFIG_IDEDMA_AUTO=y
> CONFIG_BLK_DEV_IDE_MODES=y
> CONFIG_BLK_DEV_ATARAID=m
> CONFIG_BLK_DEV_ATARAID_PDC=m
> CONFIG_SCSI=y
> CONFIG_BLK_DEV_SD=y
> CONFIG_SD_EXTRA_DEVS=16
> CONFIG_CHR_DEV_ST=m
> CONFIG_CHR_DEV_OSST=m
> CONFIG_BLK_DEV_SR=m
> CONFIG_SR_EXTRA_DEVS=2
> CONFIG_CHR_DEV_SG=m
> CONFIG_SCSI_DEBUG_QUEUES=y
> CONFIG_SCSI_CONSTANTS=y
> CONFIG_BLK_DEV_3W_XXXX_RAID=m
> CONFIG_I2O=m
> CONFIG_I2O_PCI=m
> CONFIG_I2O_BLOCK=m
> CONFIG_I2O_LAN=m
> CONFIG_I2O_SCSI=m
> CONFIG_I2O_PROC=m
> CONFIG_NETDEVICES=y
> CONFIG_DUMMY=m
> CONFIG_NET_ETHERNET=y
> CONFIG_NET_VENDOR_3COM=y
> CONFIG_VORTEX=m
> CONFIG_NS83820=m
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_SERIAL=y
> CONFIG_SERIAL_CONSOLE=y
> CONFIG_UNIX98_PTYS=y
> CONFIG_UNIX98_PTY_COUNT=256
> CONFIG_PRINTER=m
> CONFIG_I2C=m
> CONFIG_I2C_CHARDEV=m
> CONFIG_I2C_PROC=m
> CONFIG_MOUSE=m
> CONFIG_PSMOUSE=y
> CONFIG_IPMI_HANDLER=m
> CONFIG_IPMI_DEVICE_INTERFACE=m
> CONFIG_IPMI_KCS=m
> CONFIG_IPMI_WATCHDOG=m
> CONFIG_AMD_RNG=m
> CONFIG_RTC=m
> CONFIG_AGP=m
> CONFIG_AGP_AMD=y
> CONFIG_DRM=y
> CONFIG_DRM_NEW=y
> CONFIG_DRM_R128=m
> CONFIG_QUOTA=y
> CONFIG_AUTOFS4_FS=m
> CONFIG_REISERFS_FS=m
> CONFIG_HFS_FS=m
> CONFIG_EXT3_FS=y
> CONFIG_JBD=y
> CONFIG_FAT_FS=m
> CONFIG_MSDOS_FS=m
> CONFIG_VFAT_FS=m
> CONFIG_TMPFS=y
> CONFIG_RAMFS=y
> CONFIG_ISO9660_FS=m
> CONFIG_JOLIET=y
> CONFIG_JFS_FS=m
> CONFIG_NTFS_FS=m
> CONFIG_PROC_FS=y
> CONFIG_DEVPTS_FS=y
> CONFIG_EXT2_FS=y
> CONFIG_UDF_FS=m
> CONFIG_NFS_FS=m
> CONFIG_NFSD=m
> CONFIG_SUNRPC=m
> CONFIG_LOCKD=m
> CONFIG_SMB_FS=m
> CONFIG_PARTITION_ADVANCED=y
> CONFIG_MAC_PARTITION=y
> CONFIG_MSDOS_PARTITION=y
> CONFIG_BSD_DISKLABEL=y
> CONFIG_LDM_PARTITION=y
> CONFIG_SMB_NLS=y
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="iso8859-1"
> CONFIG_VGA_CONSOLE=y
> CONFIG_VIDEO_SELECT=y
> CONFIG_FB=y
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_VIDEO_SELECT=y
> CONFIG_FB_ATY128=m
> CONFIG_FBCON_CFB8=m
> CONFIG_FBCON_CFB16=m
> CONFIG_FBCON_CFB24=m
> CONFIG_FBCON_CFB32=m
> CONFIG_FONT_8x8=y
> CONFIG_FONT_8x16=y
> CONFIG_USB=m
> CONFIG_USB_EHCI_HCD=m
> CONFIG_USB_UHCI_ALT=m
> CONFIG_USB_OHCI=m
> CONFIG_USB_STORAGE=m
> CONFIG_USB_STORAGE_DPCM=y
> CONFIG_USB_STORAGE_SDDR09=y
> CONFIG_USB_STORAGE_SDDR55=y
> CONFIG_USB_STORAGE_JUMPSHOT=y
> CONFIG_USB_PRINTER=m
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Joe Briggs
Briggs Media Systems
105 Burnsen Ave.
Manchester NH 01304 USA
TEL 603-232-3115 FAX 603-625-5809 MOBILE 603-493-2386
www.briggsmedia.com
