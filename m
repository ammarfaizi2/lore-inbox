Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264779AbRFXVsa>; Sun, 24 Jun 2001 17:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264784AbRFXVsT>; Sun, 24 Jun 2001 17:48:19 -0400
Received: from warden.digitalinsight.com ([208.29.163.2]:20434 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S264779AbRFXVsC>; Sun, 24 Jun 2001 17:48:02 -0400
From: David Lang <david.lang@digitalinsight.com>
To: John Nilsson <pzycrow@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Date: Sun, 24 Jun 2001 13:35:51 -0700 (PDT)
Subject: Re: Some experience of linux on a Laptop
In-Reply-To: <F175UFyfL1QMaCAP6Ki00001f92@hotmail.com>
Message-ID: <Pine.LNX.4.33.0106241325240.7535-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jun 2001, John Nilsson wrote:

> Date: Sun, 24 Jun 2001 22:51:56 +0200
> From: John Nilsson <pzycrow@hotmail.com>
> To: linux-kernel@vger.kernel.org
> Subject: Some experience of linux on a Laptop
>
> Well I thought that it was time for me to give some feedback to the linux
> community. So I will tell you guys a little of my experience with linux so
> far.
>
> I have a Toshiba Portege 3010CT laptop. That is:
> 266MHz Pentium-MMX
> 4GB HD with 512kb cache (which linux reduces to 0kb)
> 32 Mb EDO RAM
>
> After have tried
> Slackware
> Gentoo
> Linux From Scratch
> Debian
> Mandrake
> and soon ROCK linux
>

well, for the most part you have been trying distros that are not designed
for the desktop as much as for servers.

> I have come to the conclusion that linux is NOT suitable for the general
> desktop market, I have configured a number of linux routers/fierwalls and am
> really pleased with the scalability, but the harware compatibility is to
> damn low for a general user base. I know this isn't really a Linux issue
> rather a distribution issue, but in the end it's you guys that make the
> drivers. So a little plea is that you let the optimization phase cooldown a
> little and concern your self a little more with compatibility, and ease of
> installation, (tidy up the kernel build system).
>
> On my particular computer the chipset (toshiba specific) is not supported
> wich makes the harddrive unable to run in UDMA and/or use it's cache.
> Somehow this make X totaly unusable. With a little luck if it doesn't hang
> it takes several minutes to launch a simple program.
> This could be X specific, but I doub't it.
>
> So when you speak of being able to run on 386:es I still have problem
> starting X on 266MHz with 32Mb mem. This should not be =)
>
> And regarding my slow HD, could anyone implment an option to mount a
> filesystem while keeping statistics on fileusage so that one could optimize
> physical-file-placement?
>
>
> Features I would like in the kernel:
> 1: Make the whole insmod-rmmod tingie a kernel internal so they could be
> trigged before rootmount.

compile your kernel with all the stuff you need built in, that way you
won't need modules at all (except for pcmcia stuff)

> 2: Compile time optimization options in Make menuconfig

that's what the CPU selection is, currently that's the only optimization
available

> 3: Lilo/grub config in make menuconfig

lilo/grub/loadlinux/bootdisks/etc are all different ways to load the
kernel, the job is completely seperate from compiling the kernel and as
such integrating it would just make it harder to develop better ways to
load the kernel.

> 4: make bzImage && make modules && make modules install && cp
> arch/i386/boot/bzImage /boot/'uname -r' something inside make menuconfig
> 5: Better support for toshiba computers... well try =)
>
> 6: Wouldn't it be easier for svgalib/framebuffer/GGI/X11 and others if the
> graphiccard drivers where kernel modules?

only in the idea that the people writing graphics drivers for those other
systems would have to shift to writing kernel code. it would still be the
same people writing the code so no big advantage here

> 7: As I said mount with statistics database of files.
>
> 8: A way to change kernel without rebooting. I have no diskdrive or cddrive
> in my laptop so I often do drastic things when I install a new distribution.

this is suggested every few months, the normal answer is that there is a
lot of stuff that the new kernel needs to know from the old one to make
the handoff sucessful, with potentially drastic changes of the kernel
internal structures it's a very difficult thing to do.

rebooting isn't that big a problem for desktop/laptop use. with lilo it's
easy enough to have multiple kernels configured and boot from whichever
one you want.

David Lang


>
> I'm not on the list so please CC me any responses
>
> /John Nilsson
> _________________________________________________________________________
> Get Your Private, Free E-mail from MSN Hotmail at http://www.hotmail.com.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
