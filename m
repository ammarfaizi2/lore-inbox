Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132873AbRAWAcW>; Mon, 22 Jan 2001 19:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135608AbRAWAcM>; Mon, 22 Jan 2001 19:32:12 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:31176 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S132873AbRAWAb5>; Mon, 22 Jan 2001 19:31:57 -0500
Date: Tue, 23 Jan 2001 01:31:55 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: Karsten Keil <keil@isdn4linux.de>, linux-kernel@vger.kernel.org
Subject: BUG in modutils or drivers/isdn/hisax/
Message-ID: <20010123013155.E1173@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith,
hi Karsten,
hi linux-kernel,

the current modutils (2.4.1) cannot read the
__module_pci_device_table of a kernel/drivers/isdn/hisax/hisax.o
module of linux 2.4.0 (vanilla).

What's wrong with it?

The compiler is gcc 2.95.2 (as shipped with debian potato). All
other module device tables can be read. USB has not been
compiled.


Thanks & Regards

Ingo Oeser


Now the gory details (ask for more if needed)...

I checked:

depmod -e -n /path/to/hisax.o (showed an empty pci table)
depmod -e -n /path/to/8139too.o (showed a complete pci table)

configured in core:

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_M586TSC=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_USE_STRING_486=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_TSC=y
CONFIG_NOHIGHMEM=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_1284=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_RAM=y
CONFIG_PACKET_MMAP=y
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_SYN_COOKIES=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_PPP_MULTILINK=y
CONFIG_ISDN_PPP=y
CONFIG_ISDN_PPP_VJ=y
CONFIG_ISDN_MPP=y
CONFIG_HISAX_EURO=y
CONFIG_DE_AOC=y
CONFIG_HISAX_FRITZPCI=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_SERIAL_EXTENDED=y
CONFIG_SERIAL_DETECT_IRQ=y
CONFIG_AUTOFS4_FS=y
CONFIG_CRAMFS=y
CONFIG_RAMFS=y
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_EXT2_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_VGA_CONSOLE=y
CONFIG_MAGIC_SYSRQ=y

configured as modules:

CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PNP=m
CONFIG_ISAPNP=m
CONFIG_PACKET=m
CONFIG_NET_IPIP=m
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_COMPAT_IPCHAINS=m
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_SCSI=m
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_NE2K_PCI=m
CONFIG_8139TOO=m
CONFIG_RTL8129=m
CONFIG_PPP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
CONFIG_ISDN=m
CONFIG_ISDN_DRV_HISAX=m
CONFIG_PRINTER=m
CONFIG_RTC=m
CONFIG_ISO9660_FS=m
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_UTF8=m

That's all so far. Need more? Just ask.
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
