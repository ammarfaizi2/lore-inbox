Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbWINMBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWINMBk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 08:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWINMBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 08:01:39 -0400
Received: from agent.admingilde.org ([213.95.21.5]:60612 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP
	id S1751269AbWINMBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 08:01:39 -0400
Date: Thu, 14 Sep 2006 14:01:33 +0200
From: Martin Waitz <tali@admingilde.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Greg K-H <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [01/12] driver core fixes: make_class_name() retval check
Message-ID: <20060914120133.GS17042@admingilde.org>
Mail-Followup-To: Cornelia Huck <cornelia.huck@de.ibm.com>,
	Greg K-H <greg@kroah.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20060913163007.21cf10a8@gondolin.boeblingen.de.ibm.com> <20060913183834.3a71bbbe@gondolin.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oDto3OTLsk6uOlQH"
Content-Disposition: inline
In-Reply-To: <20060913183834.3a71bbbe@gondolin.boeblingen.de.ibm.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oDto3OTLsk6uOlQH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Sep 13, 2006 at 06:38:34PM +0200, Cornelia Huck wrote:
>  	if (class_dev->dev) {
>  		class_name =3D make_class_name(class_dev->class->name,
>  					     &class_dev->kobj);
> +		if (IS_ERR(class_name)) {
> +			error =3D PTR_ERR(class_name);
> +			class_name =3D NULL;
> +			goto out6;
> +		}

perhaps it makes sense to return NULL in make_class_name on error,
to have consistent error return values?

--=20
Martin Waitz

--oDto3OTLsk6uOlQH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFCUSdj/Eaxd/oD7IRAko/AJ9ZBDJvwr1zVQvRhVjoC4E4qW16xgCeKMXL
rotPGm0efAMK/HUXiQ2EGek=
=+++c
-----END PGP SIGNATURE-----

--oDto3OTLsk6uOlQH--
