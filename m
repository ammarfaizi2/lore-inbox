Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129516AbRBLMoX>; Mon, 12 Feb 2001 07:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129213AbRBLMoO>; Mon, 12 Feb 2001 07:44:14 -0500
Received: from host217-32-141-29.hg.mdip.bt.net ([217.32.141.29]:5124 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129516AbRBLMoB>;
	Mon, 12 Feb 2001 07:44:01 -0500
Date: Mon, 12 Feb 2001 12:46:46 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Brian Grossman <brian@SoftHome.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: sysinfo.sharedram not accounted for on i386 ? 
In-Reply-To: <20010212125314.16109.qmail@lindy.softhome.net>
Message-ID: <Pine.LNX.4.21.0102121239560.745-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2001, Brian Grossman wrote:
> > Yes.
> 
> Thanks.  Is there a preferred way of getting the equivalent info
> as free(1) did under 2.2?

btw, this is not only x86 behaviour but is also true on all other
architectures. I.e. Linux defines "shared memory" as a "integer constant
with value 0". So, to say "zero" is just a shorter form of saying "Linux
concept of shared memory". However, remember that if you are interested in
shared _pages_, that information is available and is not identically 0.
See the show_mem() function in arch/i386/mm/init.c.

> 
> I've written a script to derive it from /proc/[0-9]*/statm, but that seems
> like an awkward approach.  A related question: is the page size stored in
> /proc somewhere?

No, PAGE_SIZE is known at compile time and cannot ever change (especially
it cannot change ig you stay within i386 architecture). It is available to
programs by including <asm/page.h> header.

Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
