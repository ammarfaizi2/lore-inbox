Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263132AbTDVNV5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 09:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263133AbTDVNV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 09:21:57 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:14785 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263132AbTDVNV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 09:21:56 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16037.17599.400349.292447@gargle.gargle.HOWL>
Date: Tue, 22 Apr 2003 15:33:51 +0200
From: mikpe@csd.uu.se
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-rc1 doesn't build on ppc (6xx/pmac)
CC: linuxppc-dev@lists.linuxppc.org
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.21-pre7 built and ran Ok on my PowerMac 4400 with
CONFIG_6xx=y and CONFIG_ALL_PPC=y.
2.4.21-rc1 fails at the end of the build with:

ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic arch/ppc/kernel/head.o arch/ppc/kernel/idle_6xx.o init/main.o init/version.o init/do_mounts.o \
	--start-group \
	arch/ppc/kernel/kernel.o arch/ppc/platforms/platform.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
	 drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/macintosh/macintosh.o drivers/video/video.o drivers/usb/usbdrv.o drivers/media/media.o drivers/input/inputdrv.o \
	net/network.o \
	/tmp/linux-2.4.21-rc1/lib/lib.a \
	--end-group \
	-o vmlinux
arch/ppc/kernel/head.o(__ftr_fixup+0x60): undefined reference to `CPU_FTR_HAS_HIGH_BATS'
arch/ppc/kernel/head.o(__ftr_fixup+0x64): undefined reference to `CPU_FTR_HAS_HIGH_BATS'
arch/ppc/kernel/kernel.o: In function `sys_call_table':
arch/ppc/kernel/kernel.o(.data+0x330c): undefined reference to `__setup_cpu_7450'
arch/ppc/kernel/kernel.o(.data+0x332c): undefined reference to `__setup_cpu_7450'
arch/ppc/kernel/kernel.o(.data+0x334c): undefined reference to `__setup_cpu_7450'
arch/ppc/kernel/kernel.o(.data+0x336c): undefined reference to `__setup_cpu_7455'
arch/ppc/kernel/kernel.o(.data+0x338c): undefined reference to `__setup_cpu_7455'
arch/ppc/kernel/kernel.o(.data+0x33ac): undefined reference to `__setup_cpu_7455'
make: *** [vmlinux] Error 1

/Mikael
