Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275448AbRIZSZV>; Wed, 26 Sep 2001 14:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275449AbRIZSZM>; Wed, 26 Sep 2001 14:25:12 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46606 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S275448AbRIZSYz>; Wed, 26 Sep 2001 14:24:55 -0400
Date: Wed, 26 Sep 2001 11:24:44 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave Jones <davej@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
        <bcrl@redhat.com>, <marcelo@conectiva.com.br>, <andrea@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Locking comment on shrink_caches()
In-Reply-To: <Pine.LNX.4.30.0109261958290.8655-100000@Appserv.suse.de>
Message-ID: <Pine.LNX.4.33.0109261123380.8558-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Sep 2001, Dave Jones wrote:
> On Wed, 26 Sep 2001, Alan Cox wrote:
>
> > VIA Cyrix CIII (original generation 0.18u)
> >
> > nothing: 28 cycles
> > locked add: 29 cycles
> > cpuid: 72 cycles
>
> Interesting. From a newer C3..
>
> nothing: 30 cycles
> locked add: 31 cycles
> cpuid: 79 cycles
>
> Only slightly worse, but I'd not expected this.

That difference can easily be explained by the compiler and options.

You should use "gcc -O2" at least, in order to avoid having gcc do
unnecessary spills to memory in between the timings. And there may be some
versions of gcc that en dup spilling even then.

		Linus

