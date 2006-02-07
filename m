Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbWBGWo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbWBGWo6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 17:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbWBGWnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 17:43:17 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:53723 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932411AbWBGWnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 17:43:13 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Tue, 7 Feb 2006 20:06:26 +1000
User-Agent: KMail/1.9.1
Cc: Bojan Smojver <bojan@rexursive.com>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       suspend2-devel@lists.suspend2.net
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602071105.45688.nigel@suspend2.net> <20060207092356.GA1742@elf.ucw.cz>
In-Reply-To: <20060207092356.GA1742@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1663105.ONHQuM9Lry";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602072006.32017.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1663105.ONHQuM9Lry
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 07 February 2006 19:23, Pavel Machek wrote:
> Hi!
>=20
> > > *Users* would not be at disadvantage, but, surprise, there's one=20
thing
> > > more important than users. Thats developers, and I can guarantee you
> > > that merging 14K lines of code just to delete them half a year later
> > > would drive them crazy.
> >=20
> > It would more be an ever-changing interface that would drive them=20
crazy. So=20
> > why don't we come up with an agreed method of starting a suspend and=20
> > starting a resume that they can use, without worrying about whether=20
> > they're getting swsusp, uswsusp or Suspend2? /sys/power/state seems the=
=20
> > obvious choice for this. An additional /sys entry could perhaps be used=
=20
to=20
> > modify which implementation is used when you echo disk=20
> /sys/power/state=20
> > - something like
> >=20
> > # cat /sys/power/disk_method
> > swsusp uswsusp suspend2
> > # echo uswsusp > /sys/power/disk_method
> > # echo > /sys/power/state
> >=20
> > Is there a big problem with that, which I've missed?
>=20
> Well, for _users_ method seems to be clicking "suspend" in KDE. For
> more experienced users it is powersave -U. And you are already
> distributing script to do suspend... Just hook suspend2 to the same
> gui stuff distributions already use.

The problem is that kpowersave, for example, doesn't provide any way to say=
=20
that you want to start the cycle by doing something other than echo=20
> /sys/power/state. They're apparently planning on changing it to support=20
suspend2, but should they have to (and why again for uswsusp?).
=20
> Besides what you described can't work for uswsusp.

call_usermodehelper

Regards,

Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart1663105.ONHQuM9Lry
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD6HEnN0y+n1M3mo0RAn5mAJ9/v7IG5BkWbqsQhmj/tzBw98RZ3QCg6JhT
LZpqis5f47JCXOFjiEF2uTE=
=oacb
-----END PGP SIGNATURE-----

--nextPart1663105.ONHQuM9Lry--
