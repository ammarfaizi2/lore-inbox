Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129193AbRBWUAc>; Fri, 23 Feb 2001 15:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129394AbRBWUAW>; Fri, 23 Feb 2001 15:00:22 -0500
Received: from pipt.oz.cc.utah.edu ([155.99.2.7]:11662 "EHLO
	pipt.oz.cc.utah.edu") by vger.kernel.org with ESMTP
	id <S129193AbRBWUAN>; Fri, 23 Feb 2001 15:00:13 -0500
Date: Fri, 23 Feb 2001 13:00:07 -0700 (MST)
From: james rich <james.rich@m.cc.utah.edu>
To: linux-kernel@vger.kernel.org
cc: linux-xfs@oss.sgi.com
Subject: building 2.4.2 (with XFS) fails
Message-ID: <Pine.GSO.4.05.10102231255010.15426-100000@pipt.oz.cc.utah.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When building 2.4.2 with XFS patches the build fails with errors that
don't seem related to XFS (that's why the crosspost):

gcc -V egcs-2.91.66 -D__KERNEL__ -I/usr/src/linux/include  -Wall
-Wstrict-prototypes -O2 -fno-strict-aliasing -fomit-frame-pointer -pipe
-march=i686    -c -o dec_and_lock.o dec_and_lock.c
rm -f lib.a
ar  rcs lib.a checksum.o old-checksum.o delay.o usercopy.o getuser.o
putuser.o iodebug.o memcpy.o dec_and_lock.o
make[2]: Leaving directory `/usr/src/linux-2.4-xfs/linux/arch/i386/lib'
make[1]: Leaving directory `/usr/src/linux-2.4-xfs/linux/arch/i386/lib'
make[1]: Entering directory `/usr/src/linux-2.4-xfs/linux'
ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o --start-group arch/i386/kernel/kernel.o arch/i386/mm/mm.o
kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o drivers/block/block.o
drivers/char/char.o drivers/misc/misc.o drivers/net/net.o
drivers/media/media.o  drivers/parport/driver.o drivers/char/drm/drm.o
drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o
drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/video/video.o
drivers/i2c/i2c.o drivers/md/mddev.o net/network.o
/usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a
/usr/src/linux/arch/i386/lib/lib.a --end-group  -o vmlinux
drivers/char/char.o: In function `vt_ioctl':
drivers/char/char.o(.text+0x96fb): undefined reference to `key_maps'
drivers/char/char.o(.text+0x97cd): undefined reference to `key_maps'
drivers/char/char.o(.text+0x97ed): undefined reference to `key_maps'
drivers/char/char.o(.text+0x9808): undefined reference to `keymap_count'
drivers/char/char.o(.text+0x9877): undefined reference to `key_maps'
drivers/char/char.o(.text+0x9889): undefined reference to `keymap_count'
drivers/char/char.o(.text+0x98df): undefined reference to `key_maps'
drivers/char/char.o(.text+0x990a): undefined reference to `keymap_count'
drivers/char/char.o(.text+0x9a2e): undefined reference to `func_table'
drivers/char/char.o(.text+0x9ad7): undefined reference to `funcbufsize'
drivers/char/char.o(.text+0x9ae5): undefined reference to `funcbufleft'
drivers/char/char.o(.text+0x9afa): undefined reference to `funcbufptr'
drivers/char/char.o(.text+0x9b09): undefined reference to `func_table'
drivers/char/char.o(.text+0x9b22): undefined reference to `func_table'
drivers/char/char.o(.text+0x9b46): undefined reference to `func_table'
drivers/char/char.o(.text+0x9b57): undefined reference to `func_table'
drivers/char/char.o(.text+0x9c0b): undefined reference to `func_table'
drivers/char/char.o(.text+0x9c40): more undefined references to
`func_table' follow
drivers/char/char.o: In function `vt_ioctl':
drivers/char/char.o(.text+0x9c4a): undefined reference to `funcbufleft'
drivers/char/char.o(.text+0x9cc2): undefined reference to `func_table'
drivers/char/char.o(.text+0x9cc8): undefined reference to `funcbufptr'
drivers/char/char.o(.text+0x9d19): undefined reference to `funcbufptr'
drivers/char/char.o(.text+0x9d25): undefined reference to `func_table'
drivers/char/char.o(.text+0x9d69): undefined reference to `funcbufptr'
drivers/char/char.o(.text+0x9dc0): undefined reference to `funcbufptr'
drivers/char/char.o(.text+0x9dc9): undefined reference to `func_table'
drivers/char/char.o(.text+0x9dfb): undefined reference to `funcbufptr'
drivers/char/char.o(.text+0x9e01): undefined reference to `func_buf'
drivers/char/char.o(.text+0x9e15): undefined reference to `funcbufptr'
drivers/char/char.o(.text+0x9e1b): undefined reference to `funcbufleft'
drivers/char/char.o(.text+0x9e29): undefined reference to `funcbufsize'
drivers/char/char.o(.text+0x9e2f): undefined reference to `funcbufleft'
drivers/char/char.o(.text+0x9e39): undefined reference to `funcbufsize'
drivers/char/char.o(.text+0x9e43): undefined reference to `func_table'
drivers/char/char.o(.text+0x9e76): undefined reference to
`accent_table_size'
drivers/char/char.o(.text+0x9e89): undefined reference to
`accent_table_size'
drivers/char/char.o(.text+0x9e92): undefined reference to `accent_table'
drivers/char/char.o(.text+0x9edd): undefined reference to
`accent_table_size'
drivers/char/char.o(.text+0x9eea): undefined reference to `accent_table'
drivers/char/char.o: In function `handle_scancode':
drivers/char/char.o(.text+0x164c1): undefined reference to `key_maps'
drivers/char/char.o(.text+0x1651a): undefined reference to `key_maps'
drivers/char/char.o: In function `handle_diacr':
drivers/char/char.o(.text+0x16c28): undefined reference to
`accent_table_size'
drivers/char/char.o(.text+0x16c49): undefined reference to `accent_table'
drivers/char/char.o(.text+0x16c5b): undefined reference to `accent_table'
drivers/char/char.o(.text+0x16ca7): undefined reference to `accent_table'
drivers/char/char.o: In function `do_fn':
drivers/char/char.o(.text+0x16d1f): undefined reference to `func_table'
drivers/char/char.o: In function `compute_shiftstate':
drivers/char/char.o(.text+0x16f99): undefined reference to `plain_map'
drivers/char/char.o: In function `do_slock':
drivers/char/char.o(.text+0x170ef): undefined reference to `key_maps'
make[1]: *** [kallsyms] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4-xfs/linux'
make: *** [vmlinux] Error 2


Any ideas what is wrong?

James Rich
james.rich@m.cc.utah.edu


