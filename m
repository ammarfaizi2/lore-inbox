Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262886AbTHUTqD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 15:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262887AbTHUTqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 15:46:03 -0400
Received: from rrba-bras-193-115.telkom-ipnet.co.za ([165.165.193.115]:21632
	"EHLO nosferatu.lan") by vger.kernel.org with ESMTP id S262886AbTHUTqA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 15:46:00 -0400
Subject: Re: [PATCH] fix for htree corruption. Was: [2.6] Perl weirdness
	with ext3 and HTREE
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: chrisl@vmware.com
Cc: KML <linux-kernel@vger.kernel.org>, akpm@digeo.com, adilger@clusterfs.com,
       ext3-users@redhat.com, x86-kernel@gentoo.org,
       Ext2 Devel <ext2-devel@lists.sourceforge.net>
In-Reply-To: <20030819104026.GA25402@vmware.com>
References: <68F326C497FDB743B5F844B776C9B146097700@pa-exch4.vmware.com>
	 <1060208887.12477.31.camel@nosferatu.lan>
	 <20030819104026.GA25402@vmware.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-wIr0UsYfoyWyfpAF7xKq"
Message-Id: <1061495166.29479.1.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 21 Aug 2003 21:46:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wIr0UsYfoyWyfpAF7xKq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-08-19 at 12:40, chrisl@vmware.com wrote:

Hi

>=20
> The first patch should fix it. The bug is trigger by creating the index.
> Coping out the index we assume the dirents start with the first entry
> after "." "..".
>=20
> It can make the first previous deleted entry reappear.
> In the past we set inode to zero for empty entry so this is not
> a problem. That is not true any more.
>=20
> Andrew, I assume touch inode->i_ctime after
> ext3_mark_inode_dirty is a bug? The second patch is for that.
>=20
>=20

I can confirm that this works as expected, many thanks!
Sorry for the long delay ...


Regards,

--=20

Martin Schlemmer




--=-wIr0UsYfoyWyfpAF7xKq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/RSF+qburzKaJYLYRAkQaAKCZHZtBaoRxtrBVAXZGqbmHh265eQCggxrn
R80r9hOEvQcmSXSOEaBxGYs=
=oaGg
-----END PGP SIGNATURE-----

--=-wIr0UsYfoyWyfpAF7xKq--

