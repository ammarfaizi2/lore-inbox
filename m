Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289036AbSANUwy>; Mon, 14 Jan 2002 15:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289025AbSANUwo>; Mon, 14 Jan 2002 15:52:44 -0500
Received: from [208.29.163.248] ([208.29.163.248]:40910 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S289036AbSANUw3>; Mon, 14 Jan 2002 15:52:29 -0500
From: David Lang <david.lang@digitalinsight.com>
To: "Eric S. Raymond" <esr@thyrsus.com>
Cc: Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Mr. James W. Laferriere" <babydr@baby-dragons.com>,
        Giacomo Catenazzi <cate@debian.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Date: Mon, 14 Jan 2002 12:51:23 -0800 (PST)
Subject: Re: Hardwired drivers are going away?
In-Reply-To: <20020114151748.B19776@thyrsus.com>
Message-ID: <Pine.LNX.4.40.0201141249410.22904-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

some systems don't want modules to be loaded after boot (yes it's security
that can be bypassed, but as long as it's not your only security it's
still worth doing)

also with hardwired drivers going away does this mean that other things
that are currently compiled in will become modules, like say the IP stack?

David Lang

 On Mon, 14 Jan 2002, Eric S. Raymond wrote:

> Date: Mon, 14 Jan 2002 15:17:48 -0500
> From: Eric S. Raymond <esr@thyrsus.com>
> To: Alexander Viro <viro@math.psu.edu>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
>      Mr. James W. Laferriere <babydr@baby-dragons.com>,
>      Giacomo Catenazzi <cate@debian.org>,
>      Linux Kernel List <linux-kernel@vger.kernel.org>
> Subject: Re: Hardwired drivers are going away?
>
> Alexander Viro <viro@math.psu.edu>:
> > But it still leaves you with tristate - instead of yes/module/no it's
> > yes/yes, but don't put it on initramfs/no.  However, dependencies become
> > simpler - all you need is "I want this, that and that on initramfs" and
> > the rest can be found by depmod (i.e. configurator doesn't have to deal
> > with "FOO goes on initramfs (== old Y), so BAR and BAZ must go there
> > (== can't be M)").
>
> Actually I think we may no longer be in tristate-land.  Instead, some
> devices have the property "This belongs in initramfs if it's configured
> at all" -- specifically, drivers for potential boot devices.  Everything
> else can dynamic-load after boot time.
>
> In CML2 you can assign a symbol properties, which are written into
> trailing comments in the config file on the same line as the symbol
> value assignment.  One such property, "PRIVATE", is already
> interpreted by the postprocessor that generates autoconf.h from the
> configuration output; it prevents the symbol from being written to
> autoconf.h.
>
> The critical-for-boot property could be interpreted by the same
> postprocessor script and turned into a manifest for initramfs.  There
> would be no need for the inference engine or configurator to know
> about this property at all, just as it doesn't need to know anything
> about PRIVATE.
> --
> 		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
>
> "To disarm the people... was the best and most effectual way to enslave them."
>         -- George Mason, speech of June 14, 1788
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
