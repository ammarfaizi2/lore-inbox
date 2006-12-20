Return-Path: <linux-kernel-owner+w=401wt.eu-S932766AbWLTBCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932766AbWLTBCs (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 20:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932771AbWLTBCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 20:02:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54569 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932766AbWLTBCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 20:02:47 -0500
To: "D. Hazelton" <dhazelton@enter.net>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Linus Torvalds <torvalds@osdl.org>,
       Ricardo Galli <gallir@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: GPL only modules
References: <200612161927.13860.gallir@gmail.com>
	<86C272DA-23BA-4901-994D-6CABCC87A2DE@mac.com>
	<orlkl56lgi.fsf@redhat.com> <200612182242.33759.dhazelton@enter.net>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat OS Tools Group
Date: Tue, 19 Dec 2006 23:02:33 -0200
In-Reply-To: <200612182242.33759.dhazelton@enter.net> (D. Hazelton's message of "Mon\, 18 Dec 2006 22\:42\:33 -0500")
Message-ID: <orac1j2xcm.fsf@redhat.com>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 19, 2006, "D. Hazelton" <dhazelton@enter.net> wrote:

> However I have a feeling that the lawyers in the employ of the
> companies that ship BLOB drivers say that all they need to do to
> comply with the GPL is to ship the glue-code in source form.

> And I have to admit that this does seem to comply with the GPL - to the 
> letter, if not the spirit.

I don't see that it does comply even with the letter.  Consider this:

  These requirements apply to the modified work as a whole.  If
  identifiable sections of that work are not derived from the Program,
  and can be reasonably considered independent and separate works in
  themselves, then this License, and its terms, do not apply to those
  sections when you distribute them as separate works.  But when you
  distribute the same sections as part of a whole which is a work
  based on the Program, the distribution of the whole must be on the
  terms of this License, whose permissions for other licensees extend
  to the entire whole, and thus to each and every part regardless of
  who wrote it.

The work, in this case, is the GPLed glue code, in source form, and
the binary blob, without sources.  See that, even though the binary
blob is an independent and separate work in itself, and so it can
indeed be distributed separaly under a different license, when it's
distributed as part of a whole, then the whole must be on the terms of
the GPL.

So the question becomes whether the copyright holder of the glue code
bound by these GPL terms.

(a) If the glue code can be shown to be a derived work from Linux,
even in source form, then the copyright holder *is* bound by these
terms, and thus the whole could only be distributed under the GPL, so
including the binary blob would be in violation of the license.

(b) Now, if the glue code is *not* a derived work from Linux, then the
copyright holder is entitled to use whatever terms she likes.  It
could be any license whatsoever, that permits the distribution of the
whole or of the parts with whatever constraints copyright law
permitted.  Why would they choose the GPL in this case, then?


Let's assume they're not intentionally violating the GPL, but rather
that they believe they're entitled to do what they're doing, i.e.,
that they believe (a) their glue code is not a derived work from
Linux.

In this case, they *can* distribute the glue source code under the GPL
along with their binary blob.  But can anyone else?

Methinks anyone else would be entitled to pass the same whole along
under the GPL, per section 1, but wouldn't be entitled to distribute
modified versions, because this would require the derived work to be
licensed under the GPL, and nobody else is able to provide the source
code to the binary blob.

And then, who'd be entitled to complain?  Only the copyright holder of
the glue code and the binary blob.

Would you like to be on the wrong end of a copyright infringement
lawsuit by one of these binary blob distributors for distributing a
patched version of their glue code + binary blob?  More to the point,
do you think they would actually bring suit, just to make it clear
that the whole point is for them to keep a monopoly on the rights to
modify and then distribute the combined work, in spite of using the
GPL for (part of) the work?


It gets trickier for binaries, since they are quite possibly derived
works from the kernel, licensed under the GPL.  If they are, they
can't be distributed at all, not even by the copyright holder of the
glue code + binary blob.  If they aren't, then the copyright holder
can distribute them, but nobody else can because that would be a
violation of the GPL, as in the discussion above.  So, the copyright
holder would be keeping a monopoly on the rights to distribute
binaries, and anyone else could be sued by them.


Sure enough, one might think of praising them for distributing the
glue code under the GPL.  Then others could take this glue code and
use it for something else that is useful, right?

Well...  Not quite.  For one, even if enabling others to distribute
glue code + binary blobs were a good thing, using somebody else's glue
code means you're bound by the GPL requirements, so you can't ship the
combination of the glue code with your binary blob.

And then, if you intend to use the glue code to plug in some other
code that is GPL-compatible in the kernel, perhaps you'd be better off
not using the glue code at all, but rather modifying the
GPL-compatible code to fit.

So, even if condoning binary blobs were morally acceptable, we still
wouldn't be gaining anything from this relationship, we'd only be
enabling vendors to sell us their undocumented hardware while denying
us our freedoms.

Why should we do this?

-- 
Alexandre Oliva         http://www.lsd.ic.unicamp.br/~oliva/
FSF Latin America Board Member         http://www.fsfla.org/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
