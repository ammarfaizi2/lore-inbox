Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbUJ0F1C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbUJ0F1C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 01:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbUJ0F1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 01:27:02 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:53147 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261650AbUJ0FZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 01:25:50 -0400
Message-ID: <417F315A.9060906@comcast.net>
Date: Wed, 27 Oct 2004 01:25:46 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041022)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
CC: Ed Tomlinson <edt@aei.ca>, Massimo Cetra <mcetra@navynet.it>,
       "'Chuck Ebbert'" <76306.1226@compuserve.com>,
       "'Bill Davidsen'" <davidsen@tmr.com>,
       "'William Lee Irwin III'" <wli@holomorphy.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: My thoughts on the "new development model"
References: <00c201c4bb4c$56d1b8b0$e60a0a0a@guendalin> <200410261719.56474.edt@aei.ca> <Pine.LNX.4.61.0410270402340.20284@student.dei.uc.pt>
In-Reply-To: <Pine.LNX.4.61.0410270402340.20284@student.dei.uc.pt>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Marcos D. Marado Torres wrote:
| On Tue, 26 Oct 2004, Ed Tomlinson wrote:
|
|>>> 2.4 tree is still the best solution for production.
|>>> 2.6 tree is great for gentoo users who like gcc consuming all CPU
|>>> (maxumum respect to gentoo but I prefer debian)
|>>
|>>
|>> The issue is that Linus _has_ changed the development model.  What we
|>> have
|>> now is more flexable and much more responsive to changes.  This does
|>> lead to stable releases that are not quite a stable as some of the
|>> previous
|>> stable series...  This is why I suggest a fix/security branch.  The
|>> idea being
|>> that after a month or so of fixes etc it will be a very stable kernel
|>> and it will
|>> not have slowed down development.
|
|
| The sole existence of this discussion prooves that there's already the
| need of
| a new step. But why trying to re-invent the wheel? Yes, relating to 2.6
| we need
| already a "very stable kernel" and a "not-slowed down development
| kernel". When
| it happened in 2.4 2.5 was created. Isn't all this just the indication
| that we
| need a 2.6 development like 2.4 is, and we need 2.7 to be created?
|

Another shameless plug for me:
http://lkml.org/lkml/2004/10/26/171

Short version to save you reading of my spam:
Let's make 2.7 what 2.6 is now (a relatively stable kernel that gets
relatively stable feature enhancements continuously), rather than what
2.5 was (a hell of a lot of patches and then a hell of a lot of
debugging), and make 2.6 more restrictive than 2.4 in that it should be
strictly bugfixes (including security bugs) and no backported drivers or
features.

I read a page about open source software development once, I don't
remember if it was an article or a book or what; but it said something
I've held to heart for a while:  Open source projects tend to follow the
poorly designed development model of alternating between a "stable" and
an "unstable" branch, when it's possible to simply perpetually add
stablized, debugged features straight to mainline after they've been
developed independently on the side.

It is apparent that what we have here is exactly what the author
suggested in place of the stable/unstable cycle; it is also apparent
that this is a naiive model not because it becomes difficult to avoid
bugs, but because it becomes difficult to actually develope on the side
with all of the changes happening to mainline.  By combining both
models, a balance is met.

This same model can be implemented as a meta-model (or something) if the
external projects chose on their own which versions to freeze at.  This
creates a problem, however, as patches for these projects become
distributed across ranges of versions.  Consider having a development
driver for 2.6.7 for an ADSL card; a development driver for 2.6.5 for a
network card; and a development DRM driver for 2.6.10 for a particular
video card.  The unfortunate soul having all three of these pieces of
hardware is quite SOL.

On the other hand, there are those who simply get fed up chasing the
volatile codebase of mainline, ad simply wait for it to stabalize.
Unless you throw them their bone, they won't get any work done; this is
not only their problem, but their users' as well.


| Mind Booster Noori
|
| -- /* *************************************************************** */
|    Marcos Daniel Marado Torres         AKA    Mind Booster Noori
|    http://student.dei.uc.pt/~marado   -      marado@student.dei.uc.pt
|    () Join the ASCII ribbon campaign against html email, Microsoft
|    /\ attachments and Software patents.   They endanger the World.
|    Sign a petition against patents:  http://petition.eurolinux.org
| /* *************************************************************** */

- -
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBfzFZhDd4aOud5P8RAiTmAJ9obM88F5YW29Rcke3oKrWngs/rRACaAxqZ
BBoLsEO2QdBIJfZlBvGpZHk=
=hMNm
-----END PGP SIGNATURE-----
