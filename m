Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbTJARoh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 13:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbTJARog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 13:44:36 -0400
Received: from mail.zrz.TU-Berlin.DE ([130.149.4.15]:14726 "EHLO
	mail.zrz.tu-berlin.de") by vger.kernel.org with ESMTP
	id S262015AbTJARo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 13:44:27 -0400
X-Mailer: exmh 2.3 [17-Jan-2001] with nmh-1.0.4
To: isdn4linux@listserv.isdn4linux.de
Cc: linux-kernel@vger.kernel.org
Comment: Software is like sex - it's better when it's free. --Linus Torvalds
Subject: 2.4.22 PPP filtering for ISDN
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 01 Oct 2003 19:44:20 +0200
From: Frank Elsner <Elsner@zrz.TU-Berlin.DE>
Message-Id: <E1A4l1Q-0001GC-FD@bronto.zrz.TU-Berlin.DE>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When trying to compile kernel 2.4.22 (from kernel.org) with 
PPP filtering for ISDN enabled by "CONFIG_IPPP_FILTER=y" I get 

    ld -m elf_i386 -T /usr/src/linux-2.4.22/arch/i386/vmlinux.lds -e stext arch/i386
/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o init/do_m
ounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/f
s.o ipc/ipc.o \
         drivers/parport/driver.o drivers/char/char.o drivers/block/block.o driv
ers/misc/misc.o drivers/net/net.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o
 drivers/cdrom/driver.o drivers/pci/driver.o drivers/video/video.o drivers/media
/media.o drivers/isdn/vmlinux-obj.o \
        net/network.o \
        /usr/src/linux-2.4.22/arch/i386/lib/lib.a /usr/src/linux-2.4.22/lib/lib.
a /usr/src/linux-2.4.22/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/isdn/vmlinux-obj.o: In function `isdn_ppp_ioctl':
drivers/isdn/vmlinux-obj.o(.text+0xe64e): undefined reference to `sk_chk_filter'
drivers/isdn/vmlinux-obj.o: In function `isdn_ppp_push_higher':
drivers/isdn/vmlinux-obj.o(.text+0xf2e5): undefined reference to `sk_run_filter'
drivers/isdn/vmlinux-obj.o(.text+0xf32d): undefined reference to `sk_run_filter'
drivers/isdn/vmlinux-obj.o: In function `isdn_ppp_xmit':
drivers/isdn/vmlinux-obj.o(.text+0xf729): undefined reference to `sk_run_filter'
drivers/isdn/vmlinux-obj.o(.text+0xf78e): undefined reference to `sk_run_filter'
drivers/isdn/vmlinux-obj.o: In function `isdn_ppp_autodial_filter':
drivers/isdn/vmlinux-obj.o(.text+0xfcba): undefined reference to `sk_run_filter'
drivers/isdn/vmlinux-obj.o(.text+0xfce4): more undefined references to `sk_run_f
ilter' follow
make: *** [vmlinux] Error 1

Relevant config options are set as follows:

# ISDN subsystem
CONFIG_ISDN=y
CONFIG_ISDN_BOOL=y
CONFIG_ISDN_PPP=y
CONFIG_ISDN_PPP_VJ=y
CONFIG_ISDN_MPP=y
CONFIG_ISDN_PPP_BSDCOMP=m
CONFIG_ISDN_PPP_LZSCOMP=m          

Where is the problem located ?          


Regards        _______________________________________________________________ 
Frank Elsner  /                         c/o  Technische Universitaet Berlin   |
 ____________/                               ZRZ, Sekr. E-N 50                |
|                                            Einsteinufer 17                  |
| Voice: +49 30 314 23897                    D-10587 Berlin                   |
| SMTP : Elsner@zrz.TU-Berlin.DE             Germany    ______________________|
|_______________________________________________________| Momentan ist richtig



