Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281648AbRKPXOz>; Fri, 16 Nov 2001 18:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281646AbRKPXOp>; Fri, 16 Nov 2001 18:14:45 -0500
Received: from maila.telia.com ([194.22.194.231]:12013 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id <S281643AbRKPXOd>;
	Fri, 16 Nov 2001 18:14:33 -0500
Message-ID: <3BF59D71.1020705@peope.net>
Date: Sat, 17 Nov 2001 00:12:49 +0100
From: Per-Olof Pettersson <peope@peope.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: compiling 2.4.14 fails in block.o (probably loopback)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.]
compiling 2.4.14 fails in block.o (probably loopback)

[2.]
Compiling fails when enabling loopback-support in block-devices.
When disabling loopback-support it works.

[3.]
block.o loopback compiling

[4.]
2.4.14

[7.1.]
Linux burken 2.4.14 #4 Fri Nov 16 18:30:19 CET 2001 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11
util-linux             2.10l
mount                  2.10l
modutils               2.3.11
e2fsprogs              1.18
Linux C Library        2.1.3
ldd: version 1.9.9
Procps                 2.0.6
Net-tools              1.55
Kbd                    0.99
Sh-utils               2.0
Modules Loaded         NVdriver

[X.]
Output from compile:
make[1]: Leaving directory `/usr/local/src/linux/arch/i386/lib'
ld -m elf_i386 -T /usr/local/src/linux/arch/i386/vmlinux.lds -e stext 
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o 
init/version.o \
         --start-group \
         arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o 
mm/mm.o fs/fs.o ipc/ipc.o \
          drivers/char/char.o drivers/block/block.o drivers/misc/misc.o 
drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o 
drivers/ide/idedriver.o drivers/cdrom/driver.o 
drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/video/video.o 
drivers/usb/usbdrv.o drivers/input/inputdrv.o \
         net/network.o \
         /usr/local/src/linux/arch/i386/lib/lib.a 
/usr/local/src/linux/lib/lib.a /usr/local/src/linux/arch/i386/lib/lib.a \
         --end-group \
         -o vmlinux
drivers/block/block.o: In function `lo_send':
drivers/block/block.o(.text+0x894f): undefined reference to 
`deactivate_page'
drivers/block/block.o(.text+0x8999): undefined reference to 
`deactivate_page'
make: *** [vmlinux] Error 1

Workaround:
Do not compile with loopback-support in block-devices.

Best regards
Per-Olof Pettersson

