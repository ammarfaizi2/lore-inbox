Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263332AbTDGIPP (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 04:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263328AbTDGIPP (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 04:15:15 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:14572 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S263332AbTDGIPN (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 04:15:13 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: linux-kernel@vger.kernel.org
Subject: An idea for prefetching swapped memory...
Date: Mon, 7 Apr 2003 10:26:43 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_HZTk+Okv0Bi9LLP";
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200304071026.47557.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_HZTk+Okv0Bi9LLP
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

Hello,

some days ago some friends and me argued about a feature which seems not to=
 be=20
included in current OSs but could improve useability mainly for desktop=20
computers.

The idea was about prefetching swapped out pages when some memory is free, =
the=20
CPU is idle and the I/O load is low.

So this should not 'cost' much but behave better on following situation:
(I think there are even more such situations, this one should just be an=20
example)

One is surfing the internet and having some browser windows opened. Now,=20
without closing the browser windows, he is playing some game which needs=20
pretty much memory so the browsers memory is getting swapped out. After=20
finishing gaming he's going to make some coffee and then surfing the intern=
et=20
again.
But even if the computer was IDLE for a time and, as the game was closed=20
again, some memory is really FREE, the pages for the browser are swapped in=
=20
just when they are needed and not in advance.

With this feature there should be no performance decrease because only free=
=20
resources would be used, and if pages were swapped in but not be used, they=
=20
stay not dirty and so have not to be written to disk when they are swapped=
=20
out again. But the improvements should be obvious if simply the last swaped=
=20
out pages are swapped in again...

If somebody could give me a hint how to implement this I would try it. I ho=
pe=20
it will not be very difficult... ;-)

Thank you for reading and perhaps thinking about it...

Best regards
   Thomas Schlichter
--Boundary-02=_HZTk+Okv0Bi9LLP
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+kTZHYAiN+WRIZzQRAmfLAJ9weSjhvGgQLmNICs4LRqySsm5wUQCgg63N
NzrXXo/U1tmlhaAjd8MB2LA=
=cLak
-----END PGP SIGNATURE-----

--Boundary-02=_HZTk+Okv0Bi9LLP--

