Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265701AbUADOkG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 09:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265707AbUADOkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 09:40:05 -0500
Received: from wblv-238-222.telkomadsl.co.za ([165.165.238.222]:2432 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265701AbUADOjy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 09:39:54 -0500
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Con Kolivas <kernel@kolivas.org>
Cc: Soeren Sonnenburg <kernel@nn7.de>, Willy Tarreau <willy@w.ods.org>,
       Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       gillb4@telusplanet.net
In-Reply-To: <200401042345.33039.kernel@kolivas.org>
References: <Pine.LNX.4.44.0401031439060.24942-100000@coffee.psychology.mcmaster.ca>
	 <200401041949.27408.kernel@kolivas.org>
	 <1073214820.6075.254.camel@nosferatu.lan>
	 <200401042345.33039.kernel@kolivas.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-18n9lbloEierR8nenqoQ"
Message-Id: <1073227359.6075.284.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 04 Jan 2004 16:42:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-18n9lbloEierR8nenqoQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-01-04 at 14:45, Con Kolivas wrote:
> On Sun, 4 Jan 2004 22:13, Martin Schlemmer wrote:
> > On Sun, 2004-01-04 at 10:49, Con Kolivas wrote:
> > > > I added a fprintf(stderr, "%d\n", amount); to that code and indeed
> > > > amount was *always* 1 no matter what I did (it even was 1 when the
> > > > (dmesg/...) output came in fast). And jump scrolling would take pla=
ce
> > > > if amount > 59 in my case... can this still be not a schedulers iss=
ue ?
> > > >
> > > >
> > > > Looking at that how can it not be a scheduling problem ....
> > >
> > > Scheduling problem, yes; of a sort.
> > >
> > > Solution by altering the scheduler, no.
> > >
> > > My guess is that turning the xterm graphic candy up or down will chan=
ge
> > > the balance. Trying to be both gui intensive and a console is where i=
t's
> > > happening. On some hardware you are falling on both sides of the fenc=
e
> > > with 2.6 where previously you would be on one side.
> >
> > So its Ok for 'eye candy' to 'lag', but xmms should not skip?  Anyhow,
> > its xterm that he have issues with, not gnome-terminal or such with
> > transparency.  I smell something ...
>=20
> Sigh...=20
>=20
> Xmms was a simple test case long forgotten but most still think all I did=
 was=20
> make an xmms scheduler. Deleting one character from sched.c before all of=
 my=20
> patches would make the scheduler ideal for xmms. Any braindead idiot can =
tune=20
> a scheduler for just one application.

Well, its the favorite example 8)

>  An application that changes it's=20
> behaviour dynamically well in the setting of a particular scheduler, thou=
gh?=20
> Should a scheduler be tuned to suit a coding style or quirk?=20
>=20

But the scheduler changes to a particular application?  I still am of
opinion that the current scheduler in mainline 'breaks' priorities ...
call it dynamic tuning or whatever you like.  Now something gets
priority while something else starves.

> I should go back to lurking before people start calling me names. This th=
read=20
> has gone long enough for that. If I hadn't said anything it would have di=
ed=20
> out by now.

Well, I have stayed out of this for months now, as its always 'they' at
fault - that app, or piece of code.  Sure, I am one of those whining
users, and I have no particular interest in the scheduler code - that
is if it behaves like it should.  But whatever is in now, just do not
behave as expected, and call it a feature or whatever you want, if it
deviates the definition, then what should we call it?  Or if its a
feature, can we have the weirdness in priorities disabled by default
with a sysctl or sysfs switch?

> Instead I'm drawing attention to my fundamentally flawed code.
>=20

The scrolling is but one part.  Just starting an app, or running
'vim /etc/fstab' for example takes ages some times, even with
minimal load.  If xterm, gnome-term, aterm, multi-gnome-term,
etc is broken, how do we fix it then?  What about some of the
other issues?  If its a problem with those apps, why is it I still
wonder what they are doing wrong, and it not fixed?

Do not worry, _I_ will go back to lurking about this issue _again_,
but after _once_again_ seeing a issue about this being blown off
as being something wrong with 'it', and some facts (you did see
that the skipping code for the other user _never_ kicked in)
were just ignored, I just could not help myself - sorry.

At least I will not experience those issues of the others, and
hopefully Nick will not stop his work, or things change too much
to adapt his patch.


Thanks,

--=20
Martin Schlemmer

--=-18n9lbloEierR8nenqoQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQA/+CZfqburzKaJYLYRAuKlAJ9z3buW98T1Orl+DUSVpXUXEl50VQCfYieh
4oOs29ZF1wRQIso9DPeeIuI=
=DjKH
-----END PGP SIGNATURE-----

--=-18n9lbloEierR8nenqoQ--

