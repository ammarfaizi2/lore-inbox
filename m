Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291916AbSBIIok>; Sat, 9 Feb 2002 03:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288733AbSBIIoa>; Sat, 9 Feb 2002 03:44:30 -0500
Received: from r-fi057-2-19.tin.it ([62.211.52.19]:6416 "EHLO
	penny.ik5pvx.ampr.org") by vger.kernel.org with ESMTP
	id <S288731AbSBIIoX>; Sat, 9 Feb 2002 03:44:23 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.18-pre9 compile error
Reply-To: Pierfrancesco Caci <p.caci@tin.it>
From: Pierfrancesco Caci <ik5pvx@penny.ik5pvx.ampr.org>
Date: 09 Feb 2002 09:44:17 +0100
Message-ID: <87bsezcae6.fsf@penny.ik5pvx.ampr.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello, while trying to compile 2.4.18-pre9, I got this error:


ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext arch/i386/kernel
/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/f
s.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/n
et/net.o drivers/media/media.o drivers/char/agp/agp.o drivers/char/drm/drm.o dri
vers/isdn/isdn.a drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/dr
iver.o drivers/pci/driver.o drivers/video/video.o drivers/net/hamradio/hamradio.
o drivers/i2c/i2c.o drivers/md/mddev.o \
        net/network.o \
        /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a /usr/src/lin
ux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
fs/fs.o: In function `generic_cont_expand':
fs/fs.o(.text+0x3eab): undefined reference to `page_cache_release'
fs/fs.o: In function `cont_prepare_write':
fs/fs.o(.text+0x3fa9): undefined reference to `page_cache_release'
fs/fs.o(.text+0x4095): undefined reference to `page_cache_release'
fs/fs.o: In function `block_truncate_page':
fs/fs.o(.text+0x42e9): undefined reference to `page_cache_release'
fs/fs.o: In function `block_symlink':
fs/fs.o(.text+0x4aa8): undefined reference to `page_cache_release'
fs/fs.o(.text+0x4ad5): more undefined references to `page_cache_release' follow
make[1]: *** [vmlinux] Error 1
make[1]: Leaving directory `/usr/src/linux'
make: *** [stamp-build] Error 2


root@penny:/usr/src # gcc -v
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4 20011002 (Debian prerelease)


ii  binutils       2.11.92.0.12.3 The GNU assembler, linker and binary utiliti


Thanks

Pf


-- 

-------------------------------------------------------------------------------
 Pierfrancesco Caci | ik5pvx | mailto:p.caci@tin.it  -  http://gusp.dyndns.org
  Firenze - Italia  | Office for the Complication of Otherwise Simple Affairs 
     Linux penny 2.4.16 #1 Fri Nov 30 22:12:51 CET 2001 i686 unknown
