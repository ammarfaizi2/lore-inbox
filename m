Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313270AbSDDRRP>; Thu, 4 Apr 2002 12:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313272AbSDDRRF>; Thu, 4 Apr 2002 12:17:05 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:33351 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S313271AbSDDRRC>; Thu, 4 Apr 2002 12:17:02 -0500
Date: Thu, 4 Apr 2002 12:16:37 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Keith Owens <kaos@ocs.com.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
In-Reply-To: <20020404184405.C32431@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0204041151550.17895-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Apr 2002, Andrea Arcangeli wrote:

> adding export symbol here and there it's the same thing you did in the
> redhat kernel and in your tux patches here:

it was done by first *asking* all maintainers/authors involved, including
the network folks and Linus. Plus at the time it was done no _GPL way to
signal internal components existed, i'd otherwise have used it to document
that this is an internal export only, for the fully GPL-ed TUX subsystem.
But i'd have no problem with making TUX a fully statically linked thing
either. [it's just so convenient to demand-link TUX as a part of the
kernel.]

> There is no difference at all with what you did above and with my
> removal of the _GPL tag from the vmalloc_to_page [...]

(lets stop this vmalloc_to_page() thing, as i said i agree with providing
it as a published export. It's a small-enough function to be a non-issue.)

> Now if my understanding is wrong, I'd like to know of course, I'm not
> expert here, but the only logical thing I'm sure about is that if it's
> illegal for me to export my GPL wrapper then I've just the right to make
> all non GPL drivers illegal, that is the only logical sure thing that
> can be deducted. And yes, I'd be really happy if I'd that right.

while i'm not a lawyer either, i think the question here is intent, like
in most matters of law/contract. If your intent is to make something that
is a derivative look like something that is not a derivative, you are on
the bad side. Eg. the GPL also uses intent in a form - eg. 'source code'
is not some arbitrary language or format, 'source code' is the preferred
form intended for development. In this sense it's not a GPL-conform
publication of source code to provide hex-encoded objects within C files,
even though C code matches the technical definition of 'source code'.

the other problem is that i think we really want to cooperate with people
who'd like to interface with the kernel in kernel-space, without making
their code a derivative of the kernel, along a well-defined API, even if
those people do not want to GPL their code for whatever reasons. But like
Alex mentioned it, Linux never had a 'well defined module API'. There was
no guarantee, no nothing, it's not an API in the GPL sense i think.

	Ingo

