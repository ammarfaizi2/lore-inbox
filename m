Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpI6yZ4fUInZfTVef1+WfQj8wcw==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sun, 04 Jan 2004 22:02:49 +0000
Message-ID: <024d01c415a4$8eb25c10$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft CDO for Exchange 2000
Content-Class: urn:content-classes:message
Importance: normal
Date: Mon, 29 Mar 2004 16:43:18 +0100
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
From: "Arjan van de Ven" <arjanv@redhat.com>
To: <Administrator@smtp.paston.co.uk>
Cc: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>, <davej@redhat.com>
Subject: Re: 2.6.1-rc1 arch/i386/kernel/setup.c   wrong parameter order to request resources ?
References: <20040104153928.GB2416@devserv.devel.redhat.com> <Pine.LNX.4.58.0401041305440.2162@home.osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
	micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401041305440.2162@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:43:20.0093 (UTC) FILETIME=[8F94CCD0:01C415A4]

This is a multi-part message in MIME format.

--5vNYLRcllDrimb99
Content-Type: text/plain;
	charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 04, 2004 at 01:08:52PM -0800, Linus Torvalds wrote:
>=20
>=20
> On Sun, 4 Jan 2004, Arjan van de Ven wrote:
> >=20
> > in setup.c  the kernel tries to reserve ram resources for system ram etc
> > etc. However it seems it's done with the parameters to request_resource=
 in
> > the wrong order (it certainly is opposite order from other neighboring
> > code). Can someone confirm I'm not overlooking something?
>=20
> You've overlooked something.
>=20
> The core uses the rigth order: it's literally trying to find _which_ of=
=20
> the e820 resources contains the "code" and "data" resource.
>=20
> In other words: the code and data resources don't contain anything. They=
=20
> are contained _in_ something, but we don't know which one off-hand, so we=
=20
> try to register them in all the memory resources we find.=20

> and not used for anything else.

ok fair enough; maybe deserves more comment but it makes sense.

--5vNYLRcllDrimb99
Content-Transfer-Encoding: 7bit
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/+IzkxULwo51rQBIRAouSAJ9R/idYX2X+FfBjGi/GRA+vtfXlmACfSlB0
q6bVKG9rc2IGFa37MUjSJ4Y=
=zjZH
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
