Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263586AbTKFOPN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 09:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263598AbTKFOPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 09:15:13 -0500
Received: from trantor.org.uk ([213.146.130.142]:57576 "EHLO trantor.org.uk")
	by vger.kernel.org with ESMTP id S263586AbTKFOPH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 09:15:07 -0500
Subject: Re: Over used cache memory?
From: Gianni Tedesco <gianni@scaramanga.co.uk>
To: jlnance@unity.ncsu.edu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031106134031.GA2720@ncsu.edu>
References: <BAY4-F41WYf5UPHvAo10001c90f@hotmail.com>
	 <3FAA1056.6020003@aitel.hist.no>  <20031106134031.GA2720@ncsu.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-fh2Au9cyU633ahVFtIca"
Message-Id: <1068128072.530.1421.camel@lemsip>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 06 Nov 2003 15:14:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fh2Au9cyU633ahVFtIca
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-11-06 at 14:40, jlnance@unity.ncsu.edu wrote:
> If anyone has any ideas about this, I would love to hear them.

cat /proc/pid/maps of app in question....

most likely it's copying a fsck load of that file in to anonymous
mappings, causing swapping.

If it has a 2GB anonymous mapping and 1GB physical memory, swap will
happen on 1 in 2 pages that that program tries to access, on average.

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D


--=-fh2Au9cyU633ahVFtIca
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/qldIkbV2aYZGvn0RAl7fAJ0fvbQxvv1EUcjb1Efy0ZthF9JugACfb/Ui
dry0vY6YSYhtFpy2CrlLW4M=
=m9S1
-----END PGP SIGNATURE-----

--=-fh2Au9cyU633ahVFtIca--

