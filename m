Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130689AbQKQF37>; Fri, 17 Nov 2000 00:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131485AbQKQF3t>; Fri, 17 Nov 2000 00:29:49 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:19204 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130689AbQKQF3i>; Fri, 17 Nov 2000 00:29:38 -0500
Date: Thu, 16 Nov 2000 22:59:29 -0600
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: "SubmittingPatches" text
Message-ID: <20001116225929.A2918@wire.cadcamlab.org>
In-Reply-To: <200011162132.PAA01944@mandrakesoft.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200011162132.PAA01944@mandrakesoft.mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Nov 16, 2000 at 03:32:40PM -0600
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Jeff Garzik]
> 	MYSRC=/devel/linux-2.4
> 
> 	tar xvfz linux-2.4.0-test11.tar.gz
> 	mv linux linux-vanilla
> 	diff -urN linux-vanilla $MYSRC > /tmp/patch

You should use an example where $MYSRC is a single directory level
(rather than absolute path) so people can use 'patch -NEp1' rather than
having to count levels.

> 4) Select e-mail destination.
> 
> The arbiter of all Linux kernel changes is Linus Torvalds.  His e-mail
> address is torvalds@transmeta.com.

You should talk about peer review.  For nontrivial changes you should
basically never send them straight to Linus (unless you yourself are a
maintainer) -- first offer them up on mailing lists and get feedback.
Tell people to look in MAINTAINERS for the appropriate list, with
possible CC to linux-kernel.

> Before sending your change to Linus, look through the MAINTAINERS
> file and the source code, and determine if your change applies to
> a specific subsystem of the kernel, with an assigned maintainer.
> If so, e-mail that person instead.

Note that for simple typo corrections and such, Linus should probably
get a CC even if you are mailing another maintainer.  I.e. one less
level of indirection for the trivial stuff.

> When e-mailing your change, typically the change is copied
> to the primary Linux kernel developer's mailing list,
> linux-kernel@vger.kernel.org.  Other mailing lists are available
> for specific subsystems, such as USB, framebuffer devices, the VFS,
> the SCSI subsystem, etc.

Again, either here or above, you should mention that one can usually
find a relevent list in MAINTAINERS.

> 9) Don't get discouraged.  Re-submit.
> 
> After you have submitted your change, be patient and wait.  If Linus
> likes your change and applies it, it will appear in the next version
> of the kernel that he releases.

10) Make sure your patch is up to date, and keep it that way.  Until it
is accepted into the main tree, you need to make sure it always applies
without errors to the most recent kernels, including pre-patches.
(Line offsets are OK; the 'patch' command has no trouble with these.)
This can be a lot of work when the kernel is in a volatile state, but
it is good if you can make sure that you are no more than 2 or 3 days
behind "the latest".  Note that if you followed 3) and your patch is
small and self-contained, in many cases you won't need to change it for
weeks.

11) If Linus or others tell you a change is stupid, chances are they
have a point.  If you must argue your case, use technical reasoning,
not marketing.  Arguments like "but XXX OS does it this way" carry very
little weight -- instead, give us independent reasons why "this way" is
good.  Linux is not Solaris, NT, FreeBSD, or BeOS, and we like it that
way.  Arguments like "but XXX is required for better YYY compliance"
carry more weight, but you may still need to justify why YYY compliance
is important, and why it can't be achieved another way.  Arguments like
"but we have BIGNUM customers / software vendors / gov't agencies who
will deploy/support Linux as soon as it has feature XXX" are completely
worthless, unless you can show that those customers, vendors or
agencies have solid technical reasons to want feature XXX (as opposed
to "but XXX OS does it this way and we don't want to port our software"
reasons).

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
