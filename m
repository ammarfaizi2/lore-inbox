Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135255AbQLNXRD>; Thu, 14 Dec 2000 18:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129773AbQLNXQy>; Thu, 14 Dec 2000 18:16:54 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:12549 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129260AbQLNXQj>; Thu, 14 Dec 2000 18:16:39 -0500
Date: Thu, 14 Dec 2000 14:45:34 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Signal 11
In-Reply-To: <E146gyH-00007v-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10012141434320.12451-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Dec 2000, Alan Cox wrote:
> 
> > user applications and (b) gcc-2.96 is so broken that it requires special
> > libraries for C++ vtable chunks handling that is different, so the
> 
> Wrong - the C++ vtable format change is part of the intended progression of the
> compiler and needed to meet standards compliance. gcc 295 also changed the
> internal formats. Unfortunately the gcc295 and 296 formats are both probably
> not the final format. The compiler folks are not willing to guarantee anything
> untill gcc 3.0, which may actually be out by the time 2.4 is stable.

If you ask any gcc folks, the main reason they think this was a really
stupid thing to do was exactly that the 2.96 thing is incompatible BOTH
with the 2.95.x release _and_ the upcoming 3.0 release.

Nobody asked the people who knew this, apparently.

> > unusable as a development platform, and I hope RH downgrades their
> > compiler to something that works better RSN.  It apparently has problems
> 
> Like what - gcc 2.5.8 ? The problem is not in general that the snapshot is any
> buggier than before, but that the bugs are in different places. egcs and gcc295
> both caused X compile problems too.

gcc-2.95.2 is at least a real release, from a branch that is actively
maintained - so a 2.95.3 is likely to happen reasonably soon, fixing as
many problems as possible _without_ being incompatible like the snapshots
are.

Or just stay at 2.91.66 (egcs).

As to X compile problems - neither egcs nor 2.95.2 appears to have any
trouble with the CVS tree. Possibly because they got fixed, because, after
all, at least those were real releases.

I'd applaud RedHat for making snapshots available, but they should be
marked as SNAPSHOTS, and not as the main compiler with no way to fix the
damn problems it causes.

As it is, anybody doing development is probably better off at RH-6.2.
That is doubly true if they intend to release binaries.

			Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
