Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284886AbSABWKe>; Wed, 2 Jan 2002 17:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287016AbSABWKT>; Wed, 2 Jan 2002 17:10:19 -0500
Received: from white.pocketinet.com ([12.17.167.5]:27108 "EHLO
	white.pocketinet.com") by vger.kernel.org with ESMTP
	id <S287044AbSABWJw>; Wed, 2 Jan 2002 17:09:52 -0500
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <nknight@pocketinet.com>
Reply-To: nknight@pocketinet.com
To: Keith Owens <kaos@ocs.com.au>, "Albert D. Cahalan" <acahalan@cs.uml.edu>
Subject: Re: system.map
Date: Wed, 2 Jan 2002 14:09:53 -0800
X-Mailer: KMail [version 1.3.1]
Cc: timothy.covell@ashavan.org, adriankok2000@yahoo.com.hk (adrian kok),
        linux-kernel@vger.kernel.org
In-Reply-To: <10236.1010007095@ocs3.intra.ocs.com.au>
In-Reply-To: <10236.1010007095@ocs3.intra.ocs.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <WHITEAiPyTxQplr0tEj00000aaa@white.pocketinet.com>
X-OriginalArrivalTime: 02 Jan 2002 22:08:19.0346 (UTC) FILETIME=[FC515720:01C193D9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 January 2002 01:31 pm, Keith Owens wrote:
> On Wed, 2 Jan 2002 16:17:30 -0500 (EST),
>
> "Albert D. Cahalan" <acahalan@cs.uml.edu> wrote:
> >That's not a nice place. Besides the fact that System.map is
> >neither library nor module, /lib/modules is less likely to
> >exist than /boot is. It's a wee bit slower too.
>
> /boot is a hangover from old i386 systems that could not boot past
> cylinder 1024 so you needed a special partition to hold the boot
> images.  That restriction does not exist on any system less than 5
> years old nor on most non-i386 machines, the requirement for a
> special /boot is obsolete on most machines.
>
> System.map is not required for booting, it is only used after init
> starts, therefore it does not belong in /boot anyway.
>
> IA64 requires boot files to be in /boot/efi which must be a VFAT
> style partition.  Trust me, you don't want anything in /boot/efi
> unless you have to.
>
> For all those reasons, putting System.map and .config in /boot is the
> wrong thing to do.  There is no point in creating yet another

For what reasons? I see no valid reason for it being the "Wrong" thing 
to do. I wouldn't even call it QUESTIONABLE. Nor is it simply a 
"holdover". There are still systems in use whos BIOS simply *does not 
support* booting past the 1024th cyl.
1. Putting stuff in /boot is generaly the "standard" thing to do, 
generaly won't cause confusion among experienced users, and will make 
sense to new users; /lib/modules/* will make no sense whatsoever.

2. /boot is shorter than /lib/modules/`uname -r`, and no I'm not 
kidding. I like short pathnames, it's for this reason I prefer to 
deposit stuff in /usr instead of /usr/local when it's on my personal 
desktop system. I'll sometimes spend hours copying kernels around or 
troubleshooting. The last thing I want to do is type 
/lib/mod<tab>/2.4<tab><damn forgot, more than one 2..4 
kernel>.18<tab><damn forgot more than one -pre <pre-1>/bz<tab> when I 
could instead type /bo<tab>/kern<tab>2.4.18....
This of course assumes I'm using a shell with filename completion! That 
in itself is not always possible on an extremely broken system.

3. Given that neither system is inherently bad, what makes you 
qualified to say it's "wrong" ?

> directory to hold these files when /lib/modules/`uname -r` will do
> the job.  Even on systems with no modules, /lib/modules can be
> created to hold the kernel specific files.  I put my bootable kernels
> in /lib/modules as well, then I have exactly one place to remove to
> get rid of an old kernel.
>
> If it makes you feel happier, think of /lib/modules as 'kernel
> specific data'.  Pity about the name but it is hard coded into too
> many programs to change it to /lib/kernel or /kernel.
>
> >It's a wee bit slower too.
>
> ????
