Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319013AbSH2BOM>; Wed, 28 Aug 2002 21:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319035AbSH2BOM>; Wed, 28 Aug 2002 21:14:12 -0400
Received: from sycorax.lbl.gov ([128.3.5.196]:54442 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id <S319013AbSH2BOM>;
	Wed, 28 Aug 2002 21:14:12 -0400
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre5
References: <Pine.LNX.4.44.0208281946150.5234-100000@freak.distro.conectiva>
From: Alex Romosan <romosan@sycorax.lbl.gov>
Date: 28 Aug 2002 18:18:32 -0700
In-Reply-To: <Pine.LNX.4.44.0208281946150.5234-100000@freak.distro.conectiva> (message from Marcelo Tosatti on Wed, 28 Aug 2002 19:46:53 -0300 (BRT))
Message-ID: <873csybgyf.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo@conectiva.com.br> writes:

> Here goes pre5.

compilation failed:

ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/video/video.o drivers/input/inputdrv.o drivers/i2c/i2c.o drivers/md/mddev.o \
        net/network.o \
        /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a /usr/src/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/net/net.o: In function `e100_diag_config_loopback':
drivers/net/net.o(.text+0x81a2): undefined reference to `e100_force_speed_duplex'

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
