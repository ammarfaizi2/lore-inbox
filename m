Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262115AbRETVAX>; Sun, 20 May 2001 17:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262179AbRETVAN>; Sun, 20 May 2001 17:00:13 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:36106 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262115AbRETU74>; Sun, 20 May 2001 16:59:56 -0400
Date: Sun, 20 May 2001 16:59:52 -0400
From: Arjan van de Ven <arjanv@redhat.com>
To: "Eric S. Raymond" <esr@thyrsus.com>, David Woodhouse <dwmw2@infradead.org>,
        Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Background to the argument about CML2 design philosophy
Message-ID: <20010520165952.A9622@devserv.devel.redhat.com>
In-Reply-To: <20010518113726.A29617@devserv.devel.redhat.com> <20010518114922.C14309@thyrsus.com> <8485.990357599@redhat.com> <20010520111856.C3431@thyrsus.com> <15823.990372866@redhat.com> <20010520114411.A3600@thyrsus.com> <16267.990374170@redhat.com> <20010520131457.A3769@thyrsus.com> <18686.990380851@redhat.com> <20010520164700.H4488@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010520164700.H4488@thyrsus.com>; from esr@thyrsus.com on Sun, May 20, 2001 at 04:47:00PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2001 at 04:47:00PM -0400, Eric S. Raymond wrote:
> In order to prevent that happening, I would like to have some recognized
> criterion for configuration cases that are so perverse that it is a 
> net loss to accept the additional complexity of handling them within the
> configurator.

"It doesn't compile/link" would be a good one. "It requires subsystem FOO to
operate" is another (think about IDE DMA drivers and the IDE subsystem, or
NIC drivers vs CONFIG_NET)
 
> A lot of people (including, apparently, you) are saying there are no such
> cases.  I wonder if you'll change your minds when you have to handle the
> overhead yourselves?

Somehow the current overhead isn't that high. You might argue that the
current Config.in is broken given my definition. That is fixable with a day
of work; I've been doing so on a regular basis with the tooling I wrote for
automatic testing of this.

Maybe it would be possible to separate "hard" dependencies like the current
system has with the "soft" ones one needs for entry-level configtools. Or
maybe it needs 2 files for that.. CML1 style (style, maybe not syntax) ones
and the newstyle info.


I liked the suggestion where the "automatic" derivations got turned into
manual ones for expert mode... 

I haven't tried CML2 yet (I've yet to find a suitable .deb of Python2 for my
Debian Potato playbox) so I don't know if that is actually possible, or that
it requires some redesign.

Greetings,
  Arjan van de Ven


