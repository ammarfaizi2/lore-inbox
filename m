Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263142AbRFGVCk>; Thu, 7 Jun 2001 17:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263141AbRFGVCa>; Thu, 7 Jun 2001 17:02:30 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:17934 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263142AbRFGVCZ>; Thu, 7 Jun 2001 17:02:25 -0400
Date: Thu, 7 Jun 2001 14:01:53 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Keitaro Yosimura <ramsy@linux.or.jp>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help i18n system
In-Reply-To: <20010607165007.A299.RAMSY@linux.or.jp>
Message-ID: <Pine.LNX.4.21.0106071351300.6604-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Kernel mailing list added to Cc ]

On Thu, 7 Jun 2001, Keitaro Yosimura wrote:
> 
> Configure.help i18n system is the thing which uses MD5 SUM of the text
> of the text as a key, and calls suitable data to the present language
> setup (it judges from an environment variable).

Quite frankly, I dislike the current Configure.help setup for a lot of
reasons, none of which are i18n-related.

One is a "simple" technical detail (the fact that it is all in one big
file instead of distributed over the places that actually _implement_ the
different config options), but the other is just that from what I've seen,
the overlap between people developing the code, and the people trying to
explain the config options is actually rather small.

So I wonder if the Configure.help text should not possibly be even _more_
distributed than just splitting it up into different files. It might very
well be acceptable to actually distribute it over the net (and have just a
mapping of config options into www-addresses or something).

I suspect that this is actually something that intersects with the i18n
work: how does the i18n projects distribute the actual help texts? Done
right, maybe the same distributed environment could be used for
everything, and getting Configure.help entirely out of the "core kernel"
tree, and into a separate distribution (where the English version would be
just one among many distributions).

I like to keep things that belong together in one distribution (especially
so that when people make changes to infrastructure they can more easily
change all the users - there's been tons of synchronization problems with
"external packages"), but on the other hand some things would probably be
better maintained outside the core package.

Configure.help certainly isn't all that kernel version dependent, and
could successfully be maintained completely outside the kernel, I suspect.

And I know that I'm bad at maintaining documentation like this, simply
because I never use it, and I don't care enough. Trying to care about the
i18n version when I don't even understand what it says would be completely
impossible for me.

Comments?

		Linus

