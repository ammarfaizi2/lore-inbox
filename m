Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292783AbSCDTUU>; Mon, 4 Mar 2002 14:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292795AbSCDTUL>; Mon, 4 Mar 2002 14:20:11 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:22151 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S292783AbSCDTTv>; Mon, 4 Mar 2002 14:19:51 -0500
Date: Mon, 4 Mar 2002 19:58:27 +0100
From: Norbert Tretkowski <tretkowski@bzimage.de>
To: linux-kernel@vger.kernel.org
Subject: Matrox Framebuffer with 2.4.18-ac2 and -ac3 (was: Linux 2.4.18-ac3)
Message-ID: <20020304185826.GA2745@rollcage.bzimage.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E16heAb-0005cC-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16heAb-0005cC-00@the-village.bc.nu>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

I can't compile 2.4.18-ac2 and -ac3 with Matrox Framebuffer support.
The following error occured while making bzImage:

ld -m elf_i386 -T
/home/tretkowski/test/linux-2.4.18-rc3/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/video/video.o \
        net/network.o \
        /home/tretkowski/test/linux-2.4.18-rc3/arch/i386/lib/lib.a /home/tretkowski/test/linux-2.4.18-rc3/lib/lib.a /home/tretkowski/test/linux-2.4.18-rc3/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/video/video.o: In function `m1064_compute':
drivers/video/video.o(.text+0xad9d): undefined reference to
`matroxfb_g450_setclk'
make: *** [vmlinux] Error 1

Relevant part of my .config:

CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_MYSTIQUE=y

Without Framebuffer the kernel compiles fine. Maybe this

> Linux 2.4.18pre7-ac2
> o	Updated matrox drivers				(Petr Vandrovec)

is the problem?

Regards, Norbert
