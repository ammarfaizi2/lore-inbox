Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288896AbSBDUlY>; Mon, 4 Feb 2002 15:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288897AbSBDUlO>; Mon, 4 Feb 2002 15:41:14 -0500
Received: from vracs001.vrac.iastate.edu ([129.186.232.215]:7205 "EHLO
	vracs001.vrac.iastate.edu") by vger.kernel.org with ESMTP
	id <S288896AbSBDUk6>; Mon, 4 Feb 2002 15:40:58 -0500
Subject: Re: Linux 2.5.3-dj2
From: "Daniel E. Shipton" <dshipton@vrac.iastate.edu>
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020204194719.C11789@suse.de>
In-Reply-To: <20020204154800.A13519@suse.de>
	<1012841649.8335.6.camel@regatta>  <20020204194719.C11789@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 04 Feb 2002 14:34:58 -0600
Message-Id: <1012854899.8333.12.camel@regatta>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

close......that worked out....how about this one...
keep up the good work...

daniel.e.shipton 

gcc -D__KERNEL__ -I/home/kernel/linux-2.5/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686   -DKBUILD_BASENAME=iodebug  -c -o iodebug.o iodebug.c
rm -f lib.a
ar  rcs lib.a checksum.o old-checksum.o delay.o usercopy.o getuser.o
memcpy.o strstr.o iodebug.o
make[2]: Leaving directory `/home/kernel/linux-2.5/arch/i386/lib'
make[1]: Leaving directory `/home/kernel/linux-2.5/arch/i386/lib'
ld -m elf_i386 -T /home/kernel/linux-2.5/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
        /home/kernel/linux-2.5/arch/i386/lib/lib.a
/home/kernel/linux-2.5/lib/lib.o
/home/kernel/linux-2.5/arch/i386/lib/lib.a \
         drivers/base/base.o drivers/char/char.o drivers/block/block.o
drivers/misc/misc.o drivers/net/net.o drivers/media/media.o
drivers/char/drm/drm.o drivers/net/fc/fc.o
drivers/net/appletalk/appletalk.o drivers/net/tokenring/tr.o
drivers/net/wan/wan.o drivers/atm/atm.o drivers/ide/idedriver.o
drivers/cdrom/driver.o drivers/pci/driver.o
drivers/net/pcmcia/pcmcia_net.o drivers/net/wireless/wireless_net.o
drivers/pnp/pnp.o drivers/video/video.o drivers/md/mddev.o \
        net/network.o \
        --end-group \
        -o vmlinux
fs/fs.o: In function `init_iso9660_fs':
fs/fs.o(.text.init+0xdf1): undefined reference to `zisofs_cleanup'
make: *** [vmlinux] Error 1



