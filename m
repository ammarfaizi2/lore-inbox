Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287566AbSAAJR7>; Tue, 1 Jan 2002 04:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287773AbSAAJRj>; Tue, 1 Jan 2002 04:17:39 -0500
Received: from h24-71-223-13.cg.shawcable.net ([24.71.223.13]:35697 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id <S287566AbSAAJRi>; Tue, 1 Jan 2002 04:17:38 -0500
Date: Tue, 01 Jan 2002 02:17:32 -0700 (MST)
From: Tim Keating <tkeating@shaw.ca>
Subject: Another .text.exit error.  2.4.18pre1
X-X-Sender: <tkeating@darkspace.hidden.net>
To: linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.33.0201010206291.217-100000@darkspace.hidden.net>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ld -m elf_i386 -T /usr/src/linux-pre/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o
drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/cdrom/driver.o
drivers/pci/driver.o drivers/video/video.o drivers/input/inputdrv.o \
        net/network.o \
        /usr/src/linux-pre/arch/i386/lib/lib.a
/usr/src/linux-pre/lib/lib.a /usr/src/linux-pre/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
net/network.o(.text.lock+0x16f0): undefined reference to `local symbols in
discarded section .text.exit'
make: *** [vmlinux] Error 1


Using Keith Owens perl script I found in message;

http://www.uwsg.indiana.edu/hypermail/linux/kernel/0112.3/0700.html

I get ...


Finding objects, 438 objects, ignoring 0 module(s)
Finding conglomerates, ignoring 35 conglomerate(s)
Scanning objects
Error: ./net/ipv4/netfilter/ip_nat_snmp_basic.o .text.lock refers to
0000003c R_386_PC32        .text.exit
Done

I'm sorry .. not on the list.  Please cc me if you require more info.

Tim

-- 
If you want to speak to someone knowledgeable about computers and who
knows what's going on in "the local computer store", then you are forced
to talk to yourself... (;-))

