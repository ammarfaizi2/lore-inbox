Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265438AbUAHTZx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 14:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265806AbUAHTZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 14:25:53 -0500
Received: from h192n2fls310o1003.telia.com ([81.224.187.192]:52115 "EHLO
	cambrant.com") by vger.kernel.org with ESMTP id S265438AbUAHTZu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 14:25:50 -0500
Date: Thu, 8 Jan 2004 20:25:39 +0100
From: Tim Cambrant <tim@cambrant.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Cleanup patches - comparison is always [true|false] + unsigned/signed compare, and similar issues.   (consolidating existing threads)
Message-ID: <20040108192539.GA11663@cambrant.com>
References: <Pine.LNX.4.56.0401081847190.10083@jju_lnx.backbone.dif.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0401081847190.10083@jju_lnx.backbone.dif.dk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 08, 2004 at 06:59:48PM +0100, Jesper Juhl wrote:
>=20
> A) I wanted to remove code that could potentially be hiding a real bug.
> Examples would be code that by using an unsigned value might be casting
> away a needed 'signedness' of a variable. Code that by mixing signed and
> unsigned comparisons might be buggy in the case where the signed value
> overflows and all other nasties that can potentially happen when signed
> and unsigned values are mixed.

This should always be pursued. Unnecessary code does infact still exist
inside the kernel, and if a bug should find it's way in there it would
both be annoying for developers and dangerous for end-users.

> B) I wanted to remove dead code that was never being executed under any
> circumstances. This includes both tiny fragments and larger sections of
> code. I wanted to do this for 2 main reasons; first of all to attempt to
> cut down the amount of unnessesary code for people to read through when
> trying to understand the workings of a certain bit of code.
> Secondly to try find cases where changes to code had left some bits
> obsolete but those bits had been left in by mistake.

Readability should always be an issue, since the amount of documentation
and how easy a newbie can find his/her way through the sources is really
important for Linux. The easier it is to understand the code, the more
people will get involved in kernel developing in the end. It also sends
a message of professionality to have clean code which is consistant and
solid. From personal experience, I have become quite worried and paranoid
about the Linux kernel and software in general since I began reading LKML
and following up bugs, since issues like this do exist. Not that I have
ever had any real problems at all with the kernel, but knowing that a
lot of the code is unmaintained and erroneous takes away some of the
feeling of stability and security that the initial impression of Linux
gave me. Not that this has much to do with actual developing, but since
I am not a developer, I think I speak for most end-users who dig a little
deeper than desktop usage of Linux.

> C) Remove as many warning messages as possible. One reason is to get less
> cluttered output in general and also when compiling with -W. Another
> reason being that some warnings actually indicate real bugs - I'm aware
> that some warnings are completely pointless and the code being warned
> about is exactely as it should be, and such warnings should be ignored.

Warnings can infact be the problems with the compiler, and not errors
in the code itself. In some cases the programmers do the right thing,
and the compiler-programmers has to adjust to what infact is the right
thing to do. With this being said, warnings _are_ annoying. Someone
ought to categorize different types of warnings and only remove the
ones that everyone (or someone with authority) agrees is safe to
correct. Removing warnings just for the fun of it might not always
be the way to go.
=20
> What I did not intend to do with those patches was to decrease the
> readabillity of the code or trouble maintainers with pointless
> patch-reading.

Most maintainers would benefit from these patches in the end, no
matter how annoying it is to read through them at first. It is a
kernel janitor job, but even the "important" and busy developers
should care about these things. Nobody wants a messy kernel, so
a cleanup process like this would probably be appreciated from most
people.

> I don't want to bother anyone with pointless patches, and I see no need to
> spend my time doing stuff that people don't appreciate either

Indeed, it's not fun to do something that no-one appreciates, so a
rally like this might be necessary to get people to notice that a
project like this is going down. Posting cleanup-patches once a week
to LKML is probably not the way to go, since most of them will be
ignored and/or flamed.

Great initiative, Jesper. Cleanups are needed too. Being a fan of
cleanliness and neat code I suggest you go ahead if people seem
to care about these things.


                Tim Cambrant

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE//a6z+p4C2FlRhwIRAmeEAKCkiPHmnO2baPPi9U9m4BCM4YOCNwCfa8s0
XqbzSarL4y9mVLlNg4BHXkU=
=qymS
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
