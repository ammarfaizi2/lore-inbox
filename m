Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263840AbTJ1Dwt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 22:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263843AbTJ1Dwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 22:52:49 -0500
Received: from dhcp160178171.columbus.rr.com ([24.160.178.171]:14857 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S263840AbTJ1Dwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 22:52:47 -0500
Date: Mon, 27 Oct 2003 22:52:44 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: [PATCH] PS/2 mouse rate setting
Message-ID: <20031028035244.GA20145@rivenstone.net>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org, vojtech@suse.cz
References: <20031027140217.GA1065@averell> <Pine.LNX.4.44.0310270830060.1699-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310270830060.1699-100000@home.osdl.org>
User-Agent: Mutt/1.5.4i
From: <jhf@rivenstone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2003 at 08:32:15AM -0800, Linus Torvalds wrote:
>=20
> On Mon, 27 Oct 2003, Andi Kleen wrote:
> >=20
> > Overall as KVM user I must say I'm not very happy with the 2.6 mouse
> > driver. 2.4 pretty much worked out of the box, but 2.6 needs
> > lots of strange options (psmouse_noext, psmouse_rate=3D80)=20
> > because it does things very differently out of the box.
>=20
> I agree. The keyboard driver has also deteriorated, I think.=20
>=20
> I'd suggest we _not_ set the rate by default at all (and let the default
> thing just happen). And only set the rate if the user _asks_ for it with
> your setup thing. Mind sending me that kind of patch?
>=20

    I need this patch to use the scroll wheel on my Logitech mouse
with my Belkin KVM switch in 2.6. This patch was in -mm for a while
before some changes there broke the diff, and I got some mail from
people who said it was helpful.  I didn't hear about any problems.

    Linus, will you please consider applying it?

    The new mouse autodetection sets my mouse up to use the Logitech
ps2++ protocol, but Belkin KVMs speak only the Microsoft Intellimouse
protocol and plain ps2.  In 2.4, with X and GPM set up to use the
imps2 protocol, things work fine -- my mouse also speaks imps2 -- but
in 2.6 I don't get a choice.

    One person also used it to disable the Synaptic touchpad driver at
runtime without disabling the scroll wheel on their external mouse.  I
think the parameter this patch adds should cover most regressions that
have to do with the mouse autodetection, since the Intellimouse
protocol seems to be kind of a lowest common denominator because
Windows supports it out of the box.

    Unfortunately, I was unable to get any sort of comment from
Vojtech Pavlik about this patch. =20

--=20
Joseph Fannin
jhf@rivenstone.net

"That's all I have to say about that." -- Forrest Gump.

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/negMWv4KsgKfSVgRAlAMAKCSzj4UppzdU0G4K4ckQp6nE5H6sgCfcJVA
VDFlHaqQjJReX6hUFDJuBHo=
=n9vV
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
