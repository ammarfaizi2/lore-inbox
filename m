Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262665AbVBYKOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbVBYKOe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 05:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262664AbVBYKOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 05:14:34 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:57262 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262665AbVBYKO0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 05:14:26 -0500
Date: Fri, 25 Feb 2005 11:14:24 +0100
From: Kurt Garloff <garloff@suse.de>
To: Amon Ott <ao@rsbac.org>
Cc: rsbac@rsbac.org,
       Lorenzo =?iso-8859-1?Q?Hern=E1ndez_Garc=EDa-Hierro?= 
	<lorenzo@gnu.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "linux-security-module@wirex.com" <linux-security-module@wirex.com>
Subject: Re: [rsbac] Thoughts on the "No Linux Security Modules framework" old claims
Message-ID: <20050225101423.GG19066@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Amon Ott <ao@rsbac.org>, rsbac@rsbac.org,
	Lorenzo =?iso-8859-1?Q?Hern=E1ndez_Garc=EDa-Hierro?= <lorenzo@gnu.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-security-module@wirex.com" <linux-security-module@wirex.com>
References: <1108507089.3826.83.camel@localhost.localdomain> <200502211119.24845.ao@rsbac.org> <20050224005551.GD18216@tpkurt.garloff.de> <200502240928.46262.ao@rsbac.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jHkwA2TBA/ec6v+"
Content-Disposition: inline
In-Reply-To: <200502240928.46262.ao@rsbac.org>
X-Operating-System: Linux 2.6.11-rc4-bk9-27-xen i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9jHkwA2TBA/ec6v+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Amon,

On Thu, Feb 24, 2005 at 09:28:38AM +0100, Amon Ott wrote:
> On Donnerstag 24 Februar 2005 01:55, Kurt Garloff wrote:
> > If you apply them (and I hope Linus will), capabilities is default
> > and you can replace that by loading an LSM. You can stack capability
> > on top of the primary LSM again, if the latter supports this.
>=20
> Well, not quite, although it is an improvement.
>=20
> As long as the capabilities module does not support stacking, anybody=20
> needing capabilities and e.g. on-access scanning with Dazuko will=20
> have to unload this module, load another module, and reload it.=20

Nope.

With the patchset applied you get capabilities as default behaviour,
so with_out_ any LSM loaded.

> This creates a nasty race condition.=20

You can load any module to replace capabilities. No race condition
(except that the point in time when the security_ops is actually
 updated is not well defined as there's no locking nor wmb()).

You can also load the capabilities module on top of the default,
but it won't change any behaviour then (other than eating a few
percent performance in some paths).

> BTW, what happens if capabilities=20
> have been compiled static, not as a module?

Why would you want to do this?

> AFAIK, not all LSM modules provide correct stacking.=20

True.

Regards,
--=20
Kurt Garloff, Director SUSE Labs, Novell Inc.

--9jHkwA2TBA/ec6v+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCHvp/xmLh6hyYd04RAvlAAKCkt3O5H+htnUEkMrqqkUDg953VBgCfSxIs
8sUeQ+LoWnadS/ebVZMEd0g=
=aLjT
-----END PGP SIGNATURE-----

--9jHkwA2TBA/ec6v+--
