Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264410AbTLGLep (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 06:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264411AbTLGLep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 06:34:45 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:52435 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S264410AbTLGLen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 06:34:43 -0500
Subject: Re: 2.4.23 hard lock, 100% reproducible.
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Mark Symonds <mark@symonds.net>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <049e01c3bca9$0eae8880$7a01a8c0@gandalf>
References: <29654.1070788614@ocs3.intra.ocs.com.au>
	 <049e01c3bca9$0eae8880$7a01a8c0@gandalf>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-f4GXqz6IslQnQrWuc07k"
Message-Id: <1070796878.23878.57.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 07 Dec 2003 12:34:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-f4GXqz6IslQnQrWuc07k
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-12-07 at 11:01, Mark Symonds wrote:

> puggy:/usr/src/linux/2.4.23# ksymoops -m ./System.map -A c02363dd
> ksymoops 2.4.9 on i686 2.4.23.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.23/ (default)
>      -m ./System.map (specified)
>=20
> Error (regular_file): read_ksyms stat /proc/ksyms failed
> ksymoops: No such file or directory
> No modules in ksyms, skipping objects
> No ksyms, skipping lsmod
>=20
>=20
> Adhoc c02363dd <tcp_print_conntrack+2d/60>

Hmm, it looks like it's this line in tcp_print_conntrack()

return sprintf(buffer, "%s ", tcp_conntrack_names[state]);

But it would be good if you could recompile and use addr2line (or gdb)
to get the exact line (offsets and memory-addresses depends on compiler
used and other stuff).

I took a quick look at the code but didn't see anything obvious.

--=20
/Martin

--=-f4GXqz6IslQnQrWuc07k
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/0xBOWm2vlfa207ERAjHfAJ4pmMQsIw5Uz4Nhy4c6OYu4TjslwQCfV6xj
qudQNSwc9A54gxwq8ptcySg=
=fpG6
-----END PGP SIGNATURE-----

--=-f4GXqz6IslQnQrWuc07k--
