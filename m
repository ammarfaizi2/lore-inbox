Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132684AbRDBLlJ>; Mon, 2 Apr 2001 07:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132689AbRDBLk7>; Mon, 2 Apr 2001 07:40:59 -0400
Received: from gsm2.lmt.lv ([212.93.96.2]:38927 "HELO gsm2.lmt.lv")
	by vger.kernel.org with SMTP id <S132684AbRDBLko>;
	Mon, 2 Apr 2001 07:40:44 -0400
Message-ID: <3AC86511.F3123F6C@lmt.lv>
Date: Mon, 02 Apr 2001 14:40:01 +0300
From: Andrejs Dubovskis <andrejs@lmt.lv>
X-Mailer: Mozilla 4.75 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: can not compile 2.4.3 on alpha
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[linux] make dep;make clean;make boot
...
gcc -D__KERNEL__ -I/usr/src/linux-2.4.3/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
-mno-fp-regs -ffixed-8 -mcpu=ev5 -Wa,-mev6   -c -o init/main.o
init/main.c
In file included from /usr/src/linux-2.4.3/include/linux/highmem.h:6,
                 from /usr/src/linux-2.4.3/include/linux/pagemap.h:17,
                 from /usr/src/linux-2.4.3/include/linux/locks.h:9,
                 from /usr/src/linux-2.4.3/include/linux/raid/md.h:37,
                 from init/main.c:25:
/usr/src/linux-2.4.3/include/asm/pgalloc.h:334: conflicting types for
`pte_alloc'
/usr/src/linux-2.4.3/include/linux/mm.h:399: previous declaration of
`pte_alloc'
/usr/src/linux-2.4.3/include/asm/pgalloc.h:352: conflicting types for
`pmd_alloc'
/usr/src/linux-2.4.3/include/linux/mm.h:412: previous declaration of
`pmd_alloc'
make: *** [init/main.o] Error 1

======================================

[andrejs@smsmail2 linux]$ grep -v ^# .config | uniq
CONFIG_ALPHA=y

CONFIG_ALPHA_GENERIC=y
CONFIG_ISA=y
CONFIG_EISA=y
CONFIG_PCI=y
CONFIG_ALPHA_BROKEN_IRQ_MASK=y
CONFIG_PCI_NAMES=y
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y

CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y

CONFIG_MD=y
CONFIG_BLK_DEV_LVM=y

CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_SYN_COOKIES=y

CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=y
CONFIG_BLK_DEV_SR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_SCSI_CONSTANTS=y

CONFIG_SCSI_NCR53C8XX=y
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=8
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=20

CONFIG_NETDEVICES=y

CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_DE4X5=y

CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=128

CONFIG_RTC=y

CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y

CONFIG_OSF_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y

CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y

CONFIG_MATHEMU=y

======================================

[linux] sh scripts/ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux smsmail2.td.lmt.lv 2.4.2adu2 #5 Wed Mar 28 09:48:19 UTC 2001 alpha
unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.0.18
util-linux             2.10m
modutils               found
e2fsprogs              1.18
Linux C Library        > libc.2.2
Dynamic linker (ldd)   2.2
Procps                 2.0.7
Net-tools              1.56
Kbd                    command
Sh-utils               2.0
Modules Loaded
