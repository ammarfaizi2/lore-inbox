Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263715AbTKRRHw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 12:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263723AbTKRRHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 12:07:52 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:13207 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S263715AbTKRRHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 12:07:50 -0500
Date: Tue, 18 Nov 2003 18:07:49 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: How can a loadable kernel module remove itself?
Message-ID: <20031118170748.GF1037@lug-owl.de>
Mail-Followup-To: Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0311181036590.783-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8TaQrIeukR7mmbKf"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0311181036590.783-100000@ida.rowland.org>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8TaQrIeukR7mmbKf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-11-18 10:45:57 -0500, Alan Stern <stern@rowland.harvard.edu>
wrote in message <Pine.LNX.4.44L0.0311181036590.783-100000@ida.rowland.org>:
> Say I've got a kernel module that decides its job is done, and it wants t=
o=20
> unload itself automatically.  Is there any way to do that?  Basically I'm=
=20
> looking for the opposite of the request_module() function, except that=20
> I've already got a pointer to the module in question, i.e., THIS_MODULE.

If the module's runtime is *really* limited (eg. I oftenly use very
small modules to printk() me some bytes from some in-kernel data
structures), then just do what you need to do in the function
"registered" with module_init() and return with !=3D 0...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--8TaQrIeukR7mmbKf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/ulHkHb1edYOZ4bsRAn5XAKCAUBQId3nM3vcM/8R4gsdug77VoQCfR5qo
Tlq9m++mt0U1iwm31TtaFkE=
=a1fC
-----END PGP SIGNATURE-----

--8TaQrIeukR7mmbKf--
