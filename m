Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262737AbVCJQln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbVCJQln (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 11:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbVCJQlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 11:41:42 -0500
Received: from h116083.upc-h.chello.nl ([62.194.116.83]:53516 "EHLO lab.d20.nl")
	by vger.kernel.org with ESMTP id S262711AbVCJQhK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 11:37:10 -0500
Subject: Re: [patch 1/1] /proc/$$/ipaddr and per-task networking bits
From: Joost Remijn <remijnj@d20.nl>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1110470935.6291.105.camel@laptopd505.fenrus.org>
References: <1110464202.9190.7.camel@localhost.localdomain>
	 <1110464782.6291.95.camel@laptopd505.fenrus.org>
	 <1110468517.9190.24.camel@localhost.localdomain>
	 <1110469087.6291.103.camel@laptopd505.fenrus.org>
	 <1110470430.9190.33.camel@localhost.localdomain>
	 <1110470935.6291.105.camel@laptopd505.fenrus.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-UK6++jguJM8rVhfgse/Q"
Date: Thu, 10 Mar 2005 17:36:46 +0100
Message-Id: <1110472606.5589.20.camel@frost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UK6++jguJM8rVhfgse/Q
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-03-10 at 17:08 +0100, Arjan van de Ven wrote:
> On Thu, 2005-03-10 at 17:00 +0100, Lorenzo Hern=C3=A1ndez Garc=C3=ADa-Hie=
rro
> wrote: it tries to fill the
> > ipaddr member of the task_struct structure with the IP address
> > associated to the user running @current task/process,if available.
>=20
> but... a use doesn't hane an IP. a host does.

I'm not sure i understand but i've just tried to read the code and it
looks like the IP address is the address of the other end of a socket.

This address is set when a process does accept(). So this user IP we are
talking about would be the remote users host IP (or gateway in case of
NAT).=20

I don't think i fully understand the code but it looks like it only
holds the remote IP address of the last accept()-ed connection.=20

Joost Remijn

--=-UK6++jguJM8rVhfgse/Q
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCMHeeTXl8Eth9Jm8RAqEcAKCIuCoO1kqa0+PHMnMWCpprjp4phQCdG64Z
ZqKvJoeRwbPYknQzP4JkiJM=
=1Xbm
-----END PGP SIGNATURE-----

--=-UK6++jguJM8rVhfgse/Q--

