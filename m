Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbTJLXCB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 19:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbTJLXCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 19:02:01 -0400
Received: from smtp2.dei.uc.pt ([193.137.203.229]:51395 "EHLO smtp2.dei.uc.pt")
	by vger.kernel.org with ESMTP id S261217AbTJLXB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 19:01:58 -0400
Date: Mon, 13 Oct 2003 00:01:49 +0100 (WEST)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23-pre7-pac1
In-Reply-To: <Pine.LNX.4.56.0310122352140.16519@dot.kde.org>
Message-ID: <Pine.LNX.4.58.0310130001020.29346@student.dei.uc.pt>
References: <Pine.LNX.4.56.0310122352140.16519@dot.kde.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-UC-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-DEI-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't compile to me...

ld -m elf_i386 -T /root/kernel/linux-2.4.23-pre7-pac1/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/char/agp/agp.o drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/pcmcia/pcmcia.o drivers/net/pcmcia/pcmcia_net.o drivers/pnp/pnp.o drivers/video/video.o drivers/usb/usbdrv.o drivers/media/media.o drivers/net/irda/irda.o \
        net/network.o \
        /root/kernel/linux-2.4.23-pre7-pac1/arch/i386/lib/lib.a /root/kernel/linux-2.4.23-pre7-pac1/lib/lib.a /root/kernel/linux-2.4.23-pre7-pac1/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
arch/i386/kernel/kernel.o(.text.init+0x59c8): In function `acpi_parse_lapic':
: undefined reference to `acpi_table_print_madt_entry'
arch/i386/kernel/kernel.o(.text.init+0x5a38): In function `acpi_parse_lapic_nmi':
: undefined reference to `acpi_table_print_madt_entry'
arch/i386/kernel/kernel.o(.text.init+0x5b2e): In function `acpi_boot_init':
: undefined reference to `acpi_table_init'
arch/i386/kernel/kernel.o(.text.init+0x5b53): In function `acpi_boot_init':
: undefined reference to `acpi_table_parse'
arch/i386/kernel/kernel.o(.text.init+0x5b7e): In function `acpi_boot_init':
: undefined reference to `acpi_table_parse_madt'
arch/i386/kernel/kernel.o(.text.init+0x5bb3): In function `acpi_boot_init':
: undefined reference to `acpi_table_parse_madt'
arch/i386/kernel/kernel.o(.text.init+0x5bd1): In function `acpi_boot_init':
: undefined reference to `acpi_table_parse_madt'
make: *** [vmlinux] Error 1

Any thoughts on this?

--
==================================================
Marcos Daniel Marado Torres AKA Mind Booster Noori
/"\               http://student.dei.uc.pt/~marado
\ /                       marado@student.dei.uc.pt
 X   ASCII Ribbon Campaign
/ \  against HTML e-mail and Micro$oft attachments
==================================================

On Mon, 13 Oct 2003, Bernhard Rosenkraenzer wrote:

> $SUBJECT, AKA the "just returning from vacation release", is at
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/bero/2.4/2.4.23/
>
> Not many changes other than syncing with what happened while I was gone:
>
> - Sync with 2.4.23-pre7
> - Make sure everything compiles
> - Update DRI (good news for SiS graphics users: If you use this
>   along with XFree86 CVS, you'll have hw accelerated 3D)
>
> LLaP
> bero
>
> --
> Ark Linux - Linux for the masses
> http://www.arklinux.org/
>
> Redistribution and processing of this message is subject to
> http://www.arklinux.org/terms.php
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
