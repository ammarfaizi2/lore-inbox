Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264806AbSLGVyS>; Sat, 7 Dec 2002 16:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264814AbSLGVyS>; Sat, 7 Dec 2002 16:54:18 -0500
Received: from lakemtao03.cox.net ([68.1.17.242]:29391 "EHLO
	lakemtao03.cox.net") by vger.kernel.org with ESMTP
	id <S264806AbSLGVyR>; Sat, 7 Dec 2002 16:54:17 -0500
Message-ID: <3DF26FED.5070502@cox.net>
Date: Sat, 07 Dec 2002 16:02:21 -0600
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kenel compilation failure
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I downloaded kernel 2.4.20 and got the following during 'make modules'

; SNIP
gcc -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
-pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS
-include /usr/src/linux-2.4.20/include/linux/modversions.h  -nostdinc
-iwithprefix include -DKBUILD_BASENAME=scsi_syms  -DEXPORT_SYMTAB -c
scsi_syms.c
ld -m elf_i386 -r -o scsi_mod.o scsi.o hosts.o scsi_ioctl.o constants.o
scsicam.o scsi_proc.o scsi_error.o scsi_obsolete.o scsi_queue.o scsi_lib.o
scsi_merge.o
scsi_dma.o scsi_scan.o scsi_syms.o
ln -sf sim710.scr fake7.c
gcc -E -D__KERNEL__ -I/usr/src/linux-2.4.20/include -traditional
-DCHIP=710 fake7.c | grep -v '^#' | perl -s script_asm.pl -ncr710
script_asm.pl : Illegal combination of registers in line 72 :   MOVE
CTEST7 & 0xef TO CTEST7
        Either source and destination registers must be the same,
        or either source or destination register must be SFBR.
make[2]: *** [sim710_d.h] Error 255
make[2]: Leaving directory `/usr/src/linux-2.4.20/drivers/scsi'
make[1]: *** [_modsubdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.20/drivers'
make: *** [_mod_drivers] Error 2
; SNIP

I didn't know who exactly to send that to, but I am definately sure that 
isn't supposed to happen. I've attached my configuration file to help. 
I'm not on the mailing list, so if you need anymore information, email 
me directly.
Thank you.

-David van Hoose
davidvh@cox.net

