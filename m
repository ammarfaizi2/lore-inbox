Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbUCIN2v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 08:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbUCIN2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 08:28:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3241 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261921AbUCIN23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 08:28:29 -0500
Subject: Re: [BUG][2.6.4-rc2-mm1] kernel BUG at fs/proc/generic.c:664!
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: =?ISO-8859-1?Q?Ram=F3n?= Rey Vicente <ramon.rey@hispalinux.es>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1078836492.23461.7.camel@debian>
References: <1078836492.23461.7.camel@debian>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YZuYMwd6iBSHkrSyoIdi"
Organization: Red Hat, Inc.
Message-Id: <1078838902.4452.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 09 Mar 2004 14:28:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YZuYMwd6iBSHkrSyoIdi
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-03-09 at 13:48, Ram=C3=B3n Rey Vicente wrote:
> Hi.
>=20
> I get this with latest -mm kernel.
Mar  9 02:43:05 debian kernel:=20
[__crc_nf_unregister_hook+351987/1212996] snd_audiopci_remove+0x10/0x40
[snd_ens1371]


Hi,

It looks like the snd_ens1371 kernel module is removing a proc directory
that isn't yet empty; that always was illegal (and could cause memory
corruption) so now it's trapped on....

--=-YZuYMwd6iBSHkrSyoIdi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBATcZ2xULwo51rQBIRAvnhAJ9Ho8ZIXl+zqW3nKfIJLrkQ+asEnACfcXDM
tbOfesMFhi/CsK9cEK8x8ms=
=OfD3
-----END PGP SIGNATURE-----

--=-YZuYMwd6iBSHkrSyoIdi--

