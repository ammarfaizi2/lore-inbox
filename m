Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315557AbSECFqj>; Fri, 3 May 2002 01:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315558AbSECFqi>; Fri, 3 May 2002 01:46:38 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:32266 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315557AbSECFqh>; Fri, 3 May 2002 01:46:37 -0400
Date: Fri, 3 May 2002 07:46:31 +0200
From: Jurriaan on Alpha <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.5.13 on Alpha: undefined reference to vmalloc in scsidrv.o
Message-ID: <20020503054631.GA17932@alpha.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

.config available on request:

ng -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev56 -Wa,-mev6   -DKBUILD_BASENAME=srm_printk  -c -o srm_printk.o srm_printk.c
ar rcs lib.a __divqu.o __remqu.o __divlu.o __remlu.o udelay.o memset.o memcpy.o memmove.o io.o checksum.o csum_partial_copy.o strlen.
o strcat.o strcpy.o strncat.o strncpy.o stxcpy.o stxncpy.o strchr.o strrchr.o memchr.o copy_user.o clear_user.o strncpy_from_user.o s
trlen_user.o csum_ipv6_magic.o clear_page.o copy_page.o strcasecmp.o fpreg.o callback_srm.o srm_puts.o srm_printk.o
make[1]: Leaving directory `/usr/src/linux-2.5.13/arch/alpha/lib'
make CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.5.13/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-stri
ct-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev56 -Wa,-mev6 " -C  arch/alpha/math-emu
make[1]: Entering directory `/usr/src/linux-2.5.13/arch/alpha/math-emu'
make all_targets
make[2]: Entering directory `/usr/src/linux-2.5.13/arch/alpha/math-emu'
gcc -D__KERNEL__ -I/usr/src/linux-2.5.13/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasi
ng -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev56 -Wa,-mev6   -DKBUILD_BASENAME=math  -c -o math.o math.c
math.c: In function `alpha_fp_emul':
math.c:204: warning: right shift count is negative
math.c:204: warning: left shift count >= width of type
math.c:220: warning: left shift count is negative
math.c:238: warning: statement with no effect
math.c:258: warning: right shift count >= width of type
math.c:258: warning: right shift count >= width of type
math.c:262: warning: right shift count >= width of type
math.c:262: warning: right shift count >= width of type
math.c:270: warning: statement with no effect
math.c:270: warning: statement with no effect
math.c:270: warning: statement with no effect
math.c:277: warning: statement with no effect
math.c:277: warning: statement with no effect
math.c:277: warning: statement with no effect
math.c:99: warning: `SR_f' might be used uninitialized in this function
math.c:100: warning: `DR_f' might be used uninitialized in this function
gcc  -D__KERNEL__ -I/usr/src/linux-2.5.13/include  -c -o qrnnd.o qrnnd.S
rm -f math-emu.o
ld  -r -o math-emu.o math.o qrnnd.o
make[2]: Leaving directory `/usr/src/linux-2.5.13/arch/alpha/math-emu'
make[1]: Leaving directory `/usr/src/linux-2.5.13/arch/alpha/math-emu'
gcc -E -D__KERNEL__ -I/usr/src/linux-2.5.13/include -xc -P arch/alpha/vmlinux.lds.in -o arch/alpha/vmlinux.lds
ld -static -T arch/alpha/vmlinux.lds -N  arch/alpha/kernel/head.o init/main.o init/version.o init/do_mounts.o \
        --start-group \
        arch/alpha/kernel/kernel.o arch/alpha/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o arch/alpha/math-emu/math-emu.o \
        /usr/src/linux-2.5.13/arch/alpha/lib/lib.a /usr/src/linux-2.5.13/lib/lib.a /usr/src/linux-2.5.13/arch/alpha/lib/lib.a \
         drivers/base/base.o drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o dr
ivers/char/drm/drm.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o sound/sound.o drivers/pci/driver.o drivers
/net/tulip/tulip_net.o drivers/video/video.o drivers/usb/usbdrv.o drivers/input/inputdrv.o drivers/input/serio/seriodrv.o \
        net/network.o \
        --end-group \
        -o vmlinux
drivers/scsi/scsidrv.o: In function `sd_init':
drivers/scsi/scsidrv.o(.text+0x1e3f0): undefined reference to `vmalloc'
drivers/scsi/scsidrv.o(.text+0x1e3f4): undefined reference to `vmalloc'
drivers/scsi/scsidrv.o(.text+0x1e444): undefined reference to `vmalloc'
drivers/scsi/scsidrv.o(.text+0x1e448): undefined reference to `vmalloc'
drivers/scsi/scsidrv.o(.text+0x1e498): undefined reference to `vmalloc'
drivers/scsi/scsidrv.o(.text+0x1e49c): more undefined references to `vmalloc' follow
make: *** [vmlinux] Error 1
alpha:/usr/src/linux-2.5.13#

Good luck,
Jurriaan
-- 
"To boldly binary patch commercial programs where no commercial program
has been binary patched before.."
	Linus Torvalds on patching Quake.
Debian GNU/Linux 2.5.10 on Alpha 988 bogomips load:0.06 0.20 0.36
