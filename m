Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbVHOHtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbVHOHtu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 03:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbVHOHtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 03:49:50 -0400
Received: from mail27.syd.optusnet.com.au ([211.29.133.168]:30913 "EHLO
	mail27.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932162AbVHOHtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 03:49:50 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: usb camera failing in 2.6.13-rc6
Date: Mon, 15 Aug 2005 17:49:20 +1000
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <mailman.1124005092.8274.linux-kernel2news@redhat.com> <200508150929.21402.kernel@kolivas.org> <20050814172600.71a4a8cc.zaitcev@redhat.com>
In-Reply-To: <20050814172600.71a4a8cc.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1442011.s2U9Ev5T4W";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508151749.23116.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1442011.s2U9Ev5T4W
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Mon, 15 Aug 2005 10:26, Pete Zaitcev wrote:
> On Mon, 15 Aug 2005 09:29:20 +1000, Con Kolivas <kernel@kolivas.org> wrot=
e:
> > > Remember that dmesg diff you sent? That's the one. If you strace
> > > the digikamcameracl, it probably keels over after EBUSY.
> >
> > Nice shot! Got it in one. bugzilla updated with confirmation.
> >
> > So how do we proceed with this one? Do I need to file a digikam bug
> > report too?
>
> Since I never encountered it, I'm not versed in the switching of
> the current altsetting. I suppose, this has to be discussed between
> digikam developers and linux-usb-devel (Alan Stern probably knows
> how that has to be done). It's very likely that all digikam needs
> is to claim the interface after the altsetting was switched...
> But I really do not know.

Ok I've investigated further and had a pointer from Andrew Clayton who fixe=
s=20
this problem with a gphoto2 upgrade. The issue is a libgphoto2 one and=20
kernels 2.6.13+ will require libgphoto2 2.1.6 or later to work properly.

To sort this out before 2.6.13 comes out and it bites a lot of people - as=
=20
most distros will have this problem - I suggest pointing them to the bugzil=
la=20
entry as a FAQ:

http://bugzilla.kernel.org/show_bug.cgi?id=3D5063

Cheers,
Con

--nextPart1442011.s2U9Ev5T4W
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDAEkDZUg7+tp6mRURAlfHAJ9MZG13Ct1g5ptqqxI/POfLV+S+CQCeMEAB
dOm7lskwxWlk6zWkHFTI5Ko=
=Jj/Z
-----END PGP SIGNATURE-----

--nextPart1442011.s2U9Ev5T4W--
