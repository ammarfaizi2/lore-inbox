Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbTH2O1i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 10:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbTH2O1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 10:27:37 -0400
Received: from [24.241.190.29] ([24.241.190.29]:54918 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S261271AbTH2O1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 10:27:30 -0400
Date: Fri, 29 Aug 2003 10:27:22 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: David T Hollis <dhollis@davehollis.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext2 -> ext3 on the fly?
Message-ID: <20030829142722.GB12564@rdlg.net>
Mail-Followup-To: David T Hollis <dhollis@davehollis.com>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20030829141619.GA12564@rdlg.net> <3F4F6233.5050809@davehollis.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Content-Disposition: inline
In-Reply-To: <3F4F6233.5050809@davehollis.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thus spake David T Hollis (dhollis@davehollis.com):

> Robert L. Harris wrote:
>=20
> >I have a number of servers which are currently mounting /usr as ext2.  I=
=20
> >have a means of doing an tune2fs -j on all of them remotely en mass but
> >I'd rather not reboot them all to enable journaling on machines that are
> >up and not having issues.  I've tried to do a:
> >
> >mount -t ext3 -o remount /usr
> >
> >as well as just a mount -o remount after changing the fstab.
> >
> >on a test box but it just blows out a usage message.  Is there a way to
> >do this remount without a complete reboot that'll be transparant to
> >users?
> >
> >
> >If not, is it dangerous to tune2fs the filesystems, change the fstab and
> >then leave the box up for 2-6 months and let them reboot through
> >atrrition, upgrades, etc?
> >
> >Current kernel is 2.4.21-ac3, getting outages and upgrades is a rather
> >long process involving regression testing, etc.
> >
> >Robert
> >
> >:wq!
> >------------------------------------------------------------------------=
---
> >Robert L. Harris                     | GPG Key ID: E344DA3B
> >                                        @ x-hkp://pgp.mit.edu
> >DISCLAIMER:
> >     These are MY OPINIONS ALONE.  I speak for no-one else.
> >
> >Life is not a destination, it's a journey.
> > Microsoft produces 15 car pileups on the highway.
> >   Don't stop traffic to stand and gawk at the tragedy.
> >=20
> >
> I would be inclined to say it's not safe not from a code perspective but=
=20
> an administration perspective.  If you make a change as significant as=20
> the file system format but don't test it until you reboot the box six=20
> months from now (when you aren't thinking about how you changed it six=20
> months ago) problems are likely to happen.  Could be a simple typo or=20
> something else, but it can definitely come back to bite you in the=20
> backside.  Granted, if you forgot to change your fstab to ext3, you'd=20
> still boot and be fine running as ext2, you just never can tell what=20
> could happen.  Murphy always likes to visit on those occasions.


My thoughts exactly, just wanted someone else to say it so I can give it
to management.  Unfortunately I know their response will be that our
package management system will ensure this won't happen which
technically it shouldn't but I can think of a couple ways ti still
could.


:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/T2LK8+1vMONE2jsRAsJoAJ9KTdn1McNIz8WpHXLCUuydmO5OtgCgpFne
VC2k/hGnPyzA21ivkNb1mRE=
=WP+k
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
