Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262664AbVFWIs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262664AbVFWIs1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbVFWIoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:44:20 -0400
Received: from nysv.org ([213.157.66.145]:34210 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S262585AbVFWIJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 04:09:05 -0400
Date: Thu, 23 Jun 2005 11:08:51 +0300
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: "Artem B. Bityuckiy" <dedekind@yandex.ru>,
       Christophe Saout <christophe@saout.de>, Andrew Morton <akpm@osdl.org>,
       Hans Reiser <reiser@namesys.com>, hch@infradead.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: reiser4 plugins
Message-ID: <20050623080851.GB11013@nysv.org>
References: <dedekind@yandex.ru> <42B98FD5.6050201@yandex.ru> <200506221733.j5MHXEoH007541@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eP8xGX2lG1UwfyBj"
Content-Disposition: inline
In-Reply-To: <200506221733.j5MHXEoH007541@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.5.9i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eP8xGX2lG1UwfyBj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 22, 2005 at 01:33:14PM -0400, Horst von Brand wrote:
>> > So merge it as it is=20
>Fix it first. The "merge as it stands" just gives rise to stuff that is
>/never/ fixed properly.

It's in -mm already and it was said the big grudges are fixed.

What do you still want?

>> >                      and move the stuff to the VFS as needed or
>> > deemed necessary. And enable the pseudo interface, or at least
>> > set it in menuconfig and enable by default, it needs testing too.
>
>Then test it out of the standard tree...

Huh? You mean -mm? That's what people do, backport to mainline.

Or did I miss something?

>> Reiser4 has a number of great (IMO) things like file as directory,
>Urgh.

Your opinion :)

>>                    different kinds of stat data,
>Usefulness? Sounds like kernel bloat leading to userspace bloat and
>applications/users wondering what the heck goes on when they don't grok the
>particular stat format.

Oh no! NOOOOOOOO! New features come at a cost?!

Shit, I better unpack my C64.

>> etc. Some thing is not yet ready - doesn't matter. Some of this is of
>> general interest, some is Reiser4-dedicated.
>
>I don't see anything that would interest me at least, so you can safely
>scratch the "general interest" part.

These are things people will start using when available.

They're given a framework which enables them to do things other
people can't imagine.

Too bad you're convinced everything everyone does is on the level of "Urgh"

>> New interfaces are needed to allow users to utilize that all.
>
>That is a quite strong argument /against/ it all in my book. It means bloat
>in /every/ filesystem, and they have shown to be able to do without for
>some 30 years now. I'd need /very/ strong reasons for adding something.

But the competitor's filesystems are evolving past that 30-year-old
paradigm, why shouldn't Linux's?

And if Reiser4 is merged and its VFS-doubling things merged into the VFS,
how much will it bloat Ext2 if Ext2 doesn't go near files-as-dirs
or extended stat data?

>It has been argued over and over that that particular feature /can't/ be
>implemented sanely anyway, so it has to stay out. Besides not making any

Arguments left and right for and against this.

I'd rather see someone write the code that does this, or, even better,
you can write the code that proves this definitively wrong and someone
else will get it to work.

(Ok, I hate the "DIY" counter-argument as much as the next man, but
this seemed almost an appropriate place to use it)

>sense. "You've got files and directories" is a bit asymetrical and so not
>quite nice; "all you have is directories" is symmetrical, estetic, and
>completely useless; "some files are directories, some aren't; files in
>file-directories are different than regular files in directory-directories"
>is just a mindless jumble.

"You've got data objects"

All we need is the extra bit that's MAY_LOOKUP so we don't need +x
to access metadata. But apparently this is too much to ask for.

Why? /Probably/ standards compliance.=20
So why be compliant, if it's backwards compatible? SILENCE!
No really, why not extend something without breaking? ...we don't wanna...

>> The other question that it may be difficult to foresee everything and
>> it may make sense to move some things upper in future.
>Another good reason to keep it out ;-)

Sure, extinguish innovation. Got it.

--=20
mjt


--eP8xGX2lG1UwfyBj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCum4TIqNMpVm8OhwRAnTsAJ9AKrILzPA3LfJPiWG/EKg53fnToQCcDfNY
WnT0ILkU7f0kQn9hlCP5GzI=
=Pww0
-----END PGP SIGNATURE-----

--eP8xGX2lG1UwfyBj--
