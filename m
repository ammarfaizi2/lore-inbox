Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288544AbSAVQGd>; Tue, 22 Jan 2002 11:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288566AbSAVQGX>; Tue, 22 Jan 2002 11:06:23 -0500
Received: from p50859276.dip.t-dialin.net ([80.133.146.118]:60635 "EHLO
	minerva.local.lan") by vger.kernel.org with ESMTP
	id <S288544AbSAVQGG>; Tue, 22 Jan 2002 11:06:06 -0500
From: Martin Loschwitz <madkiss@madkiss.de>
Date: Tue, 22 Jan 2002 17:06:03 +0100
To: linux-kernel@vger.kernel.org
Subject: 2.4.18-pre4: undefined reference to `local symbols in discarded section .text.exit'
Message-ID: <20020122160603.GA7182@madkiss.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear ladies and gentleman,

5 minutes ago, I tried to compile Linux 2.4.18-pre4 on my Debian Sid box.
I did this from a cleanly unpacked/patched kernel-source. The build
failed for the following reason:

ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
	--start-group \
	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
	drivers/parport/driver.o drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/video/video.o drivers/i2c/i2c.o \
	net/network.o \
	/usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a /usr/src/linux/arch/i386/lib/lib.a \
	--end-group \
	-o vmlinux
drivers/media/media.o: In function `bttv_probe':
drivers/media/media.o(.text.init+0x15db): undefined reference to `local symbols in discarded section .text.exit'
							 
Would you be so friendly to fix this bug please? :)

--
-- Martin Loschwitz ---------------- hobbit.NeverAgain.DE --
-- Koernerstrasse 58 ---------- mail <madkiss@madkiss-de> --
-- 41747 Viersen ------------ http http://www.madkiss.de/ -- 
-- Germany ------------------------ irc Madkiss (IRC-Net) --
