Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263097AbVALFLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263097AbVALFLv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 00:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263029AbVALFLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 00:11:50 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:43700 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263097AbVALFJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 00:09:48 -0500
Subject: Re: [PATCH] make uselib configurable (was Re: uselib()  & 2.6.X?)
From: Stephen Pollei <stephen_pollei@comcast.net>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050112021246.GE4325@ip68-4-98-123.oc.oc.cox.net>
References: <Pine.LNX.4.58LT.0501071648160.30645@oceanic.wsisiz.edu.pl>
	<20050107170712.GK29176@logos.cnet>
	<1105136446.7628.11.camel@localhost.localdomain>
	<Pine.LNX.4.58.0501071609540.2386@ppc970.osdl.org>
	<20050107221255.GA8749@logos.cnet>
	<Pine.LNX.4.58.0501081042040.2386@ppc970.osdl.org>
	<20050111225127.GD4378@ip68-4-98-123.oc.oc.cox.net>
	<20050111235907.GG2760@pclin040.win.tue.nl> 
	<20050112021246.GE4325@ip68-4-98-123.oc.oc.cox.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-YzGYaF8HpP+TB7pa1p5w"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Jan 2005 21:11:40 -0800
Message-Id: <1105506703.977.19.camel@fury>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YzGYaF8HpP+TB7pa1p5w
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-01-11 at 18:12, Barry K. Nathan wrote:
> > There are more ancient system calls, like old_stat and oldolduname.
> > Do we want separate options for each system call that is obsoleted?

> A config option for each one would be a bit much, I'll agree. However,
> I think having a single config option for the whole bunch would be a
> good idea.=20
=20
> less controversial than trying to do all of the old syscalls now.
Well the most controversial one-stop option could be a by date option.
CONFIG_OBSOLETE_TIME could default to 199201 or whatever

then you could then make things obsolete by wrapping them with
#if CONFIG_OBSOLETE_TIME <=3D 199805
 /* old stat stuff */
#endif
#if CONFIG_OBSOLETE_TIME <=3D 200211
/* old uname stuff */
#endif
#if CONFIG_OBSOLETE_TIME <=3D 200501
  /* uselib */
#endif

Then people could select with one option just to what extent they want
to support old crufty stuff. So one person could go super lean and mean
by choosing 200502 , while another could choose 200000 just to have
things from this century. Most people could just leave it alone.


--=20
http://dmoz.org/profiles/pollei.html
http://sourceforge.net/users/stephen_pollei/
http://www.orkut.com/Profile.aspx?uid=3D2455954990164098214
http://stephen_pollei.home.comcast.net/
GPG Key fingerprint =3D EF6F 1486 EC27 B5E7 E6E1  3C01 910F 6BB5 4A7D 9677

--=-YzGYaF8HpP+TB7pa1p5w
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQBB5LGMkQ9rtUp9lncRAvrhAKCRBiQLkK+rQt1kMso542K9Taf3zACfcvOH
rBXLgEZvSWl3YH8FeGGLFjQ=
=pyh5
-----END PGP SIGNATURE-----

--=-YzGYaF8HpP+TB7pa1p5w--

