Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132433AbRACQK2>; Wed, 3 Jan 2001 11:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132453AbRACQKT>; Wed, 3 Jan 2001 11:10:19 -0500
Received: from staff0138.dada.it ([195.110.97.138]:59531 "EHLO
	blacksheep.at.dada.it") by vger.kernel.org with ESMTP
	id <S132433AbRACQKI>; Wed, 3 Jan 2001 11:10:08 -0500
Date: Wed, 3 Jan 2001 16:33:34 +0100 (CET)
From: Patrizio Bruno <patrizio@dada.it>
To: John Summerfield <summer@OS2.ami.com.au>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.0-test12 hang
In-Reply-To: <200101031330.f03DU4Q02199@emu.os2.ami.com.au>
Message-ID: <Pine.LNX.4.10.10101031631570.27828-100000@blacksheep.at.dada.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had the same problem on my machine, I solved unloading agpgart and drm
(r128.o for me, cause I have a Rage 128 video card), I think there's a bug
into the XFree drm support, but when I post the problem I received no reply.

P.

On Wed, 3 Jan 2001, John Summerfield wrote:

> 
> This kernel
> VERSION = 2
> PATCHLEVEL = 4
> SUBLEVEL = 0
> EXTRAVERSION = -test12
> 
> Sometimes locks solid (alt-sysrq doesn't work), sometimes less so (alt-sysrq 
> does work) but more often reboots when a user (me with my usual account, me 
> with an alternate little-user account) logs in and starts XFree, or logs in 
> through kdm.
> 
> I've reverted to an earlier build (vmlinuz.old) of the same kernel and all is 
> well again.
> 
> I don't have the old configuration file (.config) to compare with; the config 
> that fails follows at the end of this description.
> 
> 
> What I changed is a few network options; I'm setting up to play with uml and 
> chose options to allow ethertap and TUN. I also turned on the netfilter stuff, 
> and forwarding/masq
> 
> My video adaptor is i740-based, the motherboard an ASUS P2L97-S with BIOS 1010 
> beta 3 (I have been thinking of replacing my PII-233 with a Celeron, but 
> haven't done so).
> 
> 
> CONFIG_X86=y
> CONFIG_ISA=y
> CONFIG_UID16=y
> CONFIG_EXPERIMENTAL=y
> CONFIG_MODULES=y
> CONFIG_KMOD=y
> CONFIG_M686=y
> CONFIG_X86_WP_WORKS_OK=y
> CONFIG_X86_INVLPG=y
> CONFIG_X86_CMPXCHG=y
> CONFIG_X86_BSWAP=y
> CONFIG_X86_POPAD_OK=y
> CONFIG_X86_L1_CACHE_SHIFT=5
> CONFIG_X86_TSC=y
> CONFIG_X86_GOOD_APIC=y
> CONFIG_X86_PGE=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> CONFIG_X86_MSR=y
> CONFIG_NOHIGHMEM=y
> CONFIG_X86_UP_IOAPIC=y
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_NET=y
> CONFIG_PCI=y
> CONFIG_PCI_GOANY=y
> CONFIG_PCI_BIOS=y
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_NAMES=y
> CONFIG_HOTPLUG=y
> CONFIG_SYSVIPC=y
> CONFIG_BSD_PROCESS_ACCT=y
> CONFIG_SYSCTL=y
> CONFIG_KCORE_ELF=y
> CONFIG_BINFMT_ELF=y
> CONFIG_BINFMT_MISC=y
> CONFIG_PM=y
> CONFIG_ACPI=y
> CONFIG_PARPORT=m
> CONFIG_PARPORT_1284=y
> CONFIG_PNP=y
> CONFIG_BLK_DEV_FD=y
> CONFIG_BLK_DEV_LOOP=m
> CONFIG_PACKET=y
> CONFIG_NETLINK=y
> CONFIG_NETFILTER=y
> CONFIG_NETFILTER_DEBUG=y
> CONFIG_FILTER=y
> CONFIG_UNIX=y
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> CONFIG_IP_NF_CONNTRACK=y
> CONFIG_IP_NF_FTP=y
> CONFIG_IP_NF_IPTABLES=y
> CONFIG_IP_NF_FILTER=m
> CONFIG_IP_NF_TARGET_REJECT=m
> CONFIG_IP_NF_TARGET_MIRROR=m
> CONFIG_IP_NF_NAT=m
> CONFIG_IP_NF_NAT_NEEDED=y
> CONFIG_IP_NF_TARGET_MASQUERADE=m
> CONFIG_IP_NF_TARGET_REDIRECT=m
> CONFIG_IP_NF_MANGLE=m
> CONFIG_IP_NF_TARGET_LOG=m
> CONFIG_IDE=y
> CONFIG_BLK_DEV_IDE=y
> CONFIG_BLK_DEV_IDEDISK=y
> CONFIG_IDEDISK_MULTI_MODE=y
> CONFIG_BLK_DEV_IDECD=y
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> CONFIG_IDEDMA_PCI_AUTO=y
> CONFIG_BLK_DEV_IDEDMA=y
> CONFIG_BLK_DEV_PIIX=y
> CONFIG_PIIX_TUNING=y
> CONFIG_IDEDMA_AUTO=y
> CONFIG_IDEDMA_IVB=y
> CONFIG_BLK_DEV_IDE_MODES=y
> CONFIG_SCSI=y
> CONFIG_BLK_DEV_SD=y
> CONFIG_SD_EXTRA_DEVS=40
> CONFIG_BLK_DEV_SR=y
> CONFIG_BLK_DEV_SR_VENDOR=y
> CONFIG_SR_EXTRA_DEVS=2
> CONFIG_CHR_DEV_SG=y
> CONFIG_SCSI_DEBUG_QUEUES=y
> CONFIG_SCSI_MULTI_LUN=y
> CONFIG_SCSI_CONSTANTS=y
> CONFIG_SCSI_LOGGING=y
> CONFIG_SCSI_AIC7XXX=y
> CONFIG_AIC7XXX_TCQ_ON_BY_DEFAULT=y
> CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
> CONFIG_AIC7XXX_PROC_STATS=y
> CONFIG_AIC7XXX_RESET_DELAY=5
> CONFIG_NETDEVICES=y
> CONFIG_DUMMY=m
> CONFIG_TUN=m
> CONFIG_ETHERTAP=m
> CONFIG_NET_ETHERNET=y
> CONFIG_NET_PCI=y
> CONFIG_EPIC100=y
> CONFIG_PPP=m
> CONFIG_PPP_MULTILINK=y
> CONFIG_PPP_ASYNC=m
> CONFIG_PPP_DEFLATE=m
> CONFIG_PPP_BSDCOMP=m
> CONFIG_PPPOE=m
> CONFIG_SLIP=m
> CONFIG_INPUT=y
> CONFIG_INPUT_MOUSEDEV=y
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> CONFIG_INPUT_EVDEV=y
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_SERIAL=y
> CONFIG_UNIX98_PTYS=y
> CONFIG_UNIX98_PTY_COUNT=256
> CONFIG_PRINTER=m
> CONFIG_MOUSE=y
> CONFIG_PSMOUSE=y
> CONFIG_AGP=m
> CONFIG_AGP_INTEL=y
> CONFIG_DRM=y
> CONFIG_AUTOFS_FS=y
> CONFIG_AUTOFS4_FS=y
> CONFIG_FAT_FS=m
> CONFIG_MSDOS_FS=m
> CONFIG_JFFS_FS_VERBOSE=0
> CONFIG_ISO9660_FS=y
> CONFIG_JOLIET=y
> CONFIG_PROC_FS=y
> CONFIG_DEVPTS_FS=y
> CONFIG_EXT2_FS=y
> CONFIG_NFS_FS=y
> CONFIG_NFSD=y
> CONFIG_SUNRPC=y
> CONFIG_LOCKD=y
> CONFIG_MSDOS_PARTITION=y
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="iso8859-1"
> CONFIG_VGA_CONSOLE=y
> CONFIG_VIDEO_SELECT=y
> CONFIG_FB=y
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_FB_VESA=y
> CONFIG_VIDEO_SELECT=y
> CONFIG_FBCON_CFB8=y
> CONFIG_FBCON_CFB16=y
> CONFIG_FBCON_CFB24=y
> CONFIG_FBCON_CFB32=y
> CONFIG_FONT_8x8=y
> CONFIG_FONT_8x16=y
> CONFIG_SOUND=m
> CONFIG_SOUND_ES1371=m
> CONFIG_USB=y
> CONFIG_USB_DEVICEFS=y
> CONFIG_USB_UHCI_ALT=y
> CONFIG_USB_MOUSE=y
> CONFIG_MAGIC_SYSRQ=y
> 
> -- 
> Cheers
> John Summerfield
> http://www2.ami.com.au/ for OS/2 & linux information.
> Configuration, networking, combined IBM ftpsites index.
> 
> Note: mail delivered to me is deemed to be intended for me, for my disposition.
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

---------------------------------------------------------
Patrizio Bruno
DADA spa / Ed-IT Development Staff
Borgo degli Albizi 37/r
50122 Firenze
Italy
tel +39 05520351
fax +39 0552478143

PGP PublicKey available at: http://www.keyserver.net/en/
---------------------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
