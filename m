Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264585AbUESWyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264585AbUESWyD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 18:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264664AbUESWyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 18:54:03 -0400
Received: from facmail.cc.gettysburg.edu ([138.234.4.150]:10146 "EHLO
	facmail.cc.gettysburg.edu") by vger.kernel.org with ESMTP
	id S264585AbUESWx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 18:53:59 -0400
Date: Wed, 19 May 2004 17:21:49 -0400
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5, 2.6.6-rc2 sluggish interrupts
Message-ID: <20040519212149.GA1075@andromeda>
References: <E1BJOXM-0007zu-6H@andromeda> <20040519191900.GA1052@andromeda> <20040519192414.GA1210@andromeda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20040519192414.GA1210@andromeda>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Justin Pryzby <justinpryzby@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Found a solution: disable cpufreq.  I also saw these:

	May 16 12:39:48 andromeda kernel: cpufreq: change failed with new_state
	0 and result 3
	May 16 14:59:13 andromeda kernel: cpufreq: change failed with new_state
	0 and result 3
	May 16 14:59:13 andromeda kernel: cpufreq: change failed with new_state
	0 and result 3

Justin

On Wed, May 19, 2004 at 03:24:14PM -0400, pryzbyj wrote:
> This also suffices to cease the skipping:
>=20
> 	while true; do false; done;
>=20
> I also see this, by the way:
>=20
> 	May 19 15:15:51 andromeda kernel: psmouse.c: Mouse at
> 	isa0060/serio1/input0 lost
> 	 synchronization, throwing 2 bytes away.
> 	May 19 15:16:02 andromeda kernel: psmouse.c: Mouse at
> 	isa0060/serio1/input0 lost
> 	 synchronization, throwing 1 bytes away.
> 	May 19 15:16:03 andromeda kernel: psmouse.c: Mouse at
> 	isa0060/serio1/input0 lost
> 	 synchronization, throwing 2 bytes away.
>=20
> But these don't correlate with the skips, which frequently happen even
> when there's no kernel log entry for the mouse.  FWIW, that could be a
> legitimate hardware problem, though it happens even when I'm using an
> external mouse (laptop).
>=20
> Justin
>=20
> On Wed, May 19, 2004 at 03:19:00PM -0400, pryzbyj wrote:

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAq8/th7yD3l4ITTYRAqvUAJ9pNkltErUyAsjTtzSuu4ku2FGLdACeJ0UB
c2O6jpj/jKcIILvk893zviY=
=g1gB
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
