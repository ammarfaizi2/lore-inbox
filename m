Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132931AbRDEPgV>; Thu, 5 Apr 2001 11:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132930AbRDEPgC>; Thu, 5 Apr 2001 11:36:02 -0400
Received: from pieck.student.uva.nl ([146.50.96.22]:17874 "EHLO
	pieck.student.uva.nl") by vger.kernel.org with ESMTP
	id <S132929AbRDEPfv>; Thu, 5 Apr 2001 11:35:51 -0400
From: "R. van Dijk" <Rudmer.vanDijk@student.uva.nl>
To: linux-kernel@vger.kernel.org
Reply-To: rudmer.vandijk@student.uva.nl
Message-ID: <911e4990c632.90c632911e49@student.uva.nl>
Date: Thu, 05 Apr 2001 17:35:02 +0200
X-Mailer: Netscape Webmail
MIME-Version: 1.0
Content-Language: en
Subject: cannot compile kernel
X-Accept-Language: en
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

since kernel-version 2.4.1 I am not able to compile the kernel for my 
system (currently I run version 2.4.0). This is in my point of view due 
to a not included function but since i do not know if this is correct I 
send the output of the linking part of the kernel:

-- start output --
ld -m elf_i386 -T /usr/src/linux-2.4.3/arch/i386/vmlinux.lds -e stext 
arch/i386/
kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o 
mm/mm.o fs/f
s.o ipc/ipc.o \
        drivers/block/block.o drivers/char/char.o drivers/misc/misc.o 
drivers/ne
t/net.o drivers/media/media.o  drivers/parport/driver.o 
drivers/ide/idedriver.o
drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o 
drivers
/video/video.o \
        net/network.o \
        /usr/src/linux-2.4.3/arch/i386/lib/lib.a 
/usr/src/linux-2.4.3/lib/lib.a
/usr/src/linux-2.4.3/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
init/main.o: In function `check_fpu':
init/main.o(.text.init+0x23): undefined reference to 
`__buggy_fxsr_alignment'
make: *** [vmlinux] Error 1

-- end output --

compiling of the needed .o files did not give any errors.

Hardware specifications (from dmesg):
CPU: AMD Athlon(tm) Processor stepping 02 @ 1000 MHz
256 MB memory
BIOS Vendor: Award Software International, Inc.
BIOS Version: 6.00 PG
BIOS Release: 11/13/00
System Vendor: MICRO-STAR INTERNATIONAL CO., LTD.
Product Name: MS-6330.
Version  .
Serial Number  .
Board Vendor: MICRO-STAR INTERNATIONAL CO., LTD.
Board Name: MS-6330.
Board Version:  .
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a IDE UDMA66 controller on pci0:7.1
hda: QUANTUM FIREBALL ST6.4A, ATA DISK drive

compiler (gcc --version): pgcc-2.95.2
GNU ld 2.9.1
GNU Make version 3.78.1
GNU assembler 2.9.1

I hope i have included enough information for you and that you will be 
able to solve my problem. 

Thanks in advance,
Rudmer

