Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271910AbRHVAgv>; Tue, 21 Aug 2001 20:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271909AbRHVAgm>; Tue, 21 Aug 2001 20:36:42 -0400
Received: from beppo.feral.com ([192.67.166.79]:32269 "EHLO beppo.feral.com")
	by vger.kernel.org with ESMTP id <S271902AbRHVAgW>;
	Tue, 21 Aug 2001 20:36:22 -0400
Date: Tue, 21 Aug 2001 17:35:50 -0700 (PDT)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: <mjacob@feral.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ricky Beam <jfbeam@bluetopia.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Qlogic/FC firmware
In-Reply-To: <E15ZLor-0000cl-00@the-village.bc.nu>
Message-ID: <20010821172532.C23686-100000@wonky.feral.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Other than it's age, I see *zero* reason to remove it from the tree.
>
> Well let me quote from it again
>
> /*
>  *     W     W     A     RRRR    N   N   IIIII   N   N    GGG
>  *     W     W    A A    R   R   N   N     I     N   N   G   G
>  *     W     W   A   A   R  R    NN  N     I     NN  N   G
>  *     W  W  W   AAAAA   RRR     N N N     I     N N N   G  GG
>  *     W  W  W   A   A   R R     N  NN     I     N  NN   G   G
>  *     W W W W   A   A   R  R    N   N     I     N   N   G   G
>  *      W   W    A   A   R   R   N   N   IIIII   N   N    GGGG
>  *
>  *         This version of firmware is a release candidate,
>  *     design verification testing (DVT) has not been completed.
>  */
>
> or in simple terms "might lose all your data"

Take this with a grain of salt. It's true that it hasn't passed DVT. But it's
also true that f/w which *has* passed DVT has eaten your data as well.

Almost precisely by definition, if the system you embed this firmware in is
*not* one that has gone thru Qlogic DVT, you should in fact be putting the
warning on yourself.

>
> > >Well maybe, and whats the right way to do that, oh my god I do believe its
> > >an initrd.
> >
> > __init_data
>
> Doesnt work in modules. See previous twice repeated discussion.
>
> As Matthew has noted, we have a source of newer firmware, and because the
> sparc's have this annoying firmware problem it is going to be appropriate
> to add build in firmware as a config option (probably set with def_bool on
> sparc..)
>
> At the time a) I didnt realise the sparc setup was so anal, and b) I didnt
> know about the firmware update.
>

It's not just a question of having firmware updated into flash- which, btw,
companies like Veritas have shied away from getting custoemrs to do because
you *do* have a small but finite amount of risk updating flash. It's also code
that as yet has to be written for qlogicfc (e.g.) that would pull it *out* of
flash so it can be pushed into SRAM (which is what the BIOS code on other
platforms do).

-matt


