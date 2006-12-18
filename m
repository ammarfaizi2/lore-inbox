Return-Path: <linux-kernel-owner+w=401wt.eu-S1754774AbWLRX3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754774AbWLRX3A (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 18:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754772AbWLRX3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 18:29:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38197 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754763AbWLRX27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 18:28:59 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ricardo Galli <gallir@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: GPL only modules
References: <200612161927.13860.gallir@gmail.com>
	<Pine.LNX.4.64.0612161253390.3479@woody.osdl.org>
	<orwt4qaara.fsf@redhat.com>
	<Pine.LNX.4.64.0612170927110.3479@woody.osdl.org>
	<orpsah6m3s.fsf@redhat.com>
	<Pine.LNX.4.64.0612181134260.3479@woody.osdl.org>
	<or64c96ius.fsf@redhat.com>
	<Pine.LNX.4.64.0612181242530.3479@woody.osdl.org>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat OS Tools Group
Date: Mon, 18 Dec 2006 21:28:46 -0200
In-Reply-To: <Pine.LNX.4.64.0612181242530.3479@woody.osdl.org> (Linus Torvalds's message of "Mon\, 18 Dec 2006 12\:50\:09 -0800 \(PST\)")
Message-ID: <orlkl46axd.fsf@redhat.com>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 18, 2006, Linus Torvalds <torvalds@osdl.org> wrote:

> On Mon, 18 Dec 2006, Alexandre Oliva wrote:

>> > In other words, in the GPL, "Program" does NOT mean "binary". Never has.

>> Agreed.  So what?  How does this relate with the point above?

> Here's how it relates:
>  - if a program is not a "derived work" of the C library, then it's not 
>    "the program" as defined by the GPLv2 AT ALL.

In the case I'm talking about, libgpl (make it a GPLed libc) is the
program, and a binary produced by linking anything else with the
program (libgpl) is what you claim to be an aggregate (a term not
defined in the GPL; is it defined in US law?).

For both static and dynamic linking, you might claim the output is an
aggregate, but that doesn't matter.  What matters is whether or not
the output is a work based on the program, and whether the "mere
aggregation" paragraph kicks in.

If the output is not an aggregate, which is quite likely to be
the case for dynamic linking, and quite possibly also for many static
linking cases, then the "mere aggregation" paragraph of clause 2 does
not kick in.

If the output is indeed an aggregate, as it may quite likely be in the
case of static linking, then the "mere aggregation" considerations of
clause 2 may kick in and enable the 'anything else' to not be brought
under the scope of the license.  You still need permission to
distribute the whole.  The GPL asserts its non-interference with your
ability to distribute the separate portion separately, under whatever
license you can, as long as it's not a derived work from the GPL
portion.

But what about the whole?  If you can't separate the whole into, well,
the separate components, is it still a mere aggregate?  mkisofs will
create an image in which the components are all there, easily
extractable individually in their original form.  This is *clearly*
mere aggregation, even if some components turn out to be works based
on other GPL programs.

But even in the case of static linking, this is not how it works.
Say, if the portions of the static libgpl to be copied to the output
are selected based on the contents of the 'anything else', could you
legitimately claim that the output is not a derived work of both
libgpl and this 'anything else', but rather a mere aggregation of
unrelated works?

In either case, if you distribute the linker output, and it happens to
be found to be a derived work of the program (libgpl), aggregate or
not, then you must license the whole of the linker output under the
GPL, and this means to me that you have to be able to provide the
source code of every portion thereof under the GPL, except for
portions explicitly excluded by the GPL itself.

So whether it's an aggregate or not is completely irrelevant.  What
matters is whether it's a derived work of a GPLed program (and if
there is copying, it probably is) and whether the mere aggregation
clause kicks in to grant an exception.

> THAT is the difference between static and dynamic. A simple command line 
> flag to the linker shouldn't really reasonably be considered to change 
> "derivation" status.

If in one case there is extraction, copying and transformation of the
GPLed intput, and in the other there is something much simpler (does
it still qualify as extraction, copying and transformation?), then
derivation becomes more or less obvious to prove, but you're right in
that the status of the output probably won't change.  The status of
the inputs certainly doesn't.

> Either something is derived, or it's not. If it's derived, "ld", 
> "mkisofs", "putting them close together" or "shipping them on totally 
> separate CD's" doesn't matter. It's still derived.

But the important questions at hand, I think, are what makes it
derived, and whether it qualifies for any of the exceptions in the
GPL.

-- 
Alexandre Oliva         http://www.lsd.ic.unicamp.br/~oliva/
FSF Latin America Board Member         http://www.fsfla.org/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
