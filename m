Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273293AbRIWFAi>; Sun, 23 Sep 2001 01:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273289AbRIWFA3>; Sun, 23 Sep 2001 01:00:29 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:60881 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S273281AbRIWFAP>;
	Sun, 23 Sep 2001 01:00:15 -0400
Message-ID: <3BAD6C78.8034024E@candelatech.com>
Date: Sat, 22 Sep 2001 22:00:40 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: pre14 won't link: put_gendisk
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone got a patch for this?

Also, it seems that more kernels have *not* compiled lately
than have compiled.  I know people are working really hard, but
it does seem like we could at least keep compile problems out
of the pre-patches and 'stable' releases...

I'm using the i686.config file from RH's 2.4.7-2 beta kernel source rpm.

Thanks,
Ben


ar  rcs lib.a checksum.o old-checksum.o delay.o usercopy.o getuser.o memcpy.o strstr.o iodebug.o
make[2]: Leaving directory `/home/greear/kernel/2.4/linux/arch/i386/lib'
make[1]: Leaving directory `/home/greear/kernel/2.4/linux/arch/i386/lib'
ld -m elf_i386 -T /home/greear/kernel/2.4/linux/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/drm/drm.o drivers/net/fc/fc.o
drivers/net/appletalk/appletalk.o drivers/net/tokenring/tr.o drivers/net/wan/wan.o drivers/atm/atm.o drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/pci/driver.o
drivers/net/pcmcia/pcmcia_net.o drivers/net/wireless/wireless_net.o drivers/pnp/pnp.o drivers/video/video.o drivers/md/mddev.o \
        net/network.o \
        /home/greear/kernel/2.4/linux/arch/i386/lib/lib.a /home/greear/kernel/2.4/linux/lib/lib.a /home/greear/kernel/2.4/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/ide/idedriver.o: In function `probedisk':
drivers/ide/idedriver.o(.text.init+0x436c): undefined reference to `put_gendisk'
drivers/ide/idedriver.o(.text.init+0x475c): undefined reference to `put_gendisk'
make: *** [vmlinux] Error 1


-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
