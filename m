Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263859AbTETSMi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 14:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbTETSMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 14:12:38 -0400
Received: from D36e4.pppool.de ([80.184.54.228]:34178 "EHLO solfire")
	by vger.kernel.org with ESMTP id S263859AbTETSMh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 14:12:37 -0400
Date: Tue, 20 May 2003 20:26:15 +0200 (CEST)
Message-Id: <20030520.202615.85413275.mccramer@s.netic.de>
To: linux-kernel@vger.kernel.org
From: Meino Christian Cramer <mccramer@s.netic.de>
In-Reply-To: <1047063457.1947.2.camel@rousalka>
References: <1047063457.1947.2.camel@rousalka>
X-Mailer: Mew version 3.2 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre5/7 fails to compile
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

 I got some weird problems to compile linux 2.4.21 pre 5 and pre 7.

 Both fail at the same point of code:

 gcc -D__KERNEL__ -I/usr/src/linux-2.4.21p7/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon   -nostdinc -iwithprefix include -DKBUILD_BASENAME=mmx  -c -o mmx.o mmx.c
 rm -f lib.a
 ar  rcs lib.a checksum.o old-checksum.o delay.o usercopy.o getuser.o memcpy.o strstr.o mmx.o
 make[2]: Leaving directory `/usr/src/linux-2.4.21p7/linux/arch/i386/lib'
 make[1]: Leaving directory `/usr/src/linux-2.4.21p7/linux/arch/i386/lib'
 ld -m elf_i386 -T /usr/src/linux-2.4.21p7/linux/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o init/do_mounts.o \
         --start-group \
         arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
          drivers/parport/driver.o drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/char/agp/agp.o drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/video/video.o drivers/media/media.o drivers/i2c/i2c.o \
         net/network.o \
         /usr/src/linux-2.4.21p7/linux/arch/i386/lib/lib.a /usr/src/linux-2.4.21p7/linux/lib/lib.a /usr/src/linux-2.4.21p7/linux/arch/i386/lib/lib.a \
         --end-group \
         -o vmlinux
 net/network.o(.text+0xd807): In function `rtnetlink_rcv':
 : undefined reference to `rtnetlink_rcv_skb'
 make: *** [vmlinux] Error 1

 Could one give me a hint what is goind wrong here ?
 Please CC me, since I am currently not subscribed.

 Thank you very much for your help and undertstanding in advance!

 Kind regards,
 Meino Cramer


 - used system, software: -
 Linux 2.4.20 
 gcc 3.3.
 glibc 2.3.2.
 binutils 2.14.90.0.2
 gdb 5.3
 XFree 4.3.99.3 (hardware dri/drm enabled and working)
 IceWM 2.7

- used system, hardware: -
 ATI Radeon 7500 AGP made by Sapphire
 Athlon XP 2400+
 EPoX 8K5A3+
 256 MB DDR RAM

