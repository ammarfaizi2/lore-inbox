Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129807AbQLMJWn>; Wed, 13 Dec 2000 04:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129874AbQLMJWd>; Wed, 13 Dec 2000 04:22:33 -0500
Received: from netsrvr.ami.com.au ([203.55.31.38]:45876 "EHLO
	netsrvr.ami.com.au") by vger.kernel.org with ESMTP
	id <S129807AbQLMJW1>; Wed, 13 Dec 2000 04:22:27 -0500
Message-Id: <200012130649.eBD6mcZ02368@emu.os2.ami.com.au>
X-Mailer: exmh version 2.1.1 10/15/1999
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: DPMS kicks in at the wrong time
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_1809358760"
Date: Wed, 13 Dec 2000 14:48:47 +0800
From: John Summerfield <summer@OS2.ami.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_1809358760
Content-Type: text/plain; charset=us-ascii

System:
P II, ASUS P2L97-S motherboard (LX chipset plus onboard SCSI).
Currently I740-based video card, Sony Multiscan SFII.
Linux possum 2.4.0-test12 #6 Wed Dec 13 13:43:54 WST 2000 i686 



It's happened on this machine with every kernel I've tried it, right back to 
(I'm pretty sure) 2.1 days.

Whenever I try frame buffer support, this is what happens:
1) I can boot up with the logo, lots of characters across the screen, and 
Linux happily writing on my console.

2) I can switch to a graphics display, either with KDM/GDM/XDM, or by logging 
in and starting X.
3) When I then switch back to a virtual console, the screen blanks and 
switches to power-saving mode.



Here's the config:



--==_Exmh_1809358760
Content-Type: text/plain ; name="ZZ"; charset=us-ascii
Content-Description: ZZ
Content-Disposition: attachment; filename="ZZ"

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_M686=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_MSR=y
CONFIG_NOHIGHMEM=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_PARPORT=m
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
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
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_IDEDMA_AUTO=y
CONFIG_IDEDMA_IVB=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_TCQ_ON_BY_DEFAULT=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
CONFIG_AIC7XXX_PROC_STATS=y
CONFIG_AIC7XXX_RESET_DELAY=5
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_EPIC100=y
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
CONFIG_SLIP=m
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_EVDEV=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_AGP=m
CONFIG_AGP_INTEL=y
CONFIG_DRM=y
CONFIG_AUTOFS4_FS=y
CONFIG_ISO9660_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=y
CONFIG_NFSD=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_MSDOS_PARTITION=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SOUND=y
CONFIG_SOUND_ES1371=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI_ALT=y
CONFIG_USB_MOUSE=y
CONFIG_MAGIC_SYSRQ=y

--==_Exmh_1809358760
Content-Type: text/plain; charset=us-ascii

Cheers
John Summerfield
http://www2.ami.com.au/ for OS/2 & linux information.
Configuration, networking, combined IBM ftpsites index.

--==_Exmh_1809358760--


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
