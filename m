Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135721AbREBS3Z>; Wed, 2 May 2001 14:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135716AbREBS3O>; Wed, 2 May 2001 14:29:14 -0400
Received: from mxout1.cac.washington.edu ([140.142.32.5]:18189 "EHLO
	mxout1.cac.washington.edu") by vger.kernel.org with ESMTP
	id <S135724AbREBS27>; Wed, 2 May 2001 14:28:59 -0400
Message-ID: <3AF051FC.21AFA1DB@u.washington.edu>
Date: Wed, 02 May 2001 11:29:16 -0700
From: Daniel Howe <dchowe@u.washington.edu>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel build problem (2.4.1)...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,
I'm having a problem with my running kernel (2.4.1) - attempting to make
a boot floppy. make bzDisk(& make bzImage) give the error below - any
ideas? Seems like bootsec is missing. I'm running Debian on x86...
thanks much,
/daniel


make[1]: Leaving directory `/usr/src/linux-2.4.1/arch/i386/lib'
ld -m elf_i386 -T /usr/src/linux-2.4.1/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
        drivers/block/block.o drivers/char/char.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o  drivers/char/agp/agp.o
drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/cdrom/driver.o
drivers/sound/sounddrivers.o drivers/pci/driver.o
drivers/pcmcia/pcmcia.o drivers/net/pcmcia/pcmcia_net.o
drivers/pnp/pnp.o drivers/video/video.o \
        net/network.o \
        /usr/src/linux-2.4.1/arch/i386/lib/lib.a
/usr/src/linux-2.4.1/lib/lib.a /usr/src/linux-2.4.1/arch/i386/lib/lib.a
\
        --end-group \
        -o vmlinux
nm vmlinux | grep -v '\(compiled\)\|\(\.o$\)\|\( [aUw]
\)\|\(\.\.ng$\)\|\(LASH[RL]DI\)' | sort > System.map
make[1]: Entering directory `/usr/src/linux-2.4.1/arch/i386/boot'
ld -m elf_i386 -Ttext 0x0 -s -oformat binary bbootsect.o -o bbootsect
ld: cannot open binary: No such file or directory
make[1]: *** [bbootsect] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.1/arch/i386/boot'
make: *** [bzImage] Error 2
