Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281235AbRKLEYG>; Sun, 11 Nov 2001 23:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281239AbRKLEXs>; Sun, 11 Nov 2001 23:23:48 -0500
Received: from cx518206-a.irvn1.occa.home.com ([24.21.107.122]:5625 "HELO
	pobox.com") by vger.kernel.org with SMTP id <S281235AbRKLEXn>;
	Sun, 11 Nov 2001 23:23:43 -0500
Subject: [BUG] 2.4.15-pre3 compile failure
To: linux-kernel@vger.kernel.org
Date: Sun, 11 Nov 2001 20:24:13 -0800 (PST)
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20011112042413.39000898E3@pobox.com>
From: barryn@pobox.com (Barry K. Nathan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make[3]: Entering directory `/home/barryn/lsoft/kernels/2.4/build/linux-2.4.15-pre3-iserv/fs/proc'
gcc -D__KERNEL__ -I/home/barryn/lsoft/kernels/2.4/build/linux-2.4.15-pre3-iserv/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686    -c -o proc_misc.o proc_misc.c
proc_misc.c: In function `proc_misc_init':
proc_misc.c:573: `proc_ksyms_operations' undeclared (first use in this function)proc_misc.c:573: (Each undeclared identifier is reported only once
proc_misc.c:573: for each function it appears in.)
make[3]: *** [proc_misc.o] Error 1
make[3]: Leaving directory `/home/barryn/lsoft/kernels/2.4/build/linux-2.4.15-pre3-iserv/fs/proc'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/home/barryn/lsoft/kernels/2.4/build/linux-2.4.15-pre3-iserv/fs/proc'
make[1]: *** [_subdir_proc] Error 2
make[1]: Leaving directory `/home/barryn/lsoft/kernels/2.4/build/linux-2.4.15-pre3-iserv/fs'
make: *** [_dir_fs] Error 2

`grep ^C .config` follows. Perhaps most notable is that this kernel is
being built without module support.

-Barry K. Nathan <barryn@pobox.com>

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_M686=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_PM=y
CONFIG_APM=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_PACKET=y
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_IP_NF_COMPAT_IPCHAINS=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_PCNET32=y
CONFIG_PPP=y
CONFIG_PPP_ASYNC=y
CONFIG_PPP_DEFLATE=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_TMPFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_MINIX_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_UTF8=y
CONFIG_VGA_CONSOLE=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_OHCI=y
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_PL2303=y
