Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312357AbSDCTYE>; Wed, 3 Apr 2002 14:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312358AbSDCTXz>; Wed, 3 Apr 2002 14:23:55 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:26651 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312357AbSDCTXi>; Wed, 3 Apr 2002 14:23:38 -0500
Date: Wed, 3 Apr 2002 21:23:15 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
        Ingo Molnar <mingo@redhat.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
Message-ID: <20020403212315.I10959@dualathlon.random>
In-Reply-To: <20020403201322.E10959@dualathlon.random> <E16sqAf-0004JH-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2002 at 08:11:49PM +0100, Alan Cox wrote:
> > The vmalloc_to_page function is been patched into the kernel without any
> > special restriction or requirement for such code, there is not a single
> 
> Untrue.

Please, go ahead and tell me _where_ the conditions for copying and
using such code are been written and why such code licence is different
from map_user_kiobuf. I check the memory.c file in 2.4.19pre5 and
nothing is written about those special restrictions.

> > comment about a change of licence (infact it's probably been cut and
> > pasted from one of the dozen of device drivers doing that by hand
> 
> All of them GPL none of them exporting it to non GPL users. That code is
> and always was GPL. Nor is it an interface for random binary authors. That
> vmalloc handling code took a lot of work, binary authors can go and write

such vmalloc_to_page function takes 5 minutes to rewrite, that's not
lots of work in my vocabulary but anyways "how hard the code is to
write" doesn't matter with the rest of the discussion.

> their own.
> 
> > have the agreement Linus can release a new kernel tarball with the new
> > licence for all the normal kernel code, i.e. pure GPL. But for the core
> 
> Every single line of code I ever submitted to Linus is -pure- GPL. It bears
> a GPL header. That includes my part of the vmalloc_to_page work. It has
> never been available to non GPL modules. You took code I and many others
> own and exposed it as a library for non GPL users. If they use it that way
> they are violating copyright law, and they *will* get cease and desist
> letters.
> 
> Anyone using any code of mine in the kernel with non GPL code does so on
> the basis of the legal doctrine of what is or is not a derivative work,
> and they do so on their own legal assessment. Taking code I am one of the
> authors of and making it convenient for people like veritas to use in non
> GPL code is quite different. Its theft plain and simple.

What is plain and simple is that since you didn't wrote a single line
about it, there cannot be any licence difference between your
vmalloc_to_page in 2.4.19pre5 and map_user_kiobuf.

Furthmore exposing the function to binary only devices, doesn't mean I
will even link a binary only device with it, and nevertheless I won't
because I don't use binary only drivers, but again this is not the main
topic.

Andrea
