Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274260AbRISXXt>; Wed, 19 Sep 2001 19:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274263AbRISXXk>; Wed, 19 Sep 2001 19:23:40 -0400
Received: from Expansa.sns.it ([192.167.206.189]:10757 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S274260AbRISXX1>;
	Wed, 19 Sep 2001 19:23:27 -0400
Date: Thu, 20 Sep 2001 01:23:43 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Dan Hollis <goemon@anime.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Athlon bug stomper. Pls apply.
In-Reply-To: <3BA8EA04.E55BAA02@redhat.com>
Message-ID: <Pine.LNX.4.33.0109200122250.25500-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On the Athlon 1300 Mhz with the patch but a working bios i get.

please consider uts 200 Mhz FSB.


Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $
clear_page() tests
clear_page function 'warm up run'        took 21709 cycles per page
clear_page function '2.4 non MMX'        took 13974 cycles per page
clear_page function '2.4 MMX fallback'   took 13108 cycles per page
clear_page function '2.4 MMX version'    took 13940 cycles per page
clear_page function 'faster_clear_page'  took 5341 cycles per page
clear_page function 'even_faster_clear'  took 5924 cycles per page

copy_page() tests
copy_page function 'warm up run'         took 20559 cycles per page
copy_page function '2.4 non MMX'         took 27741 cycles per page
copy_page function '2.4 MMX fallback'    took 28340 cycles per page
copy_page function '2.4 MMX version'     took 20802 cycles per page
copy_page function 'faster_copy'         took 11894 cycles per page
copy_page function 'even_faster'         took 12288 cycles per page


On Wed, 19 Sep 2001, Arjan van de Ven wrote:

> Dan Hollis wrote:
> >
> > On Wed, 19 Sep 2001, Linus Torvalds wrote:
> > > It is _probably_ an undocumented performance thing, and clearing that
> > > bit may slow something down. But it might also change some behaviour,
> > > and knowing _what_ the behaviour is might be very useful for figuring
> > > out what it is that triggers the problem.
> >
> > AFAIK noone has even tested it yet to see what it does to performance! Eg
> > it might slow down memory access so that athlon-optimized memcopy is now
> > slower than non-athlon-optimized memcopy. And if it turns out to be the
> > case, we might as well just use the non-athlon-optimized memcopy instead
> > of twiddling undocumented northbridge bits...
>
> Ok but that part is simple:
>
> run
>
> http://www.fenrus.demon.nl/athlon.c
>
> .....
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

