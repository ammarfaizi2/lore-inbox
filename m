Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbUCXWF1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 17:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbUCXWF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 17:05:26 -0500
Received: from ns.suse.de ([195.135.220.2]:21971 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262130AbUCXWFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 17:05:17 -0500
Date: Wed, 24 Mar 2004 23:03:10 +0100
From: Kurt Garloff <garloff@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Non-Exec stack patches
Message-ID: <20040324220310.GF4504@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Andi Kleen <ak@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>
References: <1D3lO-3dh-13@gated-at.bofh.it> <1D3YZ-3Gl-1@gated-at.bofh.it> <m3n066eqbf.fsf@averell.firstfloor.org> <4061619F.4020704@stesmi.com> <20040324112739.GA64848@colin2.muc.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="doKZ0ri6bHmN2Q5y"
Content-Disposition: inline
In-Reply-To: <20040324112739.GA64848@colin2.muc.de>
X-Operating-System: Linux 2.6.4-2-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--doKZ0ri6bHmN2Q5y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andi,

On Wed, Mar 24, 2004 at 12:27:39PM +0100, Andi Kleen wrote:
Stefan Smietanowski <stesmi@stesmi.com> wrote:
> > I would THINK they would include the NX bit but that's just a guess of
> > course.
>=20
> Most likely yes.=20
>=20
> But who buys such crippled CPUs will have to live with that. Or do a patc=
h.

It should be straightforward. Put a different value in the
protection_map if such a CPU is detected. That should be all.

> NX support is mostly hype anyways, it doesn't give you much advantage.

It puts the hurdle somewhat higher and for some exploits does prevent
them. You can still overwrite the return address, but you need to have
put code into the data section prior to this to exploit. This may or may
not possible depending on how the daemon works. Marking the data section
non-executable would help further ...

It's always a tradeoff. Given the simplicity of the patch, I'm in favour
of having it.

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>             [Koeln, DE]
Physics:Plasma modeling <garloff@plasimo.phys.tue.nl> [TU Eindhoven, NL]
Linux: SUSE Labs (Head)        <garloff@suse.de>    [SUSE Nuernberg, DE]

--doKZ0ri6bHmN2Q5y
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAYgWexmLh6hyYd04RAkZRAKCSysnZmTSdOwvzyF5NnjTxsnHTzgCgpmBK
kGEB5FLy5smmv509Ms9T3wU=
=NyRc
-----END PGP SIGNATURE-----

--doKZ0ri6bHmN2Q5y--
