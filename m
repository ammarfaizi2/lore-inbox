Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbTELE52 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 00:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbTELE52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 00:57:28 -0400
Received: from dsl-62-3-122-163.zen.co.uk ([62.3.122.163]:55983 "EHLO
	tor.trudheim.com") by vger.kernel.org with ESMTP id S261901AbTELE50
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 00:57:26 -0400
Subject: Re: Two RAID1 mirrors are faster than three
From: Anders Karlsson <anders@trudheim.com>
To: Clemens Schwaighofer <cs@tequila.co.jp>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3EBF24A8.1050100@tequila.co.jp>
References: <200305112212_MC3-1-386B-32BF@compuserve.com>
	 <3EBF24A8.1050100@tequila.co.jp>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tDJUR8x8Sg/4shXVllfm"
Organization: Trudheim Technology Limited
Message-Id: <1052716203.4100.10.camel@tor.trudheim.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4Rubber Turnip 
Date: 12 May 2003 06:10:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tDJUR8x8Sg/4shXVllfm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-05-12 at 05:35, Clemens Schwaighofer wrote:

> Why three drives in a Raid1? Raid one is just mirror, or is the third
> drive like a "hot" replace drive if one of the others fail?

With normal mirroring (one original, one copy) you do have the
redundancy and the speedboost at reads, but at mirroring with one
original and two copies (I know AIX does this), you get in to a scenario
that is quite handy. Say you run a large database in a 24/7 operation.
You want to back the database up, but you can only get 5-10 minutes
downtime on it. You then quiesce the database, split off the second copy
from the mirror, mount that as a separate filesystem and back that up
while the original with its first copy has already stepped back into
full use.

Once you finished your backup, you add your split-off copy back to the
original and primary copy and you are back where you started.

HTH,

/Anders


--=-tDJUR8x8Sg/4shXVllfm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA+vyyrLYywqksgYBoRAuOYAJ9l1xgp4Mjtyqrsu0k0Md2wHkLINgCg0gVa
dVe6ZA20T2N66BJ/yMGpgK0=
=Lvqx
-----END PGP SIGNATURE-----

--=-tDJUR8x8Sg/4shXVllfm--

