Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280288AbRKFT5y>; Tue, 6 Nov 2001 14:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280291AbRKFT5o>; Tue, 6 Nov 2001 14:57:44 -0500
Received: from mail5.svr.pol.co.uk ([195.92.193.20]:2613 "EHLO
	mail5.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S280288AbRKFT5d>; Tue, 6 Nov 2001 14:57:33 -0500
Content-Type: text/plain; charset=US-ASCII
From: Chris Howells <chris@chrishowells.co.uk>
Organization: @ $HOME
To: linux-kernel@vger.kernel.org
Subject: Re: Error compiling 2.4.14
Date: Tue, 6 Nov 2001 19:57:07 +0000
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E161CLj-0003zf-00.2001-11-06-19-57-32@mail5.svr.pol.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> drivers/block/block.o: In function `lo_send':
> drivers/block/block.o(.text+0xa41f): undefined reference to 
> `deactivate_page'
> drivers/block/block.o(.text+0xa469): undefined reference to 
> `deactivate_page'
> make: *** [vmlinux] Error 1
> [root@interno linux]#

I have a similair problem with 2.4.14 + ext3 patch on SuSE 7.3 (gcc 2.95.3), 
during "make bzImage".

make[1]: Leaving directory `/usr/src/linux-2.4.14/arch/i386/lib'
ld -m elf_i386 -T /usr/src/linux-2.4.14/arch/i386/vmlinux.lds -e stext 
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o 
init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o 
fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o 
drivers/net/net.o drivers/media/media.o drivers/net/fc/fc.o drivers/atm/atm.o 
drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o 
drivers/pci/driver.o drivers/video/video.o \
        net/network.o \
        /usr/src/linux-2.4.14/arch/i386/lib/lib.a 
/usr/src/linux-2.4.14/lib/lib.a /usr/src/linux-2.4.14/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/block/block.o: In function `lo_send':
drivers/block/block.o(.text+0xa4e9): undefined reference to `deactivate_page'
drivers/block/block.o(.text+0xa50f): undefined reference to `deactivate_page'
make: *** [vmlinux] Error 1


Any ideas? I badly need this kernel -- the 2.4.10 SuSE seems to be crippled 
because it crashes my Al440LX system on shutdown 
(http://lists2.suse.com/archive/suse-linux-e/2001-Nov/0481.html).

- -- 
Cheers, Chris Howells -- chris@chrishowells.co.uk, howells@kde.org
Web: http://chrishowells.co.uk, PGP key: http://chrishowells.co.uk/pgp.txt
KDE: http://www.koffice.org, http://edu.kde.org, http://usability.kde.org

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE76ECaF8Iu1zN5WiwRApZ9AKCApi0ySdIaW2imgq18brRaeGAC2wCeLv5q
/53zh+JRfvYz+be+cMkMl0Y=
=QuyU
-----END PGP SIGNATURE-----
