Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290165AbSAKXjs>; Fri, 11 Jan 2002 18:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290170AbSAKXjk>; Fri, 11 Jan 2002 18:39:40 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:52266 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S290168AbSAKXj2> convert rfc822-to-8bit; Fri, 11 Jan 2002 18:39:28 -0500
Date: Sat, 12 Jan 2002 00:38:56 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Andreas Boman <aboman@goofy.nerdfest.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17 has 2 modules named sym53c8xx.o
In-Reply-To: <20020111153341.1ebf02a2.aboman@goofy.nerdfest.org>
Message-ID: <20020112001454.A2127-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 11 Jan 2002, Andreas Boman wrote:

> On Fri, 11 Jan 2002 21:01:27 +0100 (CET)
> Gérard Roudier <groudier@free.fr> wrote:
>
> >
> >
> > On Fri, 11 Jan 2002, Andreas Boman wrote:
> >
> > > It seems a new sym53c8xx was added in 2.4.17, and now there are 2
> modules,
> > > both named sym53c8xx.o (CONFIG_SCSI_SYM53C8XX and
> > > CONFIG_SCSI_SYM53C8XX_2). This was noticed since my mkinitrd script
> isn't
> > > smart enough to destinguish the two. Leading to the question how does
> > > modprobe? Comparing this with the naming scheme used for the two
> aic7xxx
> > > modules (aic7xxx.o and aic7xxx_old.o) it seems like its a bug to me,
> in
> > > either case I'd appritiate some input from somebody clued in on the
> issue.
> >
> > This is a compatibility feature. Just select _the_ driver you want to
> use
> > but not both. The bug is to build the both drivers without special needs
> > or goal.
> >
> > Renaming a driver object module will break compatibility of old linux
> > installations depending of the driver selected, and also may break
> > flexibility for who knows what he is doing.
>
> This is a fine argument, until you consider kernels that arent built
> specifically for one platform. I am trying to build a generic kernel that
> will work on any supported hardware its loaded on. The documentation for
> the new sym53c8xx_2.o driver states: "If your system has problems using
> this new major version of the SYM53C8XX driver, you may switch back to
> driver version 1."

What should I have written ?
What about : "you are required to persist using the new driver until all
your filesystems get definitely screwed". :-)

> That one sentence makes me think that the old driver should be renamed
> sym53c8xx_old so that both modules can be built and the _old driver loaded
> if the new causes any problems.
>
> Further, if you dont rename either of the modules, something should be
> done to prevent build of both modules, and/or the documentation (help)
> should include a blurb about the modules being named the same thing and
> the problems this is bound to cause. As it is there is no indication that
> theese modules will be named the same thing, unless you look in the
> Makefiles.

The old driver doesn't work that bad and the new one is already proven to
work at least as well as the old one. There is about no risk with using
either driver in my opinion. However, I can understand that using one when
beleiving that you are using the other one is not a pleasant situation.

> > By the way, if it ever happens one of the two modules to be renamed in
> > 2.4, it is the old version that will be. As a result, the patch you sent
> > me directly that renames the new version is exactly what I donnot want
> to
> > be done.
>
> Wich is as I suggested should be done. The reason I attached that patch
> was just to show that this is an issue that I have had to deal with. And
> as I stated, I renamed the new driver since it has the new config option,
> and resides in the  drivers/scsi/sym53c8xx_2 subdirectory (and was a much
> quicker workaround).

The renaming of sym-1 does not require my intervention. This can be done
by kernel maintainer in a minute. It just would be kind to ask me for
before this to be done, but it is not required at all. If Marcello is
reading this mail, then let me say him that I am ok with the renaming of
the old driver, even if I donnot catch the real need for this.

> > In kernel 2.5, SYM53C8XX_2 will replace SYM53C8XX. I already agreed with
> > the proposal to remove the old driver version, and I suggested so
> > implicitely, obviously, by providing SYM53C8XX_2. I hope this will also
> > happen in 2.4 series, but probably a bit later.
>
> Why rename it later (in the 2.4 series) instead of now? The problems
> caused by a renaming would occur at that time as well as it would now.

I wasn't talking about the renaming but about the removing.

  Gérard.

