Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261961AbSIYMAU>; Wed, 25 Sep 2002 08:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261962AbSIYMAU>; Wed, 25 Sep 2002 08:00:20 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:23015 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S261961AbSIYMAU>;
	Wed, 25 Sep 2002 08:00:20 -0400
Date: Wed, 25 Sep 2002 14:04:48 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Oleg Drokin <green@namesys.com>, "David S. Miller" <davem@redhat.com>,
       zaitcev@redhat.com, mingo@redhat.com,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: cmpxchg in 2.5.38
In-Reply-To: <Pine.LNX.4.44.0209251024580.4690-100000@localhost.localdomain>
Message-ID: <Pine.GSO.4.21.0209251403440.6130-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2002, Ingo Molnar wrote:
> On Wed, 25 Sep 2002, Oleg Drokin wrote:
> > Ingo's argument was that since there is only one place in code that
> > accesses that variable (map->page), it is safe to rely on such a
> > crippled cmpxchg implementation.
> 
> yes. It's only this place in the code that ever modifies that word, and
> that happens only once during the lifetime of this address, so i'll rather
> add a spinlock to the generic PID allocator code, it's a very very rare
> slowpath.

Furthermore archs that have cmpxchg() define __HAVE_ARCH_CMPXCHG, while
currently no code tests for it...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

