Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbQJaU6j>; Tue, 31 Oct 2000 15:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129097AbQJaU63>; Tue, 31 Oct 2000 15:58:29 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:62729 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129069AbQJaU6L>; Tue, 31 Oct 2000 15:58:11 -0500
Date: Tue, 31 Oct 2000 12:57:42 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.0-test10
In-Reply-To: <Pine.LNX.4.21.0010311845570.1190-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.10.10010311252470.22165-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Oct 2000, Rik van Riel wrote:
> On Tue, 31 Oct 2000, Linus Torvalds wrote:
> > 
> > Ok, test10-final is out there now. This has no _known_ bugs that
> > I consider show-stoppers, for what it's worth.
> > 
> > And when I don't know of a bug, it doesn't exist. Let us
> > rejoice. In traditional kernel naming tradition, this kernel
> > hereby gets anointed as one of the "greased weasel" kernel
> > series, one of the final steps in a stable release.
> 
> Well, there's the thing with RAW IO being done into a
> process' address space and the data arriving only after
> the page gets unmapped from the process.

Yes. But that doesn't count like a "show-stopper" for me, simply because
it's one of those small details that are known, and never materialize
under normal load.

Yes, it will have to be fixed before anybody starts doing RAW IO in a
major way. And I bet it will be fixed. But it's not on my list of "I
cannot release a 2.4.0 before this is done" - even if I think it will
actually be fixed for the common case before that anyway.

(Note: I suspect that we may just have to accept the fact that due to NFS
etc issues, RAW IO into a shared mapping might not really supported at
all. I don't think any raw IO user uses it that way anyway, so I think the
big and worrisome case is actually only the swap-out case).

> > We're still waiting for the Vatican to officially canonize this
> > kernel, but trust me, that's only a matter of time. It's a
> > little known fact, but the Pope likes penguins too.
> 
> Lets just hope he doesn't need RAW IO ;)

Naah, he mainly just does some browsing with netscape, and (don't tell a
soul) plays QuakeIII with the door locked.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
