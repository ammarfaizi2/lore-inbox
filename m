Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbVIVUtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbVIVUtz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 16:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbVIVUtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 16:49:55 -0400
Received: from pih-relay04.plus.net ([212.159.14.131]:49641 "EHLO
	pih-relay04.plus.net") by vger.kernel.org with ESMTP
	id S1751178AbVIVUty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 16:49:54 -0400
Date: Thu, 22 Sep 2005 21:49:53 +0100
From: Chris Sykes <chris@sigsegv.plus.com>
To: linux-kernel@vger.kernel.org
Cc: ext2-devel@lists.sourceforge.net
Subject: Re: Hang during rm on ext2 mounted sync (2.6.14-rc2+)
Message-ID: <20050922204953.GA5767@sigsegv.plus.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net
References: <20050922163708.GF5898@sigsegv.plus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <20050922163708.GF5898@sigsegv.plus.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 22, 2005 at 05:37:08PM +0100, Chris Sykes wrote:
> Ext gurus
>=20
> Kernels: 2.6.14-rc1 -> 2.6.14-rc2 + up to hg changeset 5c9ff0e17a61
>=20
> I'm experiencing processes getting stuck in the 'D' state whilst
> rm'ing files on an ext2 fs mounted with the 'sync' option.  What I've
> tested so far:
>=20
>  * Ext2 mounted with sync:     rm hangs
>  * Ext2 mounted without sync:  OK
>  * Ext3 mounted with sync:     OK
>  * Ext3 mounted without sync:  OK

More datapoints:

2.6.13.2 is OK.
Latest 2.6.14 from the mercurial repository as of this afternoon is
still affected.  I'll try to narrow it down some more with a binary
search.

It seems that not just any rm will cause the stuck process.  The
following procedure seems to get it every time though (I encountered
this bug first whilst running update-grub):

  # cd /sync_ext2
  # cp /boot/grub/menu.lst ./menu.lst.new
  # cat menu.lst.new > menu.lst
  # rm menu.lst

--=20

(o-  Chris Sykes
//\       "Don't worry. Everything is getting nicely out of control ..."
V_/_                          Douglas Adams - The Salmon of Doubt
GPG Fingerprint: 5E8E D17F F96C CC08 911D  CAF2 9049 70D8 5143 8090

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFDMxjxkElw2FFDgJARAlljAKCy+js6uaVF2yPXFkbrs1NOdgZJfQCfZorI
IS9z6TipU7FyB0jUvIX/AGs=
=TZBy
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
