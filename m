Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbTEJBIg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 21:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263628AbTEJBIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 21:08:36 -0400
Received: from smtp.cogeco.net ([216.221.81.25]:2039 "EHLO fep2.cogeco.net")
	by vger.kernel.org with ESMTP id S261869AbTEJBIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 21:08:35 -0400
Date: Fri, 9 May 2003 21:28:05 -0400
To: linux-kernel@vger.kernel.org
Subject: Linking error in sounddrivers.o (2.4.20)
Message-ID: <20030510012805.GA1037@dragon.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Olivier Dragon <dragon@shadnet.shad.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

In the 2.4.20 kernel I have encountered a linking error happening in
sounddrivers.o. It happens with the following config file when doing
"make bzImage". It first happened with a ck6 patched kernel but I have
verified on two different computers (laptop running knoppix 3.2 and
desktop running Debian unstable) that it also happens in the unpatched
vanilla kernel.

http://dragon.homelinux.org/linux-2.4.20-ck6-config

Here is the few last lines before the error occurs, during a
"make bzImage":
<<<<<<<<<<<<<<<<
ld -m elf_i386 -T /home/oli/src/linux2.4/linux-laptop/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/acpi/acpi.o drivers/parport/driver.o drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/video/video.o drivers/usb/usbdrv.o drivers/input/inputdrv.o \
        net/network.o \
        /home/oli/src/linux2.4/linux-laptop/arch/i386/lib/lib.a /home/oli/src/linux2.4/linux-laptop/lib/lib.a /home/oli/src/linux2.4/linux-laptop/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/sound/sounddrivers.o(.text.init+0x63a): In function `trident_probe':
: undefined reference to `pcigame_attach'
make: *** [vmlinux] Error 1
>>>>>>>>>>>>>>>>>


Here is the output from ver_linux script on my desktop machine:
Linux trinity 2.4.20-ck6 #4 Fri Apr 25 15:20:53 EDT 2003 i686 unknown unknown GNU/Linux
Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
modutils               2.4.21
e2fsprogs              1.33
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.8
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
Modules Loaded         radeon


If I have forgotten any information please let me know and I will gladly
and promptly answer.

Thank you very much,
-Olivier
