Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbWHJHax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWHJHax (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 03:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbWHJHax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 03:30:53 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:33005 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751447AbWHJHaw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 03:30:52 -0400
Subject: Re: [PATCH 1/6] ehea: interface to network stack
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, netdev <netdev@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>,
       Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>
In-Reply-To: <1155190553.9801.38.camel@localhost.localdomain>
References: <44D99EFC.3000105@de.ibm.com>
	 <1155190553.9801.38.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-GaCv2NE0p8UwUhN37GLQ"
Date: Thu, 10 Aug 2006 17:30:50 +1000
Message-Id: <1155195050.9801.67.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GaCv2NE0p8UwUhN37GLQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-08-10 at 16:15 +1000, Michael Ellerman wrote:
> > +	struct hcp_query_ehea_port_cb_2 *cb2 =3D NULL;
> > +	struct net_device_stats *stats =3D &port->stats;
> > +
> > +	EDEB_EN(7, "net_device=3D%p", dev);
> > +
> > +	cb2 =3D kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
> > +	if (!cb2) {
> > +		EDEB_ERR(4, "No memory for cb2");
> > +		goto get_stat_exit;
>=20
> You leak cb2 here.
>=20
> > +	}
> > +
> > +	hret =3D ehea_h_query_ehea_port(adapter->handle,
> > +				      port->logical_port_id,
> > +				      H_PORT_CB2,
> > +				      H_PORT_CB2_ALL,
> > +				      cb2);
> > +
> > +	if (hret !=3D H_SUCCESS) {
> > +		EDEB_ERR(4, "query_ehea_port failed for cb2");
> > +		goto get_stat_exit;

Sorry, here.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-GaCv2NE0p8UwUhN37GLQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBE2uCqdSjSd0sB4dIRAkLbAJoD4gD9x3bXAO+mlQ2p21Bng4qHIwCggJAD
EZZ0k3+qO3f3A2lfDFDoa8c=
=Xtps
-----END PGP SIGNATURE-----

--=-GaCv2NE0p8UwUhN37GLQ--

