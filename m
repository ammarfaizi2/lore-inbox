Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbVB1BDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVB1BDU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 20:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbVB1BDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 20:03:20 -0500
Received: from ozlabs.org ([203.10.76.45]:49823 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261525AbVB1BDL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 20:03:11 -0500
Date: Mon, 28 Feb 2005 11:54:10 +1100
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Eric Gaumer <gaumerel@ecs.fullerton.edu>
Cc: linux-kernel@vger.kernel.org, proski@gnu.org
Subject: Re: [PATCH] orinoco rfmon
Message-ID: <20050228005410.GB9197@localhost.localdomain>
Mail-Followup-To: David Gibson <hermes@gibson.dropbear.id.au>,
	Eric Gaumer <gaumerel@ecs.fullerton.edu>,
	linux-kernel@vger.kernel.org, proski@gnu.org
References: <4220BB87.2010806@ecs.fullerton.edu> <20050227033944.GA15380@localhost.localdomain> <422269BA.9070308@ecs.fullerton.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <422269BA.9070308@ecs.fullerton.edu>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 27, 2005 at 04:45:46PM -0800, Eric Gaumer wrote:
> David Gibson wrote:
> >
> >This looks like the ancient version of the monitor patch - which
> >includes importing a lot of needless junk from the linux-wlan-ng
> >tree.  A cleaned up version of monitor has been merged in the orinoco
> >CVS tree for ages now, but unfortunately that's long overdue for a
> >merge with mainline.  I'm trying to get that merge done - I just don't
> >have much time or energy for the orinoco driver these days.  One stack
> >of patches which gets part of the way went to Jeff Garzik last week.
> >We'll see how we go.
> >
> >In the meantime go to http://savannah.nongnu.org/projects/orinoco for
> >access to the driver CVS.  You probably want to get the "for_linus"
> >branch of CVS if you're planning to work with 2.6.
> >
>=20
> Thanks David, the CVS code works great with the small excpetion of the=20
> following change to
> get it to build.
>=20
> diff -Nru orinoco-cvs/orinoco_cs.c orinoco-build/orinoco_cs.c
> +++ orinoco-build/orinoco_cs.c  2005-02-27 15:00:07.698368136 -0800
> @@ -428,7 +428,7 @@
>         SET_MODULE_OWNER(dev);
>         card->node.major =3D card->node.minor =3D 0;
>=20
> -       SET_NETDEV_DEV(dev, &handle_to_dev(handle));
> +       dev->name[0] =3D '\0';
>         /* Tell the stack we exist */
>         if (register_netdev(dev) !=3D 0) {
>                 printk(KERN_ERR PFX "register_netdev() failed\n");
>=20
>=20
> What's the deal with the broken firmware for monitor mode?
>=20
>  * v0.15rc1 -> v0.15rc2 - 28 Jul 2004 - Pavel Roskin & David Gibson
>  *      o orinoco_pci saves PCI registers on suspend (Simon Huggins).
>  *      o Monitor mode disabled on Agere 8.xx firmware - it's broken.
>=20
> I have 8.4 but things seem fine (used this card in monitor mode for over =
a=20
> year without
> problems).
>=20
> I just disabled the check for broken firmware and things seem fine (bette=
r=20
> than the original
> patch I posted). The iwlist command now works. Could the buggy firmware b=
e=20
> generalized a bit
> too much? Perhaps only certain versions > 8 are buggy?

Possibly, but I don't really have the means to find out in more
detail.  The trouble is that when it falls over, it falls over very
badly, which is why we disable this rather than just letting the user
risk it.  Pavel knows more of the details on this one.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist.  NOT _the_ _other_ _way_
				| _around_!
http://www.ozlabs.org/people/dgibson

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCImuyaILKxv3ab8YRAqFZAJwNKG5Lnj99izFYL2Tm2qlrNfxSAgCffpjd
KXtgduN077IDCNnZf++A8OY=
=mJk/
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
