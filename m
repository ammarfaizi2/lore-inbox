Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270464AbRITSJQ>; Thu, 20 Sep 2001 14:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274586AbRITSI4>; Thu, 20 Sep 2001 14:08:56 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:8405 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S270464AbRITSIr>; Thu, 20 Sep 2001 14:08:47 -0400
Date: Thu, 20 Sep 2001 12:10:05 -0600
Message-Id: <200109201810.f8KIA5j04307@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: drivers/char/sonypi.h broken
In-Reply-To: <E15k7uP-0005im-00@the-village.bc.nu>
In-Reply-To: <200109201418.f8KEIjG01625@vindaloo.ras.ucalgary.ca>
	<E15k7uP-0005im-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> > in 12 hours. I think this just highlights the need for BitKeeper or
> > equivalent, where automated regression testing (even a simple "does it
> > compile and link?") is performed, and if the test fails, it gets
> > bounced and doesn't even get to Linus.
> 
> I do compile/link tests but not a million combinations of them. Its
> o(N!) remember..

Yes, and even if you were able to do so, there is still the problem of
testing against the version that Linus applies the patch to (which as
you said earlier, is a moving target). I guess one solution would be
to have the tool Linus uses (or should use:-) also do a test, and if
it fails, to bounce it. That would be done against Linus' working
tree.

However, that would reduce Linus' flexibility in applying a series of
patches which involves global API changes. Hm. Perhaps an option so
that Linus can accept a patch if he knows it's part of a global API
change.

Another alternative, which has been raised before, is Linus' patch
queue is made public. As I understand it, Linus files pending patches
into a special folder, and then later feeds that folder, en-masse,
into patch(1), and a release/pre-patch is born. That patch queue could
be distributed using the kernel.org mirror system. This would be a
generally useful thing, and with automated regression testing, reduces
the window for merge errors.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
