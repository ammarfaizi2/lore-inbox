Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbVGEQdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbVGEQdi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 12:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVGEQaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 12:30:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:18362 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261939AbVGEQ0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 12:26:52 -0400
Date: Tue, 5 Jul 2005 18:26:49 +0200
From: Kurt Garloff <garloff@suse.de>
To: James Morris <jmorris@redhat.com>
Cc: Tony Jones <tonyj@immunix.com>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Greg Kroah-Hartman <gregkh@suse.de>, Steve Beattie <smb@wirex.com>,
       Linux LSM list <linux-security-module@wirex.com>
Subject: Re: [PATCH 1/3] Make cap default
Message-ID: <20050705162649.GB12583@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	James Morris <jmorris@redhat.com>, Tony Jones <tonyj@immunix.com>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
	Greg Kroah-Hartman <gregkh@suse.de>, Steve Beattie <smb@wirex.com>,
	Linux LSM list <linux-security-module@wirex.com>
References: <20050705072111.GA10453@tpkurt.garloff.de> <Xine.LNX.4.44.0507051139470.3247-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0507051139470.3247-100000@thoron.boston.redhat.com>
X-Operating-System: Linux 2.6.11.4-21.7-xen i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi James,

On Tue, Jul 05, 2005 at 11:40:40AM -0400, James Morris wrote:
> On Tue, 5 Jul 2005, Kurt Garloff wrote:
>=20
> > #  define COND_SECURITY(seop, def)			\
> > 	(security_opt->seop =3D=3D NULL) ||			\
> > 	 security_ops =3D=3D &capability_security_ops)?	\
> > 	 def: security_ops->seop
>=20
> Why is this a macro and not a static inline?

Good question ...

The number and type of parameters is variable, so we can't=20
easily do it with ONE static inline function.

seop is the function call including parameters, as is def.
Which means that the idea won't work the way I suggested in
the email. We'd need a three arg version, one for the security_ops
function name, one for the cap version and one for the arguments.

Best,
--=20
Kurt Garloff, Director SUSE Labs, Novell Inc.

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCyrTJxmLh6hyYd04RArV6AJ41YHLKEtA4gESzmH0kaTBPhTu/IgCgm5rE
b2bUF7lzp6SzBetFQqUixdo=
=ZqDv
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
