Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262972AbSJAX6C>; Tue, 1 Oct 2002 19:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262973AbSJAX6B>; Tue, 1 Oct 2002 19:58:01 -0400
Received: from mta02ps.bigpond.com ([144.135.25.134]:13810 "EHLO
	mta02ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S262972AbSJAX6A>; Tue, 1 Oct 2002 19:58:00 -0400
Message-ID: <016101c269a8$e4d85440$0800000a@ValVenus>
From: "David McIlwraith" <quack@bigpond.net.au>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.40] DAC960 broken?
Date: Wed, 2 Oct 2002 10:15:57 +1000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On compiling the driver w/ Dave Olein's patches:



gcc -Wp,-MD,./.DAC960.o.d -D__KERNEL__ -I/usr/src/linux-2.5.40/include -Wall
 -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-ali
asing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -I/usr/src/
linux-2.5.40/arch/i386/mach-generic -nostdinc -iwithprefix
lude    -DKBUILD_BASENAME=DAC960   -c -o DAC960.o DAC960.c
drivers/block/DAC960.c: In function `DAC960_RegisterBlockDevice':
drivers/block/DAC960.c:2112: structure has no member named `major_name'
drivers/block/DAC960.c: In function `DAC960_UnregisterBlockDevice':
drivers/block/DAC960.c:2137: structure has no member named `major_name'
drivers/block/DAC960.c:2150: warning: implicit declaration of function
`blk_clear'
drivers/block/DAC960.c: In function `DAC960_Initialize':
drivers/block/DAC960.c:2766: too many arguments to function `register_disk'
drivers/block/DAC960.c: In function `DAC960_Open':
drivers/block/DAC960.c:5316: too many arguments to function `register_disk'
   ld -m elf_i386  -r -o built-in.o elevator.o ll_rw_blk.o blkpg.o genhd.o
block_ioctl.o deadline-iosched.o floppy.o DAC960.o
ld: cannot open DAC960.o: No such file or directory
make[2]: *** [built-in.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.40/drivers/block'
make[1]: *** [block] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.40/drivers'
make: *** [drivers] Error 2

Anyone have any ideas?

Thanks in advance,
David McIlwraith mailto:quack@bigpond.net.au


