Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130078AbRALLP5>; Fri, 12 Jan 2001 06:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130751AbRALLPs>; Fri, 12 Jan 2001 06:15:48 -0500
Received: from fe180.worldonline.dk ([212.54.64.209]:16 "HELO
	fe180.worldonline.dk") by vger.kernel.org with SMTP
	id <S129967AbRALLPe>; Fri, 12 Jan 2001 06:15:34 -0500
Date: Fri, 12 Jan 2001 11:52:19 +0100 (CET)
From: Niels Kristian Bech Jensen <nkbj@image.dk>
To: Pau <linux4u@wanadoo.es>
cc: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: error compiling 2.4.1-pre3
In-Reply-To: <Pine.LNX.4.30.0101120956240.1297-100000@pau.intranet.ct>
Message-ID: <Pine.LNX.4.30.0101121151290.573-100000@hafnium.nkbj.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2001, Pau wrote:

>
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
> -fomit-frame-pointer -fno-strict-aliasing -pipe
> -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include
> /usr/src/linux/include/linux/modversions.h   -DEXPORT_SYMTAB -c xor.c
> In file included from /usr/src/linux/include/linux/raid/md.h:51,
>                  from xor.c:22:
> /usr/src/linux/include/linux/raid/md_k.h: In function `pers_to_level':
> /usr/src/linux/include/linux/raid/md_k.h:39: warning: control reaches end
> of non-void function
> xor.c: In function `calibrate_xor_block':
> xor.c:118: `HAVE_XMM' undeclared (first use in this function)
> xor.c:118: (Each undeclared identifier is reported only once
> xor.c:118: for each function it appears in.)
> {standard input}: Assembler messages:
> {standard input}:8: Warning: Ignoring changed section attributes for
> .modinfo
> make[2]: *** [xor.o] Error 1
> make[2]: Leaving directory `/usr/src/linux/drivers/md'
> make[1]: *** [_modsubdir_md] Error 2
> make[1]: Leaving directory `/usr/src/linux/drivers'
> make: *** [_mod_drivers] Error 2
>
Replace the two instances of HAVE_XMM in include/asm-i386/xor.h by
cpu_has_xmm.

-- 
Niels Kristian Bech Jensen -- nkbj@image.dk -- http://www.image.dk/~nkbj/

----------->>  Stop software piracy --- use free software!  <<-----------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
