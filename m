Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbUE2VkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbUE2VkW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 17:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbUE2VkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 17:40:22 -0400
Received: from ms-smtp-02.rdc-kc.rr.com ([24.94.166.122]:9869 "EHLO
	ms-smtp-02.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S261156AbUE2VkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 17:40:15 -0400
Subject: Re: 2.6 kernel OOPs with Nomad MuVo MP3 player
From: Derek Witt <dwitt1@kc.rr.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1085816432.11120.18.camel@saiya-jin>
References: <1085816432.11120.18.camel@saiya-jin>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7xXKQMoBULP2U/fLauUp"
Message-Id: <1085866812.10867.4.camel@saiya-jin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 29 May 2004 16:40:13 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7xXKQMoBULP2U/fLauUp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I have rebuilt my kernel without preempt support and passed
"elevator=3Ddeadline" to  the kernel on reboot. I now can mount my nomad
muvo without any major problems.

However, it times out and gives the oops on attemptng to dismount, but
the only effect of that is that the USB reiterates itself and the next
time  I insert the drive, it gets bumped up (e.g. from /dev/sda1 to
/dev/sdb1).  Also, it sometimes gets rendered read-only (easily resolved
by remounting the drive with same device name).

But, during the copy process, my computer is unsually bogged down (the
jumping mouse cursor in X).

So, I am suspecting the AS Anticipatory IO scheduler at fault.

On Sat, 2004-05-29 at 02:40, Derek Witt wrote:
> Good morning.
>=20
> I am attempting to mount my Creative Nomad MuVo MP3 Player. However,
> every time I try to mount or copy to the drive, I constantly get a
> Kernel oops. I am currently running 2.6.6-rc1 under Gentoo 1.4. SuSE 9.0
> running vanilla 2.6.5  returns the same problem.
>=20
> My dump indicates a problem with usb-storage trying to preempt parts of
> itself.
>=20
> The included dump is during a copy attempt.
>=20
> I am quite puzzled by this.. I'm going to rebuild my kernel sans preempt
> and see what happens.
>=20

Derek J Witt,
dwitt1@kc.rr.com.


--=-7xXKQMoBULP2U/fLauUp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAuQM72lgVX+zXThwRAsxFAKCbN+ovlKrH0ZN8MifocJAd/EwK3QCeOk4l
QWroRME7jwne/JdmBOAUR74=
=VdLY
-----END PGP SIGNATURE-----

--=-7xXKQMoBULP2U/fLauUp--

