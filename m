Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVBNXYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVBNXYL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 18:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVBNXYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 18:24:11 -0500
Received: from s-utl01-nypop.stsn.com ([199.106.90.52]:28367 "HELO
	s-utl01-nypop.stsn.com") by vger.kernel.org with SMTP
	id S261226AbVBNXYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 18:24:04 -0500
Date: Tue, 15 Feb 2005 00:23:25 +0100
From: Kurt Garloff <garloff@suse.de>
To: James Morris <jmorris@redhat.com>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Andreas Gruenbacher <agruen@suse.de>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: [PATCH] 5/5: LSM hooks rework
Message-ID: <20050214232325.GI18744@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	James Morris <jmorris@redhat.com>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Andreas Gruenbacher <agruen@suse.de>, Chris Wright <chrisw@osdl.org>,
	Stephen Smalley <sds@epoch.ncsc.mil>
References: <20050213211238.GM27893@tpkurt.garloff.de> <Xine.LNX.4.44.0502141143420.24807-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BghK6+krpKHjj+jk"
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0502141143420.24807-100000@thoron.boston.redhat.com>
X-Operating-System: Linux 2.6.11-rc4-20050214001414-default i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
X-OriginalArrivalTime: 14 Feb 2005 23:23:59.0661 (UTC) FILETIME=[430FADD0:01C512EC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BghK6+krpKHjj+jk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi James,

On Mon, Feb 14, 2005 at 11:50:01AM -0500, James Morris wrote:
> On Sun, 13 Feb 2005, Kurt Garloff wrote:
>=20
> >  /* Condition for invocation of non-default security_op */
> >  #define COND_SECURITY(seop, def) 	\
> > -	(likely(security_ops =3D=3D &capability_security_ops))? def: security=
_ops->seop
> > +	(unlikely(security_enabled))? security_ops->seop: def
>=20
> So this will cause a false unlikely() for every single SELinux hook,
> again.

A correct unlikely() in my book.

Yes, that was one of the reasons that I split up the patches.

There are people who believe that we should optimize for the=20
slow path (SELinux) or at least not penalize it.
Fine with me, feel free to ignore patches 4, 5 then.

> This was rejected last year.=20

It wasn't. The discussion did not come to a conclusion.

Best regards,
--=20
Kurt Garloff, Director SUSE Labs, Novell Inc.

--BghK6+krpKHjj+jk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCETLtxmLh6hyYd04RAq8PAJ9EUY9/nIeOGYYk1OLPcKRn6FzibACeLVb0
abtlnyS3vpaFkPTxYkna5ks=
=uuYA
-----END PGP SIGNATURE-----

--BghK6+krpKHjj+jk--
