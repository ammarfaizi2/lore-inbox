Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281834AbRKRAoz>; Sat, 17 Nov 2001 19:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281835AbRKRAop>; Sat, 17 Nov 2001 19:44:45 -0500
Received: from lifshitz.ucdavis.edu ([169.237.42.72]:7832 "EHLO
	lifshitz.ucdavis.edu") by vger.kernel.org with ESMTP
	id <S281834AbRKRAoj>; Sat, 17 Nov 2001 19:44:39 -0500
Date: Sat, 17 Nov 2001 16:44:37 -0800
From: Peter Jay Salzman <psalzman@lifshitz.ucdavis.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.4.14 compiling failed
Message-ID: <20011117164437.A6361@lifshitz.ucdavis.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this is probably known already, but just in case, 2.4.14 compiling just
failed on me:

  make[1]: Leaving directory `/usr/src/linux-2.4.14/arch/i386/lib'
  ld -m elf_i386 -T /usr/src/linux-2.4.14/arch/i386/vmlinux.lds -e stext
  arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
  init/version.o \
          --start-group \
          arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o
  fs/fs.o ipc/ipc.o \
           drivers/parport/driver.o drivers/char/char.o drivers/block/block.o
  drivers/misc/misc.o drivers/net/net.o drivers/media/media.o
  drivers/char/agp/agp.o drivers/char/drm/drm.o drivers/ide/idedriver.o
  drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/sound/sounddrivers.o
  drivers/pci/driver.o drivers/pnp/pnp.o
  drivers/video/video.o \
          net/network.o \
          /usr/src/linux-2.4.14/arch/i386/lib/lib.a
  /usr/src/linux-2.4.14/lib/lib.a /usr/src/linux-2.4.14/arch/i386/lib/lib.a \
          --end-group \
          -o vmlinux
  drivers/block/block.o: In function `lo_send':
  drivers/block/block.o(.text+0xa57f): undefined reference to `deactivate_page'
  drivers/block/block.o(.text+0xa5c9): undefined reference to `deactivate_page'
  make: *** [vmlinux] Error 1

i wanted to upgrade because 2.4.13 has been flaky.  earlier today, my
system became very sloooow.  i killed just about every process with no
effect.   top reported that kswapd was taking 99% of the cpu.

then just a few minutes ago, my system hung (couldn't ssh in either).  at
the time, all i was running was g++ and mp3blaster.  wasn't even running X.

so i went to update to 2.4.14.  and the compile just failed.

no big deal -- i can live with it until 2.4.15 comes out, but i thought
someone should know about this.

no response is required.  i know how busy everyone here is.


pete  (not subscribed)
