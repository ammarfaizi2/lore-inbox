Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316916AbSFQSX5>; Mon, 17 Jun 2002 14:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316919AbSFQSX4>; Mon, 17 Jun 2002 14:23:56 -0400
Received: from faraday.ee.utt.ro ([193.226.10.1]:23564 "EHLO faraday.ee.utt.ro")
	by vger.kernel.org with ESMTP id <S316916AbSFQSXz>;
	Mon, 17 Jun 2002 14:23:55 -0400
Date: Mon, 17 Jun 2002 21:23:45 +0300 (EEST)
From: Sebastian Szonyi <sony@faraday.ee.utt.ro>
To: kk maddowx <kk_maddox2000@yahoo.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18 kernel panics before and after boot
In-Reply-To: <20020617165244.44049.qmail@web21001.mail.yahoo.com>
Message-ID: <Pine.LNX.4.33.0206172106160.5396-100000@faraday.ee.utt.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Jun 2002, kk maddowx wrote:

> Date: Mon, 17 Jun 2002 09:52:44 -0700 (PDT)
> From: kk maddowx <kk_maddox2000@yahoo.com>
> To: Kristian Peters <kristian.peters@korseby.net>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: 2.4.18 kernel panics before and after boot
>
> Unfortunately I could not get memtest to work. I added
> the lines:
>
> label=memtest
> image=/boot/memtest
>
> to lilo.conf and ran lilo.

try swapping the lines

> I can see the selection for memtest but it wont accept
> it as a bootable image. I did swap the memory out and
> still recieve kernel panics with known working memory.
>
> However if I boot from my old 2.2.20 kernel I will
> never see a panic or experience a panic after boot
> making me think the memory is ok. Here is the dmesg
> from a successful 2.4 boot if that helps:
>
>
>
> LILO
> Loading 2.4..................
> Linux version 2.4.18a (root@birdbrain) (gcc version
> 2.96 20000731 (Red Hat Linux
>  7.0)) #1 Thu Jun 13 01:54:35 EDT 2002

Linux 2.4.18a ?
Never heard about it :-)

gcc 2.96 ?
use 2.95.3 or 2.95.4

See $(kernel_root)/Documentation/Changes to find out what you need
for compiling this kernel (where $(kernel_root) is where
your kernel tree is located for example /usr/src/linux )



>
> I have noticed that if the kernel does decide to panic
> on boot it will happen after the "Freeing unused
> memory" message is printed. Do you have any ideas what
> might be casuing this? TIA
>
>

An unsupported filesystem in your  kernel (i.e. your
filesystem is xfs for example and you don't have xfs
support in kernel)

Could be many things.

> --- Kristian Peters <kristian.peters@korseby.net>
> wrote:
> > Hello.
> >
> > I suspect bad ram. Could you verify with memtest86
> > that your ram is ok ?
> >
> > *Kristian
> >
> > kk maddowx <kk_maddox2000@yahoo.com> wrote:
> > > >>EIP; 00000400 Before first symbol   <=====
> > > Trace; c0127b63 <shrink_cache+2b3/2f0>
> > > Trace; c0127cd6 <shrink_caches+56/90>
> > > Trace; c0127d40 <try_to_free_pages+30/50>
> > > Trace; c0127dd4 <kswapd_balance_pgdat+44/90>
> > > Trace; c0127e36 <kswapd_balance+16/30>
> > > Trace; c0127f51 <kswapd+a1/c0>
> > > Trace; c0127eb0 <kswapd+0/c0>
> > > Trace; c010552b <kernel_thread+2b/40>
> >
> >   :... [snd.science] ...:
> >  ::                             _o)
> >  :: http://www.korseby.net      /\\
> >  :: http://gsmp.sf.net         _\_V
> >   :.........................:
>
>
> __________________________________________________
> Do You Yahoo!?
> Yahoo! - Official partner of 2002 FIFA World Cup
> http://fifaworldcup.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

