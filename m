Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318194AbSG3LCi>; Tue, 30 Jul 2002 07:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318221AbSG3LCi>; Tue, 30 Jul 2002 07:02:38 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:5629 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318194AbSG3LCh>; Tue, 30 Jul 2002 07:02:37 -0400
Subject: Re: [ERROR] with 2.4.19[rc2|rc3]: Linking error scsidrv.o
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marc-Christian Petersen <mcp@linux-systeme.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200207301232.50704.mcp@linux-systeme.de>
References: <200207301232.50704.mcp@linux-systeme.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 30 Jul 2002 13:22:01 +0100
Message-Id: <1028031721.6725.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-30 at 11:32, Marc-Christian Petersen wrote:
> ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext
> arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
> init/version.o --start-group arch/i386/kernel/kernel.o arch/i386/mm/mm.o
> kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o  drivers/char/char.o
> drivers/block/block.o drivers/misc/misc.o drivers/net/net.o
> drivers/media/media.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o
> drivers/video/video.o net/network.o /usr/src/linux/arch/i386/lib/lib.a
> /usr/src/linux/lib/lib.a /usr/src/linux/arch/i386/lib/lib.a
> --end-group  -o vmlinux
> drivers/scsi/scsidrv.o: In function `ahc_proc_write_seeprom':
> drivers/scsi/scsidrv.o(.text+0xdba9): undefined reference to
> `ahc_acquire_seeprom'
> drivers/scsi/scsidrv.o(.text+0xdc33): undefined reference to
> `ahc_release_seeprom'

Known problem - fixed in -ac, or for the base enable CONFIG_PCI. I'll
push the fix to Marcelo for 2.4.20pre

