Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265895AbTABEsj>; Wed, 1 Jan 2003 23:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266006AbTABEsj>; Wed, 1 Jan 2003 23:48:39 -0500
Received: from david.optusnet.com.au ([203.10.68.44]:13000 "EHLO
	david.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S265895AbTABEsh>; Wed, 1 Jan 2003 23:48:37 -0500
Date: Thu, 2 Jan 2003 15:57:03 +1100
From: David Parrish <david@dparrish.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.53 compile error
Message-ID: <20030102045702.GA16401@david.optusnet.com.au>
References: <20030102044543.GA13786@david.optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030102044543.GA13786@david.optusnet.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, that should be 2.5.54.

On Thu, Jan 02, 2003 at 03:45:43PM +1100, David Parrish wrote:
> Date: Thu, 2 Jan 2003 15:45:43 +1100
> From: David Parrish <david@dparrish.com>
> To: Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: 2.5.53 compile error
> 
> Hi there!
> 
> I'm trying to compile 2.5.53, getting the following error:
> 
> make -f scripts/Makefile.build obj=drivers/media/video
>   gcc -Wp,-MD,drivers/media/video/.videodev.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=videodev -DKBUILD_MODNAME=videodev -DEXPORT_SYMTAB  -c -o drivers/media/video/videodev.o drivers/media/video/videodev.c
>   ld -m elf_i386  -r -o drivers/media/video/videodev.ko drivers/media/video/videodev.o
>   gcc -Wp,-MD,drivers/media/video/.v4l2-common.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=v4l2_common -DKBUILD_MODNAME=v4l2_common -DEXPORT_SYMTAB  -c -o drivers/media/video/v4l2-common.o drivers/media/video/v4l2-common.c
>   ld -m elf_i386  -r -o drivers/media/video/v4l2-common.ko drivers/media/video/v4l2-common.o
>   gcc -Wp,-MD,drivers/media/video/.bttv-driver.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=bttv_driver -DKBUILD_MODNAME=bttv   -c -o drivers/media/video/bttv-driver.o drivers/media/video/bttv-driver.c
>   gcc -Wp,-MD,drivers/media/video/.bttv-cards.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=bttv_cards -DKBUILD_MODNAME=bttv   -c -o drivers/media/video/bttv-cards.o drivers/media/video/bttv-cards.c
> drivers/media/video/bttv-cards.c: In function `miro_pinnacle_gpio':
> drivers/media/video/bttv-cards.c:1742: `AUDC_CONFIG_PINNACLE' undeclared (first use in this function)
> drivers/media/video/bttv-cards.c:1742: (Each undeclared identifier is reported only once
> drivers/media/video/bttv-cards.c:1742: for each function it appears in.)
> make[3]: *** [drivers/media/video/bttv-cards.o] Error 1
> make[2]: *** [drivers/media/video] Error 2
> make[1]: *** [drivers/media] Error 2
> make: *** [drivers] Error 2
> 
> 
> david:/usr/src/linux-2.5.53# grep -r AUDC_CONFIG_PINNACLE *
> drivers/media/video/bttv-cards.c:               bttv_call_i2c_clients(btv,AUDC_CONFIG_PINNACLE,&id);
> 
> Turning off BT848 support fixes this.
> 
> -- 
> Regards,
> David Parrish
> 0410 586 121

-- 
Regards,
David Parrish
0410 586 121
