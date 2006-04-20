Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWDTWcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWDTWcM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 18:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWDTWcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 18:32:12 -0400
Received: from [80.48.65.8] ([80.48.65.8]:55475 "EHLO smtp.poczta.interia.pl")
	by vger.kernel.org with ESMTP id S932093AbWDTWcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 18:32:10 -0400
Message-ID: <44480BD9.5080100@poczta.fm>
Date: Fri, 21 Apr 2006 00:31:53 +0200
From: Lukasz Stelmach <stlman@poczta.fm>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?B?xYF1a2FzeiBTdGVsbWFjaA==?= <stlman@poczta.fm>
Subject: unix socket connection tracking 
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig48943F5C3DBCEFDACB66A795"
X-EMID: 48346138
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig48943F5C3DBCEFDACB66A795
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Greetings All.

I feel dumb as never so please enlight me. Is ther a way to find out whic=
h
process is on the other end of a unix socket pointed by a specified fd in=
 a process.

Lets say that I have got a process gconfd-2. I've straced it and got:

writev(25, [{"GIOP\1\2\1\0\267\1\0\0", 12},....

now I look at lsof
COMMAND     PID     USER   FD   TYPE     DEVICE SIZE  NODE NAME
gconfd-2   2282 jdoe       25u  unix 0xc55a9380       4222 socket

and netstat

Proto RefCnt Flags       Type       State         I-Node PID/Program name=
  Path
unix  3      [ ]         STREAM     CONNECTED     4222     2282/gconfd-2

OK, fine when the gconfd-2 has written the data something's had to read i=
t. I
ask: How can I find what has read the data? Forgive me if it's trivial bu=
t I
really find no way to learn it. Neither in /proc nor using some tools lik=
e above.

Best regards.
PS. please don't forget to CC.
--=20
By=C5=82o mi bardzo mi=C5=82o.                    Czwarta pospolita kl=C4=
=99ska, [...]
>=C5=81ukasz<                      Ju=C5=BC nie katolicka lecz z=C5=82odz=
iejska.  (c)PP


--------------enig48943F5C3DBCEFDACB66A795
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFESAvfNdzY8sm9K9wRAsCnAJ9W6RVnd+M7NAKtbyhg7JrT3UEgVACeOT16
8cXy9F7Qo5aJShYIT/TPomA=
=mnUD
-----END PGP SIGNATURE-----

--------------enig48943F5C3DBCEFDACB66A795--
