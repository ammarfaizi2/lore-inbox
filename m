Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131655AbRA3SXZ>; Tue, 30 Jan 2001 13:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131842AbRA3SXG>; Tue, 30 Jan 2001 13:23:06 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:50417 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131680AbRA3SXE>; Tue, 30 Jan 2001 13:23:04 -0500
Date: Tue, 30 Jan 2001 16:22:20 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: alex@foogod.com
cc: Alan Olsen <alan@clueserver.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Recommended swap for 2.4.x.
In-Reply-To: <20010130101009.B13819@draco.foogod.com>
Message-ID: <Pine.LNX.4.21.0101301612360.1321-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2001 alex@foogod.com wrote:
> On Tue, Jan 30, 2001 at 09:48:33AM -0200, Rik van Riel wrote:
> > It has. We now leave dirty pages swapcached, which means that
> > for certain workloads Linux 2.4 eats up much more swap space
> > than Linux 2.2.
> 
> Ah.. thanks for the clarification.  Is this duplication "hard"
> or "soft"?  i.e. under low-memory conditions, do these
> duplicated pages actually reduce the hard limit of VM available,
> or just imply that using that last bit of memory will entail
> greater paging overhead (because it has to do more cleanup)?

At the moment there is no way to reclaim the swap space if
the page is shared, and for non-shared pages we haven't
implemented a way to reclaim swap space.

While reclaiming swap space when you run out is pretty
trivial to do, Linus doesn't seem to like the idea all
that much and Disk Space Is Cheap(tm) so it's not very
high on my list of things to do.

> Does this mean that having a swap partition less than or equal
> to RAM is now effectively pointless?

If you're swapping heavily, yes. If most of your programs
fit in memory and you're hardly using swap, nothing changes.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
