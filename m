Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269404AbRIMLku>; Thu, 13 Sep 2001 07:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268940AbRIMLkk>; Thu, 13 Sep 2001 07:40:40 -0400
Received: from host217-32-117-20.in-addr.btopenworld.com ([217.32.117.20]:35223
	"EHLO buffy.monodef.org") by vger.kernel.org with ESMTP
	id <S269041AbRIMLka>; Thu, 13 Sep 2001 07:40:30 -0400
Message-Id: <200109131139.f8DBdxj0022606@buffy.monodef.org>
Content-Type: text/plain; charset=US-ASCII
From: S Fox <stuart@tech-tonic.org>
To: linux-kernel@vger.kernel.org
Subject: Strange swap problem on 2.4.5
Date: Thu, 13 Sep 2001 12:40:42 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all

First post so be kind.

I have a problem on a webserver with the following hardware(RH6.2 
/etc/sysconfig/hwconf)

class: OTHER
bus: PCI
detached: 0
driver: unknown
desc: "Relience Computer|CNB20HE"
vendorId: 1166
deviceId: 0009
pciType: 1
-
class: OTHER
bus: PCI
detached: 0
driver: unknown
desc: "Relience Computer|CNB20HE"
vendorId: 1166
deviceId: 0009
pciType: 1
-
class: OTHER
bus: PCI
detached: 0
driver: unknown
desc: "Relience Computer|unknown device 1166:0200"
vendorId: 1166
deviceId: 0200
pciType: 1
-
class: OTHER
bus: PCI
detached: 0
driver: unknown
desc: "Relience Computer|unknown device 1166:0211"
vendorId: 1166
deviceId: 0211
pciType: 1
-
class: OTHER
bus: PCI
detached: 0
driver: unknown
desc: "Relience Computer|unknown device 1166:0220"
vendorId: 1166
deviceId: 0220
pciType: 1
-
class: NETWORK
bus: PCI
detached: 0
device: eth
driver: eepro100
desc: "Intel Corporation|82557 [Ethernet Pro 100]"
vendorId: 8086
deviceId: 1229
pciType: 1
-
class: NETWORK
bus: PCI
detached: 0
device: eth
driver: eepro100
desc: "Intel Corporation|82557 [Ethernet Pro 100]"
vendorId: 8086
deviceId: 1229
pciType: 1
-
class: SCSI
bus: PCI
detached: 0
driver: unknown
desc: "Symbios|unknown device 1000:0020"
vendorId: 1000
deviceId: 0020
pciType: 1
-
class: SCSI
bus: PCI
detached: 0
driver: unknown
desc: "Symbios|unknown device 1000:0020"
vendorId: 1000
deviceId: 0020
pciType: 1
-
class: VIDEO
bus: PCI
detached: 0
driver: unknown
desc: "ATI|unknown device 1002:4752"
vendorId: 1002
deviceId: 4752
pciType: 1
-
class: MOUSE
bus: PSAUX
detached: 0
device: psaux
driver: genericps/2
desc: "Generic PS/2 Mouse"
-
class: CDROM
bus: IDE
detached: 0
device: hda
driver: ignore
desc: "CD-540E"
-
class: HD
bus: SCSI
detached: 0
device: sda
driver: ignore
desc: "Fujitsu MAJ3182MP"
host: 1
id: 0
channel: 0
lun: 0

Dual pIII 1000, 1gb mem, 1gb swap

.config from kernel is
CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_MPENTIUMIII=y
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
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_BLK_DEV_FD=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_SYN_COOKIES=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_SYM53C8XX=y
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=4
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=20
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_EEPRO100=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_INTEL_RNG=y
CONFIG_RTC=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_15=y
CONFIG_VGA_CONSOLE=y

The problem is, occationally(apparently random) the system uses about 650mg 
swap, keeps that swap level for about a week then slowly over the next 2-3 
days drops it off.  However, if I dd the swap partition to a file, the swap 
goes down to what I'd call a normal level.  Running strings through the file 
reveils mainly apache and perl stuff.(well it is a webserver!).  Nothing else 
weird seems to be happening.  

Any help|explanation appreciated.

Stuart Fox
Fotango
