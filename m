Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262781AbSJBBEe>; Tue, 1 Oct 2002 21:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262407AbSJBBEe>; Tue, 1 Oct 2002 21:04:34 -0400
Received: from air-2.osdl.org ([65.172.181.6]:19105 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262781AbSJBBE0>;
	Tue, 1 Oct 2002 21:04:26 -0400
Date: Tue, 1 Oct 2002 18:09:54 -0700
From: Dave Olien <dmo@osdl.org>
To: David McIlwraith <quack@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.40] DAC960 broken?
Message-ID: <20021001180954.A1010@build.pdx.osdl.net>
References: <016101c269a8$e4d85440$0800000a@ValVenus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <016101c269a8$e4d85440$0800000a@ValVenus>; from quack@bigpond.net.au on Wed, Oct 02, 2002 at 10:15:57AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm looking at it.  I'll try post a patch tomorrow for 2.5.40.


On Wed, Oct 02, 2002 at 10:15:57AM +1000, David McIlwraith wrote:
> On compiling the driver w/ Dave Olein's patches:
> 
> 
> 
> gcc -Wp,-MD,./.DAC960.o.d -D__KERNEL__ -I/usr/src/linux-2.5.40/include -Wall
>  -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-ali
> asing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -I/usr/src/
> linux-2.5.40/arch/i386/mach-generic -nostdinc -iwithprefix
> lude    -DKBUILD_BASENAME=DAC960   -c -o DAC960.o DAC960.c
> drivers/block/DAC960.c: In function `DAC960_RegisterBlockDevice':
> drivers/block/DAC960.c:2112: structure has no member named `major_name'
> drivers/block/DAC960.c: In function `DAC960_UnregisterBlockDevice':
> drivers/block/DAC960.c:2137: structure has no member named `major_name'
> drivers/block/DAC960.c:2150: warning: implicit declaration of function
> `blk_clear'
> drivers/block/DAC960.c: In function `DAC960_Initialize':
> drivers/block/DAC960.c:2766: too many arguments to function `register_disk'
> drivers/block/DAC960.c: In function `DAC960_Open':
> drivers/block/DAC960.c:5316: too many arguments to function `register_disk'
>    ld -m elf_i386  -r -o built-in.o elevator.o ll_rw_blk.o blkpg.o genhd.o
> block_ioctl.o deadline-iosched.o floppy.o DAC960.o
> ld: cannot open DAC960.o: No such file or directory
> make[2]: *** [built-in.o] Error 1
> make[2]: Leaving directory `/usr/src/linux-2.5.40/drivers/block'
> make[1]: *** [block] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.5.40/drivers'
> make: *** [drivers] Error 2
> 
> Anyone have any ideas?
> 
> Thanks in advance,
> David McIlwraith mailto:quack@bigpond.net.au
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
