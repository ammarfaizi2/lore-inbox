Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136079AbRA1Av0>; Sat, 27 Jan 2001 19:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136132AbRA1AvQ>; Sat, 27 Jan 2001 19:51:16 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:27404
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S136079AbRA1AvE>; Sat, 27 Jan 2001 19:51:04 -0500
Date: Sat, 27 Jan 2001 16:49:25 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Derek Benson <derek@borogoves.yi.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel boot problems
In-Reply-To: <200101280014.f0S0E4702435@borogoves.yi.org>
Message-ID: <Pine.LNX.4.10.10101271646210.25130-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Maybe try enabling ATA/IDE driver as the configuration at compile time has
changed.  Using an old 2.2 '.config' will fail to enable the subsystem.
However using a 2.4'.config' on a 2.2 compile will generally succeed in
90% of the flags.

Cheers,

On Sun, 28 Jan 2001, Derek Benson wrote:

>  Ryan> Hello all,
> 
> Hi
> 
>  Ryan> I was wondering if someone might be able to help me.  I have
>  Ryan> just compiled my kernel and set it up on a floppy to boot off a
>  Ryan> disk.  I have it then use an image file to uncompress and get
>  Ryan> the filesystem off ,etc.  Well when it boots it says it has
>  Ryan> uncompressed the filesystem image and then gives me this:
>  Ryan> Mounted Root (ext2 filesystem) readonly Freeing unused kernel
>  Ryan> memory: 212K freed Warning: unable to open an initial console
>  Ryan> Kernel panic: no init found. Try passing init= option to the
>  Ryan> kernel.
> 
>  Ryan> I know that I have init on the image, so what could I be doing
>  Ryan> wrong.  It is probably something stupid that I am overlooking,
>  Ryan> but I thank you in advance.
> 
> This is commonly seen when your /etc/fstab is pointing to the wrong partion
> for root, or (I believe) on some older kernels where the location of the root
> partition is contained within the kernel or on the boot sector somewhere.
> (Forgive me for not being more explicit my memory fails me) Try man rdev
> for changeing these values. 
> 
> Of course as someone else has noted there could be other reasons, but if
> you are looking for something 'stupid' (believe me I've done this before 
> too) then this could be it.  
> 
> Try passing 'root=/dev/hda2' or whatever (without the '') to the kernel
> at the boot prompt:
> 
> lilo: linux root=/dev/hda1 single
> 
> Replace linux above with the alias of your kernel.
> 
> If you don't know what partiion root is on you can always cycle through
> the partitions consecutively.  (I've done this before when breaking into
> linux boxes that I didn't build but had the job of maintaining).
> 
> Once you have booted into single mode you can edit /etc/fstab to point to 
> the right place.  Or else if thats correct just boot up with linux root=blah
> and you'll be up and running!
> 
> Hope this helps.
> 
> derek
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
