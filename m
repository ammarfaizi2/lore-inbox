Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267506AbRGMREC>; Fri, 13 Jul 2001 13:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267507AbRGMRDw>; Fri, 13 Jul 2001 13:03:52 -0400
Received: from 64.5.206.104 ([64.5.206.104]:16903 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S267506AbRGMRDp>; Fri, 13 Jul 2001 13:03:45 -0400
Date: Fri, 13 Jul 2001 13:03:44 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: Brunet Eric <rickos@ifrance.com>
cc: <linux-kernel@vger.kernel.org>, <eric.brunet@voila.fr>
Subject: Re: compile and bootdisk problems
In-Reply-To: <3B4F2415.559A12D9@ifrance.com>
Message-ID: <Pine.LNX.4.33.0107131254520.14872-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jul 2001, Brunet Eric wrote:

> Hello,
>
> i meet some problems in order to create a linux bootdisk:
> therefore, i tries to make a polyvalent kernel (in one floppy) with:
> -no module
> -a lot of ethernet card drivers
> This flopppy disk will be used to boot windows machine with partimage
> program in order to backup entire FS to a backup server!!
>
> The first, i couldn't compile the kernel with all ethernets card
> drivers,

Hmm. My suggestion is to choose the NICs you actually use, maybe plus ISA and
PCI NE2k (you never know...).

>  [snip]
>
> -the other problem is in boot sequence, i prapre the kernel image for
> the rootdisk(it work with a Slackware bootdisk) like this:
> >   rdev bzImage /dev/fd0
> >   rdev -r bzImage 49152 (49152 = ask disk, and read from 0)

I think you want 32768 instead. Bit 14 says load an inital ramdisk, and
nowhere in your process do you actually create one. While you're at it, ditch
the msdos and/or umsdos filesystems and use vfat instead.

> >   rdev -R bzImage 0 (to make the root RW and allow to login)
> >  dd if=bzImage of=/dev/fd0 bs=1k
>
>  [snip]
>
> I read many FAQ, ML and bootdisk HOWTO(of course) wtihout response
>
> please help me :~(
>:))I
>
> thank in advance for your response

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>




