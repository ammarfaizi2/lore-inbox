Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289357AbSAOCR5>; Mon, 14 Jan 2002 21:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289361AbSAOCRs>; Mon, 14 Jan 2002 21:17:48 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:21125
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S289357AbSAOCRg>; Mon, 14 Jan 2002 21:17:36 -0500
Date: Mon, 14 Jan 2002 21:25:50 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Unable to compile 2.4.14 on alpha
Message-ID: <20020114212550.A17323@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make[2]: Entering directory `/usr/src/2.4.14-test/arch/alpha/math-emu'
make[2]: Nothing to be done for `all_targets'.
make[2]: Leaving directory `/usr/src/2.4.14-test/arch/alpha/math-emu'
make[1]: Leaving directory `/usr/src/2.4.14-test/arch/alpha/math-emu'
ld -static -T arch/alpha/vmlinux.lds -N  arch/alpha/kernel/head.o init/main.o init/version.o \
        --start-group \
        arch/alpha/kernel/kernel.o arch/alpha/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o arch/alpha/math-emu/math-emu.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/video/video.o drivers/md/mddev.o \
        net/network.o \
        /usr/src/2.4.14-test/arch/alpha/lib/lib.a /usr/src/2.4.14-test/lib/lib.a /usr/src/2.4.14-test/arch/alpha/lib/lib.a \
        --end-group \
        -o vmlinux
arch/alpha/kernel/kernel.o(.exitcall.exit+0x0): undefined reference to `local symbols in discarded section .text.exit'
mm/mm.o(.exitcall.exit+0x0): undefined reference to `local symbols in discarded section .text.exit'
fs/fs.o(.exitcall.exit+0x0): undefined reference to `local symbols in discarded section .text.exit'
fs/fs.o(.exitcall.exit+0x8): undefined reference to `local symbols in discarded section .text.exit'
fs/fs.o(.exitcall.exit+0x10): undefined reference to `local symbols in discarded section .text.exit'
fs/fs.o(.exitcall.exit+0x18): more undefined references to `local symbols in discarded section .text.exit' follow
make: *** [vmlinux] Error 1

[root@kakarot:/usr/src/2.4.14-test] ld --version
GNU ld version 2.11.92.0.12.3 20011121 Debian/GNU Linux
Copyright 2001 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License.  This program has absolutely no warranty.
[root@kakarot:/usr/src/2.4.14-test] gcc --version
2.95.4
[root@kakarot:/usr/src/2.4.14-test] 

gcc 3.0.3 didn't work either (I don't feel that's the problem)

2.4.16 did the same thing, except it was in char.o

I tried to link the kernel by removing arch/alpha/kernel/kernel.o and
replacing with the actual files.  the error is in arch/alpha/kernel/srm_env.o

I really need something to work as I have a DAC960 controller that I want to
try.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
