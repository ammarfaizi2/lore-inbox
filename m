Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129116AbQKHASg>; Tue, 7 Nov 2000 19:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129724AbQKHAS0>; Tue, 7 Nov 2000 19:18:26 -0500
Received: from host55.osagesoftware.com ([209.142.225.55]:52485 "EHLO
	netmax.osagesoftware.com") by vger.kernel.org with ESMTP
	id <S129116AbQKHASP>; Tue, 7 Nov 2000 19:18:15 -0500
Message-Id: <4.3.2.7.2.20001107191239.00bb6ea0@mail.osagesoftware.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 07 Nov 2000 19:18:03 -0500
To: Jeff Garzik <jgarzik@mandrakesoft.com>
From: David Relson <relson@osagesoftware.com>
Subject: Re: Installing kernel 2.4
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A089752.505816BA@mandrakesoft.com>
In-Reply-To: <Pine.LNX.4.30.0011080047260.10874-100000@space.comunit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems to me that kernel/cpu matching can be broken into two relatively 
simple parts.

1 - Put a cpu "signature" in the kernel image indicating cpu requirements; and
2 - Have the bootloader (lilo) detect cpu type and match it against the cpu 
"signature".

The bootloader would then load the kernel, or could give an informative 
diagnostic.

David



At 06:59 PM 11/7/00, Jeff Garzik wrote:
>Sven Koch wrote:
> >
> > On Tue, 7 Nov 2000, David Lang wrote:
> >
> > > depending on what CPU you have the kernel (and compiler) can use 
> different
> > > commands/opmizations/etc, if you want to do this on boot you have two
> > > options.
> >
> > Wouldn't it be possible to compile the parts of the kernel needed to
> > uncompress and to detect the cpu with lower optimizations and then abort
> > with an error message?
> >
> > "Error: Kernel needs a PIII" sounds much better than just stoping dead.
>
>I agree...   maybe we can solve this simply by giving the CPU detection
>module the -march=i386 flag hardcoded, or editing the bootstrap, or
>something like that...
>
>         Jeff

--------------------------------------------------------
David Relson                   Osage Software Systems, Inc.
relson@osagesoftware.com       514 W. Keech Ave.
www.osagesoftware.com          Ann Arbor, MI 48103
voice: 734.821.8800            fax: 734.821.8800

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
