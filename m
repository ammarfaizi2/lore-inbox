Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129703AbQKHALG>; Tue, 7 Nov 2000 19:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129245AbQKHAK5>; Tue, 7 Nov 2000 19:10:57 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:29191 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129210AbQKHAKk>; Tue, 7 Nov 2000 19:10:40 -0500
Message-ID: <3A089917.4198119F@timpanogas.org>
Date: Tue, 07 Nov 2000 17:06:47 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: davej@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Installing kernel 2.4
In-Reply-To: <Pine.LNX.4.21.0011072322120.8187-100000@neo.local> <3A089254.397115FE@timpanogas.org> <3A089850.92EF0D4A@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Code is.  Data isn't.  Gcc packs data into the segment like sardines in
a can (NT code does to).  16 byte align this as well.  NetWare 16 byte
aligns everythin with an align 16 directive in the data segments of
assembler modules.

Jeff

Jeff Garzik wrote:
> 
> "Jeff V. Merkey" wrote:
> > If the compiler always aligned all functions and data on 16 byte
> > boundries (NetWare)
> > for all i386 code, it would run a lot faster.
> 
> Are you saying that it isn't?  Have you look at gcc-generated assembly
> from a recent 2.2.x or 2.4.x kernel?
> 
> 2.2.x build command line, note use of "...align...":
> /usr/bin/kgcc -D__KERNEL__ -I/spare/cvs/linux_2_2/include -Wall
> -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
> -D__SMP__ -pipe -fno-strength-reduce -m486 -malign-loops=2
> -malign-jumps=2 -malign-functions=2 -DCPU=686   -c -o extable.o
> extable.c
> 
> 2.4.x, note "preferred-stack-boundary" and generated asm code...
> gcc -D__KERNEL__ -I/spare/cvs/linux_2_4/include -Wall
> -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
> -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include
> /spare/cvs/linux_2_4/include/linux/modversions.h   -c -o emd.o emd.c
> 
>         Jeff
> 
> --
> Jeff Garzik             | "When I do this, my computer freezes."
> Building 1024           |          -user
> MandrakeSoft            | "Don't do that."
>                         |          -level 1
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
