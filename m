Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbTJIKz1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 06:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbTJIKyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 06:54:50 -0400
Received: from smtp2.actcom.co.il ([192.114.47.15]:4319 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S261984AbTJIKuH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 06:50:07 -0400
Date: Thu, 9 Oct 2003 12:49:18 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Andi Kleen <ak@muc.de>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       bos@serpentine.com
Subject: Re: [PATCH] Fix mlockall for PROT_NONE mappings
Message-ID: <20031009104918.GB4699@actcom.co.il>
References: <20031009104218.GA1935@averell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline
In-Reply-To: <20031009104218.GA1935@averell>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2003 at 12:42:18PM +0200, Andi Kleen wrote:

> I added a new argument force=3D=3D2 to get_user_pages that means to ignore
> SIGBUS or unaccessible pages errors. MAY_* is still checked for like
> with the old force =3D=3D1, it just doesn't error out now for SIGBUS
> errors on handle_mm_fault.=20

How about making it an enum or define for code readability? I'd much
rather see an IGNORE_BAD_PAGES or some such than a cryptic '2' in the
code. I can send a patch to that effect if you'd like?=20
=20
Cheers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org


--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/hT0uKRs727/VN8sRAmN1AJ9G+BOCuaLvRQo/A2gAWl812a5QfQCeMmbc
uliygkad7wHaQY5FlYHC7W4=
=dCv6
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
