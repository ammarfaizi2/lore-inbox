Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314702AbSEDRBF>; Sat, 4 May 2002 13:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314735AbSEDRBE>; Sat, 4 May 2002 13:01:04 -0400
Received: from vivi.uptime.at ([62.116.87.11]:56780 "EHLO vivi.uptime.at")
	by vger.kernel.org with ESMTP id <S314702AbSEDRBD>;
	Sat, 4 May 2002 13:01:03 -0400
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Cc: <axp-kernel-list-admin@redhat.com>
Subject: 2.5.13 on Alpha don't likes me!!!!!!!!!! - A non sucess story. 2.5.11 worked fine!
Date: Sat, 4 May 2002 18:58:01 +0200
Organization: =?us-ascii?Q?UPtime_Systemlosungen?=
Message-ID: <000401c1f38c$dcdc2330$1201a8c0@pitzeier.priv.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <Pine.NEB.4.44.0205041809410.283-100000@mimas.fachschaften.tu-muenchen.de>
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi volks!

Here is my problem:
[ ... ]
rm -f math-emu.o
ld  -r -o math-emu.o math.o qrnnd.o
make[2]: Leaving directory `/root/linux-2.5.13/arch/alpha/math-emu'
make[1]: Leaving directory `/root/linux-2.5.13/arch/alpha/math-emu'
ld -static -T arch/alpha/vmlinux.lds -N  arch/alpha/kernel/head.o
init/main.o init/version.o init/do_mounts.o \
        --start-group \
        arch/alpha/kernel/kernel.o arch/alpha/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o arch/alpha/math-emu/math-emu.o \
        /root/linux-2.5.13/arch/alpha/lib/lib.a
/root/linux-2.5.13/lib/lib.a /root/linux-2.5.13/arch/alpha/lib/lib.a \
         drivers/base/base.o drivers/char/char.o drivers/block/block.o
drivers/misc/misc.o drivers/net/net.o drivers/media/media.o
drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o
drivers/pci/driver.o drivers/net/tulip/tulip_net.o drivers/pnp/pnp.o
drivers/video/video.o \
        net/network.o \
        --end-group \
        -o vmlinux
drivers/scsi/scsidrv.o: In function `sd_init':
drivers/scsi/scsidrv.o(.text+0x4d3d8): undefined reference to `vmalloc'
drivers/scsi/scsidrv.o(.text+0x4d3dc): undefined reference to `vmalloc'
drivers/scsi/scsidrv.o(.text+0x4d424): undefined reference to `vmalloc'
drivers/scsi/scsidrv.o(.text+0x4d428): undefined reference to `vmalloc'
drivers/scsi/scsidrv.o(.text+0x4d470): undefined reference to `vmalloc'
drivers/scsi/scsidrv.o(.text+0x4d474): more undefined references to
`vmalloc' follow
make: *** [vmlinux] Error 1
[ ... ]

Is there a patch, or anything? What makes video.o here??????????

Please help me!

-Oliver


