Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbVBXBBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbVBXBBp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 20:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbVBXA7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 19:59:32 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:42987 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261715AbVBXAzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 19:55:52 -0500
Date: Thu, 24 Feb 2005 01:55:51 +0100
From: Kurt Garloff <garloff@suse.de>
To: Amon Ott <ao@rsbac.org>
Cc: rsbac@rsbac.org,
       Lorenzo =?iso-8859-1?Q?Hern=E1ndez_Garc=EDa-Hierro?= 
	<lorenzo@gnu.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "linux-security-module@wirex.com" <linux-security-module@wirex.com>
Subject: Re: [rsbac] Thoughts on the "No Linux Security Modules framework" old claims
Message-ID: <20050224005551.GD18216@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Amon Ott <ao@rsbac.org>, rsbac@rsbac.org,
	Lorenzo =?iso-8859-1?Q?Hern=E1ndez_Garc=EDa-Hierro?= <lorenzo@gnu.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-security-module@wirex.com" <linux-security-module@wirex.com>
References: <1108507089.3826.83.camel@localhost.localdomain> <200502211119.24845.ao@rsbac.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ylS2wUBXLOxYXZFQ"
Content-Disposition: inline
In-Reply-To: <200502211119.24845.ao@rsbac.org>
X-Operating-System: Linux 2.6.11-rc4-bk9-27-xen i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ylS2wUBXLOxYXZFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Amon,

On Mon, Feb 21, 2005 at 11:19:16AM +0100, Amon Ott wrote:
> > -> 5. Posix Capabilities Without Stacking Support
> >=20
> > I don't get the point of these claims.
> > The LSM framework currently has full support for dynamic and
> > logic-changeable POSIX.1e capabilities, using the capable() hook and
> > calling capable(from whatever location inside any other hook to apply
> > further logic checks (ie. in capable() check for jailed @current  proce=
ss
> > and deny use of CAP_SYS_CHROOT and CAP_SYS_ADMIN or what-ever-else
> > capabilities) or in syslog() to deny access to kernel messages stack to
> > unprivileged users.
>=20
> Without rechecking the current state: At least the last time I=20
> checked, the hardwired kernel capabilities were explicitely disabled=20
> when LSM got switched on. You had to use the capabilities LSM module=20
> instead, which was not able to stack. It always had to be the last in=20
> the chain, thus effectively sealing against any other LSM module to=20
> be loaded later.

My patches posted Feb 13 fix this.

If you apply them (and I hope Linus will), capabilities is default
and you can replace that by loading an LSM. You can stack capability
on top of the primary LSM again, if the latter supports this.

Best regards,
--=20
Kurt Garloff, Director SUSE Labs, Novell Inc.

--ylS2wUBXLOxYXZFQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCHSYXxmLh6hyYd04RAlWOAKCAqbA6SGwX2T0alErokppk7j8F9QCcDcdP
xZD7AA3PGxOdwdq22oMkZQs=
=V8Vs
-----END PGP SIGNATURE-----

--ylS2wUBXLOxYXZFQ--
