Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264879AbUAVUD6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 15:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264942AbUAVUD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 15:03:58 -0500
Received: from [199.45.143.209] ([199.45.143.209]:42248 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S264879AbUAVUDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 15:03:55 -0500
Subject: Re: Strange pauses in 2.6.2-rc1 / AMD64
From: Zan Lynx <zlynx@acm.org>
To: Aaron Mulder <ammulder@alumni.princeton.edu>
Cc: Brandon Ehle <azverkan@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0401221428200.29180-100000@www.princetongames.org>
References: <Pine.LNX.4.44.0401221428200.29180-100000@www.princetongames.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CXjeh94AhW6BMMzJ+oFb"
Message-Id: <1074801826.10610.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 22 Jan 2004 13:03:46 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CXjeh94AhW6BMMzJ+oFb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-01-22 at 12:36, Aaron Mulder wrote:
> 	Thanks for the tip.  Unfortunately, disabling Legacy USB Support
> didn't stop the pauses for me.  It's weird -- if I lay off the mouse, the
> CPU goes to 99.7-100% idle, the load goes to 0, and top shows only 1
> running task (presumably top itself).  Every little while, Java will wake
> up and do some more work, then go to sleep again.  It seems to happen
> during the "jarsigner" phase of the Java build (there are about 20
> invocations of that), and it may be launching a new process to sign each
> JAR, I'm not sure.  This last time, I noticed that Java woke up briefly
> when Mozilla hit the top list.  It just seems to need some kind of
> external stimulus.  Keyboard doesn't do it.  FYI, I have no USB devices
> connected at the moment.
>=20
> Thanks,
> 	Aaron

jarsigner might be waiting on /dev/random for some cryptographically
random bytes.  One source of randomness is mouse interrupts.

If that's the case though, I'm surprised that the keyboard doesn't work.

Does that motherboard have support for a random generator chip?  If so,
try loading that module in.
--=20
Zan Lynx <zlynx@acm.org>

--=-CXjeh94AhW6BMMzJ+oFb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAECygG8fHaOLTWwgRAhugAKCMktCG2h7hezYgFLmdZ+5YH/mz7ACfQdvX
CKftqEAE0hqOLI/J9Q2n14Y=
=iK5n
-----END PGP SIGNATURE-----

--=-CXjeh94AhW6BMMzJ+oFb--

