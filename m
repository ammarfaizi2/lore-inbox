Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282695AbRLFTxu>; Thu, 6 Dec 2001 14:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282702AbRLFTxl>; Thu, 6 Dec 2001 14:53:41 -0500
Received: from mail311.mail.bellsouth.net ([205.152.58.171]:48306 "EHLO
	imf11bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S282695AbRLFTx3>; Thu, 6 Dec 2001 14:53:29 -0500
Message-ID: <3C0FCCAC.CE6905D5@mandrakesoft.com>
Date: Thu, 06 Dec 2001 14:53:16 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.13-12mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: devnull@geisel.info
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17-pre5 "make bzImage" fails
In-Reply-To: <20011206195025.GA9599@geisel.info>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

devnull@geisel.info wrote:
> 
> Hi,
> 
> I switched from 2.4.16 to 2.4.17-pre5 without changing config and now
> "make bzImage" fails with the following error:
> 
> ----------------------------------------------------------------------------
> tmppiggy=_tmp_$$piggy; \
> rm -f $tmppiggy $tmppiggy.gz $tmppiggy.lnk; \
> objcopy -O binary -R .note -R .comment -S /usr/src/linux/vmlinux
> $tmppiggy; \
> gzip -f -9 < $tmppiggy > $tmppiggy.gz; \
> echo "SECTIONS { .data : { input_len = .; LONG(input_data_end -
> input_data) input_data = .; *(.data) input_data_end = .; }}" >
> $tmppiggy.lnk; \
> ld -m elf_i386 -r -o piggy.o -b binary $tmppiggy.gz -b elf32-i386 -T
> $tmppiggy.lnk; \
> rm -f $tmppiggy $tmppiggy.gz $tmppiggy.lnk
> gcc -D__ASSEMBLY__ -D__KERNEL__ -I/usr/src/linux/include -traditional -c
> head.S
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=athlon  -c misc.c
> ld -m elf_i386 -Ttext 0x100000 -e startup_32 -o bvmlinux head.o misc.o
> piggy.o
> ld: bvmlinux: Not enough room for program headers (allocated 2, need 3)
> ld: final link failed: Bad value

did you upgrade your binutils recently?

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

