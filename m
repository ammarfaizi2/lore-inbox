Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270164AbRHGJkj>; Tue, 7 Aug 2001 05:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270166AbRHGJka>; Tue, 7 Aug 2001 05:40:30 -0400
Received: from pD9E16562.dip.t-dialin.net ([217.225.101.98]:45817 "EHLO
	tolot.miese-zwerge.org") by vger.kernel.org with ESMTP
	id <S270164AbRHGJkR>; Tue, 7 Aug 2001 05:40:17 -0400
Date: Tue, 7 Aug 2001 11:40:23 +0200
From: Jochen Striepe <jochen@tolot.escape.de>
To: linux-kernel@vger.kernel.org
Subject: Linux-2.4.8pre5 does not build
Message-ID: <20010807114023.A23521@tolot.miese-zwerge.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
X-Editor: vim/5.8.9
X-Signature-Color: blue
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        Hi,

I just downloaded Linux-2.4.8pre5, and got the following error message.
Earlier 2.4.8pre kernels build fine.

ld -m elf_i386 -T /usr/src/linux-2.4.8pre5/arch/i386/vmlinux.lds -e
stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o drivers/ide/idedriver.o
drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/pci/driver.o
drivers/video/video.o \
        net/network.o \
        /usr/src/linux-2.4.8pre5/arch/i386/lib/lib.a
/usr/src/linux-2.4.8pre5/lib/lib.a
/usr/src/linux-2.4.8pre5/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
mm/mm.o: In function `init_shmem_fs':
mm/mm.o(.text.init+0x1025): undefined reference to `shmem_set_size'
make: *** [vmlinux] Error 1


$ sh /usr/src/linux-2.4.8pre5/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux tolot 2.4.8-pre4 #1 Sun Aug 5 13:23:51 CEST 2001 i586 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.90.0.25
util-linux             2.11g
mount                  2.11g
modutils               2.4.6
e2fsprogs              1.22
PPP                    2.4.1
Linux C Library        2.2.3
Dynamic linker (ldd)   2.2.3
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.11
Modules Loaded         nls_utf8 nls_iso8859-15 nls_iso8859-2 nls_iso8859-1 nls_cp852 nls_cp850 nls_cp437 floppy sr_mod sg isofs ne2k-pci 8390 ide-cd cdrom adlib_card opl3 sb sb_lib uart401 sound soundcore ppp_generic slhc lp parport serial


$ grep -v ^$ /usr/src/linux-2.4.8pre5/.config | grep -v ^\#

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_MK6=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_TSC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOBIOS=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_1284=y
CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_BLK_DEV_SR=m
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_NE2K_PCI=m
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_ISDN=m
CONFIG_ISDN_PPP=y
CONFIG_ISDN_PPP_VJ=y
CONFIG_ISDN_PPP_BSDCOMP=m
CONFIG_ISDN_DRV_HISAX=m
CONFIG_HISAX_EURO=y
CONFIG_HISAX_FRITZPCI=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=m
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_MINIX_FS=m
CONFIG_NTFS_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_UTF8=m
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_SOUND=m
CONFIG_SOUND_OSS=m
CONFIG_SOUND_TRACEINIT=y
CONFIG_SOUND_DMAP=y
CONFIG_SOUND_ADLIB=m
CONFIG_SOUND_SB=m
CONFIG_SOUND_YM3812=m


Please let me know if you need any more info.


Best greetings from Germany,

Jochen.

-- 
"Outside of a dog, a book is a man's best friend: and inside a dog,
it's too dark to read."
                -- Groucho Marx
