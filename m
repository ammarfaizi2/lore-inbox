Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312694AbSDXWTy>; Wed, 24 Apr 2002 18:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312696AbSDXWTx>; Wed, 24 Apr 2002 18:19:53 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:1754 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S312694AbSDXWTw> convert rfc822-to-8bit; Wed, 24 Apr 2002 18:19:52 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <mcp@linux-systeme.de>
Reply-To: mcp@linux-systeme.de
Organization: Linux-Systeme GmbH
To: linux-kernel@vger.kernel.org
Subject: 2.5.10 compile/link problem
Date: Thu, 25 Apr 2002 00:19:45 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200204250019.46082.mcp@linux-systeme.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

ld -m elf_i386 -T /usr/src/linux-2.5.10/arch/i386/vmlinux.lds -e stext 
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o 
init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o 
fs/fs.o ipc/ipc.o \
        /usr/src/linux-2.5.10/arch/i386/lib/lib.a 
/usr/src/linux-2.5.10/lib/lib.a /usr/src/linux-2.5.10/arch/i386/lib/lib.a \
         drivers/acpi/acpi.o drivers/base/base.o drivers/char/char.o 
drivers/block/block.o drivers/misc/misc.o drivers/net/net.o 
drivers/media/media.o drivers/char/drm/drm.o drivers/ide/idedriver.o 
drivers/cdrom/driver.o sound/sound.o drivers/pci/driver.o drivers/pnp/pnp.o 
drivers/video/video.o drivers/md/mddev.o \
        net/network.o \
        --end-group \
        -o vmlinux
drivers/net/net.o: In function `e100_diag_config_loopback':
drivers/net/net.o(.text+0x5adf): undefined reference to `e100_phy_reset'
make: *** [vmlinux] Error 1

With EtherExpress Pro 100 original Becker driver.

-- 
Kind regards
	Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824  080A 569D E2E3 DB44 1A16
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.selected!
