Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129130AbQKDIf4>; Sat, 4 Nov 2000 03:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129809AbQKDIfq>; Sat, 4 Nov 2000 03:35:46 -0500
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:43270 "EHLO
	munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
	id <S129130AbQKDIfj>; Sat, 4 Nov 2000 03:35:39 -0500
Date: Sat, 4 Nov 2000 03:40:02 -0500
From: Michael Meissner <meissner@spectacle-pond.org>
To: Russ Allbery <rra@stanford.edu>
Cc: Tim Riker <Tim@Rikers.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux? (was Re: Where did kgcc go in 2.4.0-test10?)
Message-ID: <20001104034002.A26612@munchkin.spectacle-pond.org>
In-Reply-To: <fa.g3i0smv.15loso7@ifi.uio.no> <fa.cjn9ksv.1a0m82t@ifi.uio.no> <ylbsvww97j.fsf@windlord.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <ylbsvww97j.fsf@windlord.stanford.edu>; from rra@stanford.edu on Fri, Nov 03, 2000 at 10:19:12PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2000 at 10:19:12PM -0800, Russ Allbery wrote:
> Tim Riker <Tim@Rikers.org> writes:
> 
> > Agreed. C99 does not replace all the needed gcc features. We should
> > start using the ones that make sense, and push for
> > standardization/documentation on the rest.
> 
> > I'm perfectly happy with this as a long term goal. I'll put what effort
> > I can into moving that direction without breaking the existing world as
> > we know it.
> 
> May I tentatively suggest that one point at which your resources could
> productively be applied is towards improving the C99 compliance in gcc?
> Clearly for the near to medium future the compiler that everyone will use
> to build the Linux kernel will be gcc, which means that in order to use
> any C99 syntax, it first has to be solid in gcc.  That means the best way
> of introducing such things into the Linux kernel is to *first* get the C99
> support solid, reliable, and efficient in gcc, then once a version of gcc
> is released with that support, help get Linux compiling with that version
> of gcc.
> 
> *Then*, when that version of gcc can be made a prerequisite for the
> kernel, you can start switching constructs over to the C99 syntax that gcc
> supports.

Hmmmmm.  Last month the compiler related thread on the kernel list was the
kernel couldn't move to newer versions of the compiler because the compiler had
changed things (where newer might mean either the latest snapshot de jour, or a
tested/appropriately patched version based off of the snapshots, or even 2.95).
Now people seem to be advocating moving the kernel to use features from C99
that haven't even been coded yet (which mean when coded using the latest
codegen as well).  Note, I seriously doubt Linus will want a flag day (ie,
after a given kernel release, you must use revision n of the compiler, but
before that release, you must use revision n-1 of the compiler), so you still
have to maintain support for the old GCC way of doing things, in addition to
the C99 way of doing things probably for a year or so.

-- 
Michael Meissner, Red Hat, Inc.
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
