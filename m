Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264413AbRFSQma>; Tue, 19 Jun 2001 12:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264411AbRFSQmU>; Tue, 19 Jun 2001 12:42:20 -0400
Received: from pD9E16C60.dip.t-dialin.net ([217.225.108.96]:26607 "EHLO
	tolot.escape.de") by vger.kernel.org with ESMTP id <S264407AbRFSQmH>;
	Tue, 19 Jun 2001 12:42:07 -0400
Date: Tue, 19 Jun 2001 18:42:00 +0200
From: Jochen Striepe <jochen@tolot.escape.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.20-pre4
Message-ID: <20010619184200.A25821@tolot.escape.de>
In-Reply-To: <20010619172219.A18744@tolot.escape.de> <E15CNM0-00067q-00@the-village.bc.nu> <20010619182635.A24252@tolot.escape.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010619182635.A24252@tolot.escape.de>
User-Agent: Mutt/1.3.19i
X-Editor: vim/5.8.3
X-Signature-Color: blue
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        Hi again,

On 19 Jun 2001, Jochen Striepe <jochen@tolot.escape.de> wrote:
> 
> Now it stops with

OK, this resolved to nothing (my mistake). Now it works fine. Until it
reaches

ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
        fs/filesystems.a \
        net/network.a \
        drivers/block/block.a drivers/char/char.o drivers/misc/misc.a drivers/net/net.a drivers/scsi/scsi.a drivers/cdrom/cdrom.a drivers/pci/pci.a drivers/pnp/pnp.a drivers/video/video.a \
        /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a /usr/src/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/scsi/scsi.a(aic7xxx.o): In function `aic7xxx_load_seeprom':
aic7xxx.o(.text+0x12a76): undefined reference to `memcpy'
make: *** [vmlinux] Error 1


HAND,

Jochen.

-- 
"Gosh that takes me back ... or forward.  That's the trouble with time
travel, you never can tell."
                -- Dr. Who
