Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135485AbRBER1t>; Mon, 5 Feb 2001 12:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129539AbRBER1j>; Mon, 5 Feb 2001 12:27:39 -0500
Received: from host217-32-121-81.hg.mdip.bt.net ([217.32.121.81]:63750 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S135485AbRBER1X>;
	Mon, 5 Feb 2001 12:27:23 -0500
Date: Mon, 5 Feb 2001 17:30:11 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: Linux2.4.1-pre1, Kernel is too big for standalone boot from
 floppy
In-Reply-To: <Pine.LNX.4.21.0102051720090.1716-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.21.0102051728250.1716-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Feb 2001, Tigran Aivazian wrote:
> Basically, I badly needed to be able to build kernels of arbitrary size

not just "to build", but "to boot", of course :)

Also, while we are in a history lesson, I might as well add that this was
precisely the time when he (Werner) replaced the monstrously hardcoded
initial page table with the one generated "automagically" -- hence the
source file size went down dramatically...

> and I asked someone who I was sure would know (Werner) how to fix it --
> and I was right -- he did know and he fixed it so now one could build very
> large kernels and have them booted via LILO. But, the old plain bootsect.S
> was still left as is, i.e. unable to boot very large kernels (for exact
> size limits see the source, arch/i386/boot/tools/build.c) and so it was
> only natural that one should printf a warning.
> 
> So, in short, such kernels are okay to boot with LILO (and most other
> bootloaders) but not if you just dd if=bzImage of=/dev/fd0, i.e. not by
> bootsect.S
> 
> 
> If you want the date... it was approximately the beginning of 2000, I
> think.
> 
> Regards,
> Tigran
> 
> 
> > 
> > make[2]: Leaving directory
> > `/usr/src/linux-2.4.2-pre1/arch/i386/boot/compressed'
> > gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o tools/build
> > tools/build.c -I/usr/src/linux/include
> > objcopy -O binary -R .note -R .comment -S compressed/bvmlinux
> > compressed/bvmlinux.out
> > tools/build -b bbootsect bsetup compressed/bvmlinux.out CURRENT > bzImage
> > Root device is (8, 1)
> > Boot sector 512 bytes.
> > Setup is 4512 bytes.
> > System is 1418 kB
> > warning: kernel is too big for standalone boot from floppy
> > 
> >        +----------------------------------------------------------------+
> >        | James   W.   Laferriere | System  Techniques | Give me VMS     |
> >        | Network        Engineer | 25416      22nd So |  Give me Linux  |
> >        | babydr@baby-dragons.com | DesMoines WA 98198 |   only  on  AXP |
> >        +----------------------------------------------------------------+
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > Please read the FAQ at http://www.tux.org/lkml/
> > 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
