Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261971AbVBXI3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbVBXI3R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 03:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbVBXI3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 03:29:17 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:21187 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261971AbVBXI24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 03:28:56 -0500
From: Amon Ott <ao@rsbac.org>
Organization: RSBAC
To: Kurt Garloff <garloff@suse.de>
Subject: Re: [rsbac] Thoughts on the "No Linux Security Modules framework" old claims
Date: Thu, 24 Feb 2005 09:28:38 +0100
User-Agent: KMail/1.7.1
Cc: rsbac@rsbac.org,
       Lorenzo =?iso-8859-1?q?Hern=E1ndez_Garc=EDa-Hierro?= 
	<lorenzo@gnu.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "linux-security-module@wirex.com" <linux-security-module@wirex.com>
References: <1108507089.3826.83.camel@localhost.localdomain> <200502211119.24845.ao@rsbac.org> <20050224005551.GD18216@tpkurt.garloff.de>
In-Reply-To: <20050224005551.GD18216@tpkurt.garloff.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1814754.28e3156VLT";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200502240928.46262.ao@rsbac.org>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e784f4497a7e52bfc8179ee7209408c3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1814754.28e3156VLT
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Donnerstag 24 Februar 2005 01:55, Kurt Garloff wrote:
> On Mon, Feb 21, 2005 at 11:19:16AM +0100, Amon Ott wrote:
> > Without rechecking the current state: At least the last time I=20
> > checked, the hardwired kernel capabilities were explicitely=20
disabled=20
> > when LSM got switched on. You had to use the capabilities LSM=20
module=20
> > instead, which was not able to stack. It always had to be the last=20
in=20
> > the chain, thus effectively sealing against any other LSM module=20
to=20
> > be loaded later.
>=20
> My patches posted Feb 13 fix this.
>=20
> If you apply them (and I hope Linus will), capabilities is default
> and you can replace that by loading an LSM. You can stack capability
> on top of the primary LSM again, if the latter supports this.

Well, not quite, although it is an improvement.

As long as the capabilities module does not support stacking, anybody=20
needing capabilities and e.g. on-access scanning with Dazuko will=20
have to unload this module, load another module, and reload it. This=20
creates a nasty race condition. BTW, what happens if capabilities=20
have been compiled static, not as a module?

AFAIK, not all LSM modules provide correct stacking. At least all=20
modules in the main line kernel should really support the official=20
way. But this is just a few cents from someone not using LSM...

Amon.
=2D-=20
http://www.rsbac.org - GnuPG: 2048g/5DEAAA30 2002-10-22

--nextPart1814754.28e3156VLT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCHZA+q9yn6h5RTo8RAslzAJ9uBqC9C1aP4STW0akWSX9TaYWMrACfb9uC
thj52httFhk6XO6NTDtQzqs=
=BbgC
-----END PGP SIGNATURE-----

--nextPart1814754.28e3156VLT--
