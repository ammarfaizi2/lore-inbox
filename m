Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130498AbQJaUsi>; Tue, 31 Oct 2000 15:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130499AbQJaUs2>; Tue, 31 Oct 2000 15:48:28 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:49403 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130498AbQJaUsU>; Tue, 31 Oct 2000 15:48:20 -0500
Date: Tue, 31 Oct 2000 18:48:06 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.0-test10
In-Reply-To: <Pine.LNX.4.10.10010311237430.22165-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0010311845570.1190-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2000, Linus Torvalds wrote:

> Ok, test10-final is out there now. This has no _known_ bugs that
> I consider show-stoppers, for what it's worth.
> 
> And when I don't know of a bug, it doesn't exist. Let us
> rejoice. In traditional kernel naming tradition, this kernel
> hereby gets anointed as one of the "greased weasel" kernel
> series, one of the final steps in a stable release.

Well, there's the thing with RAW IO being done into a
process' address space and the data arriving only after
the page gets unmapped from the process.

Then you have the RAW IO data in a swapcache page, but
the VM doesn't know how to swap it out and the page
becomes either unswappable or the data gets lost
(depending on at which stage the page is at that
moment).

But granted, this probably isn't a show-stopper for
most people and -since the fix has to support NFS
too, with its credentials stuff- a fix isn't even
underway yet...

> We're still waiting for the Vatican to officially canonize this
> kernel, but trust me, that's only a matter of time. It's a
> little known fact, but the Pope likes penguins too.

Lets just hope he doesn't need RAW IO ;)

cheers,

Rik
--
"What you're running that piece of shit Gnome?!?!"
       -- Miguel de Icaza, UKUUG 2000

http://www.conectiva.com/		http://www.surriel.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
