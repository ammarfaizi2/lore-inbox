Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130493AbRDWUO7>; Mon, 23 Apr 2001 16:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129359AbRDWUOu>; Mon, 23 Apr 2001 16:14:50 -0400
Received: from mailout00.sul.t-online.com ([194.25.134.16]:49927 "EHLO
	mailout00.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S130493AbRDWUOo>; Mon, 23 Apr 2001 16:14:44 -0400
Message-ID: <3AE48D23.4A13FB91@folkwang-hochschule.de>
Date: Mon, 23 Apr 2001 22:14:27 +0200
From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier 
	<nettings@folkwang-hochschule.de>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jochen@tolot.escape.de, linux-kernel@vger.kernel.org
Subject: 2.4.4-pre6 does not compile
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jochen wrote:
 
> 
>               Hi,
> 
>       2.4.4-pre6 actually is the 4th 2.4.4pre-Patch that does not compile
>       without further patching on my system. :-(
> 
> 
>       ld -m elf_i386 -T /usr/src/linux-2.4.4-pre6/arch/i386/vmlinux.lds -e stext 
>       arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
>               --start-group \
>               arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o 
>       ipc/ipc.o \
>               drivers/block/block.o drivers/char/char.o drivers/misc/misc.o 
>       drivers/net/net.o drivers/media/media.o  drivers/ide/idedriver.o 
>       drivers/scsi/scsidrv.o drivers/scsi/aic7xxx/aic7xxx_drv.o drivers/cdrom/driver.o 
>       drivers/pci/driver.o drivers/video/video.o \
>               net/network.o \
>               /usr/src/linux-2.4.4-pre6/arch/i386/lib/lib.a 
>       /usr/src/linux-2.4.4-pre6/lib/lib.a /usr/src/linux-2.4.4-pre6/arch/i386/lib/lib.a \
>               --end-group \
>               -o vmlinux
>       /usr/src/linux-2.4.4-pre6/lib/lib.a(rwsem.o): In function `__rwsem_do_wake':
>       rwsem.o(.text+0x30): undefined reference to `__builtin_expect'
>       rwsem.o(.text+0x73): undefined reference to `__builtin_expect'
>       make: *** [vmlinux] Error 1


same problem here.
i'm using
# gcc -v
Reading specs from /usr/lib/gcc-lib/i486-suse-linux/2.95.2/specs
gcc version 2.95.2 19991024 (release)

and this one has successfully built the last couple of kernels. if
compiler requirements have changed, may i humbly suggest to add this
to the pre-patch logfile ?

btw: i have installed clean vanilla sources. the only  possible
source of pollution was my old .config, which i copied into the tree
before making menuconfig. but this has always worked before.

regards,

jörn

(please cc: me, i only read the archives, which have some lag.
thanks.)

-- 
Jörn Nettingsmeier     
home://Kurfürstenstr.49.45138.Essen.Germany      
phone://+49.201.491621
http://www.folkwang.uni-essen.de/~nettings/
http://www.linuxdj.com/audio/lad/
