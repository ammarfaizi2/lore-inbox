Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313683AbSDPN7H>; Tue, 16 Apr 2002 09:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313682AbSDPN7G>; Tue, 16 Apr 2002 09:59:06 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:14906 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S313683AbSDPN7F>; Tue, 16 Apr 2002 09:59:05 -0400
Message-Id: <5.1.0.14.2.20020416145732.00ac6cb0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 16 Apr 2002 14:59:09 +0100
To: James Bourne <jbourne@MtRoyal.AB.CA>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: linux-2.4.19-pre7: undefined reference to
  `page_cache_release'
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0204160744210.27937-300000@skuld.mtroyal.ab.
 ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

I have already submitted a patch to fix this earlier today... and in fact 
it is identical to yours. (-:

Cheers,

Anton

At 14:50 16/04/02, James Bourne wrote:
>Hi all,
>When compiling 2.4.19-pre7 I am getting undefined reference to
>`page_cache_release' errors on linking vmlinux:
>
>make CFLAGS="-D__KERNEL__
>-I/usr/src/linux/include -Wall -Wstrict-prototypes
>-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
>-pipe -mpreferred-stack-boundary=2 -march=i686 " -C  arch/i386/lib
>make[1]: Entering directory /usr/src/linux/arch/i386/lib'
>make all_targets
>make[2]: Entering directory /usr/src/linux/arch/i386/lib'
>make[2]: Nothing to be done for `all_targets'.
>make[2]: Leaving directory /usr/src/linux/arch/i386/lib'
>make[1]: Leaving directory /usr/src/linux/arch/i386/lib'
>ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds
>-e stext arch/i386/kernel/head.o
>arch/i386/kernel/init_task.o init/main.o init/version.o init/do_mounts.o \
>         --start-group \
>
>  arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o
>ipc/ipc.o \
>          drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
>drivers/net/net.o drivers/media/media.o drivers/scsi/scsidrv.o
>drivers/cdrom/driver.o
>drivers/pci/driver.o drivers/video/video.o drivers/md/mddev.o \
>         net/network.o \
>         /usr/src/linux/arch/i386/lib/lib.a
>/usr/src/linux/lib/lib.a /usr/src/linux/arch/i386/lib/lib.a \
>         --end-group \
>         -o vmlinux
>fs/fs.o: In function `create_data_partitions':
>fs/fs.o(.text+0x2594d): undefined reference to `page_cache_release'
>fs/fs.o(.text+0x25a05): undefined reference to `page_cache_release'
>fs/fs.o: In function `get_disk_objid':
>fs/fs.o(.text+0x25d63): undefined reference to `page_cache_release'
>fs/fs.o(.text+0x25ddd): undefined reference to `page_cache_release'
>fs/fs.o(.text+0x25e18): undefined reference to `page_cache_release'
>fs/fs.o(.text+0x25ef6): more undefined references to `page_cache_release'
>follow
>make: *** [vmlinux] Error 1

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

