Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312458AbSDEKys>; Fri, 5 Apr 2002 05:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312464AbSDEKyj>; Fri, 5 Apr 2002 05:54:39 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:41227 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S312458AbSDEKyV>; Fri, 5 Apr 2002 05:54:21 -0500
Date: Fri, 5 Apr 2002 12:54:09 +0200
From: Jurriaan on Alpha <thunder7@xs4all.nl>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Linux 2.4.19-pre6 doesn't compile on Alpha
Message-ID: <20020405105409.GA29804@alpha.of.nowhere>
Reply-To: thunder7@xs4all.nl
In-Reply-To: <Pine.LNX.4.21.0204050159130.10818-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcelo Tosatti <marcelo@conectiva.com.br>
Date: Fri, Apr 05, 2002 at 02:00:18AM -0300
> 
> Hi,
> 
> Here goes pre6.
> 
Patched 2.4.19pre5 to pre6 without errors, ran 
make mrproper menuconfig dep clean boot:

init/do_mounts.c:45: parse error before `mount_initrd'
init/do_mounts.c:45: warning: type defaults to `int' in declaration of `mount_initrd'
init/do_mounts.c:45: warning: data definition has no type or storage class
init/do_mounts.c:48: parse error before `rd_doload'
init/do_mounts.c:48: warning: type defaults to `int' in declaration of `rd_doload'
init/do_mounts.c:48: warning: data definition has no type or storage class
init/do_mounts.c:58: parse error before `load_ramdisk'
init/do_mounts.c:59: warning: return-type defaults to `int'
init/do_mounts.c:63: parse error before string constant
init/do_mounts.c:63: warning: type defaults to `int' in declaration of `__setup'
init/do_mounts.c:63: warning: function declaration isn't a prototype
init/do_mounts.c:63: warning: data definition has no type or storage class
init/do_mounts.c:65: parse error before `readonly'
init/do_mounts.c:66: warning: return-type defaults to `int'
init/do_mounts.c:73: parse error before `readwrite'
init/do_mounts.c:74: warning: return-type defaults to `int'
init/do_mounts.c:81: parse error before string constant
init/do_mounts.c:81: warning: type defaults to `int' in declaration of `__setup'
[some 700 almost identical lines snipped]
make: *** [init/do_mounts.o] Error 1

This is Debian/Alpha.
.config:

CONFIG_ALPHA=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_ALPHA_MIATA=y
CONFIG_ISA=y
CONFIG_EISA=y
CONFIG_PCI=y
CONFIG_ALPHA_EV5=y
CONFIG_ALPHA_CIA=y
CONFIG_ALPHA_PYXIS=y
CONFIG_ALPHA_SRM=y
CONFIG_PCI_NAMES=y
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID5=y
CONFIG_PACKET=y
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_COMPAT_IPCHAINS=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_CMD64X=y
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_PDC202XX_BURST=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_NET_PCI=y
CONFIG_TULIP=y
CONFIG_DE4X5=y
CONFIG_YELLOWFIN=y
# ISDN subsystem
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_UNIX98_PTYS=y
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_RTC=y
CONFIG_DRM=y
CONFIG_DRM_NEW=y
CONFIG_DRM_TDFX=y
CONFIG_REISERFS_FS=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_TMPFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_UDF_FS=y
CONFIG_PARTITION_ADVANCED=y
CONFIG_OSF_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_VGA_CONSOLE=y
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_3DFX=y
CONFIG_FBCON_ADVANCED=y
CONFIG_FBCON_CFB4=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FBCON_FONTS=y
CONFIG_FONT_SUN12x22=y
CONFIG_PCI_CONSOLE=y
CONFIG_SOUND=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_OHCI=y
CONFIG_USB_STORAGE=y
CONFIG_USB_SCANNER=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MATHEMU=y
CONFIG_MAGIC_SYSRQ=y

If you need any more info, please let me know.

Thanks,
Jurriaan
-- 
I do not want people to be agreeable, as it saves me the trouble of liking them.
GNU/Linux 2.4.19p5 on Debian/Alpha 988 bogomips load:1.14 1.56 0.85
