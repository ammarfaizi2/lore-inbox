Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261312AbSKTPbc>; Wed, 20 Nov 2002 10:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261318AbSKTPbc>; Wed, 20 Nov 2002 10:31:32 -0500
Received: from [195.101.102.66] ([195.101.102.66]:3344 "EHLO
	daisy.lynuxworks.fr") by vger.kernel.org with ESMTP
	id <S261312AbSKTPba>; Wed, 20 Nov 2002 10:31:30 -0500
From: "Salvatore Palma" <spalma@lynuxworks.com>
To: <linux-kernel@vger.kernel.org>
Subject: Error in compiling the 2.4.20-rc1 linux  ppc kernel version
Date: Wed, 20 Nov 2002 16:39:14 +0100
Message-ID: <BEEJIEHLJEGEGMHGMGMHKENKCDAA.spalma@lynuxworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello
could you please help me in understand how to resolve the following problem
during linking phase?


make[2]: Nothing to be done for `all_targets'.
make[2]: Leaving directory `/usr/linuxppc/src-linuxppc_2_4/arch/ppc/lib'
make[1]: Leaving directory `/usr/linuxppc/src-linuxppc_2_4/arch/ppc/lib'
/usr/linuxppc/ppc/powerpc-linux/bin/ld -T arch/ppc/vmlinux.lds -Ttext
0xc0000000 -Bstatic arch/ppc/kernel/head.o arch/ppc/kernel/idle_6xx.o
init/main.o init/version.o init/do_mounts.o \
        --start-group \
        arch/ppc/kernel/kernel.o arch/ppc/platforms/platform.o
arch/ppc/mm/mm.o arch/ppc/lib/lib.o kernel/kernel.o mm/mm.o fs/fs.o
ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o drivers/ieee1394/ieee1394drv.o
drivers/pci/driver.o drivers/macintosh/macintosh.o \
        net/network.o \
        /usr/linuxppc/src-linuxppc_2_4/lib/lib.a \
        --end-group \
        -o vmlinux
mm/mm.o: In function `do_wp_page':
mm/mm.o(.text+0x12a4): undefined reference to `flush_tlb_page'
mm/mm.o(.text+0x12a4): relocation truncated to fit: R_PPC_REL24
flush_tlb_page
mm/mm.o(.text+0x1444): undefined reference to `flush_tlb_page'
mm/mm.o(.text+0x1444): relocation truncated to fit: R_PPC_REL24
flush_tlb_page
mm/mm.o: In function `handle_mm_fault':
mm/mm.o(.text+0x1cf8): undefined reference to `flush_tlb_page'
mm/mm.o(.text+0x1cf8): relocation truncated to fit: R_PPC_REL24
flush_tlb_page
fs/fs.o: In function `dput':
fs/fs.o(.text+0x17924): undefined reference to `atomic_dec_and_lock'
fs/fs.o(.text+0x17924): relocation truncated to fit: R_PPC_REL24
atomic_dec_and_lock
make: *** [vmlinux] Error 1

I did the following:

# make clean
# make dep
# make zImage.initrd


Many Thanks for any your help
Salvatore







===================================================================
Salvatore Palma               e: spalma@lynuxworks.fr
Consulting Engineer           v: +33 1 30 85 06 00
LYNUXWORKS S.A.               f: +33 1 30 85 06 06
2 allee de la Fresnerie       www.lynuxworks.com
78330 Fontenay-Le-Fleury
France

Open source and true real-time embedded solutions for the post-PC era
=====================================================================

