Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751708AbWIFRAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbWIFRAx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 13:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751697AbWIFRAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 13:00:53 -0400
Received: from 69-30-77-85.dq1sn.easystreet.com ([69.30.77.85]:44011 "EHLO
	camus.anholt.net") by vger.kernel.org with ESMTP id S1751676AbWIFRAv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 13:00:51 -0400
Subject: Re: Resubmit: Intel 965 Express AGP patches
From: Eric Anholt <eric@anholt.net>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060906160210.GK15918@redhat.com>
References: <115747785570-git-send-email-eric@anholt.net>
	 <20060906160210.GK15918@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-oWalGnGr/stiuRoHnAjM"
Date: Wed, 06 Sep 2006 09:56:25 -0700
Message-Id: <1157561785.11752.12.camel@vonnegut>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 FreeBSD GNOME Team Port 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oWalGnGr/stiuRoHnAjM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-09-06 at 12:02 -0400, Dave Jones wrote:
> On Tue, Sep 05, 2006 at 10:37:32AM -0700, Eric Anholt wrote:
>  > The following should be the updated patch series for the Intel 965 Exp=
ress
>  > support, unless I'm making some mistake with git-send-email.  I think =
I've
>  > covered Dave's concerns=20
>=20
> This chunk seems unrelated to 965 support.
>=20
> @@ -1469,7 +1570,7 @@ static struct agp_bridge_driver intel_91
>         .owner                  =3D THIS_MODULE,
>         .aperture_sizes         =3D intel_i830_sizes,
>         .size_type              =3D FIXED_APER_SIZE,
> -       .num_aperture_sizes     =3D 3,
> +       .num_aperture_sizes     =3D 4,
>         .needs_scratch_page     =3D TRUE,
>         .configure              =3D intel_i915_configure,
>         .fetch_size             =3D intel_i915_fetch_size,
>=20
> It seems to be a valid fix (as there are indeed 4 entries in
> intel_i830_sizes), but I wonder if this was intentional ?
> Has this been tested on 915/945?
> I've chopped this bit out and committed the rest, we can
> add this as a separate commit, which may ease future bisecting
> if anything should go awry.
> The intel_830_driver struct also lists the num of sizes as '3' btw.
> It could just be lots of cut-n-paste braindamage, but things like
> this make me nervous in a driver that supports so much hardware
> and is so.. twisted.

It just looks to me like when the 512MB entry was added for the 965, the
count was bumped for 915 too.  It wouldn't have mattered for the 915 (or
i830, if it had got the treatment), since it'll never have a 512MB
aperture anyway, and doesn't use the generic gatt creation.

> Also, do we need an entry in agp_intel_resume() for the 965 ?

Yeah, looks like it.

>  >, except for making the PCI ID stuff table-driven.
>  > You can find a patch for that on the intel-agp-i965 branch at
>  > git://anongit.freedesktop.org/~anholt/linux-2.6
>=20
> I'll take a look at those soon.

Thanks!

--=20
Eric Anholt                             anholt@FreeBSD.org
eric@anholt.net                         eric.anholt@intel.com

--=-oWalGnGr/stiuRoHnAjM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (FreeBSD)

iD8DBQBE/v25HUdvYGzw6vcRAl10AJ9fl9UUAks2+IlEOBF4EMa+is3dVwCeLup0
tFrbx3GdsSttnWQ7d7FK50w=
=ZevL
-----END PGP SIGNATURE-----

--=-oWalGnGr/stiuRoHnAjM--

