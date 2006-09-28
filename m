Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030350AbWI1XS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030350AbWI1XS1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 19:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030226AbWI1XS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 19:18:26 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:8425 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1750826AbWI1XSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 19:18:25 -0400
X-Sasl-enc: NUqhLUWM2khHWy2a3JvT5Ctme8KEbMjyGgMo9PVRHKmC 1159485506
Message-ID: <451C58AC.5060601@imap.cc>
Date: Fri, 29 Sep 2006 01:20:12 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.6) Gecko/20060729 SeaMonkey/1.0.4 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, jbeulich@novell.com
Subject: Re: [2.6.18-rc7-mm1] slow boot
References: <4516B966.3010909@imap.cc> <20060924145337.ae152efd.akpm@osdl.org> <451BFFA9.4030000@imap.cc> <200609281912.01858.ak@suse.de>
In-Reply-To: <200609281912.01858.ak@suse.de>
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA1C256E1DBCD461B4D574C61"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA1C256E1DBCD461B4D574C61
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 28.09.2006 19:12 schrieb Andi Kleen:
> On Thursday 28 September 2006 19:00, Tilman Schmidt wrote:
>=20
> missing context here, but ...

Forwarded by separate mail.

>> x86_64-mm-i386-stacktrace-unwinder.patch
[...]
>> Backing out just this patch from 2.6.18-mm1 (and resolving conflicts
>> manually the obvious way) gets the boot time back to normal (ie. as
>> fast as 2.6.18 mainline) on my
>> Linux gx110 2.6.18-mm1-noinitrd #2 PREEMPT Thu Sep 28 18:48:32 CEST 20=
06 i686 i686 i386 GNU/Linux
>> machine.
>=20
> Hmm, i assume you have lockdep on.

Indeed.

> The new backtracer is of course slower
> than the old one and it will slow down lockdep which takes a lot of bac=
ktraces.=20
> But it shouldn't be a significant slowdown.

Unfortunately, it is. Boot time roughly doubles from 39 to 76 secs.

> Can you perhaps boot with profile=3D1 and then send readprofile output =
after
> boot?

I'm afraid I'll need instructions for that. I assume "profile=3D1"
is to be appended to the kernel command line; but how do I
retrieve that readprofile output you are asking for?

Thanks
Tilman

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeoeffnet mindestens haltbar bis: (siehe Rueckseite)


--------------enigA1C256E1DBCD461B4D574C61
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFHFisMdB4Whm86/kRAr7eAJ9bhaC6yST1Cj9VStOqbTLY1f1ESACdHAnT
qM8f5XwIcRZzGRX6nDaH9bg=
=dwg3
-----END PGP SIGNATURE-----

--------------enigA1C256E1DBCD461B4D574C61--
