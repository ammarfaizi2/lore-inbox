Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131308AbRDFHUs>; Fri, 6 Apr 2001 03:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131309AbRDFHUj>; Fri, 6 Apr 2001 03:20:39 -0400
Received: from mail.axisinc.com ([193.13.178.2]:51730 "EHLO roma.axis.se")
	by vger.kernel.org with ESMTP id <S131308AbRDFHUa>;
	Fri, 6 Apr 2001 03:20:30 -0400
From: johan.adolfsson@axis.com
Message-ID: <018001c0be69$90dcb200$9db270d5@homeip.net>
Reply-To: <johan.adolfsson@axis.com>
To: <cate@debian.org>, <johan.adolfsson@axis.com>
Cc: "Erik Mouw" <J.A.K.Mouw@its.tudelft.nl>,
        "Rogier Wolff" <R.E.Wolff@bitwizard.nl>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.ggqkpgv.9g0c0b@ifi.uio.no> <fa.k6fq96v.nhaq06@ifi.uio.no> <3ACD68FF.637D8958@math.ethz.ch>
Subject: Re: Arch specific/multiple Configure.help files?
Date: Fri, 6 Apr 2001 09:16:57 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: Giacomo Catenazzi <cate@math.ethz.ch>
To: <johana@axis.com>
Cc: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>; Rogier Wolff
<R.E.Wolff@bitwizard.nl>; <linux-kernel@vger.kernel.org>
Sent: Friday, April 06, 2001 8:58 AM
Subject: Re: Arch specific/multiple Configure.help files?


> johan.adolfsson@axis.com wrote:
> >
> > I went ahead and implemented the change last night anyway and I
> > will submit the patches and see if it will be accepted or not.
> > The idea is that it first check in arch/$ARCH/Configure.help
> > and if the file or the help is not found there,
> > check Documentation/Configure.help.
> >
> > I believe there is an advantage from a maintenance point of view.
> > It least for our CRIS architecture, I don't think it's any benefit to
> > "bloat" the Documentation/Configure.help with a lot of
> > CONFIG_ETRAX entries for the various hardware inerfaces
> > when the help and config can be kept locally.
> >
>
> This was already discussed on kbuild list.
> It is better to have only 1 Configure.help. This help
> translation of the file and help busy developers.
> They should not rewrite texts in every Configure.help.

I can't see that 1 file makes it easier.
The same help text is only present in one file,
either arch/$ARCH/Configure.help or
Documentation/Configure.help

The help system first checks the file in arch/$ARCH and if
the help is not present there it checks the one in Documentation/

> If you should provide a special help on a specific ARCH you
> could modify the symbols: instead of
> : bool 'std IPC support' CONFIG_IPC
> you can do:
> : bool 'arch specific IPC help' CONFIG_IPC_STRANGE_ARCH
> : define_bool CONFIG_IPC CONFIG_IPC_STRANGE_ARCH

Don't know if you missunderstood me or if I missunderstand
you here.
The typical use for the arch specific help file would only cover
the arch specific CONFIG options (although it could "override"
the general help text in Documentation/Configure.help with
an arch specific one, but if you do that I guess you're doing
something wrong)

> ESR CML2 have the defualt path for Configure.help build in
> the rules files, but it can be overriden by command options
> to use an other Configure.help (the format do not change).

I want to be able to use two help files.

> It is also designed so that a distribution can include
> a translation of Configure.help. (But we don't expect
> to include translation in std linux kernel)
>
>
> > BTW: I added this to scripts/Configure and scripts/Menuconfig
> > but I know to little tcl/tk to get it to work for the xconfig case.
> > The variable $ARCH was not found and I don't know how to make
> > it get it from the environment variables.
> >
>
> $ARCH is set on the top of the main Makefile. You can copy
> the small shell script from here.

I found the $env(ARCH) syntax by searching the net a little so now
make xconfig works with 2 helpfiles as well.

> giacomo
>
> > /Johan

/Johan


