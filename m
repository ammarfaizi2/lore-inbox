Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312317AbSDCSOH>; Wed, 3 Apr 2002 13:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312321AbSDCSN6>; Wed, 3 Apr 2002 13:13:58 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:15636 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312317AbSDCSNv>; Wed, 3 Apr 2002 13:13:51 -0500
Date: Wed, 3 Apr 2002 20:13:22 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
        Ingo Molnar <mingo@redhat.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
Message-ID: <20020403201322.E10959@dualathlon.random>
In-Reply-To: <20020403182118.A10959@dualathlon.random> <E16soms-0004Au-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2002 at 06:43:10PM +0100, Alan Cox wrote:
> >  EXPORT_SYMBOL(vfree);
> >  EXPORT_SYMBOL(__vmalloc);
> > -EXPORT_SYMBOL_GPL(vmalloc_to_page);
> > +EXPORT_SYMBOL(vmalloc_to_page);
> 
> The authors of that code made it GPL. You have no right to change that. Its
> exactly the same as someone taking all your code and making it binary only.
> 
> You are
> 	-	subverting a digital rights management system
> 			[5 years jail in the USA]
> 	-	breaking a license
> 
> but worse than that you are ignoring the basic moral rights of the authors
> of that code.

The vmalloc_to_page function is been patched into the kernel without any
special restriction or requirement for such code, there is not a single
comment about a change of licence (infact it's probably been cut and
pasted from one of the dozen of device drivers doing that by hand
previously, just changing the retval to a struct page, so changing the
licence would been probably illegal from your part in the first place).

Now from your comment it seems with your _GPL tag you meant to give
special licence to the function, that is not obvious at all, I don't
find it written anywhere, not even in your above email, so I recommend
you to licence your code properly ASAP if you don't want to use the
standard licence of the kernel code (like bsdcomp and other piece of
sourcecode deos).

Also please realize that you are ridicolous posting emails like the
above, any real lawyer will laught at you if you pretend me to go in
jail for 5 years in the US because you think such a "_GPL" four letters
in ksyms.c enforce in a court a different licence in a function in
memory.c covered by the usual kernel license (like map_user_kiobuf),
despite there is not a single line of english out there written by the
author to confirm your assumption.  Not even a kernel hacker can guess
you meant to change the licence of the code if you don't even write a
line about a change of licence anywhere, period.  Not even there is
written anywhere in the kernel that such _GPL tags are meant to change
the licence.

Infact it's the other way around, if the author of vmalloc_to_page
wanted really to change the licence as it seems while reading your above
email (not confirmed yet), as soon as he documents his request properly,
I will tell him that I refuse him to do that, I'm one of the authors of
memory.c so that is my right to enforce it, as it was my right for Linus
to refuse my code if I wanted to use a difference licence. The reason I
refuse a change of licence for a basic functionality in memory.c, is
that those are lawyers tricks that can only hurt linux. If everybody
that writes a function starts crying like you did above it will be a
true mess, and at the very least such kind of tricks should be put in a
separate file.

So if you want to change the module licensing and avoid binary only
drivers, go and ask all the copyright holders to agree on that, once you
have the agreement Linus can release a new kernel tarball with the new
licence for all the normal kernel code, i.e. pure GPL. But for the core
kernel code it must be possible to intermix it without worrying about
licensing issues, so no special licences within memory.c, I will enforce
that, period.

If there's any expert out there that can check the correctness of what I
said I'd be grateful, thanks.

Andrea
