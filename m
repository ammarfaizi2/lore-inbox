Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271163AbTG1XSf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 19:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271191AbTG1XSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 19:18:35 -0400
Received: from bay8-f3.bay8.hotmail.com ([64.4.27.3]:1039 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S271163AbTG1XSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 19:18:32 -0400
X-Originating-IP: [63.144.164.60]
X-Originating-Email: [gpc01532@hotmail.com]
From: "G. C." <gpc01532@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: gpc01532@hotmail.com
Subject: Link Error with Galileo EVB PowerPC kernel 
Date: Mon, 28 Jul 2003 19:18:31 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY8-F39C6Z50DVb69l0000c00e@hotmail.com>
X-OriginalArrivalTime: 28 Jul 2003 23:18:31.0829 (UTC) FILETIME=[8F703C50:01C3555E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear friends,

I used my cross compiler and successfully built a 2.4.18 PowerPC Linux 
kernel, but I have problem building the Galileo EVB PowerPC kernel. It is 
the link error as listed at the end of the mail. The kernel is
linuxppc+marvell-2.4.10-pre9.tar.gz.

Is this only a config mistake? What is the correct kernel config? Any other 
suggestions?

Your help will be deeply appreciated.

GC


powerpc-linux-ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic 
arch/ppc/kernel/head.o init/main.o init/version.o \
        --start-group \
        arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o 
kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o arch/ppc/xmon/x.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o 
drivers/net/net.o drivers/media/media.o drivers/ide/idedriver.o 
drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/pci/driver.o 
drivers/net/wireless/wireless_net.o drivers/macintosh/macintosh.o 
drivers/video/video.o drivers/usb/usbdrv.o drivers/input/inputdrv.o \
        net/network.o \
        /home/marvell/project/kernel/marvell_linux/lib/lib.a \
        --end-group \
        -o vmlinux
arch/ppc/kernel/kernel.o: In function `sys_call_table':
arch/ppc/kernel/entry.S(.text.init+0xe56): undefined reference to 
`pmac_newworld'
arch/ppc/kernel/entry.S(.text.init+0xe5a): undefined reference to 
`pmac_newworld'
arch/ppc/kernel/entry.S(.text.init+0xf6c): undefined reference to 
`find_devices'arch/ppc/kernel/entry.S(.text.init+0xf6c): relocation 
truncated to fit: R_PPC_REL24 find_devices
arch/ppc/kernel/entry.S(.text.init+0xfa0): undefined reference to 
`device_is_compatible'
arch/ppc/kernel/entry.S(.text.init+0xfa0): relocation truncated to fit: 
R_PPC_REL24 device_is_compatible
arch/ppc/kernel/entry.S(.text.init+0x10ce): undefined reference to 
`sys_ctrler'
arch/ppc/kernel/entry.S(.text.init+0x10d2): undefined reference to 
`sys_ctrler'
make: *** [vmlinux] Error 1

_________________________________________________________________
Add photos to your messages with MSN 8. Get 2 months FREE*.  
http://join.msn.com/?page=features/featuredemail

