Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263862AbRFWXnK>; Sat, 23 Jun 2001 19:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263999AbRFWXnA>; Sat, 23 Jun 2001 19:43:00 -0400
Received: from Expansa.sns.it ([192.167.206.189]:46860 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S263862AbRFWXmy>;
	Sat, 23 Jun 2001 19:42:54 -0400
Date: Sun, 24 Jun 2001 01:42:48 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: "D. Stimits" <stimits@idcomm.com>
cc: kernel-list <linux-kernel@vger.kernel.org>
Subject: Re: Is this part of newer filesystem hierarchy?
In-Reply-To: <3B34EB52.D2E0A0DA@idcomm.com>
Message-ID: <Pine.LNX.4.33.0106240130010.29573-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 23 Jun 2001, D. Stimits wrote:
> > > The RH 7.1 comes with:
> > > :~# ld --version
> > > GNU ld 2.10.91
> > > Copyright 2001 Free Software Foundation, Inc.
> > > This program is free software; you may redistribute it under the terms
> > > of
> > > the GNU General Public License.  This program has absolutely no
> > > warranty.
> > >   Supported emulations:
> > >    elf_i386
> > >    i386linux
> > >    elf_i386_glibc21
> > Ok, this is the linker for compilation time, it
> > is not related to the loader for shared libraries. You can even remove
> > /usr/bin/ld, and the system will run anyway binaries, but you will not be
> > able to link compiled objects.
> > try a find for the directory ldscripts or for those files,
>
> It appears that Redhat has eliminated much of this. If I run updatedb,
> then locate, I find there is no instance of "ldscripts". Nor is there an
> instance of "i386linux" or "i386coff" that can be seen by locate. So I
> made it a wider locate, and tried for any instance of just "86linux" or
> "86coff", these also do not exist. Apparently Redhat has completely
> changed linking (looking at a backup of an older RH 6.2, these do exist,
> so I suspect the change at around 7.0).
glad to know this, i do wonder how does /usr/bin/ld work for red hat.
to my old mentality this seems red hat is going out of any resonable
standard.
>
> > >
> > > There is *no* /usr/i386-xxx except for:
> > > /usr/i386-glibc21-linux/
> > name could be different, just could you e-mail the output for
> > the command tree inside of /usr?
>
> The entire tree would be quite large. Are you looking only for
> directories (this would be a much smaller listing)? It might even
> challenge the maximum size an ISP allows before filtering it:
> 16632 directories, 258120 files
It is my own curiosity. yes if you could send me the direcotory tree of
your /usr. Just to see. Actually i know none using red hat 7.X to whom i
could ask to check, they are all slackware addicted.
>
>
> No ldscripts on the system. Through locate and awk, I can guarantee
> there is also only one ld on the system, /usr/bin/ld. It sounds like
> they did compile all other binaries from scratch, passing /lib/i686/
> explicitly.
mmm!
Again I am confused. how can the linker work?
>
>
> As far as this particular problem goes, I am trying to help the author
> of some general boot disk utilities find a good way to automatically
> detect (through perl scripts) the correct libc configuration. Telling
> users of the software that Redhat 7.1 is not supported is not an option,
> regardless of why it is a problem. What it will probably end up becoming
> is a mechanical script to test for the existence of /lib/{uname -a}/,
> and if it exists, adding it to the boot disk ld.so.conf
I would not be so scared, if you set a LD_PRELOAD_LIBRARY to
/lib/libc.so.6, you willse any binary will run anyway, because it would be
too mutch
if the same libc stripped would not run library, and they HAVE to mantein
a libc.so.6 linside of /lib, otherway this would be too mutch against
a resonable standard.
I would be happy if some guy from red hat could explain what is going on.

Luigi Genoni


