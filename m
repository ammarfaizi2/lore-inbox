Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315761AbSEDB5E>; Fri, 3 May 2002 21:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315762AbSEDB5D>; Fri, 3 May 2002 21:57:03 -0400
Received: from jalon.able.es ([212.97.163.2]:57279 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S315761AbSEDB5C>;
	Fri, 3 May 2002 21:57:02 -0400
Date: Sat, 4 May 2002 03:56:55 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: trond.myklebust@fys.uio.no
Subject: undefined reference to `in_ntoa'
Message-ID: <20020504015655.GA8544@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.3.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Building 2.4.19-pre8:

ld -m elf_i386 -T /usr/src/linux-2.4.19-pre8-jam1/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/video/video.o drivers/sensors/sensor.o \
        net/network.o \
        /usr/src/linux-2.4.19-pre8-jam1/arch/i386/lib/lib.a /usr/src/linux-2.4.19-pre8-jam1/lib/lib.a /usr/src/linux-2.4.19-pre8-jam1/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
fs/fs.o: In function `root_nfs_getport':
fs/fs.o(.text.init+0x156c): undefined reference to `in_ntoa'
make: *** [vmlinux] Error 1

It is only used in fs/nfs/nfsroot.c, and never defined (grep -r just shows that).

TIA.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre7-jam9 #2 SMP mié may 1 12:09:38 CEST 2002 i686
