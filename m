Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279952AbRJ3Nui>; Tue, 30 Oct 2001 08:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279947AbRJ3NuT>; Tue, 30 Oct 2001 08:50:19 -0500
Received: from granger.mail.mindspring.net ([207.69.200.148]:9532 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S279883AbRJ3NuI>; Tue, 30 Oct 2001 08:50:08 -0500
Date: Tue, 30 Oct 2001 07:50:43 -0600
From: Tim Walberg <twalberg@mindspring.com>
To: george anzinger <george@mvista.com>
Cc: Jonathan Briggs <zlynx@acm.org>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nasty suprise with uptime
Message-ID: <20011030075043.B4904@mindspring.com>
Reply-To: Tim Walberg <twalberg@mindspring.com>
Mail-Followup-To: Tim Walberg <twalberg@mindspring.com>,
	george anzinger <george@mvista.com>,
	Jonathan Briggs <zlynx@acm.org>,
	Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E15yJD1-0003uO-00@the-village.bc.nu> <3BDDBE89.397E42C0@lexus.com> <20011029124753.F21285@one-eyed-alien.net> <4.3.2.7.2.20011029172525.00bb2270@mail.osagesoftware.com> <3BDDE642.8000901@acm.org> <3BDE6A80.3A68A44E@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aT9PWwzfKXlsBJM1"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BDE6A80.3A68A44E@mvista.com> from george anzinger on 10/30/2001 02:53
X-PGP-RSA-Key: 0x0C8BA2FD at www.pgp.com (pgp.ai.mit.edu)
X-PGP-RSA-Fingerprint: FC08 4026 8A62 C72F 90A9 FA33 6EEA 542D
X-PGP-DSS-Key: 0x6DAB2566 at www.pgp.com (pgp.ai.mit.edu)
X-PGP-DSS-Fingerprint: 4E1B CD33 46D0 F383 1579  1CCA C3E5 9C8F 6DAB 2566
X-URL: http://www.concentric.net/~twalberg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aT9PWwzfKXlsBJM1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Wouldn't it be fairly simple for the kernel to just remember the (wall
clock) time at boot, and uptime just subtract that from the current
(wall clock) time? It would be another variable in the kernel requiring
storage but not having a whole lot of use, but what's another 8 bytes
these days? (ok, maybe it would be more critical in embedded and other
such space critical applications, but not for general desktop/server
use...)


					tw



On 10/30/2001 00:53 -0800, george anzinger wrote:
>>	Jonathan Briggs wrote:
>>	>=20
>>	> A 32 bit uptime patch should also include a new kernel parameter that
>>	> could be passed from LILO: uptime.  Then you could test the uptime pat=
ch
>>	> by passing uptime=3D4294967295
>>	>=20
>>	> Or make /proc/uptime writable.
>>=09
>>	NO NO NO! =20
>>=09
>>	First uptime is a conversion of jiffies.  Second, the POSIX standard
>>	wants a CLOCK_MONOTONIC which, by definition, can not be set.  Jiffies
>>	is the most reasonable source for this clock.  I am afraid you will have
>>	to accumulate "real" time for uptime :)
>>=09
>>	George
>>=09
>>=09
>>	>=20
>>	> David Relson wrote:
>>	>=20
>>	> > Let's assume you have the counter changed to 32 bits - RIGHT NOW
>>	> > (tm).  Build a kernel, install it, reboot.  It'll be over a year
>>	> > (approx Jan 2003) before the change will be noticeable...
>>	> >
>>	> > Methinks that's a long time to wait for a result :-)
>>	> >
>>	> > David
>>	> >
>>	>=20
>>	> -
>>	> To unsubscribe from this list: send the line "unsubscribe linux-kernel=
" in
>>	> the body of a message to majordomo@vger.kernel.org
>>	> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>	> Please read the FAQ at  http://www.tux.org/lkml/
>>	-
>>	To unsubscribe from this list: send the line "unsubscribe linux-kernel" =
in
>>	the body of a message to majordomo@vger.kernel.org
>>	More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>	Please read the FAQ at  http://www.tux.org/lkml/
End of included message



--=20
twalberg@mindspring.com

--aT9PWwzfKXlsBJM1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.1i

iQA/AwUBO96wMcPlnI9tqyVmEQJ0sgCgmpkx2msBsdMriCwNIYUHeqgWA/wAniUD
X2D80HBCYhSh565tZZx6Ygta
=dz+v
-----END PGP SIGNATURE-----

--aT9PWwzfKXlsBJM1--
