Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264786AbRFXVyk>; Sun, 24 Jun 2001 17:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264790AbRFXVyb>; Sun, 24 Jun 2001 17:54:31 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:22280 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S264786AbRFXVyQ>; Sun, 24 Jun 2001 17:54:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "John Nilsson" <pzycrow@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Some experience of linux on a Laptop
Date: Sun, 24 Jun 2001 23:57:23 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <F175UFyfL1QMaCAP6Ki00001f92@hotmail.com>
In-Reply-To: <F175UFyfL1QMaCAP6Ki00001f92@hotmail.com>
MIME-Version: 1.0
Message-Id: <0106242357230C.00430@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 24 June 2001 22:51, John Nilsson wrote:
>  So a little plea is that you let the optimization phase cooldown a
> little and concern your self a little more with compatibility, and ease of
> installation, (tidy up the kernel build system).

/me has no intention of cooling down the optimization phase

Good thing there are lots of other developers, huh?

> On my particular computer the chipset (toshiba specific) is not supported
> wich makes the harddrive unable to run in UDMA and/or use it's cache.
> Somehow this make X totaly unusable. With a little luck if it doesn't hang
> it takes several minutes to launch a simple program.
> This could be X specific, but I doub't it.

This is an optimization issue.

> So when you speak of being able to run on 386:es I still have problem
> starting X on 266MHz with 32Mb mem. This should not be =)

That's true.  Usually, X by itself starts pretty fast.  Just try 'xinit', no 
parameters.  KDE and Gnome both need to go on a diet, especially KDE.  They 
both need to open files less often on startup, in particular they should 
avoid opening the same file zillions of times.  Though we have kernel 
optimizations for that it's still sloppy and a bad idea.

> And regarding my slow HD, could anyone implment an option to mount a
> filesystem while keeping statistics on fileusage so that one could optimize
> physical-file-placement?

Optimization again.  Wait for it, fundamental changes are taking place in the 
Linux filesystem world.

> Features I would like in the kernel:
> 1: Make the whole insmod-rmmod tingie a kernel internal so they could be
> trigged before rootmount.
>
> 2: Compile time optimization options in Make menuconfig
> 3: Lilo/grub config in make menuconfig
> 4: make bzImage && make modules && make modules install && cp
> arch/i386/boot/bzImage /boot/'uname -r' something inside make menuconfig
>
> 5: Better support for toshiba computers... well try =)
>
> 6: Wouldn't it be easier for svgalib/framebuffer/GGI/X11 and others if the
> graphiccard drivers where kernel modules?
>
> 7: As I said mount with statistics database of files.
>
> 8: A way to change kernel without rebooting. I have no diskdrive or cddrive
> in my laptop so I often do drastic things when I install a new
> distribution.

It's been worked on.  Google: two kernel monte

Hmm, for someone who thinks we should cool down on optimization, you sure 
have a lot of optimizations on your wish list.

--
Daniel
