Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280824AbRKBUqb>; Fri, 2 Nov 2001 15:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280826AbRKBUqV>; Fri, 2 Nov 2001 15:46:21 -0500
Received: from smtp6.mindspring.com ([207.69.200.110]:24854 "EHLO
	smtp6.mindspring.com") by vger.kernel.org with ESMTP
	id <S280824AbRKBUqL>; Fri, 2 Nov 2001 15:46:11 -0500
Date: Fri, 2 Nov 2001 14:46:04 -0600
From: Tim Walberg <twalberg@mindspring.com>
To: Ville Herva <vherva@niksula.hut.fi>
Cc: John Adams <johna@onevista.com>, linux-kernel@vger.kernel.org
Subject: Re: Need blocking /dev/null
Message-ID: <20011102144604.E8312@mindspring.com>
Reply-To: Tim Walberg <twalberg@mindspring.com>
Mail-Followup-To: Tim Walberg <twalberg@mindspring.com>,
	Ville Herva <vherva@niksula.hut.fi>,
	John Adams <johna@onevista.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0111012322310.14742-100000@Consulate.UFP.CX> <01110215041301.01066@flash> <20011102223209.D26218@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f61P+fpdnY2FZS1u"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011102223209.D26218@niksula.cs.hut.fi> from Ville Herva on 11/02/2001 14:32
X-PGP-RSA-Key: 0x0C8BA2FD at www.pgp.com (pgp.ai.mit.edu)
X-PGP-RSA-Fingerprint: FC08 4026 8A62 C72F 90A9 FA33 6EEA 542D
X-PGP-DSS-Key: 0x6DAB2566 at www.pgp.com (pgp.ai.mit.edu)
X-PGP-DSS-Fingerprint: 4E1B CD33 46D0 F383 1579  1CCA C3E5 9C8F 6DAB 2566
X-URL: http://www.concentric.net/~twalberg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--f61P+fpdnY2FZS1u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I think that

find / -name foo 2>&-

should do the trick (under ksh, anyway, and
probably zsh or bash as well). Csh variants
IIRC don't have the concept of closing a
file descriptor...

		tw

>>=09
>>	The initial question was how to do
>>=09
>>	find / -name foo 2> /dev/null=20
>>=09
>>	or similar if /dev/null is not present. (Eat is a place holder for a
>>	imaginary progrom acting as /dev/null replacement).
>>=09
>>	I guess=20
>>=09
>>	find / -name foo 2>/dev/stdout 1>/dev/stderr | eat
>>=09
>>	would (kinda) work, but it fails if you want to do
>>=09
>>	find / -name foo 2> /dev/null | less
>>=09
>>	Can be done with named pipes, though.
>>=09
>>=09
>>	-- v --
>>=09
>>	v@iki.fi
>>	-
>>	To unsubscribe from this list: send the line "unsubscribe linux-kernel" =
in
>>	the body of a message to majordomo@vger.kernel.org
>>	More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>	Please read the FAQ at  http://www.tux.org/lkml/
End of included message



--=20
+--------------------------+------------------------------+
| Tim Walberg              | twalberg@mindspring.com      |
| 830 Carriage Dr.         | www.concentric.net/~twalberg |
| Algonquin, IL 60102      |                              |
+--------------------------+------------------------------+

--f61P+fpdnY2FZS1u
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.1i

iQA/AwUBO+MGCsPlnI9tqyVmEQKIUQCeOCga8wGJsn3RTVkMQ+eXpiX8QJIAnjlQ
xToXQYxQqC+6mU4ZRvv+AIOi
=Bn6+
-----END PGP SIGNATURE-----

--f61P+fpdnY2FZS1u--
