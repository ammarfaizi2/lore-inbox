Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310503AbSCSI4l>; Tue, 19 Mar 2002 03:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310504AbSCSI4b>; Tue, 19 Mar 2002 03:56:31 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:62218 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S310503AbSCSI4N>; Tue, 19 Mar 2002 03:56:13 -0500
Message-ID: <3C96FCE0.4EBF6D9B@aitel.hist.no>
Date: Tue, 19 Mar 2002 09:54:56 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.6 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.7 requires nfs server to link
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to compile 2.5.7 resulted in this:

ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
        /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a
/usr/src/linux/arch/i386/lib/lib.a \
         drivers/base/base.o drivers/char/char.o drivers/block/block.o
drivers/misc/misc.o drivers/net/net.o drivers/media/media.o
drivers/char/agp/agp.o drivers/char/drm/drm.o drivers/ide/idedriver.o
drivers/cdrom/driver.o sound/sound.o drivers/pci/driver.o
drivers/pnp/pnp.o drivers/video/video.o drivers/input/inputdrv.o
drivers/input/serio/seriodrv.o \
        net/network.o \
        --end-group \
        -o vmlinux
arch/i386/kernel/kernel.o: In function `sys_call_table':
arch/i386/kernel/kernel.o(.data+0x2fc): undefined reference to
`sys_nfsservctl'
make: *** [vmlinux] Error 1

The name `sys_nfsservctl' suggested some server thing was missing.  
I reconfigured with nfs server, and it linked just fine.  I 
don't intend to run a nfs server on this machine though.

Helge Hafting
