Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAAAUl>; Sun, 31 Dec 2000 19:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130530AbRAAAUb>; Sun, 31 Dec 2000 19:20:31 -0500
Received: from [213.167.220.121] ([213.167.220.121]:13316 "EHLO
	penny.ik5pvx.ampr.org") by vger.kernel.org with ESMTP
	id <S129183AbRAAAUS>; Sun, 31 Dec 2000 19:20:18 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-prerelease compile error in (maybe) mkiss
Reply-To: Pierfrancesco Caci <p.caci@tin.it>
From: Pierfrancesco Caci <ik5pvx@penny.ik5pvx.ampr.org>
Date: 01 Jan 2001 00:49:40 +0100
Message-ID: <87bstskv6z.fsf@penny.ik5pvx.ampr.org>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there... first compilation error of 2001 (at least in my timezone :-)

ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
        drivers/block/block.o drivers/char/char.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o  drivers/char/drm/drm.o drivers/isdn/isdn.a drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/video/video.o drivers/net/hamradio/hamradio.o drivers/acpi/acpi.o drivers/md/mddev.o \
        net/network.o \
        /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a /usr/src/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/net/net.o: In function `network_ldisc_init':
drivers/net/net.o(.text.init+0x135): undefined reference to `mkiss_init_ctrl_dev'
make: *** [vmlinux] Error 1


Ciao

Pf



-- 

-------------------------------------------------------------------------------
 Pierfrancesco Caci | ik5pvx | mailto:p.caci@tin.it  -  http://gusp.dyndns.org
  Firenze - Italia  | Office for the Complication of Otherwise Simple Affairs 
     Linux penny 2.4.0-test10 #1 Wed Nov 8 22:58:01 CET 2000 i686 unknown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
