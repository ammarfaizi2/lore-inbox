Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135846AbRA1AOb>; Sat, 27 Jan 2001 19:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135844AbRA1AOX>; Sat, 27 Jan 2001 19:14:23 -0500
Received: from mail001.syd.optusnet.com.au ([203.2.75.244]:24518 "EHLO
	mail001.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S135890AbRA1AOO>; Sat, 27 Jan 2001 19:14:14 -0500
Date: Sun, 28 Jan 2001 10:14:04 +1000
Message-Id: <200101280014.f0S0E4702435@borogoves.yi.org>
From: Derek Benson <derek@borogoves.yi.org>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel boot problems
Reply-to: derek@borogoves.yi.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Ryan> Hello all,

Hi

 Ryan> I was wondering if someone might be able to help me.  I have
 Ryan> just compiled my kernel and set it up on a floppy to boot off a
 Ryan> disk.  I have it then use an image file to uncompress and get
 Ryan> the filesystem off ,etc.  Well when it boots it says it has
 Ryan> uncompressed the filesystem image and then gives me this:
 Ryan> Mounted Root (ext2 filesystem) readonly Freeing unused kernel
 Ryan> memory: 212K freed Warning: unable to open an initial console
 Ryan> Kernel panic: no init found. Try passing init= option to the
 Ryan> kernel.

 Ryan> I know that I have init on the image, so what could I be doing
 Ryan> wrong.  It is probably something stupid that I am overlooking,
 Ryan> but I thank you in advance.

This is commonly seen when your /etc/fstab is pointing to the wrong partion
for root, or (I believe) on some older kernels where the location of the root
partition is contained within the kernel or on the boot sector somewhere.
(Forgive me for not being more explicit my memory fails me) Try man rdev
for changeing these values. 

Of course as someone else has noted there could be other reasons, but if
you are looking for something 'stupid' (believe me I've done this before 
too) then this could be it.  

Try passing 'root=/dev/hda2' or whatever (without the '') to the kernel
at the boot prompt:

lilo: linux root=/dev/hda1 single

Replace linux above with the alias of your kernel.

If you don't know what partiion root is on you can always cycle through
the partitions consecutively.  (I've done this before when breaking into
linux boxes that I didn't build but had the job of maintaining).

Once you have booted into single mode you can edit /etc/fstab to point to 
the right place.  Or else if thats correct just boot up with linux root=blah
and you'll be up and running!

Hope this helps.

derek
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
