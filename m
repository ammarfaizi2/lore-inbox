Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281863AbRL1WOX>; Fri, 28 Dec 2001 17:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281921AbRL1WOM>; Fri, 28 Dec 2001 17:14:12 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41997 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281863AbRL1WOF>; Fri, 28 Dec 2001 17:14:05 -0500
Date: Fri, 28 Dec 2001 14:11:37 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: Legacy Fishtank <garzik@havoc.gtf.org>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>, <kbuild-devel@lists.sourceforge.net>
Subject: Re: State of the new config & build system
In-Reply-To: <20011228141211.B15338@thyrsus.com>
Message-ID: <Pine.LNX.4.33.0112281408170.23445-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Dec 2001, Eric S. Raymond wrote:
>
> I'm not certain what you're objecting to, and I want to understand it.
> There are rules that use architecture symbols to suppress things like
> bus types.  I presume that's not a problem for you, but tell me if it is.

It _is_ a problem for me, because I want to do "diffstat" on a patch from
a PPC maintainer, and if I see anything non-PPC, loud ringing
noises go off in my head. I want that diffstat to say _only_

	arch/ppc/...
	include/asm-ppc/...

and nothing else. That way I know that I don't have to worry.

In contrast, if it starts talking about Documentation/Configure.help and
the main config file, I start worrying.

For example, that MATHEMU thing is just ugly. It was perfectly fine in the
per-architecture version, now it suddenly has magic dependencies just
because different architectures call it different things, and different
architectures have different rules on when it's needed.

		Linus

