Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266214AbUBQOXh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 09:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266222AbUBQOXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 09:23:37 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:24553 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S266214AbUBQOXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 09:23:35 -0500
Date: Tue, 17 Feb 2004 15:23:33 +0100
From: Martin Waitz <tali@admingilde.org>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH} 2.6 and grsecurity
Message-ID: <20040217142333.GF27996@admingilde.org>
Mail-Followup-To: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
References: <200402170134.i1H1YIAW016949@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eN+VsUY52o/CFM+1"
Content-Disposition: inline
In-Reply-To: <200402170134.i1H1YIAW016949@turing-police.cc.vt.edu>
User-Agent: Mutt/1.3.28i
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eN+VsUY52o/CFM+1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

On Mon, Feb 16, 2004 at 08:34:17PM -0500, Valdis.Kletnieks@vt.edu wrote:
>  	spin_lock_bh(&inet_peer_idlock);
> -	id =3D p->ip_id_count;
> +#ifdef CONFIG_SECURITY_RANDID
> +	if (security_enable_randid)
> +		id =3D ip_randomid();
> +	else
> +#endif
> +		id =3D p->ip_id_count;

you could #define security_enable_* to 0 when CONFIG_SECURITY_*
is disabled. thay way you don't need the ugly #ifdef in the .c file

on the other hand, why do one need a syscall anyway.
only to justify the existence of some ugly lockdown mode?

well, why make it even configurable?
eigther it increases security, then by all means: enable it
unconditionally;
or it doesn't increase security, and why do we need it then?


--=20
CU,		  / Friedrich-Alexander University Erlangen, Germany
Martin Waitz	//  Department of Computer Science 12      _________
______________/// - - - - - - - - - - - - - - - - - - - - ///
dies ist eine manuell generierte mail, sie beinhaltet    //
tippfehler und ist auch ohne grossbuchstaben gueltig.   /

--eN+VsUY52o/CFM+1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAMiPkj/Eaxd/oD7IRAgj4AJ0fZe9I+mmI9CDBGG9GdtLadYdLegCdHDi/
GKjSIzHiWVoKnq5xotQx6nc=
=13jY
-----END PGP SIGNATURE-----

--eN+VsUY52o/CFM+1--
